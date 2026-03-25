import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Videoscreen extends StatefulWidget {
  const Videoscreen({super.key});

  @override
  State<Videoscreen> createState() => _VideoscreenState();
}

class _VideoscreenState extends State<Videoscreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            ),
          )
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}






// class LessonVideoScreen extends StatefulWidget {
//   const LessonVideoScreen({super.key});

//   @override
//   State<LessonVideoScreen> createState() => _LessonVideoScreenState();
// }

// class _LessonVideoScreenState extends State<LessonVideoScreen> {
//   late VideoPlayerController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller =
//         VideoPlayerController.networkUrl(
//             Uri.parse(
//               "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//             ),
//           )
//           ..initialize().then((_) {
//             setState(() {});
//           });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F7),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffD6D6F5),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.chevron_left),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         centerTitle: true,
//         title: const Text("Apple", style: TextStyle(fontSize: 25,fontWeight:FontWeight(500))),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
//         child: SizedBox(
//           width: double.infinity,
//           child: Container(
//             // color: Colors.red,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 12.0),
//                   child: const Text(
//                     "Food category - lesson 1",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                   ),
//                 ),
            
//                 const SizedBox(height: 16),
            
//                 /// VIDEO CARD
//                 AspectRatio(
                  
//                   aspectRatio: 327/247,
//                   child: Container(
//                     width: 327,
//                     height: 247,
//                     decoration: BoxDecoration(
//                       color: const Color(0xffD9D7F1),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 6,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: controller.value.isInitialized
//                         ? Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               /// VIDEO
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: AspectRatio(
//                                   aspectRatio: controller.value.aspectRatio,
//                                   child: VideoPlayer(controller),
//                                 ),
//                               ),
                              
//                               /// PLAY BUTTON
//                               IconButton(
//                                 iconSize: 60,
//                                 color: Colors.white,
//                                 icon: Icon(
//                                   controller.value.isPlaying
//                                       ? Icons.pause_circle
//                                       : Icons.play_circle,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     controller.value.isPlaying
//                                         ? controller.pause()
//                                         : controller.play();
//                                   });
//                                 },
//                               ),
//                             ],
//                           )
//                         : const Center(child: CircularProgressIndicator()),
//                   ),
//                 ),
            
//                 const SizedBox(height: 32),
            
//                 /// HAND DESCRIPTION
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(children: [
//                   Row(
//                     children:  [
//                       Image.asset("Assets/images/hand description.png",width: 25,height: 25,),
//                       SizedBox(width: 8),
//                       Text(
//                         "Hand Description",
//                         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                       ),
//                     ],
//                   ),
                              
//                   const SizedBox(height: 10),
                              
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 0.5,color: Color(0xffD6D6F5)),
//                       color: const Color(0xffF2F2F2),
//                       borderRadius: BorderRadius.circular(14),
//                       boxShadow: [
//                       BoxShadow(
//                       offset: Offset(2, 2),
//                       blurRadius: 4,
//                       spreadRadius: 0.3,
//                       color:  Color(0xffADADEB)
//                       ) 
//                       ]
//                     ),
//                     child: const Text(
//                       "Form your hand into a 'C shape' and move it towards your cheek with a slight twisting motion.",
//                     ),
//                   ),
                  
//                   ],),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LessonVideoScreen extends StatefulWidget {
  const LessonVideoScreen({super.key});

  @override
  State<LessonVideoScreen> createState() => _LessonVideoScreenState();
}

class _LessonVideoScreenState extends State<LessonVideoScreen> {
  late VideoPlayerController controller;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
    );

    await controller.initialize();

    chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      showControlsOnInitialize: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: const Color(0xff6C63FF),
        handleColor: const Color(0xff6C63FF),
        bufferedColor: Colors.white54,
        backgroundColor: Colors.black12,
      ),
      placeholder: Container(
        color: const Color(0xffD9D7F1),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    chewieController?.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffD6D6F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Apple",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  "Food category - lesson 1",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// VIDEO CARD
              AspectRatio(
                aspectRatio: 327 / 247,
                child: Container(
                  width: 327,
                  height: 247,
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D7F1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: chewieController != null &&
                            controller.value.isInitialized
                        ? Chewie(
                            controller: chewieController!,
                          )
                        : Container(
                            color: const Color(0xffD9D7F1),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff6C63FF),
                              ),
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// HAND DESCRIPTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "Assets/images/hand description.png",
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Hand Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: const Color(0xffD6D6F5),
                        ),
                        color: const Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 0.3,
                            color: Color(0xffADADEB),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Form your hand into a 'C shape' and move it towards your cheek with a slight twisting motion.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}