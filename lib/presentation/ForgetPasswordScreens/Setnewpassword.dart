
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/ForgetPasswordScreens/ChangedSuccessfully.dart';

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar:  AppBar(
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
              S.of(context).screen21,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Image.asset("Assets/images/Man with shield protecting data in laptop.png"),
            SizedBox(height: 24),
            Text(
              S.of(context).new_title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(S.of(context).new_desc, style: TextStyle(fontSize: 13)),
            Text(S.of(context).new_desc2, style: TextStyle(fontSize: 13)),
            SizedBox(height: 34),
            CustomTextField(hint: "Enter Your Password", label: "Password"),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(alignment: AlignmentGeometry.bottomLeft,child: Text(S.of(context).new_warning1,style: TextStyle(fontSize: 13,color: Color(0xff999999)),)),
            ),
            SizedBox(height: 34),
            CustomTextField(hint: "Enter Your Password", label: "Confirmed Password "),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(alignment: AlignmentGeometry.bottomLeft,child: Text(S.of(context).new_warning2,style: TextStyle(fontSize: 13,color: Color(0xff999999)),)),
            ),

            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (buildcontext) {
                      return MessagePage();
                    },
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(txt: "Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}