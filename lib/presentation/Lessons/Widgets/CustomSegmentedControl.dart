import 'package:flutter/material.dart';

class CustomSegmentedControl extends StatefulWidget {
  const CustomSegmentedControl({super.key, required this.onChanged});
  final Function(bool) onChanged;
  @override
  State<CustomSegmentedControl> createState() => _CustomSegmentedControlState();
}

class _CustomSegmentedControlState extends State<CustomSegmentedControl> {
  bool isAllSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      // padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xffEAEAFA),
        borderRadius: BorderRadius.circular(40),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              /// 🔵 الخلفية المتحركة
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: isAllSelected
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: constraints.maxWidth / 2,
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          isAllSelected = true;
                          widget.onChanged(true);
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          isAllSelected = false;
                          widget.onChanged(false);
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
          );
        },
      ),
    );
  }
}
