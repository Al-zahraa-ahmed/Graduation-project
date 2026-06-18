import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/QuickResponse/quick_response_cubit.dart';
import 'package:graduation_project/business_logic/QuickResponse/quick_response_state.dart';
import 'package:graduation_project/data/Models/PhraseModel.dart';
import 'package:graduation_project/generated/l10n.dart';

class QuickResponsePage extends StatelessWidget {
  const QuickResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaults = [
      S.of(context).qr_need_help,
      S.of(context).qr_bus,
      S.of(context).qr_cost,
      S.of(context).qr_help,
      S.of(context).qr_meet,
      S.of(context).qr_deaf,
      S.of(context).qr_uncomfortable,
      S.of(context).qr_appreciate,
      S.of(context).qr_police,
    ];
    return BlocProvider(
      create: (_) => QuickResponseCubit()..loadPhrases(defaults),
      child: const _QuickResponseView(),
    );
  }
}

class _QuickResponseView extends StatelessWidget {
  const _QuickResponseView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuickResponseCubit, QuickResponseState>(
      builder: (context, state) {
        final loaded = state is QuickResponseLoaded ? state : null;
        return PopScope(
          canPop: loaded == null || !loaded.selectionMode,
          onPopInvoked: (didPop) {
            if (!didPop && loaded != null && loaded.selectionMode) {
              context.read<QuickResponseCubit>().clearSelection();
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffEAEAFA), Color(0xffADADEB)],
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: _buildAppBar(context, loaded),
                  body: loaded == null
                      ? const Center(child: CircularProgressIndicator())
                      : _buildBody(context, loaded),
                  bottomNavigationBar: loaded == null
                      ? null
                      : _buildBottom(context, loaded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    QuickResponseLoaded? state,
  ) {
    if (state == null) {
      return AppBar(backgroundColor: Colors.transparent, elevation: 0);
    }
    final cubit = context.read<QuickResponseCubit>();
    final isSelecting = state.selectionMode;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: !isSelecting,
      leadingWidth: 90,
      leading: Row(
        children: [
          const SizedBox(width: 20),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xffD6D6F5),
            ),
            color: Colors.white,
            onPressed: () {
              if (isSelecting) {
                cubit.clearSelection();
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(isSelecting ? Icons.close : Icons.chevron_left),
          ),
        ],
      ),
      title: Text(
        isSelecting
            ? S.of(context).qr_n_selected(state.selectedIds.length)
            : S.of(context).quick_response,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      actions: isSelecting
          ? [
              TextButton(
                onPressed: cubit.selectAll,
                child: Text(
                  S.of(context).select_all,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ]
          : null,
    );
  }

  Widget _buildBody(BuildContext context, QuickResponseLoaded state) {
    if (state.phrases.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.record_voice_over_outlined,
                size: 64,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).qr_empty_title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5B5BD7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                S.of(context).qr_empty_hint,
                style: const TextStyle(fontSize: 14, color: Color(0xff666666)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.phrases.length,
      itemBuilder: (context, index) {
        return _PhraseCard(phrase: state.phrases[index], state: state);
      },
    );
  }

  Widget _buildBottom(BuildContext context, QuickResponseLoaded state) {
    final cubit = context.read<QuickResponseCubit>();
    if (!state.selectionMode) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () {
              HapticFeedback.selectionClick();
              _showAddOrEditDialog(context);
            },
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff8484E1), Color(0xff5B5BD7)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff5B5BD7).withOpacity(0.45),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_rounded, color: Colors.white, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    S.of(context).add_phrase,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    final count = state.selectedIds.length;
    final canEdit = count == 1;
    final selected =
        state.phrases.where((p) => state.selectedIds.contains(p.id));
    final anyUnpinned = selected.any((p) => !p.pinned);
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomAction(
            icon: Icons.delete,
            label: S.of(context).delete,
            onTap: () async {
              final confirmed = await _confirmDelete(context, count);
              if (confirmed == true) cubit.deleteSelected();
            },
          ),
          _BottomAction(
            icon: Icons.edit,
            label: S.of(context).edit,
            enabled: canEdit,
            onTap: () {
              final phrase = state.phrases
                  .firstWhere((p) => p.id == state.selectedIds.first);
              _showAddOrEditDialog(context, existing: phrase);
            },
          ),
          _BottomAction(
            icon: anyUnpinned ? Icons.push_pin : Icons.push_pin_outlined,
            label: S.of(context).pin,
            onTap: cubit.togglePinSelected,
          ),
        ],
      ),
    );
  }
}

