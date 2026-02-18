import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/CustomSegmentedControl.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

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
        title: Text(S.of(context).lessons_vocab, style: Textstyles.medium25),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text(
                "0/10 Lessons",
                style: Textstyles.medium13.copyWith(color: Color(0xff999999)),
              ),
            ),
            SizedBox(height: 20),
            CustomSegmentedControl(),
            SizedBox(height: 40),
Expanded(
  child: ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Lesson();
    },
  ),
)
          ],
        ),
      ),
    );
  }
}
