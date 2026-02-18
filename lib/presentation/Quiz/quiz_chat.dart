import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 1;
  final int totalQuestions = 10;

  void nextQuestion() {
    if (currentQuestion == totalQuestions) {
      showFinishDialog();
    } else {
      setState(() {
        currentQuestion++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestion > 1) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Quiz Completed!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You’ve reached the end of the quiz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7C7CD5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Submit"),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDECF7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔹 الكارد مع الأسهم
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // الكارد
                    Container(
                      width: 320,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xffF2E8C9),
                            child: Text(
                              "$currentQuestion",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Question $currentQuestion / $totalQuestions",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),

                          // فيديو Placeholder
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xffD6D6F5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),

                          const Text(
                            "What does this sign mean?",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // سهم شمال
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xffD6D6F5),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: previousQuestion,
                        ),
                      ),
                    ),

                    // سهم يمين
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xffD6D6F5),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: nextQuestion,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 الإجابات
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff9C9CE0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "1 Answer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
