import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Lessons/lessons_cubit.dart';
import 'package:graduation_project/data/Models/LessonsModel.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/CustomSegmentedControl.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key, required this.id, required this.title});
  final int id;
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonsCubit()..loadLessons(id: id),
      child: Scaffold(
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
          title: Text(title, style: Textstyles.medium25),
        ),
        body: LessonScreenBody(),
      ),
    );
  }
}

class LessonScreenBody extends StatefulWidget {
  const LessonScreenBody({super.key});

  @override
  State<LessonScreenBody> createState() => _LessonScreenBodyState();
}

class _LessonScreenBodyState extends State<LessonScreenBody> {
  bool isselected = false;
  int currentindex = 0;
   List<bool> selectedItems = [];
  bool isallselected = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonsCubit, LessonsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LessonsSuccess) {
          final List<LessonsModel> l = state.lessons;
          if (selectedItems.length != l.length) {
            selectedItems = List.generate(l.length, (_) => false);
          }
          // List<LessonsModel> filtered = isallselected? l: List.generate(l.length, (index) => index).where((index) => selectedItems[index]).map((index) => l[index]).toList();
          List<LessonsModel> filtered;

if (isallselected) {
  filtered = l;
} else {
  filtered = [];

  for (int i = 0; i < l.length; i++) {
    if (selectedItems[i]) {
      filtered.add(l[i]);
    }
  }
}
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: Text(
                    "${state.progress} Lessons",
                    style: Textstyles.medium13.copyWith(
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomSegmentedControl(
                  onChanged: (bool value) {
                    setState(() {
                    isallselected = value;
                      
                    });
                  },
                ),
                SizedBox(height: 40),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final lesson = filtered[index];
                        final originalIndex = l.indexOf(lesson);
                      return Lesson(
                        l: filtered[index],
                        index: originalIndex + 1,
                        ontap: () {
                          setState(() {
                            selectedItems[originalIndex] = !selectedItems[originalIndex];
                          });
                        },
                        isselected: selectedItems[originalIndex],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is LessonsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LessonsError) {
          return Center(child: Text(state.message));
        } else {
          return Text("hi");
        }
      },
    );
  }
}
