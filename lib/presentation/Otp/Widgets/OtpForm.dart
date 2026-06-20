import 'dart:async' show Timer;
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/business_logic/Auth/OtpCubit/otp_cubit.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/presentation/ForgetPasswordScreens/Setnewpassword.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';
import 'package:graduation_project/presentation/Otp/Widgets/Otp_input_fields.dart';

class OtpInputsForm extends StatefulWidget {
  const OtpInputsForm({
    super.key,
    required this.userid,
    required this.isResetPassword,
  });
  final int userid;
  final bool isResetPassword;
  @override
  State<OtpInputsForm> createState() => _OtpInputsFormState();
}

class _OtpInputsFormState extends State<OtpInputsForm> {
  int start = 59; // عدد الثواني للتايمر
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (start == 0) {
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();

    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    super.dispose();
  }

  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();

  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final f4 = FocusNode();

  void _submit() {
    final otp = c1.text + c2.text + c3.text + c4.text;
    if (otp.length != 4) {
      AppSnackBar.error(context, S.of(context).otp_incomplete);
      return;
    }
    if (widget.isResetPassword) {
      context.read<OtpCubit>().verifyForgetPassword(
        userid: widget.userid,
        otp: otp,
      );
    } else {
      context.read<OtpCubit>().verify_otp(
        userid: widget.userid,
        otp: otp,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerifySuccess) {
          timer?.cancel();
          if (!context.mounted) return;
          // Token is now cached; pull fresh profile so app-wide lang/mode
          // reflect what the server says. Fire-and-forget.
          context.read<ProfileCubit>().getMainData();
          // Route to the home matching the user's pre-signup mode choice
          // (saved to cache from the onboarding ChooseAppMode screen).
          final mode = CacheHelper.getData('mode') as String? ?? 'l';
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => mode == 'l' ? LearingHome() : Translationhome(),
              ),
            );
          });
        } else if (state is OtpForgetVerifySuccess) {
          timer?.cancel();
          if (!context.mounted) return;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SetNewPassword(reset_token: state.resetToken),
              ),
            );
          });
        } else if (state is OtpFailure) {
          AppSnackBar.error(context, state.errmsg);
        }
      },
      builder: (context, state) {
        final isLoading = state is OtpLoading;
        return Form(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpInput(controller: c1, focusNode: f1, nextFocusNode: f2),
                  OtpInput(
                    controller: c2,
                    focusNode: f2,
                    nextFocusNode: f3,
                    prevFocusNode: f1,
                  ),
                  OtpInput(
                    controller: c3,
                    focusNode: f3,
                    nextFocusNode: f4,
                    prevFocusNode: f2,
                  ),
                  OtpInput(controller: c4, focusNode: f4, prevFocusNode: f3),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "${start.toString()}s",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1E1E7B),
                    ),
                  ),
                  Text(
                    "  ${S.of(context).remaining}",
                    style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (start == 0) {
                        setState(() {
                          start = 30;
                        });
                        startTimer();
                        context.read<OtpCubit>().resend_otp(
                          userid: widget.userid,
                        );
                      }
                    },
                    child: Text(
                      S.of(context).resend_code,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        color: Color(0xff1E1E7B),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  txt: S.of(context).verify,
                  isLoading: isLoading,
                  onpressed: _submit,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
