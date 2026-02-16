import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/SearchBar.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/gridviewofcards.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

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
        title: Text(S.of(context).categories_title, style: Textstyles.medium25),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            // SearchBar(),
            Search(),
            SizedBox(height: 36),
            Expanded(child: GridOfCards())
          ],
        ),
      ),
    );
  }
}


