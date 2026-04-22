import 'package:flutter/material.dart';

class CircularNumberProgress extends StatelessWidget {
  final String text;
  final double progress;

  const CircularNumberProgress({
    super.key,
    required this.text,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 55,
            height: 55,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 14,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xffC9C7E8),
              ),
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 7,
              backgroundColor: Color(0xffF2C94C),
              valueColor: const AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
