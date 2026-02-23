import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/presentation/About%20us%20screens/About_Us.dart';
import 'package:graduation_project/presentation/About%20us%20screens/ContactUs.dart';
import 'package:graduation_project/presentation/About%20us%20screens/HelpCenter.dart';
import 'package:graduation_project/presentation/About%20us%20screens/PrivacyPolicy.dart';
import 'package:graduation_project/presentation/About%20us%20screens/Terms_and_Conditions.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';
import 'package:graduation_project/presentation/Profile/Widgets/ProfileContainer.dart';
import 'package:graduation_project/presentation/Profile/Widgets/SectionContainer.dart';
import 'package:graduation_project/presentation/Profile/Widgets/SectionTitle.dart';
import 'package:graduation_project/presentation/Profile/Widgets/buildListTile.dart';
import 'package:graduation_project/presentation/Profile/Widgets/builddivider.dart';
import 'package:graduation_project/presentation/Profile_information/Profile_information.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
  bool isLanguageExpanded = false;
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Profile", style: Textstyles.medium25),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Card
            SizedBox(height: 8),
            ProfileContainer(),

            const SizedBox(height: 24),
            const SectionTitle(title: "Account"),

            // SizedBox(height: 12,),
            SectionContainer(
              children: [
                /// Profile information
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) {
                          return Profile_information();
                        },
                      ),
                    );
                  },
                  child: buildListTile(
                  icon:  Icons.settings,
                  title:   "Profile information",
                   ontap:  () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) {
                            return Profile_information();
                          },
                        ),
                      );
                    },
                  ),
                ),

                BuildDivider(),

                /// Language (Expandable)
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 6),
                  leading: const Icon(Icons.language),
                  title: const Text("Language"),
                  trailing: Icon(
                    isLanguageExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.chevron_right,
                  ),
                  onTap: () {
                    setState(() {
                      isLanguageExpanded = !isLanguageExpanded;
                    });
                  },
                ),

                if (isLanguageExpanded) ...[
                  buildLanguageOption("Arabic"),
                  buildLanguageOption("English"),
                ],

                BuildDivider(),

                /// App Mode (no switches)
                buildListTile(icon:Icons.mic,title: "App Mode",ontap:  () {}),
              ],
            ),

            const SizedBox(height: 24),
            const SectionTitle(title: "About"),

            SectionContainer(
              children: [
                buildListTile(icon:Icons.info_outline,title:  "About Us",ontap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) {
                        return AboutUsScreen();
                      },
                    ),
                  );
                }),
                BuildDivider(),
                buildListTile(icon:Icons.security,title:  "Terms & conditions",ontap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) {
                        return TermsScreen();
                      },
                    ),
                  );
                }),
                BuildDivider(),
                buildListTile(icon:Icons.privacy_tip, title:"Privacy policy",ontap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) {
                        return PrivacyPolicyScreen();
                      },
                    ),
                  );
                }),
                BuildDivider(),
                buildListTile(icon:Icons.update,title: "App version",ontap:  () {}),
              ],
            ),

            const SizedBox(height: 24),
            const SectionTitle(title: "Support"),

            SectionContainer(
              children: [
                buildListTile(icon:Icons.phone,title: "Contact us",ontap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) {
                        return Contactus();
                      },
                    ),
                  );
                }),
                BuildDivider(),
                buildListTile(icon:Icons.help_outline,title: "Help Center",ontap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) {
                        return HelpCenterScreen();
                      },
                    ),
                  );
                }),
              ],
            ),

            const SizedBox(height: 16),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("LogOut"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageOption(String language) {
    final bool isSelected = selectedLanguage == language;

    return InkWell(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Expanded(child: Text(language)),
            CheckContainer(isselected: isSelected),
          ],
        ),
      ),
    );
  }

}

