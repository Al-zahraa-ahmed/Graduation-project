
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/CategouriesPage/CategouriesPage.dart';
import 'package:graduation_project/presentation/ChatPage/chatbot.dart';
import 'package:graduation_project/presentation/Dictionary/dictionarypage.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/HomeService.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/Homecard.dart';
import 'package:graduation_project/presentation/Profile/ProfileScreen2.dart';
import 'package:graduation_project/presentation/QuickPractice/quickpractice.dart';
import 'package:graduation_project/presentation/QuickRespose/quickresponse.dart';
import 'package:graduation_project/presentation/VideoTranslation/CameraScreen.dart';
import 'package:graduation_project/presentation/VideoTranslation/HandTrackingScreen.dart';
import 'package:graduation_project/presentation/VideoTranslation/VideoTranslationScreen.dart';
import 'package:graduation_project/presentation/VideoTranslation/cameraboxScreen.dart';
import 'package:graduation_project/presentation/VideoTranslation/handtrackingview.dart';

class Translationhome extends StatelessWidget {
  const Translationhome({super.key});

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
                Homecard(txt1: "Translate your Thoughts", txt2: "Because everyone deserves to be understood.", img: "Assets/images/Chatbot high-fives and answers the question.png",),
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
                                return HandTrackerView();
                              },
                            ),
                          );
                        },
                        child: HomeService(
                          txt1: "Video Translation",
                          txt2: "Capture video and convert it into translated text.",
                          img: "Assets/images/videotranslation.png",
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
                          txt1: "Voice Translation",
                          txt2: "Convert spoken language into accurate text instantly.",
                          img: "Assets/images/voicereco.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (buildcontext) {
                                return ChatPage();
                              },
                            ),
                          );
                        },
                        child: HomeService(
                          txt1: "Quick Response",
                          txt2: "Fast responses for common daily situations.",
                          img: "Assets/images/quickresponse.png",
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


class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}