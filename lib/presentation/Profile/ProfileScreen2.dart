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
  void initState() {
    super.initState();
    // Defensive: if the user lands here before the app-level getMainData
    // (e.g. cold-start with a token but main.dart's bloc was rebuilt), make
    // sure we kick off the fetch instead of showing a blank body.
    final cubit = context.read<ProfileCubit>();
    if (cubit.state is ProfileInitial) {
      cubit.getMainData();
    }
  }

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
        // Initial (before fetch starts) and Loading both show the spinner
        // so the user never sees a half-rendered profile with placeholder
        // text while the network is in flight.
        if (state is ProfileInitial || state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileSucces) {
          return ProfileScreenBody(user: state.user);
        }
        if (state is ProfilePrefUpdateFailed) {
          return ProfileScreenBody(user: state.user);
        }
        if (state is ProfileFailure) {
          return _ProfileErrorState(
            message: state.errmsg,
            onRetry: () => context.read<ProfileCubit>().getMainData(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _ProfileErrorState extends StatelessWidget {
  const _ProfileErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(S.of(context).retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8484E1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
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
      barrierDismissible: false,
      builder: (_) => const _DeleteAccountDialog(),
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
              imgUrl: user?.img,
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

/// Confirmation dialog for account deletion.
///
/// Stateful so it can: show an in-button spinner during the network call,
/// guard against double-taps, and use `mounted` checks instead of a raw
/// BuildContext across the async gap.
class _DeleteAccountDialog extends StatefulWidget {
  const _DeleteAccountDialog();

  @override
  State<_DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<_DeleteAccountDialog> {
  bool _loading = false;

  Future<void> _confirmDelete() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      await context.read<ProfileCubit>().deleteAccount();
      await CacheHelper.removeData("token");
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => Loginscreen()),
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      AppSnackBar.error(context, S.of(context).something_went_wrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).delete_title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).delete_desc,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _loading ? null : _confirmDelete,
                child: _loading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        S.of(context).delete_btn1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD9D9D9),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                // Block cancel mid-request so we don't leave an orphaned
                // delete call racing against a dismissed dialog.
                onPressed: _loading ? null : () => Navigator.pop(context),
                child: Text(
                  S.of(context).delete_btn2,
                  style: const TextStyle(
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
