import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/QuickPractice/Widgets/gridviewofquized.dart';
import 'package:graduation_project/presentation/QuickPractice/Widgets/startbutton.dart';

class Quickpractice extends StatelessWidget {
  const Quickpractice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        centerTitle: true,
        leading: Row(
          children: [
            SizedBox(width: 20),
            IconButton(
              style: IconButton.styleFrom(backgroundColor: Color(0xffD6D6F5)),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.chevron_left),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        S.of(context).quiz_title,
                        style: Textstyles.medium20,
                      ),
                      Text(
                        S.of(context).quiz_desc,
                        style: Textstyles.regular13,
                      ),
                      SizedBox(height: 16),
                      StartButton(),
                    ],
                  ),
                ),

                Positioned(
                  right: -10,
                  bottom: -50,
                  child: Image.asset(
                    "Assets/images/Woman busy with her study assignments.png",
                    width: 148,
                    height: 148,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(elevation: 15,color: Colors.white,child: GridviewOfQuiz()),
          )),
        ],
      ),
    );
  }
}

