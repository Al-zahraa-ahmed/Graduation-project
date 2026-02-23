import 'package:flutter/material.dart';

class ListViewOfLetters extends StatefulWidget {
  ListViewOfLetters({super.key});

  @override
  State<ListViewOfLetters> createState() => _ListViewOfLettersState();
}

class _ListViewOfLettersState extends State<ListViewOfLetters> {
  final List<String> l = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'W',
    'X',
    'Y',
    'Z',
  ];

  // bool isSelected = false;
int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 32, top: 12),
      scrollDirection: Axis.horizontal,
      itemCount: l.length,
      itemBuilder: (buildcontext, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                selectedIndex = index;
                  
                });
              },
              child: Letters(txt: l[index], isSelected: index==selectedIndex),
            ),
            SizedBox(height: 26),
          ],
        );
      },
    );
  }
}

class Letters extends StatelessWidget {
  Letters({super.key, required this.txt, required this.isSelected});
  bool isSelected = false;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      // padding: EdgeInsets.all(8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: isSelected ? Color(0xffD6D6F5) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xffADADEB),
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
