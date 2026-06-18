import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
    this.onchanged,
    this.onSubmitted,
    this.initialValue,
  });
  final Function(String)? onchanged;
  final ValueChanged<String>? onSubmitted;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 327,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffD6D6F5)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: Color(0xffADADEB),
            blurRadius: 4,
            spreadRadius: -2,
          ),
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        textInputAction: onSubmitted != null
            ? TextInputAction.search
            : TextInputAction.done,
        onChanged: onchanged,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(0),
          enabledBorder: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color:Colors.transparent),
            // borderSide: BorderSide(color:Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color:Colors.transparent),
          ),
          prefixIcon: Image.asset(
            "Assets/images/search.png",height: 20,width: 20,
          ),
          hint: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              S.of(context).categories_search,
              style: Textstyles.medium20.copyWith(color: Color(0xffD6D6F5)),
            ),
          ),
        ),
      ),
      // Row(
      //   children: [
      //     SizedBox(width: 10,),
      //   ],
      // ) ,
    );
  }
}
