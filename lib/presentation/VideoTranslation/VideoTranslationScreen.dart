import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

///
/// Background Gradient
///
Widget buildBackground() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff7F53AC), Color(0xff647DEE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );
}

///
/// Circle Icon Button
///
Widget circleIcon(IconData icon) {
  return Container(
    height: 42,
    width: 42,
    decoration: const BoxDecoration(
      color: Colors.black26,
      shape: BoxShape.circle,
    ),
    child: Icon(icon, color: Colors.white, size: 20),
  );
}

///
/// Capture Button
///
// Widget captureButton() {
//   return
// }
class captureButton extends StatelessWidget {
  const captureButton({super.key, this.ontap});
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
///
/// 1️⃣ SIGN TO TEXT SCREEN
///
////////////////////////////////////////////////////////////

class SignToTextScreen extends StatefulWidget {
  const SignToTextScreen({super.key});

  @override
  State<SignToTextScreen> createState() => _SignToTextScreenState();
}

class _SignToTextScreenState extends State<SignToTextScreen> {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),

          /// Top buttons
          Positioned(
            top: 55,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: circleIcon(Icons.close),
                ),
                Row(
                  children: [
                    circleIcon(Icons.camera_alt),
                    const SizedBox(width: 10),
                    circleIcon(Icons.flash_on),
                  ],
                ),
              ],
            ),
          ),

          /// Detection Frame
          Center(
            child: Container(
              height: 327,
              width: 327,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffF5D96B), width: 4),
              ),
              child: CameraPreview(controller!),
            ),
          ),

          /// Translated Text
          Positioned(
            bottom: 190,
            left: 45,
            right: 25,
            child: const Text(
              "translated text translated text translated text translated text translated text translated text",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),

          /// Capture Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: captureButton(
                ontap: () {
                  // controller!.startImageStream(CameraImage img);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
///
/// 2️⃣ LOW LIGHT WARNING SCREEN
///
////////////////////////////////////////////////////////////

class LowLightWarningScreen extends StatelessWidget {
  const LowLightWarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          buildBackground(),

          const Center(child: LowLightCard()),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(child: captureButton()),
          ),
        ],
      ),
    );
  }
}

class LowLightCard extends StatelessWidget {
  const LowLightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffF4C430),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_outline),
              SizedBox(width: 10),
              Text(
                "Low Visibility detected",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "please improve lighting for better accuracy. Dark environment may reduce translation speed and precision",
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 20),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flash_on, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Turn on the flash",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text("Try Anyway", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
///
/// 3️⃣ CAMERA PERMISSION SCREEN
///
////////////////////////////////////////////////////////////

class CameraPermissionScreen extends StatelessWidget {
  const CameraPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          buildBackground(),

          Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Color(0xff6C63FF),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Allow Camera Access?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Allowing camera access is important for real-time translation so we can recognize your gestures",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 20),

                  /// Grant Permission Button
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff6C63FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Grant Permission",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Maybe Later",
                    style: TextStyle(color: Colors.blue),
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: 14),
                      SizedBox(width: 5),
                      Text(
                        "Your privacy is protected",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
