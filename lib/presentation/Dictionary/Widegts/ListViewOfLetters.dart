import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Dictionary/dictionary_cubit.dart';

class LettersSection extends StatelessWidget {
  const LettersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      buildWhen: (previous, current) {
        if (previous is DictionarySuccess && current is DictionarySuccess) {
          return previous.selectedLetter != current.selectedLetter ||
              previous.allWordsByLetters != current.allWordsByLetters;
        }
        return true;
      },
      builder: (context, state) {
        if (state is! DictionarySuccess) return const SizedBox();

        final List<String> letters = state.allWordsByLetters.keys.toList();

        return SizedBox(
          height: 80,
          child: ListViewOfLetters(
            l: letters,
            ontap: (String letter) {
              context.read<DictionaryCubit>().selectLetter(
                state.selectedLetter == letter ? null : letter,
              );
            },
            selectedLetter: state.selectedLetter,
          ),
        );
      },
    );
  }
}

class ListViewOfLetters extends StatelessWidget {
  const ListViewOfLetters({
    super.key,
    required this.l,
    required this.ontap,
    this.selectedLetter,
  });
  final String? selectedLetter;
  final List<String> l;
  final ValueChanged<String> ontap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 32, top: 12),
      scrollDirection: Axis.horizontal,
      itemCount: l.length,
      itemBuilder: (buildcontext, index) {
        final letter = l[index];
        return Column(
          children: [
            InkWell(
              radius: 70,
              borderRadius: BorderRadius.circular(40),
              onTap: () => ontap(letter),
              child: Letters(
                txt: l[index],
                isSelected: selectedLetter == letter,
              ),
            ),
            SizedBox(height: 26),
          ],
        );
      },
    );
  }
}

class Letters extends StatelessWidget {
  const Letters({super.key, required this.txt, required this.isSelected});
  final bool isSelected;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: EdgeInsets.only(right: 8),
      // padding: EdgeInsets.all(8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: isSelected ? Color(0xffD6D6F5) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xffADADEB),
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


  // final List<String> l = [
  //   'A',
  //   'B',
  //   'C',
  //   'D',
  //   'E',
  //   'F',
  //   'G',
  //   'H',
  //   'I',
  //   'J',
  //   'K',
  //   'L',
  //   'M',
  //   'N',
  //   'O',
  //   'P',
  //   'Q',
  //   'R',
  //   'S',
  //   'T',
  //   'U',
  //   'W',
  //   'X',
  //   'Y',
  //   'Z',
  // ];