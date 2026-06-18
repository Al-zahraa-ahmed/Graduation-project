import 'package:flutter/material.dart';
import 'package:graduation_project/generated/l10n.dart';

/// Controlled two-tab segmented control. The parent owns the selected state
/// (we read it from the cubit) and the control is a pure render of it.
class CustomSegmentedControl extends StatelessWidget {
  const CustomSegmentedControl({
    super.key,
    required this.isAllSelected,
    required this.onChanged,
  });

  final bool isAllSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xffEAEAFA),
        borderRadius: BorderRadius.circular(40),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Animated thumb — uses Directional alignment so it tracks the
              // first/second tab correctly in RTL.
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: isAllSelected
                    ? AlignmentDirectional.centerStart
                    : AlignmentDirectional.centerEnd,
                child: Container(
                  width: constraints.maxWidth / 2,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xff9C9CE5),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      label: S.of(context).all_lessons,
                      selected: isAllSelected,
                      onTap: () => onChanged(true),
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      label: S.of(context).viewed,
                      selected: !isAllSelected,
                      onTap: () => onChanged(false),
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

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
