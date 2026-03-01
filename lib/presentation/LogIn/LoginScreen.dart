import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/LoginCubit/login_cubit.dart';
import 'package:graduation_project/presentation/LogIn/Widgets/LoginContainer.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Color(0xffEAEAFA),
        body: SingleChildScrollView(
          child: Column(children: [SizedBox(height: 210), LoginContainer()]),
        ),
      ),
    );
  }
}
