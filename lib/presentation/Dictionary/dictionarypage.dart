import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';
import 'package:graduation_project/Core/CustomWidgets/SearchBar.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfDictionarySections.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfLetters.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfWords.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ShowingResultText.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key, this.initialQuery});

  /// Pre-fills the search bar and applies the filter on load. Used when the
  /// user lands here from NotFound after typing a query.
  final String? initialQuery;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DictionaryCubit(initialQuery: initialQuery)..getDictionary(),
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 90,
          centerTitle: true,
          leading: Row(
            children: [
              const SizedBox(width: 20),
              IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: const Color(0xffD6D6F5)),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chevron_left),
              ),
            ],
          ),
          title: Text(S.of(context).dictionary_title,
              style: Textstyles.medium25),
        ),
        body: _DictionaryBody(initialQuery: initialQuery),
      ),
    );
  }
}

class _DictionaryBody extends StatelessWidget {
  const _DictionaryBody({this.initialQuery});
  final String? initialQuery;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      builder: (context, state) {
        if (state is DictionaryFailure) {
          return _ErrorState(
            message: S.of(context).dictionary_load_failed,
            onRetry: () => context.read<DictionaryCubit>().getDictionary(),
          );
        }
        if (state is! DictionarySuccess) {
          return const Center(child: CircularProgressIndicator());
        }

        final hasResults =
            state.filteredWordsByLetters.values.any((w) => w.isNotEmpty);

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 12, width: double.infinity),
                    Search(
                      initialValue: initialQuery,
                      onchanged: (value) {
                        context
                            .read<DictionaryCubit>()
                            .onSearchChanged(value);
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              Column(
                children: [
                  const LettersSection(),
                  const DictionarySection(),
                  const ShowingResultText(),
                  const SizedBox(height: 14),
                  if (hasResults)
                    const DictionaryWordsSection()
                  else
                    const _NoResultsState(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NoResultsState extends StatelessWidget {
  const _NoResultsState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).dictionary_no_results,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(S.of(context).retry),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8484E1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
