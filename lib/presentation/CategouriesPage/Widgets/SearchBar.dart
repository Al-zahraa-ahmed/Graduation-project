import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,width: 327,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8,vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffD6D6F5)),
        color:Colors.white,
        borderRadius:BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset:Offset(2,2),
            color: Color(0xffADADEB),
            blurRadius: 4,
            spreadRadius:-2
            
          )
        ]
      ),
      child:Row(
        children: [
          Image.asset("Assets/images/search.png"),
          SizedBox(width: 10,),
          Text(S.of(context).categories_search,style: Textstyles.medium20.copyWith(color: Color(0xffD6D6F5)),)
        ],
      ) ,
    );
  }
}