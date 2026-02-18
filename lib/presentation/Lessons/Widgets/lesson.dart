
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class Lesson extends StatefulWidget {
  const Lesson({super.key});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  bool isselected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0,right: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Color(0xffD6D6F5),
              borderRadius: BorderRadius.circular(40),
            ),
      
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isselected = !isselected;
                });
              },
              child: Container(
                height: 22,
                width: 22,
                // padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: isselected ? Color(0xff5B5BD7) : null,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(width: 2, color: Color(0xff5B5BD7)),
                ),
                child: Center(
                  child: Icon(
                    fontWeight: FontWeight.w800,
                    size: 14,
                    Icons.check,
                    color: isselected ? Colors.white : Color(0xff5B5BD7),
                  ),
                ),
              ),
            ),
          ),
      
      // **************************
          SizedBox(width: 23,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lesson 1",style: TextStyle(fontSize: 20,color: Color(0xff999999)),),
              // SizedBox(height: 5,),
              Text("Father",style: TextStyle(fontSize: 20,),),
            ],
          ),
              Expanded(child: SizedBox()),
              Text("20.15",style: Textstyles.medium13.copyWith(color: Color(0xff999999)),),
      
      
      
      
        ],
      ),
    );
  }
}
