import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';

enum AppMode { educationalMode, translationMode }

class ChooseMode extends StatefulWidget {
  const ChooseMode({super.key, required this.firstselected});
final AppMode firstselected;
  @override
  State<ChooseMode> createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ChooseMode> {
  AppMode selectedMode = AppMode.educationalMode;
  bool isExpanded = false;
  @override
  void initState() {
    if (widget.firstselected == AppMode.educationalMode) {
      selectedMode = AppMode.educationalMode;
    } else {
      selectedMode = AppMode.translationMode;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.only(left: 6, right: 2),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        leading: Image.asset(
          "Assets/images/appmode.png",
          height: 28,
          width: 28,
        ),
        title: Text(S.of(context).account_mode, style: TextStyle(fontSize: 16)),
        trailing: isExpanded
            ? Icon(Icons.keyboard_arrow_down)
            : Icon(Icons.chevron_right, size: 28),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 4,
              bottom: 12,
              top: 6,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).mode_learn, style: TextStyle(fontSize: 16)),
                    InkWell(
                      onTap: () {
                        if (selectedMode == AppMode.educationalMode) return;
                        context.read<ProfileCubit>().changeMode(mode: "l");
                        selectedMode = AppMode.educationalMode;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LearingHome()),
                          (route) => false,
                        );
                      },
                      child: CheckContainer(
                        isselected: selectedMode == AppMode.educationalMode,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).mode_ass, style: TextStyle(fontSize: 16)),
                    InkWell(
                      onTap: () {
                        if (selectedMode == AppMode.translationMode) return;
                        context.read<ProfileCubit>().changeMode(mode: "a");
                        selectedMode = AppMode.translationMode;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => Translationhome()),
                          (route) => false,
                        );
                      },
                      child: CheckContainer(
                        isselected: selectedMode == AppMode.translationMode,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}