import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/data/Models/ProfileModel.dart';
// import 'package:graduation_project/data/Models/UserModel.dart';
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
        if (state is ProfileLoading) {
    return const Center(child: CircularProgressIndicator());
  }
        if (state is ProfileSucces) {
          final ProfileModel user = state.user;
          print("kkkkkkkkkkkkkkkk");
          print(user.toJson().toString());
          return ProfileScreenBody(user: state.user);
        } 
        if (state is ProfileFailure) {
          return ProfileScreenBody();
    // return Center(child: Text(state.errmsg));

  }

  return const SizedBox.shrink();

      },
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key, this.user});
  final ProfileModel? user;

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Confirm Logout",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Are you sure you want to logout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff7C7CD5),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      await CacheHelper.removeData("token");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => Loginscreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD9D9D9),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Confirm Account Deletion",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Are you sure you want to delete your account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        final cubit = context.read<ProfileCubit>();
                        await cubit.deleteAccount();
                        await CacheHelper.removeData("token");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => Loginscreen()),
                          (route) => false,
                        );
                      } catch (e) {
                        Navigator.pop(dialogContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to delete account")),
                        );
                      }
                    },
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD9D9D9),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
              ontap: () {
                _showLogoutDialog(context);
              },
            ),

            LogoutAndDelete(
              img: "Assets/images/delete.png",
              title: "Delete Account",
              c: Colors.red,
              ontap: () {
                _showDeleteDialog(context);
              },
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
