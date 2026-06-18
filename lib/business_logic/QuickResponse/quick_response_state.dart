import 'package:graduation_project/data/Models/PhraseModel.dart';

abstract class QuickResponseState {
  const QuickResponseState();
}

class QuickResponseInitial extends QuickResponseState {
  const QuickResponseInitial();
}

class QuickResponseLoading extends QuickResponseState {
  const QuickResponseLoading();
}

class QuickResponseLoaded extends QuickResponseState {
  final List<PhraseModel> phrases;
  final Set<String> selectedIds;
  final String? speakingId;

  const QuickResponseLoaded({
    required this.phrases,
    this.selectedIds = const {},
    this.speakingId,
  });

  bool get selectionMode => selectedIds.isNotEmpty;

  List<PhraseModel> get pinned =>
      phrases.where((p) => p.pinned).toList(growable: false);

  List<PhraseModel> get unpinned =>
      phrases.where((p) => !p.pinned).toList(growable: false);

  QuickResponseLoaded copyWith({
    List<PhraseModel>? phrases,
    Set<String>? selectedIds,
    String? speakingId,
    bool clearSpeaking = false,
  }) {
    return QuickResponseLoaded(
      phrases: phrases ?? this.phrases,
      selectedIds: selectedIds ?? this.selectedIds,
      speakingId: clearSpeaking ? null : (speakingId ?? this.speakingId),
    );
  }
}
