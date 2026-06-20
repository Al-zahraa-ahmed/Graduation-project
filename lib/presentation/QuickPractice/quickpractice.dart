import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/QuickPractice/Widgets/gridviewofquized.dart';
import 'package:graduation_project/presentation/QuickPractice/Widgets/startbutton.dart';

bool _isInitialLoad(QuizState s) => s is QuizInitial || s is QuizLoading;

class Quickpractice extends StatelessWidget {
  const Quickpractice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit()..loadQuizzes(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leadingWidth: 90,
          centerTitle: true,
          leading: Row(
            children: [
              const SizedBox(width: 20),
              IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: const Color(0xffD6D6F5)),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chevron_left),
              ),
            ],
          ),
          title: Text(
            S.of(context).home1_service3,
            style: Textstyles.medium25,
          ),
        ),
        body: BlocBuilder<QuizCubit, QuizState>(
          // Only react to coarse load-state changes — once the quizzes are
          // loaded once, mid-screen state transitions (e.g., navigating to
          // start a quiz) shouldn't flash the full-page loader.
          buildWhen: (prev, curr) =>
              _isInitialLoad(prev) != _isInitialLoad(curr) ||
              (curr is QuizError) != (prev is QuizError),
          builder: (context, state) {
            if (_isInitialLoad(state)) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is QuizError) {
              return _PageErrorState(
                onRetry: () => context.read<QuizCubit>().loadQuizzes(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                S.of(context).quiz_title,
                                style: Textstyles.medium20,
                              ),
                              Text(
                                S.of(context).quiz_desc,
                                style: Textstyles.regular13,
                              ),
                              const SizedBox(height: 16),
                              const StartButton(),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                          end: -10,
                          bottom: -50,
                          child: Image.asset(
                            "Assets/images/Woman busy with her study assignments.png",
                            width: 148,
                            height: 148,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      child: const GridviewOfQuiz(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PageErrorState extends StatelessWidget {
  const _PageErrorState({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              S.of(context).quiz_load_failed,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(S.of(context).retry),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8484E1),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
