import 'package:flutter/material.dart';
import 'package:graduation_project/data/Models/CategoryModel.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/learningcards.dart';
import 'package:graduation_project/presentation/Lessons/lessonScreen.dart';

class GridOfCards extends StatelessWidget {
  const GridOfCards({super.key, required this.l});
  final List<CategoryModel> l;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
      ),
      itemCount: l.length,
      itemBuilder: (BuildContext context, int index) {
        return LearningCards(
          c: l[index],
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) {
                  return LessonsScreen(id: l[index].id, title:isArabic()? l[index].name.ar:l[index].name.en,);
                },
              ),
            );
          },
        );
      },
    );
  }
}
