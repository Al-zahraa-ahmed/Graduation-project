import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Appmodes/ChooseAppMode.dart';
import 'package:graduation_project/presentation/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/presentation/onboarding/Widgets/Screen.dart';


class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffEAEAFA), Color(0xffD6D6F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                children: [
                  screen1(
                    img:
                        'Assets/images/Women engaged in a conversation or discussion.png',
                    txt1: S.of(context).screen1_title,
                    txt2: S.of(context).screen1_desc,
                  ),
                  screen1(
                    img:
                        'Assets/images/Chatbot high-fives and answers the question.png',
                    txt1: S.of(context).screen2_title,
                    txt2: S.of(context).screen2_desc,
                  ),
                  screen1(
                    img:
                        "Assets/images/Voice assistant answering questions@4x.png",
                    txt1: S.of(context).screen3_title,
                    txt2: S.of(context).screen3_desc,
                  ),
                  screen1(
                    img:
                        "Assets/images/Playing adventure game in virtual reality, Digital gaming experience in VR.png",
                    txt1: S.of(context).screen4_title,
                    txt2: S.of(context).screen4_desc,
                  ),
                ],
              ),
            ),
            DotsIndicator(
              // reversed: true,
              dotsCount: 4,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                // color: Color(0xff5DB957).withValues(alpha: 0.5),
                // activeColor: Appcolors.primar,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              txt: S.of(context).onboarding_btn,
              onpressed: () {
                if (currentIndex < 3) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (buildcontext) {
                        return OnboardingMode();
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

