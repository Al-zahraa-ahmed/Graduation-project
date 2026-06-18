import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/Validators.dart';
import 'package:graduation_project/business_logic/Auth/ForgetPasswordCubit/forget_password_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Otp/OtpPage.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left),
              ),
              Text(
                S.of(context).screen20,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Image.asset("Assets/images/password authentication complete.png"),
                SizedBox(height: 24),
                Text(
                  S.of(context).forget_title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(S.of(context).forget_desc, style: TextStyle(fontSize: 13)),
                Text(S.of(context).forget_desc2, style: TextStyle(fontSize: 13)),
                SizedBox(height: 34),
                ForgetPassForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPassForm extends StatefulWidget {
  const ForgetPassForm({super.key});

  @override
  State<ForgetPassForm> createState() => _ForgetPassFormState();
}

class _ForgetPassFormState extends State<ForgetPassForm> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailNode = FocusNode();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    emailController.dispose();
    emailNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!formkey.currentState!.validate()) {
      if (_autovalidateMode != AutovalidateMode.onUserInteraction) {
        setState(() {
          _autovalidateMode = AutovalidateMode.onUserInteraction;
        });
      }
      return;
    }
    context.read<ForgetPasswordCubit>().forgetpassword(
      email: emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OtpPage(
                email: emailController.text.trim(),
                isResetPassword: true,
                userId: state.userId,
              ),
            ),
          );
        } else if (state is ForgetPasswordFailure) {
          AppSnackBar.error(context, state.errmsg, onRetry: _submit);
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgetPasswordLoading;
        return Form(
          key: formkey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              CustomTextField(
                controller: emailController,
                focusNode: emailNode,
                keyboardtype: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => isLoading ? null : _submit(),
                hint: "Enter Your Email",
                label: S.of(context).email,
                validator: (value) => Validators.email(
                  value,
                  requiredMsg: S.of(context).email_required,
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  txt: S.of(context).confirm_mail,
                  isLoading: isLoading,
                  onpressed: _submit,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
