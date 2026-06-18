import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Profile/ProfileScreen2.dart';

class WelcomeMsg extends StatelessWidget {
  const WelcomeMsg({super.key, this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsetsDirectional.only(end: 8, start: 20),
      title: Text(
        '${user?.username ?? ''}',
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        S.of(context).home1_welcome,
        style: Textstyles.medium13.copyWith(color: const Color(0xff999999)),
      ),
      trailing: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfileScreen()),
          );
        },
        child: Image.asset('Assets/images/settings.png'),
      ),
    );
  }
}
