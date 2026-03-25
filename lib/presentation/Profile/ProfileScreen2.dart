import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/presentation/About%20us%20screens/About_Us.dart';
import 'package:graduation_project/presentation/About%20us%20screens/ContactUs.dart';
import 'package:graduation_project/presentation/About%20us%20screens/HelpCenter.dart';
import 'package:graduation_project/presentation/About%20us%20screens/PrivacyPolicy.dart';
import 'package:graduation_project/presentation/About%20us%20screens/Terms_and_Conditions.dart';
import 'package:graduation_project/presentation/LogIn/LoginScreen.dart';
import 'package:graduation_project/presentation/Profile/Widgets/ChooseApplang.dart';
import 'package:graduation_project/presentation/Profile/Widgets/Chooseappmode.dart';
import 'package:graduation_project/presentation/Profile/Widgets/LougoutAndDelete.dart';
import 'package:graduation_project/presentation/Profile/Widgets/ProfileContainer.dart';
import 'package:graduation_project/presentation/Profile/Widgets/SectionContainer.dart';
import 'package:graduation_project/presentation/Profile/Widgets/SectionTitle.dart';
import 'package:graduation_project/presentation/Profile/Widgets/buildListTile.dart';
import 'package:graduation_project/presentation/Profile/Widgets/builddivider.dart';
import 'package:graduation_project/presentation/Profile_information/Profile_information.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getMainData(),
      child: Scaffold(
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
        body: ProfileScreenBlocBuilder(),
      ),
    );
  }
}

class ProfileScreenBlocBuilder extends StatelessWidget {
  const ProfileScreenBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ProfileSucces ) {
          final UserModel user = state.user;
          print(user.toJson().toString());
          return ProfileScreenBody(user: user);
        } else {
          return ProfileScreenBody();
        }
        
      },
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key, this.user});
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileContainer(
              email: user?.email ?? "email",
              username: user?.username,
            ),
            const SectionTitle(title: "Account"),
            SectionContainer(
              children: [
                buildListTile(
                  img: "Assets/images/settingsicon.png",
                  title: "Profile information",
                  ontap: () {
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
                BuildDivider(),
                ChooseLanguage(
                  firstselected: user?.language == "en"
                      ? AppLanguage.english
                      : AppLanguage.arabic,
                ),
                BuildDivider(),
                ChooseMode(
                  firstselected: user?.mode == "l"
                      ? AppMode.educationalMode
                      : AppMode.translationMode,
                ),
              ],
            ),
            const SectionTitle(title: "About"),
            const AboutContainer(),
            const SectionTitle(title: "Support"),
            const SupportContainer(),
            SizedBox(height: 8),
            LogoutAndDelete(
              img: "Assets/images/logout.png",
              title: 'Logout',
              ontap: () async {
                await CacheHelper.removeData("token");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => Loginscreen()),
                  (route) => false,
                );
              },
            ),

            LogoutAndDelete(
              img: "Assets/images/delete.png",
              title: "Delete Account",
              c: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class SupportContainer extends StatelessWidget {
  const SupportContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      children: [
        buildListTile(
          img: "Assets/images/contact.png",
          title: "Contact us",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) {
                  return Contactus();
                },
              ),
            );
          },
        ),
        BuildDivider(),
        buildListTile(
          img: "Assets/images/helpcenter.png",
          title: "Help Center",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) {
                  return HelpCenterScreen();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class AboutContainer extends StatelessWidget {
  const AboutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      children: [
        buildListTile(
          img: "Assets/images/about.png",
          title: "About Us",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) {
                  return AboutUsScreen();
                },
              ),
            );
          },
        ),
        BuildDivider(),
        buildListTile(
          img: "Assets/images/trerms.png",
          title: "Terms & conditions",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) {
                  return TermsScreen();
                },
              ),
            );
          },
        ),
        BuildDivider(),
        buildListTile(
          img: "Assets/images/privacy.png",
          title: "Privacy policy",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) {
                  return PrivacyPolicyScreen();
                },
              ),
            );
          },
        ),
        BuildDivider(),
        buildListTile(
          img: "Assets/images/appversion.png",
          title: "App version",
        ),
      ],
    );
  }
}
