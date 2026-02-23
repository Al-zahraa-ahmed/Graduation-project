import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/SearchBar.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),),
        elevation: 0,
        backgroundColor: Color(0xffD6D6F5),
        foregroundColor: Colors.black,
        title: const Text(
          "Not found",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 48,),
          Search(),
          SizedBox(height: 40,),
          Image.asset("Assets/images/speech bubble with question.png"),
          SizedBox(height: 21,),
          Text("Oops! we couldn’t found that video .",style: Textstyles.medium20,),
          Text("maybe try different keyword!",style: TextStyle(fontSize: 16,color: Color(0xff999999)),),
        ],
      ),
    );
  }
}
