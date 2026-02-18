
import 'package:flutter/material.dart';

class CustomSegmentedControl extends StatefulWidget {
  const CustomSegmentedControl({super.key});

  @override
  State<CustomSegmentedControl> createState() => _CustomSegmentedControlState();
}

class _CustomSegmentedControlState extends State<CustomSegmentedControl> {
  bool isAllSelected = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 40,
        // padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xffEAEAFA),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            /// 🔵 الخلفية المتحركة
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: isAllSelected
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 178,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xff9C9CE5),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),

            /// 🟢 النصوص
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = true;
                      });
                    },
                    child: Center(
                      child: Text(
                        "All Lessons",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: isAllSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = false;
                      });
                    },
                    child: Center(
                      child: Text(
                        "Viewed",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: isAllSelected ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
