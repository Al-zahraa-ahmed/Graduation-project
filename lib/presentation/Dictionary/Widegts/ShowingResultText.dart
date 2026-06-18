import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';

/// Reflects whichever filter is currently active. Hides itself when no
/// filter is set — showing "Showing results for 'A'" when the user hasn't
/// picked anything is misleading.
class ShowingResultText extends StatelessWidget {
  const ShowingResultText({super.key});

  String? _activeFilter(DictionarySuccess s) {
    final q = s.searchQuery.trim();
    if (q.isNotEmpty) return q;
    if (s.selectedLetter != null && s.selectedLetter!.isNotEmpty) {
      return s.selectedLetter;
    }
    if (s.selectedCategory != null && s.selectedCategory!.isNotEmpty) {
      return s.selectedCategory;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      buildWhen: (prev, curr) {
        if (prev is DictionarySuccess && curr is DictionarySuccess) {
          return prev.searchQuery != curr.searchQuery ||
              prev.selectedLetter != curr.selectedLetter ||
              prev.selectedCategory != curr.selectedCategory;
        }
        return true;
      },
      builder: (context, state) {
        if (state is! DictionarySuccess) return const SizedBox.shrink();
        final filter = _activeFilter(state);
        if (filter == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 36.0),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              S.of(context).dictionary_results_for(filter),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff1E1E7B),
              ),
            ),
          ),
        );
      },
    );
  }
}
