
import 'package:flutter/material.dart';

class ShowingResultText extends StatelessWidget {
  const ShowingResultText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0),
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Text(
          "Showing results for ‘A’",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff1E1E7B),
          ),
        ),
      ),
    );
  }
}
