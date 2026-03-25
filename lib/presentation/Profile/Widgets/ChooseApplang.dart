import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/data/Services/UserApiService.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';

enum AppLanguage { arabic, english }

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key, required this.firstselected});
  final AppLanguage firstselected;
  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  final UserApiService userapi = UserApiService();
  late AppLanguage selectedLang;
  bool isExpanded = false;
  // bool arabic = false;
  @override
  void initState() {
    if (widget.firstselected == AppLanguage.arabic) {
      selectedLang = AppLanguage.arabic;
    } else {
      selectedLang = AppLanguage.english;
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
        leading: Image.asset("Assets/images/lang.png", height: 28, width: 28),
        title: Text("Language", style: TextStyle(fontSize: 16)),
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
                    Text("Arabic", style: TextStyle(fontSize: 16)),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          selectedLang = AppLanguage.arabic;
                        });
                        await userapi.changeLanguage(language: "ar");
                      },
                      child: CheckContainer(
                        isselected: selectedLang == AppLanguage.arabic,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("English", style: TextStyle(fontSize: 16)),
                    InkWell(
                      onTap: ()async {
                        setState(() {
                          selectedLang = AppLanguage.english;
                        });
                        await userapi.changeLanguage(language: "en");
                        
                      },
                      child: CheckContainer(
                        isselected: selectedLang == AppLanguage.english,
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
