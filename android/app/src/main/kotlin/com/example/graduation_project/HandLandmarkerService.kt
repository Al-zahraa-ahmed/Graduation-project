package com.example.graduation_project

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Matrix
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.vision.core.RunningMode
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarker
import java.nio.ByteBuffer

/**
 * Wraps MediaPipe Tasks Vision HandLandmarker, mirroring the Python pipeline:
 *  - VIDEO running mode
 *  - 2 hands max
 *  - 0.3 / 0.3 / 0.3 confidences (detection / presence / tracking)
 *  - Returns landmarks AND handedness ("Left" / "Right") per hand
 *  - Optional horizontal mirror to match `cv2.flip(frame, 1)`
 */
class HandLandmarkerService(context: Context, modelBytes: ByteArray) {

    private val landmarker: HandLandmarker

    init {
        // MediaPipe needs a *direct* ByteBuffer for setModelAssetBuffer.
        val direct = ByteBuffer.allocateDirect(modelBytes.size)
        direct.put(modelBytes)
        direct.rewind()

        val baseOptions = BaseOptions.builder()
            .setModelAssetBuffer(direct)
            .build()

        val options = HandLandmarker.HandLandmarkerOptions.builder()
            .setBaseOptions(baseOptions)
            .setRunningMode(RunningMode.VIDEO)
            .setNumHands(2)
            .setMinHandDetectionConfidence(0.3f)
            .setMinHandPresenceConfidence(0.3f)
            .setMinTrackingConfidence(0.3f)
            .build()

        landmarker = HandLandmarker.createFromOptions(context, options)
    }

    fun detect(
        yBytes: ByteArray, uBytes: ByteArray, vBytes: ByteArray,
        width: Int, height: Int,
        yRowStride: Int, uvRowStride: Int, uvPixelStride: Int,
        rotationDegrees: Int,
        mirror: Boolean,
        timestampMs: Long
    ): List<Map<String, Any>> {

        // 1. YUV_420_888 → ARGB_8888
        val argb = yuv420ToArgb(
            yBytes, uBytes, vBytes,
            width, height,
            yRowStride, uvRowStride, uvPixelStride
        )
        var bitmap = Bitmap.createBitmap(argb, width, height, Bitmap.Config.ARGB_8888)

        // 2. Apply rotation (sensor → upright) and selfie mirror in one matrix pass.
        if (rotationDegrees != 0 || mirror) {
            val m = Matrix()
            if (rotationDegrees != 0) m.postRotate(rotationDegrees.toFloat())
            if (mirror) m.postScale(-1f, 1f)
            bitmap = Bitmap.createBitmap(bitmap, 0, 0, width, height, m, true)
        }

        // 3. Run MediaPipe in VIDEO mode (timestamp must be monotonically increasing).
        val mpImage = BitmapImageBuilder(bitmap).build()
        val r = landmarker.detectForVideo(mpImage, timestampMs)

        // 4. Pack landmarks + handedness for each detected hand.
        val out = ArrayList<Map<String, Any>>(r.landmarks().size)
        for (i in r.landmarks().indices) {
            val lms = r.landmarks()[i]
            val landmarkList = ArrayList<Map<String, Double>>(lms.size)
            for (lm in lms) {
                landmarkList.add(
                    mapOf(
                        "x" to lm.x().toDouble(),
                        "y" to lm.y().toDouble(),
                        "z" to lm.z().toDouble()
                    )
                )
            }
            val handedness = r.handednesses()[i].firstOrNull()?.categoryName() ?: "Unknown"
            out.add(
                mapOf(
                    "landmarks" to landmarkList,
                    "handedness" to handedness
                )
            )
        }
        return out
    }

    fun close() {
        try {
            landmarker.close()
        } catch (_: Exception) { /* ignore */ }
    }

    /**
     * Convert a YUV_420_888 image (3 planes) into a packed ARGB_8888 IntArray.
     * Uses BT.601 coefficients in fixed-point (10-bit) for speed.
     */
    private fun yuv420ToArgb(
        y: ByteArray, u: ByteArray, v: ByteArray,
        width: Int, height: Int,
        yRowStride: Int, uvRowStride: Int, uvPixelStride: Int
    ): IntArray {
        val out = IntArray(width * height)
        var dst = 0
        for (j in 0 until height) {
            val yRowBase = j * yRowStride
            val uvRowBase = (j shr 1) * uvRowStride
            for (i in 0 until width) {
                val yVal = y[yRowBase + i].toInt() and 0xFF
                val uvCol = (i shr 1) * uvPixelStride
                val uVal = (u[uvRowBase + uvCol].toInt() and 0xFF) - 128
                val vVal = (v[uvRowBase + uvCol].toInt() and 0xFF) - 128

                // BT.601: R = Y + 1.402 V; G = Y - 0.344 U - 0.714 V; B = Y + 1.772 U
                var r = yVal + ((1436 * vVal) shr 10)         // 1.402
                var g = yVal - ((352 * uVal + 731 * vVal) shr 10) // 0.344, 0.714
                var b = yVal + ((1814 * uVal) shr 10)         // 1.772

                if (r < 0) r = 0 else if (r > 255) r = 255
                if (g < 0) g = 0 else if (g > 255) g = 255
                if (b < 0) b = 0 else if (b > 255) b = 255

                out[dst++] = (0xFF shl 24) or (r shl 16) or (g shl 8) or b
            }
        }
        return out
    }
}
