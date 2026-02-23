import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/presentation/ErrorsScreens/NoConnection.dart';

class ListViewOfWords extends StatelessWidget {
  const ListViewOfWords({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (buildcontext, index) {
        return WordCard();
      },
    );
  }
}


class WordCard extends StatelessWidget {
  const WordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 329,
      height: 87,
      margin: EdgeInsets.only(left: 32, right: 32, bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: Color(0xffADADEB),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Apple", style: Textstyles.medium16),
              Text(
                "Noun . Food",
                style: TextStyle(fontSize: 13, color: Color(0xff999999)),
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            iconSize: 42,
            icon: Icon(Icons.play_circle),
            color: Color(0xffADADEB),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) {
                    return Noconnection();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

