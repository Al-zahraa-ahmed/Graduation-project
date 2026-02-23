import 'package:flutter/material.dart';

class ListViewOfDictionarySections extends StatefulWidget {
  ListViewOfDictionarySections({super.key});

  @override
  State<ListViewOfDictionarySections> createState() =>
      _ListViewOfDictionarySectionsState();
}

class _ListViewOfDictionarySectionsState
    extends State<ListViewOfDictionarySections> {
  final List<String> l = [
    "Numbers",
    "Colors",
    "Social Media",
    "Family",
    "Arabic Alphabet",
    "Calender",
    "Emotions",
    "Greetings",
    "Transportations",
    "Food",
    "Subjects",
    "Jobs",
    "Verbs",
    "Animals & Insects",
    "Places",
    "University Majors",
    "Arab Countries",
    "Geographical Landmarks",
    "Negative & Interrogative Tools",
  ];

  int selectedindex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 30),
      scrollDirection: Axis.horizontal,
      itemCount: l.length,
      itemBuilder: (buildcontext, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selectedindex = index;
                });
              },
              child: DictionarySections(txt: l[index], isSelected: selectedindex==index),
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
