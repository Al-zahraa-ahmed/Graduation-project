import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/business_logic/Search/cubit/search_cubit.dart';
import 'package:meta/meta.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  DictionaryCubit() : super(DictionaryInitial());
  final SearchApi api=SearchApi();

Timer? _debounce;
  
  void search(String q, {required bool isArabic}) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = q.trim().toLowerCase();

      final current = state;
      if (current is! DictionarySuccess) return;

      // لو السيرش فاضي رجّع الكل
      if (query.isEmpty) {
        emit(DictionarySuccess());
        return;
      }

      // final result = current.all.where((c) {
      //   final letter = (isArabic ? c.name.ar : c.name.en).toLowerCase();
      //   final sectiom = (isArabic ? c.desc.ar : c.desc.en).toLowerCase();
      //   return name.contains(query) || desc.contains(query);
      // }).toList();

      emit(DictionarySuccess());
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
