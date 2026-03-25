import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/CategouriesPage/CategouriesPage.dart';
import 'package:graduation_project/presentation/Dictionary/dictionarypage.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/HomeService.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/Homecard.dart';
import 'package:graduation_project/presentation/Profile/ProfileScreen2.dart';
import 'package:graduation_project/presentation/QuickPractice/quickpractice.dart';

class LearingHome extends StatelessWidget {
  const LearingHome({super.key});

  @override
  Widget build(BuildContext context) {
    final userString = CacheHelper.getData("user");
    final userMap = jsonDecode(userString);
    final user = UserModel.fromJson(userMap);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                WelcomeMsg(user: user),
                SizedBox(height: 16),
                Homecard(txt1: S.of(context).home1_message, txt2: S.of(context).home1_submessage, img: "Assets/images/books.png",),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (buildcontext) {
                                return CategoriesPage();
                              },
                            ),
                          );
                        },
                        child: HomeService(
                          txt1: S.of(context).home1_service1,
                          txt2: S.of(context).home1_service1_desc,
                          img: "Assets/images/hands.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (buildcontext) {
                                return DictionaryPage();
                              },
                            ),
                          );
                        },
                        child: HomeService(
                          txt1: S.of(context).home1_service2,
                          txt2: S.of(context).home1_service2_desc,
                          img: "Assets/images/dict.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (buildcontext) {
                                return Quickpractice();
                              },
                            ),
                          );
                        },
                        child: HomeService(
                          txt1: S.of(context).home1_service3,
                          txt2: S.of(context).home1_service3_desc,
                          img: "Assets/images/practice.png",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (buildcontext) {
                                return Translationhome();
                              },
                            ),
                          );
                        },
                        child: HomeService(
                          txt1: S.of(context).home1_service4,
                          txt2: S.of(context).home1_service4_desc,
                          img: "Assets/images/game.png",
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

class WelcomeMsg extends StatelessWidget {
  const WelcomeMsg({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(right: 8, left: 20),
      title: Text("${user.username}!", style: TextStyle(fontSize: 20)),
      subtitle: Text(
        S.of(context).home1_welcome,
        style: Textstyles.medium13.copyWith(color: Color(0xff999999)),
      ),
      trailing: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) {
                return ProfileScreen();
              },
            ),
          );
        },
        child: Image.asset("Assets/images/settings.png"),
      ),
    );
  }
}
