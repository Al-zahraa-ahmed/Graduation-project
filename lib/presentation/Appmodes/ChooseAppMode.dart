
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/WelcomPage/WelcomPage.dart';

class OnboardingMode extends StatelessWidget {
  const OnboardingMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    Text(
                      S.of(context).screen5_title,
                      style: Textstyles.medium25.copyWith(
                        color: Color(0xff1E1E7B),
                      ),
                    ),
                    Text(
                      S.of(context).screen5_desc1,
                      style: Textstyles.medium13.copyWith(
                        color: Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Stack(
                alignment: AlignmentGeometry.center,
                clipBehavior: Clip.none,
                children: [
                  Image.asset("Assets/images/Rectangle 6.png"),
                  Positioned(
                    child: Image.asset(
                      width: 275,height: 345,
                      "Assets/images/Considering options with question marks, Decision making or problem solving.png",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              ChooseWhichMode(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  S.of(context).screen5_desc2,
                  style: Textstyles.medium13.copyWith(color: Color(0xff999999)),
                ),
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseWhichMode extends StatelessWidget {
  const ChooseWhichMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (buildcontext) {
                    return Platform_Mode_Welcome_Page(
                      txt1: S.of(buildcontext).screen6_transmode,
                      txt2: S.of(buildcontext).screen6_desc,
                    );
                  },
                ),
              );
            },
            child: CustomCard(
              img: "Assets/images/Platformmode.png",
              txt1: S.of(context).mode1,
              txt2: S.of(context).mode1_desc,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (buildcontext) {
                    return Platform_Mode_Welcome_Page(
                      txt1: S.of(buildcontext).screen7_platformmode,
                      txt2: S.of(buildcontext).screen7_desc,
                    );
                  },
                ),
              );
            },
            child: CustomCard(
              img: 'Assets/images/TranslateMode.png',
              txt1: S.of(context).mode2,
              txt2: S.of(context).mode2_desc,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.img,
    required this.txt1,
    required this.txt2,
  });
  final String img, txt1, txt2;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 216,width: 172,
      padding: EdgeInsets.only(bottom: 12, top: 10, right: 0, left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Color(0xffD6D6F5),
            Color(0xffADADEB),
            Color(0xff8484E1),
            Color(0xffADADEB),
            Color(0xffD6D6F5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Image.asset(img),
          Text(txt1, style: Textstyles.medium13),
          Text(txt2, style: TextStyle(fontSize: 13, color: Colors.white)),
        ],
      ),
    );
  }
}
