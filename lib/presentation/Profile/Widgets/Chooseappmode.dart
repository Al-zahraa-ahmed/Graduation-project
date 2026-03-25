import 'package:flutter/material.dart';
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
        title: Text("App Mode", style: TextStyle(fontSize: 16)),
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
                    Text("Educational Mode", style: TextStyle(fontSize: 16)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedMode = AppMode.educationalMode;
                        });
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
                    Text("Translation Mode", style: TextStyle(fontSize: 16)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedMode = AppMode.translationMode;
                        });
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