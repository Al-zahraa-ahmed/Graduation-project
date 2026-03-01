


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class OtpInput extends StatelessWidget {
//   const OtpInput({super.key, this.onsaved});
//   final Function(String?)? onsaved;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xff2B3574).withValues(alpha: 0.3),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: Offset(4, 4),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//       ),
//       width: 64,
//       height: 64,
//       child: TextFormField(
        
//         cursorHeight: 24,
//         onSaved: onsaved,
//         style: TextStyle(fontSize: 39, fontWeight: FontWeight.w600),
//         onChanged: (value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus();
//           }
//         },
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//         // keyboardAppearance:br ,
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         decoration: InputDecoration(
//           // hint:
//           //  Container(height: 4, width: 0, color: Colors.black),
//           contentPadding: EdgeInsets.all(4),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }

class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.prevFocusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? prevFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2B3574).withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      width: 64,
      height: 64,
      child: TextFormField(
      
        controller: controller,
        focusNode: focusNode,
        cursorHeight: 24,
        style: const TextStyle(fontSize: 39, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,

        inputFormatters:  [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],

        onChanged: (value) {
          // لو كتب رقم -> روح للي بعدها لو موجود
          if (value.length == 1) {
            if (nextFocusNode != null) {
              nextFocusNode!.requestFocus();
            } else {
              focusNode.unfocus(); // آخر خانة: يقف
            }
          }

          // لو مسح -> ارجع للي قبلها لو موجود
          if (value.isEmpty) {
            if (prevFocusNode != null) {
              prevFocusNode!.requestFocus();
            }
          }
        },

        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(4),
          border: InputBorder.none,
        ),
      ),
    );
  }
}