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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffEAEAFA),
           resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints:BoxConstraints(minHeight: constraints.maxHeight) ,
                  child: Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Column(children: [ LoginContainer()]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
