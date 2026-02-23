import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(
        centerTitle: true,
        leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),),
        elevation: 0,
        backgroundColor: Color(0xffD6D6F5),
        foregroundColor: Colors.black,
        title: const Text(
          "Contact us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text("We welcome your inquiries",style: Textstyles.medium20,),
            Image.asset("Assets/images/Chat dialog with support service.png"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("Assets/images/facebook.png",height: 66,width:66,),
                  Image.asset("Assets/images/phone.png",height: 66,width: 66,),
                  Image.asset("Assets/images/mail.png",height: 66,width: 66,),
                  Image.asset("Assets/images/whats.png",height: 66,width: 66,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}