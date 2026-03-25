/*
package com.example.graduation_project

import android.content.Context
import android.graphics.Bitmap
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarker
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarkerResult
import com.google.mediapipe.tasks.vision.core.RunningMode

class HandLandmarkerHelper(context: Context) {

    private val handLandmarker: HandLandmarker

    init {
        val baseOptions = BaseOptions.builder()
            .setModelAssetPath("hand_landmarker.task")
            .build()

        val options = HandLandmarker.HandLandmarkerOptions.builder()
            .setBaseOptions(baseOptions)
            .setRunningMode(RunningMode.LIVE_STREAM)
            .setNumHands(2)
            .build()

        handLandmarker = HandLandmarker.createFromOptions(context, options)
    }

    fun detect(bitmap: Bitmap): HandLandmarkerResult {
        val mpImage = BitmapImageBuilder(bitmap).build()
        return handLandmarker.detect(mpImage)
    }
}
*/