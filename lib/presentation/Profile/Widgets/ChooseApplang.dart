import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  bool isExpanded = false;

  /// Cache is the source of truth for the active locale (matches main.dart's
  /// MaterialApp). State is only used as a fallback before the cache has been
  /// initialized, so the checkmark always lines up with what the app actually
  /// renders.
  String _currentLang(ProfileState state) {
    final cache = CacheHelper.getData('lang') as String?;
    if (cache != null && cache.isNotEmpty) return cache;
    if (state is ProfileSucces) return state.user.language ?? 'en';
    if (state is ProfilePrefUpdateFailed) return state.user.language ?? 'en';
    return 'en';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final lang = _currentLang(state);
        final isAr = lang == 'ar';
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
              "Assets/images/lang.png",
              height: 28,
              width: 28,
            ),
            title:
                Text(S.of(context).account_lang, style: TextStyle(fontSize: 16)),
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
                    InkWell(
                      onTap: () {
                        if (isAr) return;
                        context.read<ProfileCubit>().changelang(lang: 'ar');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).lang_ar,
                                style: TextStyle(fontSize: 16)),
                            CheckContainer(isselected: isAr),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        if (!isAr) return;
                        context.read<ProfileCubit>().changelang(lang: 'en');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).lang_en,
                                style: TextStyle(fontSize: 16)),
                            CheckContainer(isselected: !isAr),
                          ],
                        ),
                      ),
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
