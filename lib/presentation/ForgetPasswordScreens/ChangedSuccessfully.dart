
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LogIn/LoginScreen.dart';

class PasswordSuccessfullyChanged extends StatefulWidget {
  const PasswordSuccessfullyChanged({super.key});

  @override
  State<PasswordSuccessfullyChanged> createState() => _PasswordSuccessfullyChangedState();
}

class _PasswordSuccessfullyChangedState extends State<PasswordSuccessfullyChanged> {
  @override
  void initState() {
    super.initState();
      Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Loginscreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/images/Frame 5.png",width: 100,height: 100,),
            SizedBox(height: 20,),
            Text(S.of(context).passwordchanged,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
            Text(S.of(context).success,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
            SizedBox(height: 20,),
            Text(S.of(context).confirmsg,style: Textstyles.medium13.copyWith(color: Color(0xff999999)),),
            Text(S.of(context).confirmsg2,style: Textstyles.medium13.copyWith(color: Color(0xff999999)),),
            Text(S.of(context).confirmsg3,style: Textstyles.medium13.copyWith(color: Color(0xff999999)),),
          ],
        ),
      ),
    );
  }
}

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});
  

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _opacity = Tween<double>(begin: 1, end: 0).animate(_controller);

    _controller.forward().whenComplete(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Loginscreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/images/Frame 5.png",width: 100,height: 100,),
            SizedBox(height: 20,),
            Text(S.of(context).passwordchanged,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
            Text(S.of(context).success,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
            SizedBox(height: 20,),
            Text(S.of(context).confirmsg,style: Textstyles.medium13.copyWith(color: Color(0xff999999)),),
            Text(S.of(context).confirmsg2,style: Textstyles.medium13.copyWith(color: Color(0xff999999)),),
            Text(S.of(context).confirmsg3,style: Textstyles.medium13.copyWith(color: Color(0xff999999)),),
          ],
        ),
      ),
        ),
      ),
    );
  }
}
