import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';
import 'package:graduation_project/data/Models/WordModel.dart';
import 'package:graduation_project/presentation/ErrorsScreens/NotFound.dart';
import 'package:graduation_project/presentation/PlayVideo/VideoScreen.dart';

/// Renders the filtered word list as a true sliver so the parent
/// CustomScrollView can lazy-build word cards as they scroll into view.
/// When the filter produces no matches, fills the remaining viewport with
/// a friendly empty state so the layout doesn't collapse to a thin strip.
class DictionaryWordsSliver extends StatelessWidget {
  const DictionaryWordsSliver({super.key, required this.emptyState});

  final Widget emptyState;

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
        if (state is! DictionarySuccess) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        final List<WordModel> filteredWords = state.filteredWordsByLetters
            .values
            .expand((list) => list)
            .toList();
        if (filteredWords.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: emptyState,
          );
        }
        return SliverList.builder(
          itemCount: filteredWords.length,
          itemBuilder: (context, index) => WordCard(w: filteredWords[index]),
        );
      },
    );
  }
}

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.w});
  final WordModel w;

  /// YouTube URL validation is enough — the player itself handles network
  /// errors via its own UI. We used to do a HEAD pre-check with the auth
  /// token, but that leaked the bearer token to youtube.com.
  void _openVideo(BuildContext context) {
    if (w.link.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NotFoundPage()),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonVideoScreen(
          videoUrl: w.link,
          title: w.word,
          desc: w.desc,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 329,
      height: 87,
      margin: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            color: Color(0xffADADEB),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => _openVideo(context),
          borderRadius: BorderRadius.circular(12),
          splashColor: const Color(0x33ADADEB),
          highlightColor: const Color(0x1AADADEB),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.play_circle,
                  size: 42,
                  color: Color(0xffADADEB),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
