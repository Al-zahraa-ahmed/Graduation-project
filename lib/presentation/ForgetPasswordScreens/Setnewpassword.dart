import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/business_logic/Auth/ResetPasswordCubit/reset_password_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/ForgetPasswordScreens/ChangedSuccessfully.dart';

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({super.key, required this.reset_token});
  final String reset_token;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left),
              ),
              Text(
                S.of(context).screen21,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "Assets/images/Man with shield protecting data in laptop.png",
                ),
                SizedBox(height: 24),
                Text(
                  S.of(context).new_title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(S.of(context).new_desc, style: TextStyle(fontSize: 13)),
                Text(S.of(context).new_desc2, style: TextStyle(fontSize: 13)),
                SizedBox(height: 34),
                ResetPasswordForm(reset_token: reset_token,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key, required this.reset_token});
  final String reset_token;
  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  late String pass1, pass2;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (buildcontext) {
                return MessagePage();
              },
            ),
          );
        } else if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errmsg)));
        } else if (state is ResetPasswordLoading) {
          print("hi");
        }
      },
      builder: (context, state) {
        return Form(
          key: formkey,
          child: Column(
            children: [
              CustomTextField(
                hint: "Enter Your Password",
                label: "Password",
                onsaved: (value) {
                  pass1 = value!;
                },
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: Text(
                    S.of(context).new_warning1,
                    style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                  ),
                ),
              ),
              SizedBox(height: 34),
              CustomTextField(
                hint: "Enter Your Password",
                label: "Confirmed Password ",
                onsaved: (value) {
                  pass2 = value!;
                },
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: Text(
                    S.of(context).new_warning2,
                    style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                  ),
                ),
              ),

              SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    context.read<ResetPasswordCubit>().resetPassword(
                      reset_token: widget.reset_token,
                      pass: pass1,
                      pass2: pass2,
                    );
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(txt: "Reset Password"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
