import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/OtpCubit/otp_cubit.dart';
import 'package:graduation_project/presentation/Otp/Widgets/Locpic.dart';
import 'package:graduation_project/presentation/Otp/Widgets/OtpForm.dart';


class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.userId, required this.email});
  final int userId;
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: Scaffold(
        backgroundColor: Color(0xffEAEAFA),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Lockpic(),
              SizedBox(height: 16),
              Text(
                textAlign: TextAlign.center,
                "For your security, We have sent A One-Time Code to your email $email Enter It to access your account.",
                style: TextStyle(fontSize: 13, color: Color(0xff999999)),
              ),
              SizedBox(height: 20),
              OtpInputsForm(userid: userId,),
             
            ],
          ),
        ),
      ),
    );
  }
}
