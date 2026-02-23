import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';

class Profile_information extends StatelessWidget {
  const Profile_information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Stack(
            clipBehavior: Clip.none,
            // alignment: AlignmentGeometry.bottomLeft,
            children: [
              Image.asset("Assets/images/Group 1.png"),
              Positioned(
                top: 30,
                left: 20,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Color(0xffD6D6F5),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.chevron_left),
                ),
              ),
              Positioned(left: 0,right: 0,bottom: -40,child: Image.asset("Assets/images/Ellipse 4.png",height: 99,width: 99,))
            ],
          ),
          SizedBox(height: 68,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
            CustomTextField(hint: "Zahraaahmed17", label: "User Name"),
            SizedBox(height: 24,),
            CustomTextField(hint: "Zahraa Ahmed", label: "Name"),
            SizedBox(height: 24,),
            CustomTextField(hint: "*****************", label: "Current Password"),
            SizedBox(height: 24,),
            CustomTextField(hint: "*****************", label: "New Password"),
            SizedBox(height: 24,),
            CustomTextField(hint:"*****************", label: "Confirm Password"),
            SizedBox(height: 20,),
            SizedBox(width: double.infinity,child: CustomButton(txt: "save changes")),
            SizedBox(height: 12,),
            SizedBox(width: double.infinity,child: CustomButton(txt: "Cancel",c: Color(0xffCCCCCC),)),
            
              ],
            ),
          )
        ],
      ),
    );
  }
}