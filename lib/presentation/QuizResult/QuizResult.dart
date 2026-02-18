import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/AmazingContainer.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/ExamResult.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/ScoreContainer.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/quickReviewButtons.dart';

class QuickResult extends StatelessWidget {
  const QuickResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("Assets/images/Group 1.png"),
          SizedBox(height: 12),
          Amazingcontainer(),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
            child: Card(
              elevation: 4,
              color: Colors.white,

              child: Column(
                children: [
                  ScoreContainer(),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Assets/images/fireworksleft.png",
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(width: 5),
                      ExamResult(),
                      SizedBox(width: 5),
                      Image.asset(
                        "Assets/images/fireworksright.png",
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuickReviewButtons(
                          img: "Assets/images/replay.png",
                          txt: "Play Again",
                        ),
                        QuickReviewButtons(
                          img: "Assets/images/eye.png",
                          txt: "Review Answers",
                        ),
                        QuickReviewButtons(
                          img: "Assets/images/share.png",
                          txt: "Share Score",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Assets/images/Fireworks bottomleft.png",
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(width: 20),
                      QuickReviewButtons(
                        onpressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (buildcontext) {
                                return LearingHome();
                              },
                            ),
                          );
                        },
                        img: "Assets/images/home.png",
                        txt: "Return Home",
                      ),
                      SizedBox(width: 20),
                      Image.asset(
                        "Assets/images/Fireworks bottomright.png",
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//         padding: EdgeInsets.all(10),
//         width: 34,
//         height: 34,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(offset: Offset(2, 2), blurRadius: 4, spreadRadius: 1),
//           ],
//           color: Color(0xffADADEB),
//         ),
//         child: Image.asset(img,height: 10,width: 10,),
//       ),
