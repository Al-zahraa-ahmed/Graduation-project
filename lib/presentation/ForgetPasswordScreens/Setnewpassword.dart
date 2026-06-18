import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/Validators.dart';
import 'package:graduation_project/business_logic/Auth/ResetPasswordCubit/reset_password_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/ForgetPasswordScreens/ChangedSuccessfully.dart';

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({super.key, required this.reset_token});
  final String reset_token;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
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
                S.of(context).screen21,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "Assets/images/Man with shield protecting data in laptop.png",
                ),
                SizedBox(height: 24),
                Text(
                  S.of(context).new_title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(S.of(context).new_desc, style: TextStyle(fontSize: 13)),
                Text(S.of(context).new_desc2, style: TextStyle(fontSize: 13)),
                SizedBox(height: 34),
                ResetPasswordForm(reset_token: reset_token),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key, required this.reset_token});
  final String reset_token;
  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formkey = GlobalKey<FormState>();
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final pass1Node = FocusNode();
  final pass2Node = FocusNode();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    pass1Controller.dispose();
    pass2Controller.dispose();
    pass1Node.dispose();
    pass2Node.dispose();
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
    context.read<ResetPasswordCubit>().resetPassword(
      reset_token: widget.reset_token,
      pass: pass1Controller.text,
      pass2: pass2Controller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MessagePage()),
          );
        } else if (state is ResetPasswordFailure) {
          AppSnackBar.error(context, state.errmsg, onRetry: _submit);
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;
        return Form(
          key: formkey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              CustomTextField(
                controller: pass1Controller,
                focusNode: pass1Node,
                isabvious: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => pass2Node.requestFocus(),
                hint: S.of(context).enter_your_password,
                label: S.of(context).password,
                validator: (value) => Validators.password(
                  value,
                  requiredMsg: S.of(context).password_required,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: Text(
                    S.of(context).new_warning1,
                    style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                  ),
                ),
              ),
              SizedBox(height: 34),
              CustomTextField(
                controller: pass2Controller,
                focusNode: pass2Node,
                isabvious: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => isLoading ? null : _submit(),
                hint: S.of(context).enter_your_password,
                label: S.of(context).profile_confirm_pass,
                validator: (value) => Validators.confirmPassword(
                  value,
                  pass1Controller.text,
                  mismatchMsg: S.of(context).passwords_must_match,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: Text(
                    S.of(context).new_warning2,
                    style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                  ),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  txt: S.of(context).new_btn,
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
