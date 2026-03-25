import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/business_logic/Auth/ForgetPasswordCubit/forget_password_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Otp/OtpPage.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
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
              // SizedBox(width: 10,),
              Text(
                S.of(context).screen20,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Image.asset("Assets/images/password authentication complete.png"),
                SizedBox(height: 24),
                Text(
                  S.of(context).forget_title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(S.of(context).forget_desc, style: TextStyle(fontSize: 13)),
                Text(S.of(context).forget_desc2, style: TextStyle(fontSize: 13)),
                SizedBox(height: 34),
                ForgetPassForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPassForm extends StatelessWidget {
  ForgetPassForm({super.key});
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
   String email="";
  @override
  Widget build(BuildContext context) {
    final user = getSavedUser();
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
                    if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User data is missing')),
            );
            return;
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (builder) {
                return OtpPage(email: email, isResetPassword: true, userId: user!.id);
              },
            ),
          );
        } else if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errmsg)));
        }
      },
      builder: (context, state) {
        return Form(
          key: formkey,
          child: Column(
            children: [
              CustomTextField(
                hint: "Enter Your Email",
                label: "Email",
                onsaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    context.read<ForgetPasswordCubit>().forgetpassword(
                      email: email,
                    );
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(txt: "Confirm mail"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
