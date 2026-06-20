import 'package:flutter/material.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/CategouriesPage/CategouriesPage.dart';
import 'package:graduation_project/presentation/Dictionary/dictionarypage.dart';
import 'package:graduation_project/presentation/ArGame/ar_card_game_screen.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/HomeService.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/Homecard.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/WelcomeMsg.dart';
import 'package:graduation_project/presentation/QuickPractice/quickpractice.dart';

class LearingHome extends StatelessWidget {
  const LearingHome({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getSavedUser();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                WelcomeMsg(user: user),
                const SizedBox(height: 16),
                Homecard(
                  txt1: S.of(context).home1_message,
                  txt2: S.of(context).home1_submessage,
                  img: "Assets/images/books.png",
                ),
                const SizedBox(height: 21),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Text(
                    S.of(context).home1_services,
                    style: Textstyles.medium25,
                  ),
                ),
                const SizedBox(height: 21),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      HomeService(
                        txt1: S.of(context).home1_service1,
                        txt2: S.of(context).home1_service1_desc,
                        img: "Assets/images/hands.png",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CategoriesPage()),
                        ),
                      ),
                      HomeService(
                        txt1: S.of(context).home1_service2,
                        txt2: S.of(context).home1_service2_desc,
                        img: "Assets/images/dict.png",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DictionaryPage()),
                        ),
                      ),
                      HomeService(
                        txt1: S.of(context).home1_service3,
                        txt2: S.of(context).home1_service3_desc,
                        img: "Assets/images/practice.png",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Quickpractice()),
                        ),
                      ),
                      HomeService(
                        txt1: S.of(context).home1_service4,
                        txt2: S.of(context).home1_service4_desc,
                        img: "Assets/images/game.png",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ArCardGameScreen(),
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
      ),
    );
  }
}
