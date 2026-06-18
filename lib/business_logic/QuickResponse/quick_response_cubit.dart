import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/business_logic/QuickResponse/quick_response_state.dart';
import 'package:graduation_project/data/Models/PhraseModel.dart';

class QuickResponseCubit extends Cubit<QuickResponseState> {
  static const _storageKey = 'quick_response_phrases';
  static const _seededFlagKey = 'quick_response_seeded';
  final FlutterTts _tts = FlutterTts();

  QuickResponseCubit() : super(const QuickResponseInitial()) {
    _tts.setCompletionHandler(() {
      if (isClosed) return;
      final s = state;
      if (s is QuickResponseLoaded && s.speakingId != null) {
        emit(s.copyWith(clearSpeaking: true));
      }
    });
  }

  /// Loads phrases from cache. On first launch (no cache, no seed flag), seeds
  /// the list with [defaultPhrases]. The flag means we never re-seed after the
  /// user has interacted (e.g. deleted everything intentionally).
  Future<void> loadPhrases(List<String> defaultPhrases) async {
    if (isClosed) return;
    final raw = CacheHelper.getData(_storageKey) as String?;
    final seeded = CacheHelper.getData(_seededFlagKey) as bool? ?? false;

    List<PhraseModel> phrases;
    if (raw != null) {
      try {
        final List<dynamic> list = jsonDecode(raw);
        phrases = list
            .map((j) => PhraseModel.fromJson(j as Map<String, dynamic>))
            .toList();
      } catch (_) {
        phrases = [];
      }
    } else if (!seeded) {
      final base = DateTime.now().microsecondsSinceEpoch;
      phrases = defaultPhrases
          .asMap()
          .entries
          .map((e) => PhraseModel(id: 'seed_${base + e.key}', text: e.value))
          .toList();
      await _persist(phrases);
      await CacheHelper.saveData(key: _seededFlagKey, value: true);
    } else {
      phrases = [];
    }

    if (isClosed) return;
    emit(QuickResponseLoaded(phrases: _sorted(phrases)));
  }

  Future<void> addPhrase(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final s = state;
    if (s is! QuickResponseLoaded) return;
    final phrase = PhraseModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: trimmed,
    );
    final updated = _sorted([...s.phrases, phrase]);
    await _persist(updated);
    if (isClosed) return;
    emit(s.copyWith(phrases: updated));
  }

  Future<void> editPhrase(String id, String newText) async {
    final trimmed = newText.trim();
    if (trimmed.isEmpty) return;
    final s = state;
    if (s is! QuickResponseLoaded) return;
    final updated = s.phrases
        .map((p) => p.id == id ? p.copyWith(text: trimmed) : p)
        .toList();
    await _persist(updated);
    if (isClosed) return;
    emit(s.copyWith(phrases: updated, selectedIds: const {}));
  }

  Future<void> deleteSelected() async {
    final s = state;
    if (s is! QuickResponseLoaded || s.selectedIds.isEmpty) return;
    final updated =
        s.phrases.where((p) => !s.selectedIds.contains(p.id)).toList();
    await _persist(updated);
    if (isClosed) return;
    emit(s.copyWith(phrases: updated, selectedIds: const {}));
  }

  Future<void> deletePhraseById(String id) async {
    final s = state;
    if (s is! QuickResponseLoaded) return;
    final updated = s.phrases.where((p) => p.id != id).toList();
    await _persist(updated);
    if (isClosed) return;
    emit(s.copyWith(phrases: updated));
  }

  Future<void> togglePinPhraseById(String id) async {
    final s = state;
    if (s is! QuickResponseLoaded) return;
    final updated = _sorted(s.phrases
        .map((p) => p.id == id ? p.copyWith(pinned: !p.pinned) : p)
        .toList());
    await _persist(updated);
    if (isClosed) return;
    emit(s.copyWith(phrases: updated));
  }

  Future<void> togglePinSelected() async {
    final s = state;
    if (s is! QuickResponseLoaded || s.selectedIds.isEmpty) return;
    final selectedPhrases =
        s.phrases.where((p) => s.selectedIds.contains(p.id));
    // Pin all if any in the selection is unpinned, otherwise unpin all.
    final anyUnpinned = selectedPhrases.any((p) => !p.pinned);
    final updated = _sorted(s.phrases
        .map((p) => s.selectedIds.contains(p.id)
            ? p.copyWith(pinned: anyUnpinned)
            : p)
        .toList());
    await _persist(updated);
    if (isClosed) return;
    emit(s.copyWith(phrases: updated, selectedIds: const {}));
  }

  void toggleSelection(String id) {
    final s = state;
    if (s is! QuickResponseLoaded) return;
    final next = Set<String>.from(s.selectedIds);
    if (!next.add(id)) next.remove(id);
    emit(s.copyWith(selectedIds: next));
  }

  void startSelection(String id) {
    final s = state;
    if (s is! QuickResponseLoaded) return;
    emit(s.copyWith(selectedIds: {id}));
  }

  void selectAll() {
    final s = state;
    if (s is! QuickResponseLoaded) return;
    emit(s.copyWith(selectedIds: s.phrases.map((p) => p.id).toSet()));
  }

  void clearSelection() {
    final s = state;
    if (s is! QuickResponseLoaded) return;
    emit(s.copyWith(selectedIds: const {}));
  }

  Future<void> speak(PhraseModel phrase) async {
    final s = state;
    if (s is! QuickResponseLoaded) return;
    try {
      await _tts.stop();
    } catch (_) {}
    // Pick TTS locale by script — handles bilingual phrase lists transparently.
    final isArabic = RegExp(r'[؀-ۿ]').hasMatch(phrase.text);
    // Each TTS call is wrapped independently: a missing Arabic engine on the
    // device shouldn't suppress speech entirely — fall through to .speak with
    // whatever the default voice is.
    try {
      await _tts.setLanguage(isArabic ? 'ar' : 'en-US');
    } catch (_) {}
    try {
      await _tts.setSpeechRate(0.5);
    } catch (_) {}
    if (isClosed) return;
    emit(s.copyWith(speakingId: phrase.id));
    try {
      await _tts.speak(phrase.text);
    } catch (_) {
      if (isClosed) return;
      emit(s.copyWith(clearSpeaking: true));
    }
  }

  Future<void> _persist(List<PhraseModel> phrases) async {
    final json = jsonEncode(phrases.map((p) => p.toJson()).toList());
    await CacheHelper.saveData(key: _storageKey, value: json);
  }

  /// Pinned first, then newest first within each group.
  static List<PhraseModel> _sorted(List<PhraseModel> phrases) {
    final list = [...phrases];
    list.sort((a, b) {
      if (a.pinned != b.pinned) return a.pinned ? -1 : 1;
      return b.createdAt.compareTo(a.createdAt);
    });
    return list;
  }

  @override
  Future<void> close() async {
    await _tts.stop();
    return super.close();
  }
}
