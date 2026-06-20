import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/business_logic/Auth/GoogleAuth/google_auth_cubit.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';

class GoogleOrFacebook extends StatelessWidget {
  const GoogleOrFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GoogleAuthCubit(),
      child: const _GoogleButton(),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  /// Sentinel error codes the cubit emits map to localized strings. Anything
  /// else (server/API messages) we show verbatim.
  String _resolveMessage(BuildContext context, String raw) {
    switch (raw) {
      case 'google_sign_in_failed':
        return S.of(context).google_sign_in_failed;
      case 'google_no_id_token':
        return S.of(context).google_no_id_token;
      default:
        return raw;
    }
  }

  void _onSuccess(BuildContext context) {
    // Mirror LoginForm: refresh profile in the background, then route to the
    // home matching the user's saved mode.
    context.read<ProfileCubit>().getMainData();
    final mode = CacheHelper.getData('mode') as String? ?? 'l';
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => mode == 'l' ? LearingHome() : Translationhome(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccess) {
          _onSuccess(context);
        } else if (state is GoogleAuthFailure) {
          AppSnackBar.error(context, _resolveMessage(context, state.message));
        }
      },
      builder: (context, state) {
        final isLoading = state is GoogleAuthLoading;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: isLoading
                  ? null
                  : () => context.read<GoogleAuthCubit>().signInWithGoogle(),
              borderRadius: BorderRadius.circular(20),
              child: isLoading
                  ? const SizedBox(
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Color(0xff8484E1),
                      ),
                    )
                  : Image.asset(
                      "Assets/images/Vector.png",
                      height: 35,
                      width: 35,
                    ),
            ),
          ],
        );
      },
    );
  }
}
