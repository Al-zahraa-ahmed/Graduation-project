part of 'dictionary_cubit.dart';

@immutable
sealed class DictionaryState {}

final class DictionaryInitial extends DictionaryState {}

final class DictionaryLoading extends DictionaryState {}

final class DictionarySuccess extends DictionaryState {
  final Map<String, List<WordModel>> allWordsByLetters;
  final Map<String, List<WordModel>> filteredWordsByLetters;
  final String searchQuery;
  final String? selectedLetter;
  final String? selectedCategory;

  DictionarySuccess({
    required this.allWordsByLetters,
    required this.filteredWordsByLetters,
    this.searchQuery = "",
    this.selectedLetter,
    this.selectedCategory,
  });

  DictionarySuccess copyWith({
    Map<String, List<WordModel>>? allWordsByLetters,
    Map<String, List<WordModel>>? filteredWordsByLetters,
    String? searchQuery,
    String? selectedLetter,
    String? selectedCategory,
    bool clearLetter = false,
    bool clearCategory = false,
  }) {
    return DictionarySuccess(
      allWordsByLetters: allWordsByLetters ?? this.allWordsByLetters,
      filteredWordsByLetters:
          filteredWordsByLetters ?? this.filteredWordsByLetters,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedLetter: clearLetter ? null: (selectedLetter ?? this.selectedLetter),
      selectedCategory: clearCategory? null: (selectedCategory ?? this.selectedCategory),
    );
  }
}

final class DictionaryFailure extends DictionaryState {
  final String errmsg;

  DictionaryFailure({required this.errmsg});
}
