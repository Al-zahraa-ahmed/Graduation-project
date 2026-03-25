import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Auth/SignUpCubit/SignUpCubit.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/SignUpContainer.dart';

// class SignUp extends StatelessWidget {
//   const SignUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) {
//         return SignUpCubit();
//       },
//       child: Scaffold(
//         backgroundColor: Color(0xffEAEAFA),
//         body: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               color: Color(0xffEAEAFA),
//             ),
//            Positioned(
//           //  bottom: 0,
//              child: SingleChildScrollView(
//               // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//               padding: EdgeInsets.all(0),
//               // dragStartBehavior: DragStartBehavior.down,
//                child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [SizedBox(height: 60), SignupContainer()],
//                            ),
//              ),
//            ),
//           ]
//         ),
//       ),
//     );
//   }
// }

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffEAEAFA),
          resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: const [
                        Spacer(),
                        SignupContainer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}