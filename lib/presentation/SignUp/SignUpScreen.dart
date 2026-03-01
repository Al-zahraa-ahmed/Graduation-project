import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/SignUpCubit/SignUpCubit.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/SignUpContainer.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SignUpCubit();
      },
      child: Scaffold(
        backgroundColor: Color(0xffEAEAFA),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60,),
              SignupContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
