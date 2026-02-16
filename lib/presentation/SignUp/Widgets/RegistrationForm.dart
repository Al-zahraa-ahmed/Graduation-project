import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/presentation/Otp/OtpPage.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextField(label: "Name", hint: "Enter your name"),
          SizedBox(height: 50),
          CustomTextField(label: "Email", hint: "Enter Your Email"),
          SizedBox(height: 50),
          CustomTextField(label: "Password", hint: "Enter Your Password"),
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
                  side: BorderSide(width: 2, color: Color(0xff999999)),
                  value: false,
                  onChanged: (newvalue) {},
                ),
                MultiColorText(
                  txt1: "I agree to the processing of",
                  txt2: "Personal data",
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CustomButton(txt: "Sign Up"),
          ),
        ],
      ),
    );
  }
}

