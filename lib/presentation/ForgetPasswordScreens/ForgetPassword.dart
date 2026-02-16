import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/ForgetPasswordScreens/Setnewpassword.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
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
            CustomTextField(hint: "Enter Your Email", label: "Email"),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (buildcontext) {
                      return SetNewPassword();
                    },
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(txt: "Confirm mail"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

