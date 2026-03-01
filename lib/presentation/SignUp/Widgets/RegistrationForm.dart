import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/business_logic/SignUpCubit/SignUpCubit.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
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
                return OtpPage(userId: state.userid, email: email);
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
                    return "Name is required";
                  }
                },
                label: "Name",
                hint: "Enter your name",
                onsaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 50),
              CustomTextField(
                keyboardtype: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                },
                label: "Email",
                hint: "Enter Your Email",
                onsaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 50),
              CustomTextField(
                isabvious: true,
                label: "Password",
                hint: "Enter Your Password",
                onsaved: (value) {
                  pass = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                },
              ),
              SizedBox(height: 50),
              CustomTextField(
                label: "Confirm Password",
                hint: "Confirm Your Password",
                onsaved: (value) {
                  pass2 = value!;
                },
                validator: (value) {
                  if ((value == null || value.isEmpty)&& value==pass) {
                    return "Both passwords must match";
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
                      txt1: "I agree to the processing of",
                      txt2: "Personal data",
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
                      ? CircularProgressIndicator()
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
