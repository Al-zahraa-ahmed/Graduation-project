import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Categories/categories_cubit.dart';
import 'package:graduation_project/data/Models/CategoryModel.dart';
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
    // late List<dynamic> l=context.read<SearchCubit>().
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          final List<CategoryModel> visible_categouries = state.visible;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                // SearchBar(),
                Search(
                  onchanged: (value) {
                    context.read<CategoriesCubit>().search(
                      value,
                      isArabic: isArabic(),
                    );
                  },
                ),
                SizedBox(height: 36),
                Expanded(child: GridOfCards(l: visible_categouries)),
              ],
            ),
          );
        } else if (state is CategoriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoriesError) {
          return Center(child: Text(state.message));
        } else {
          return Text("hi");
        }
      },
    );
  }
}
