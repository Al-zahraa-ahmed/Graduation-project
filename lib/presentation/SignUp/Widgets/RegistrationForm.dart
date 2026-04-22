import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/business_logic/Auth/SignUpCubit/SignUpCubit.dart';
import 'package:graduation_project/presentation/Otp/OtpPage.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool isRememberMe = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String email, name, pass, pass2;
  late int userid;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext) {
                return OtpPage(userId: state.userid, email: email, isResetPassword: false,);
              },
            ),
          );
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errormsg)));
        }
      },
      builder: (context, state) {
        return Form(
          key: formkey,
          child: Column(
            children: [
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).name_required;
                  }
                },
                label: S.of(context).profile_name,
                hint: S.of(context).enter_name,
                onsaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 45),
              CustomTextField(
                keyboardtype: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).email_required;
                  }
                },
                label: S.of(context).email,
                hint: S.of(context).enter_your_email,
                onsaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 45),
              CustomTextField(
                isabvious: true,
                label: S.of(context).password,
                hint: S.of(context).enter_your_password,
                onsaved: (value) {
                  pass = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).password_required;
                  }
                },
              ),
              SizedBox(height: 45),
              CustomTextField(
                label: S.of(context).profile_confirm_pass,
                hint: S.of(context).confirm_your_password,
                onsaved: (value) {
                  pass2 = value!;
                },
                validator: (value) {
                  if ((value == null || value.isEmpty)&& value==pass) {
                    return S.of(context).passwords_must_match;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Checkbox(
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.white; // الخلفية تفضل أبيض دايمًا
                      }),
                      checkColor: Color(0xff999999),
                      side: MaterialStateBorderSide.resolveWith((states) {
                        return BorderSide(
                          color: Color(0xff999999), // الحواف رمادي دايمًا
                          width: 2,
                        );
                      }),
                      value: isRememberMe,
                      onChanged: (newvalue) {
                        setState(() {
                          isRememberMe = newvalue!;
                        });
                      },
                    ),
                    MultiColorText(
                      txt1: S.of(context).agree_processing,
                      txt2: S.of(context).personal_data,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (formkey.currentState!.validate() &&
                      isRememberMe == true) {
                        formkey.currentState!.save();
                    context.read<SignUpCubit>().SignUp(
                      name: name,
                      email: email,
                      password: pass,
                      password2: pass2,
                      agreement: isRememberMe,
                    );
                    
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: state is SignUpLoading
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(txt: "Sign Up"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
