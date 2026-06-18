import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/SendFrames/send_frames_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/HomeService.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/Homecard.dart';
import 'package:graduation_project/presentation/LearningHome/widgets/WelcomeMsg.dart';
import 'package:graduation_project/presentation/QuickRespose/quickresponse.dart';
import 'package:graduation_project/presentation/VideoTranslation/handtrackingview.dart';
import 'package:graduation_project/presentation/VoiceTranslation/voice_translation_page.dart';

class Translationhome extends StatelessWidget {
  const Translationhome({super.key});

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
                  txt1: S.of(context).home2_message,
                  txt2: S.of(context).home2_submessage,
                  img:
                      "Assets/images/Chatbot high-fives and answers the question.png",
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
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => SignPredictionCubit()..initModel(),
                              child: const HandTrackerView(),
                            ),
                          ),
                        ),
                        child: HomeService(
                          txt1: S.of(context).home2_service1,
                          txt2: S.of(context).home2_service1_desc,
                          img: "Assets/images/videotranslation.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VoiceTranslationPage(),
                          ),
                        ),
                        child: HomeService(
                          txt1: S.of(context).home2_service2,
                          txt2: S.of(context).home2_service2_desc,
                          img: "Assets/images/voicereco.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuickResponsePage(),
                          ),
                        ),
                        child: HomeService(
                          txt1: S.of(context).home2_service3,
                          txt2: S.of(context).home2_service3_desc,
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
