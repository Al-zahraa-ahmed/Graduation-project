import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:graduation_project/business_logic/Categories/categories_cubit.dart';
import 'package:graduation_project/business_logic/Search/cubit/search_cubit.dart';
import 'package:graduation_project/data/Models/WordModel.dart';
import 'package:meta/meta.dart';

part 'dictionary_state.dart';

// class DictionaryCubit extends Cubit<DictionaryState> {
//   DictionaryCubit() : super(DictionaryInitial());
//   final CategoriesApi categoriesApi = CategoriesApi();
//   Future<void> getDictionary() async {
//     emit(DictionaryLoading());
//     try {
//       final response = await categoriesApi.getDictionary();
//       emit(DictionarySuccess(allWordsByLetters: response, filteredWordsByLetters: response));
//     } on DioException catch (e) {
//       print("STATUS: ${e.response?.statusCode}");
//       print("DATA: ${e.response?.data}");
//       print("MESSAGE: ${e.message}");
//       emit(DictionaryDailure(errmsg: e.error.toString()));
//     }
//   }
// }
class DictionaryCubit extends Cubit<DictionaryState> {
  DictionaryCubit({this.initialQuery}) : super(DictionaryInitial());

  /// Optional query to apply immediately after the dictionary loads — used
  /// when the user lands on Dictionary from elsewhere (e.g. typing in the
  /// search bar on NotFound) so the filter is already in place.
  final String? initialQuery;
  final CategoriesApi categoriesApi = CategoriesApi();
  Timer? _debounce;

  Future<void> getDictionary() async {
    emit(DictionaryLoading());
    try {
      final response = await categoriesApi.getDictionary();
      if (isClosed) return;

      // Precompute the distinct category list once so the category strip
      // can read it as O(1) instead of expand+map+toSet on every rebuild.
      final categories = response.values
          .expand((list) => list)
          .map((w) => w.category)
          .where((c) => c.isNotEmpty)
          .toSet()
          .toList();

      final loaded = DictionarySuccess(
        allWordsByLetters: response,
        filteredWordsByLetters: response,
        categories: categories,
        searchQuery: initialQuery ?? '',
      );

      if (initialQuery != null && initialQuery!.trim().isNotEmpty) {
        // Apply the filter synchronously so the user lands on a pre-filtered
        // list — skips the debounce that onSearchChanged would otherwise add.
        _applyFilters(loaded);
      } else {
        emit(loaded);
      }
    } on DioException catch (e) {
      if (isClosed) return;
      emit(DictionaryFailure(errmsg: ApiException.fromDio(e).message));
    }
  }

  void onSearchChanged(String q) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final current = state;
      if (current is! DictionarySuccess) return;

      final newState = current.copyWith(searchQuery: q);
      _applyFilters(newState);
    });
  }

  void selectLetter(String? letter) {
    final current = state;
    if (current is! DictionarySuccess) return;

    final newState = current.copyWith(
      selectedLetter: letter,
      clearLetter: letter == null,
    );

    _applyFilters(newState);
  }

  void selectCategory(String? category) {
    final current = state;
    if (current is! DictionarySuccess) return;

    final newState = current.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
    );

    _applyFilters(newState);
  }

  void clearAllFilters() {
    final current = state;
    if (current is! DictionarySuccess) return;

    final newState = current.copyWith(
      searchQuery: '',
      clearLetter: true,
      clearCategory: true,
    );

    _applyFilters(newState);
  }

  void _applyFilters(DictionarySuccess current) {
    if (isClosed) return;
    final query = current.searchQuery.trim().toLowerCase();
    final selectedLetter = current.selectedLetter;
    final selectedCategory = current.selectedCategory;

    final filteredMap = <String, List<WordModel>>{};

    current.allWordsByLetters.forEach((letter, words) {
      // فلترة الحرف
      if (selectedLetter != null && selectedLetter.isNotEmpty) {
        if (letter != selectedLetter) return;
      }

      final filteredWords = words.where((word) {
        final matchesCategory = selectedCategory == null ||
            selectedCategory.isEmpty ||
            word.category == selectedCategory;

        final wordText = word.word.toLowerCase();
        final categoryText = word.category.toLowerCase();

        final matchesQuery = query.isEmpty ||
            wordText.contains(query) ||
            
            categoryText.contains(query);

        return matchesCategory && matchesQuery;
      }).toList();

      if (filteredWords.isNotEmpty) {
        filteredMap[letter] = filteredWords;
      }
    });

    emit(
      current.copyWith(
        filteredWordsByLetters: filteredMap,
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}