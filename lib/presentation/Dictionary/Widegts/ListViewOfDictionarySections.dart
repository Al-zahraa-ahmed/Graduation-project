import 'package:flutter/material.dart';

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
 DictionarySections({super.key, required this.txt, required this.isSelected});
  bool isSelected = false;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Container(
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