class _PhraseCard extends StatelessWidget {
  const _PhraseCard({required this.phrase, required this.state});
  final PhraseModel phrase;
  final QuickResponseLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuickResponseCubit>();
    final isSelected = state.selectedIds.contains(phrase.id);
    final isSpeaking = state.speakingId == phrase.id;

    final card = GestureDetector(
      onTap: () {
        if (state.selectionMode) {
          cubit.toggleSelection(phrase.id);
        } else {
          cubit.speak(phrase);
        }
      },
      onLongPress: () {
        if (!state.selectionMode) {
          HapticFeedback.mediumImpact();
          cubit.startSelection(phrase.id);
        }
      },
      child: AnimatedScale(
        scale: isSelected ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 140),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff5B5BD7).withOpacity(.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: phrase.pinned && !state.selectionMode
                ? const BorderDirectional(
                    start: BorderSide(color: Colors.deepPurple, width: 4),
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                state.selectionMode
                    ? (isSelected ? Icons.check_circle : Icons.circle_outlined)
                    : (isSpeaking ? Icons.graphic_eq : Icons.record_voice_over),
                color: Colors.deepPurple,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  phrase.text,
                  style: const TextStyle(
                    color: Color(0xff5B5BD7),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (phrase.pinned && !state.selectionMode)
                const Padding(
                  padding: EdgeInsetsDirectional.only(start: 8),
                  child:
                      Icon(Icons.push_pin, size: 16, color: Colors.deepPurple),
                ),
            ],
          ),
        ),
      ),
    );

    // Selection mode disables swipe — long-press multi-select takes priority.
    if (state.selectionMode) return card;

    return Dismissible(
      key: ValueKey(phrase.id),
      // Swipe right (start→end): pin/unpin without dismissing.
      background: _SwipeBackground(
        icon: phrase.pinned ? Icons.push_pin_outlined : Icons.push_pin,
        color: const Color(0xff8484E1),
        alignStart: true,
      ),
      // Swipe left (end→start): delete with confirmation.
      secondaryBackground: const _SwipeBackground(
        icon: Icons.delete_outline_rounded,
        color: Color(0xffE57373),
        alignStart: false,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final confirmed = await _confirmDelete(context, 1);
          return confirmed ?? false;
        }
        // Pin swipe: toggle and snap back.
        HapticFeedback.lightImpact();
        context.read<QuickResponseCubit>().togglePinPhraseById(phrase.id);
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<QuickResponseCubit>().deletePhraseById(phrase.id);
        }
      },
      child: card,
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({
    required this.icon,
    required this.color,
    required this.alignStart,
  });
  final IconData icon;
  final Color color;
  final bool alignStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      alignment: alignStart
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: alignStart
              ? Alignment.centerLeft
              : Alignment.centerRight,
          end: alignStart ? Alignment.centerRight : Alignment.centerLeft,
          colors: [color, color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.enabled = true,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.deepPurple),
              const SizedBox(height: 4),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showAddOrEditDialog(
  BuildContext context, {
  PhraseModel? existing,
}) async {
  final cubit = context.read<QuickResponseCubit>();
  final controller = TextEditingController(text: existing?.text ?? '');
  final isEdit = existing != null;

  await showDialog<void>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      title: Text(
        isEdit ? S.of(context).qr_edit_phrase : S.of(context).add_phrase,
      ),
      content: TextField(
        controller: controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        maxLength: 200,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(hintText: S.of(context).enter_phrase),
        onSubmitted: (val) => _saveAndPop(dialogCtx, cubit, val, existing),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogCtx),
          child: Text(S.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () =>
              _saveAndPop(dialogCtx, cubit, controller.text, existing),
          child: Text(isEdit ? S.of(context).qr_save : S.of(context).add),
        ),
      ],
    ),
  );
}

void _saveAndPop(
  BuildContext context,
  QuickResponseCubit cubit,
  String text,
  PhraseModel? existing,
) {
  if (text.trim().isEmpty) return;
  if (existing == null) {
    cubit.addPhrase(text);
  } else {
    cubit.editPhrase(existing.id, text);
  }
  Navigator.pop(context);
}

Future<bool?> _confirmDelete(BuildContext context, int count) {
  return showDialog<bool>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      title: Text(
        count == 1
            ? S.of(context).qr_delete_confirm_title
            : S.of(context).qr_delete_confirm_multi(count),
      ),
      content: Text(S.of(context).qr_delete_confirm_desc),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogCtx, false),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogCtx, true),
          child: Text(
            S.of(context).delete,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
