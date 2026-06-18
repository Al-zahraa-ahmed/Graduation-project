import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/data/Models/ProfileModel.dart';
// import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/presentation/About%20us%20screens/About_Us.dart';
import 'package:graduation_project/presentation/About%20us%20screens/ContactUs.dart';
import 'package:graduation_project/presentation/About%20us%20screens/HelpCenter.dart';
import 'package:graduation_project/presentation/About%20us%20screens/PrivacyPolicy.dart';
import 'package:graduation_project/presentation/About%20us%20screens/Terms_and_Conditions.dart';
import 'package:graduation_project/generated/l10n.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        title: Text(S.of(context).profile_title, style: Textstyles.medium25),
      ),
      body: ProfileScreenBlocBuilder(),
    );
  }
}

class ProfileScreenBlocBuilder extends StatelessWidget {
  const ProfileScreenBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // Surface failed pref-syncs (changeLang / changeMode) to the user.
        // The cubit has already rolled back its in-memory state so the UI
        // continues to show the previous (now-canonical) lang/mode.
        if (state is ProfilePrefUpdateFailed) {
          AppSnackBar.error(context, state.errmsg);
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileSucces) {
          return ProfileScreenBody(user: state.user);
        }
        if (state is ProfilePrefUpdateFailed) {
          return ProfileScreenBody(user: state.user);
        }
        if (state is ProfileFailure) {
          return ProfileScreenBody();
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
                  S.of(context).logout_title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  S.of(context).logout_desc,
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
                      S.of(context).logout,
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
                      S.of(context).delete_btn2,
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
                  S.of(context).delete_title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  S.of(context).delete_desc,
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
                          SnackBar(content: Text(S.of(context).profile_load_error)),
                        );
                      }
                    },
                    child: Text(
                      S.of(context).delete_btn1,
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
                      S.of(context).delete_btn2,
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
            SectionTitle(title: S.of(context).account_title),
            SectionContainer(
              children: [
                buildListTile(
                  img: "Assets/images/settingsicon.png",
                  title: S.of(context).account_info,
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
                const ChooseLanguage(),
                BuildDivider(),
                const ChooseMode(),
              ],
            ),
            SectionTitle(title: S.of(context).about_title),
            const AboutContainer(),
            SectionTitle(title: S.of(context).support_title),
            const SupportContainer(),
            SizedBox(height: 8),
            LogoutAndDelete(
              img: "Assets/images/logout.png",
              title: S.of(context).logout,
              ontap: () {
                _showLogoutDialog(context);
              },
            ),

            LogoutAndDelete(
              img: "Assets/images/delete.png",
              title: S.of(context).account_delete,
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
          title: S.of(context).support_contact,
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
          title: S.of(context).support_help,
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
          title: S.of(context).about_about,
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
          title: S.of(context).about_terms,
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
          title: S.of(context).about_privacy,
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
          title: S.of(context).about_version,
        ),
      ],
    );
  }
}
