part of 'dictionary_cubit.dart';

@immutable
sealed class DictionaryState {}

final class DictionaryInitial extends DictionaryState {}

final class DictionaryLoading extends DictionaryState {}

final class DictionarySuccess extends DictionaryState {
  // final
}

final class DictionaryDailure extends DictionaryState {
  final String errmsg;

  DictionaryDailure({required this.errmsg});
}
