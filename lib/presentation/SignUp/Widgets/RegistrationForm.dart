import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
bool isRememberMe = false;
GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String email,name ,pass,pass2;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          CustomTextField(label: "Name", hint: "Enter your name"),
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
              child: CustomButton(txt: "Sign Up"),
            ),
          ),
        ],
      ),
    );
  }
}

