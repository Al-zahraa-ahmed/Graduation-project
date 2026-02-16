import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/learningcards.dart';

class GridOfCards extends StatelessWidget {
  const GridOfCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      itemCount: 16,
      itemBuilder: (BuildContext context, int index) {
        return LearningCards();
      },
    );
  }
}