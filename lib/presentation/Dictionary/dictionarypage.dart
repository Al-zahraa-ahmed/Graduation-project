import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/SearchBar.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfDictionarySections.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfLetters.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ListViewOfWords.dart';
import 'package:graduation_project/presentation/Dictionary/Widegts/ShowingResultText.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DictionaryCubit(),
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
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Search(),
              SizedBox(height: 12),
              Container(
                color: Color(0xffF2F2F2),
                child: Column(
                  children: [
                    SizedBox(height: 80, child: ListViewOfLetters()),
                    SizedBox(height: 60, child: ListViewOfDictionarySections()),
                    ShowingResultText(),
                    SizedBox(height: 14),
                    ListViewOfWords(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
