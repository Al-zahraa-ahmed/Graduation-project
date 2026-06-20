part of 'dictionary_cubit.dart';

@immutable
sealed class DictionaryState {}

final class DictionaryInitial extends DictionaryState {}

final class DictionaryLoading extends DictionaryState {}

final class DictionarySuccess extends DictionaryState {
  final Map<String, List<WordModel>> allWordsByLetters;
  final Map<String, List<WordModel>> filteredWordsByLetters;
  /// Cached on construction so the category strip doesn't recompute the full
  /// distinct list on every state emission (search keystrokes, filter taps).
  final List<String> categories;
  final String searchQuery;
  final String? selectedLetter;
  final String? selectedCategory;

  DictionarySuccess({
    required this.allWordsByLetters,
    required this.filteredWordsByLetters,
    required this.categories,
    this.searchQuery = "",
    this.selectedLetter,
    this.selectedCategory,
  });

  DictionarySuccess copyWith({
    Map<String, List<WordModel>>? allWordsByLetters,
    Map<String, List<WordModel>>? filteredWordsByLetters,
    List<String>? categories,
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
      categories: categories ?? this.categories,
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
