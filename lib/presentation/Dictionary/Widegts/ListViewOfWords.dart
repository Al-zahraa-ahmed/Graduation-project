import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';
import 'package:graduation_project/data/Models/WordModel.dart';
import 'package:graduation_project/presentation/ErrorsScreens/NoConnection.dart';
import 'package:graduation_project/presentation/PlayVideo/VideoScreen.dart';

class DictionaryWordsSection extends StatelessWidget {
  const DictionaryWordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      buildWhen: (previous, current) {
        if (previous is DictionarySuccess && current is DictionarySuccess) {
          return previous.filteredWordsByLetters !=
              current.filteredWordsByLetters;
        }
        return true;
      },
      builder: (context, state) {
        if (state is! DictionarySuccess) return const SizedBox();

        final List<WordModel> filteredWords = state
            .filteredWordsByLetters
            .values
            .expand((list) => list)
            .toList();

        return ListViewOfWords(w: filteredWords);
      },
    );
  }
}

class ListViewOfWords extends StatelessWidget {
  const ListViewOfWords({super.key, required this.w});
  final List<WordModel> w;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: w.length,
      itemBuilder: (buildcontext, index) {
        return WordCard(w: w[index]);
      },
    );
  }
}

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.w});
  final WordModel w;
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  w.word,
                  style: Textstyles.medium16,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  w.category,
                  style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                ),
              ],
            ),
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
                    return LessonVideoScreen();
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
