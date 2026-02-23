import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class Noconnection extends StatelessWidget {
  const Noconnection({super.key});

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
          "Not found",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        
        children: [
          SizedBox(height: 91,),
          Image.asset("Assets/images/noconnection.png",height: 150,width: 150,),
          SizedBox(height: 30,),
          Text("No connection!",style: Textstyles.medium25,),
          SizedBox(height: 8,),
          Text("It seems you’re offline. please check",style: TextStyle(color: Color(0xff999999),fontSize: 16),),
          Text("your connection and try again",style: TextStyle(color: Color(0xff999999),fontSize: 16),),
          SizedBox(height: 36,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Retrybutton(),
          )

        ],
      ),
    );
  }
}

class Retrybutton extends StatelessWidget {
  const Retrybutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32,vertical: 0),
      decoration: BoxDecoration(
        color: Color(0xff8484E1),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){}, icon: Image.asset("Assets/images/retry.png")),
            SizedBox(width: 6,),
            Text("Retry",style: Textstyles.medium20.copyWith(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}