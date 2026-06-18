import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Categories/categories_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/Core/CustomWidgets/SearchBar.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/gridviewofcards.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..loadCategouries(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 90,
          centerTitle: true,
          leading: Row(
            children: [
              SizedBox(width: 20),
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Color(0xffD6D6F5)),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left),
              ),
            ],
          ),
          title: Text(
            S.of(context).categories_title,
            style: Textstyles.medium25,
          ),
        ),
        body: CaregoryPageBody(),
      ),
    );
  }
}

class CaregoryPageBody extends StatefulWidget {
  const CaregoryPageBody({super.key});

  @override
  State<CaregoryPageBody> createState() => _CaregoryPageBodyState();
}

class _CaregoryPageBodyState extends State<CaregoryPageBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Search(
                  onchanged: (value) {
                    context.read<CategoriesCubit>().search(
                      value,
                      isArabic: isArabic(),
                    );
                  },
                ),
                const SizedBox(height: 36),
                Expanded(
                  child: state.visible.isEmpty
                      ? const _NoResultsState()
                      : GridOfCards(l: state.visible),
                ),
              ],
            ),
          );
        } else if (state is CategoriesError) {
          return _ErrorState(
            message: S.of(context).categories_load_failed,
            onRetry: () =>
                context.read<CategoriesCubit>().loadCategouries(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _NoResultsState extends StatelessWidget {
  const _NoResultsState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            S.of(context).categories_no_results,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
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
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12),
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
