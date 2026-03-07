import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
  DictionaryCubit() : super(DictionaryInitial());

  final CategoriesApi categoriesApi = CategoriesApi();
  Timer? _debounce;

  Future<void> getDictionary() async {
    emit(DictionaryLoading());
    try {
      final response = await categoriesApi.getDictionary();

      emit(
        DictionarySuccess(
          allWordsByLetters: response,
          filteredWordsByLetters: response,
        ),
      );
    } on DioException catch (e) {
      emit(
        DictionaryFailure(
          errmsg: e.message ?? 'Something went wrong',
        ),
      );
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