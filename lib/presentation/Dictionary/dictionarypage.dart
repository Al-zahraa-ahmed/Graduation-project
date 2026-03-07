import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';
import 'package:graduation_project/data/Models/WordModel.dart';
import 'package:graduation_project/Core/CustomWidgets/SearchBar.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfDictionarySections.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfLetters.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfWords.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ShowingResultText.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DictionaryCubit()..getDictionary(),
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: Colors.white,
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
          title: Text("Dictionary", style: Textstyles.medium25),
        ),
        body: DictionaryPageBody(),
      ),
    );
  }
}

class DictionaryPageBody extends StatelessWidget {
  const DictionaryPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DictionaryCubit, DictionaryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is DictionarySuccess) {
          final Map<String, List<WordModel>> allWordsByLetters =
              state.allWordsByLetters;
          final Map<String, List<WordModel>> FilteredWordsByLetters =
              state.filteredWordsByLetters;
          final List<String> letters = allWordsByLetters.keys.toSet().toList();
          final List<WordModel> words = allWordsByLetters.values
              .expand((list) => list)
              .toList();
          final List<WordModel> Filteredwords = FilteredWordsByLetters.values
              .expand((list) => list)
              .toList();
          final List<String> categouries = words
              .map((e) => e.category)
              .toSet()
              .toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                  SizedBox(height: 12,width: double.infinity,),
                  Search(
                    onchanged: (value) {
                      context.read<DictionaryCubit>().onSearchChanged(value);
                    },
                  ),
                  SizedBox(height: 12),
                  
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: ListViewOfLetters(
                        l: letters,
                        ontap: (String letter) {
                          context.read<DictionaryCubit>().selectLetter(
                           state.selectedLetter== letter?null:letter,
                          );
                        },
                        selectedLetter: state.selectedLetter,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListViewOfDictionarySections(l: categouries, ontap: (String category) { 
                        context.read<DictionaryCubit>().selectCategory(
                           state.selectedCategory== category?null:category,
                          );
                       },selectedCategory: state.selectedCategory,),
                    ),
                    ShowingResultText(),
                    SizedBox(height: 14),
                    ListViewOfWords(w: Filteredwords),
                  ],
                ),
              ],
            ),
          );
        } else if (state is DictionaryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DictionaryFailure) {
          return Center(child: Text(state.errmsg.toString()));
        } else {
          throw Exception();
        }
      },
    );
  }
}
