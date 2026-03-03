import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

part 'search_state.dart';


class SearchApi {
  final Dio dio=Dio();
  Future<List<dynamic>> search({required String query}) async {
    final res = await dio.get(
      '/search',
      queryParameters: {'q': query},
    );

    // افترضي الريسبونس: { "data": [ ... ] }
    return (res.data['data'] as List);
  }
}


class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final SearchApi api=SearchApi();
  Timer? _debounce;

  void onQueryChanged(String q) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      final query = q.trim();

      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());
      try {
        final results = await api.search(query: query);
        if (results.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchSuccess(results));
        }
      } catch (e) {
        emit(SearchError('Something went wrong'));
      }
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

