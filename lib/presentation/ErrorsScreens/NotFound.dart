import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/Core/CustomWidgets/SearchBar.dart';
import 'package:graduation_project/presentation/Dictionary/dictionarypage.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  void _searchInDictionary(BuildContext context, String q) {
    final query = q.trim();
    if (query.isEmpty) return;
    // Replace NotFound with Dictionary pre-filtered to the typed query —
    // saves the user another tap and gives them a useful next step.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DictionaryPage(initialQuery: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        elevation: 0,
        backgroundColor: const Color(0xffD6D6F5),
        foregroundColor: Colors.black,
        title: Text(
          S.of(context).not_found,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 48),
            Search(
              onSubmitted: (q) => _searchInDictionary(context, q),
            ),
            const SizedBox(height: 40),
            Image.asset("Assets/images/speech bubble with question.png"),
            const SizedBox(height: 21),
            Text(S.of(context).not_found_desc, style: Textstyles.medium20),
            Text(
              S.of(context).not_found_hint,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
