
import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/presentation/CustomWidgets/CustomTextField.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextField(label: "Email", hint: "Enter Your Email"),
          SizedBox(height: 60),
          CustomTextField(label: "Password", hint: "Enter Your Password"),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Checkbox(
                  side: BorderSide(width: 2, color: Color(0xff999999)),
                  value: false,
                  onChanged: (newvalue) {},
                ),
                Text(
                  "Remember me",
                  style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                ),
                Spacer(),
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff1E1E7B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: CustomButton(txt: "Log In"),
          ),
        ],
      ),
    );
  }
}
