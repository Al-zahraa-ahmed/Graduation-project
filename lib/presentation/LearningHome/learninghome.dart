import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/HomeService.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/Homecard.dart';

class LearingHome extends StatelessWidget {
  const LearingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            ListTile(
              contentPadding: EdgeInsets.only(right: 8, left: 20),
              title: Text("Roaa Shosha!", style: TextStyle(fontSize: 20)),
              subtitle: Text(
                S.of(context).home1_welcome,
                style: Textstyles.medium13.copyWith(color: Color(0xff999999)),
              ),
              trailing: Image.asset("Assets/images/settings.png"),
            ),
            SizedBox(height: 16),
            Homecard(),
            SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                S.of(context).home1_services,
                style: Textstyles.medium25,
              ),
            ),
            SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  HomeService(
                    txt1: S.of(context).home1_service1,
                    txt2: S.of(context).home1_service1_desc,
                    img: "Assets/images/hands.png",
                  ),
                  HomeService(
                    txt1: S.of(context).home1_service2,
                    txt2: S.of(context).home1_service2_desc,
                    img: "Assets/images/dict.png",
                  ),
                  HomeService(
                    txt1: S.of(context).home1_service3,
                    txt2: S.of(context).home1_service3_desc,
                    img: "Assets/images/practice.png",
                  ),
                  HomeService(
                    txt1: S.of(context).home1_service4,
                    txt2: S.of(context).home1_service4_desc,
                    img: "Assets/images/game.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
