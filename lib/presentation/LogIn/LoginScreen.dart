import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Auth/LoginCubit/login_cubit.dart';
import 'package:graduation_project/presentation/LogIn/Widgets/LoginContainer.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffEAEAFA),
        // Keep the sheet anchored at a fixed 70% of the screen even when the
        // keyboard opens. The SingleChildScrollView inside LoginContainer
        // scrolls the focused TextField above the keyboard.
        resizeToAvoidBottomInset: false,
        // SafeArea applied only at the top so the sheet's bottom edge sits
        // flush with the bottom of the screen (no gesture-area gap).
        body: SafeArea(
          bottom: false,
          child: Column(
            children: const [
              Spacer(),
              LoginContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
