import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/presentation/ForgetPasswordScreens/ForgetPassword.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isRememberMe = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String email, pass;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
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
          SizedBox(height: 60),
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
          SizedBox(height: 10),
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
                Text(
                  "Remember me",
                  style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (buildcontext) {
                          return Forgetpassword();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 13,
                      // color: Color(0xff1E1E7B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              if(formkey.currentState!.validate()){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext) {
                    return LearingHome();
                  },
                ),
              );
                
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(txt: "Log In"),
            ),
          ),
        ],
      ),
    );
  }
}
