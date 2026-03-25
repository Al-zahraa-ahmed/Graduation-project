import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';
import 'package:graduation_project/data/Models/WordModel.dart';



class DictionarySection extends StatelessWidget {
  const DictionarySection ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      buildWhen: (previous, current) {
        if (previous is DictionarySuccess && current is DictionarySuccess) {
          return previous.selectedCategory != current.selectedCategory ||
              previous.allWordsByLetters != current.allWordsByLetters;
        }
        return true;
      },
      builder: (context, state) {
          if (state is! DictionarySuccess) return const SizedBox();

        final List<WordModel> words = state.allWordsByLetters.values
            .expand((list) => list)
            .toList();

        final List<String> categories = words
            .map((e) => e.category)
            .toSet()
            .toList();
        return SizedBox(
          height: 60,
          child: ListViewOfDictionarySections(l: categories, ontap:  (String category) {
              context.read<DictionaryCubit>().selectCategory(
                state.selectedCategory == category ? null : category,
              );
            },selectedCategory: state.selectedCategory ,),
        );
      },
    );
  }
}

class ListViewOfDictionarySections extends StatelessWidget {
 const ListViewOfDictionarySections({super.key, required this.l, this.selectedCategory, required this.ontap});
  final String? selectedCategory;
  final List<String> l;
  final ValueChanged<String> ontap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 30),
      scrollDirection: Axis.horizontal,
      itemCount: l.length,
      itemBuilder: (buildcontext, index) {
        final category = l[index];
        return Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap:()=> ontap(category),
              child: DictionarySections(
                txt: l[index],
                isSelected: selectedCategory == category,
              ),
            ),
            SizedBox(height: 14),
          ],
        );
      },
    );
  }
}

class DictionarySections extends StatelessWidget {
 const DictionarySections({super.key, required this.txt, required this.isSelected});
 final bool isSelected ;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      decoration: BoxDecoration(
        border: isSelected? null:Border.all(width: 0.4,color: Color(0xffADADEB)),
        borderRadius: BorderRadius.circular(40),
        color: isSelected ? Color(0xffD6D6F5) : Colors.white,
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

  // final List<String> l = [
  //   "Numbers",
  //   "Colors",
  //   "Social Media",
  //   "Family",
  //   "Arabic Alphabet",
  //   "Calender",
  //   "Emotions",
  //   "Greetings",
  //   "Transportations",
  //   "Food",
  //   "Subjects",
  //   "Jobs",
  //   "Verbs",
  //   "Animals & Insects",
  //   "Places",
  //   "University Majors",
  //   "Arab Countries",
  //   "Geographical Landmarks",
  //   "Negative & Interrogative Tools",
  // ];