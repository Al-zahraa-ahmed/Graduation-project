import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';

class ChooseMode extends StatefulWidget {
  const ChooseMode({super.key});

  @override
  State<ChooseMode> createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ChooseMode> {
  bool isExpanded = false;

  String _currentMode(ProfileState state) {
    if (state is ProfileSucces) return state.user.mode ?? _cacheMode();
    if (state is ProfilePrefUpdateFailed) {
      return state.user.mode ?? _cacheMode();
    }
    return _cacheMode();
  }

  String _cacheMode() => CacheHelper.getData('mode') as String? ?? 'l';

  Future<void> _switchTo(String mode) async {
    final cubit = context.read<ProfileCubit>();
    final ok = await cubit.changeMode(mode: mode);
    if (!mounted || !ok) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => mode == 'l' ? LearingHome() : Translationhome(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final mode = _currentMode(state);
        final isLearn = mode == 'l';
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 6, right: 2),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            leading: Image.asset(
              "Assets/images/appmode.png",
              height: 28,
              width: 28,
            ),
            title:
                Text(S.of(context).account_mode, style: TextStyle(fontSize: 16)),
            trailing: isExpanded
                ? Icon(Icons.keyboard_arrow_down)
                : Icon(Icons.chevron_right, size: 28),
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 4,
                  bottom: 12,
                  top: 6,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).mode_learn,
                            style: TextStyle(fontSize: 16)),
                        InkWell(
                          onTap: () {
                            if (isLearn) return;
                            _switchTo('l');
                          },
                          child: CheckContainer(isselected: isLearn),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).mode_ass,
                            style: TextStyle(fontSize: 16)),
                        InkWell(
                          onTap: () {
                            if (!isLearn) return;
                            _switchTo('a');
                          },
                          child: CheckContainer(isselected: !isLearn),
                        ),
                      ],
                    ),
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
