import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/presentation/LogIn/LoginScreen.dart';

class Platform_Mode_Welcome_Page extends StatelessWidget {
  const Platform_Mode_Welcome_Page({
    super.key,
    required this.txt1,
    required this.txt2,
  });
  final String txt1, txt2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).screen6_title,
                      style: TextStyle(fontSize: 39, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      txt1,
                      style: TextStyle(fontSize: 39, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      txt2,
                      style: Textstyles.medium13.copyWith(
                        color: Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ),
          
              SizedBox(height: 69),
              Stack(
                alignment: AlignmentGeometry.center,
                clipBehavior: Clip.none,
                children: [
                  Image.asset("Assets/images/Rectangle 6.png"),
                  Positioned(
                    child: Image.asset(
                      "Assets/images/Welcome sign, woman waving hello.png",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 75),
              GetstartedButton(),
              SizedBox(height: 13),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (buildcontext) {
                        return Loginscreen();
                      },
                    ),
                  );
                },
                child: MultiColorText2(
                  txt1: "Already have an account?",
                  txt2: "Log in",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetstartedButton extends StatelessWidget {
  const GetstartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: LinearGradient(
          colors: [Color(0xffD6D6F5), Color(0xff8484E1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).welcome_btn,
            style: Textstyles.medium25.copyWith(color: Colors.white),
          ),
          SizedBox(width: 20),
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Color(0xffD6D6F5)),
            color: Colors.white,
            onPressed: () {},
            icon: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
