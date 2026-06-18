import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/Core/Validators.dart';
import 'package:graduation_project/business_logic/Auth/SignUpCubit/SignUpCubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Otp/OtpPage.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool agreedToTerms = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final nameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) nameNode.requestFocus();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    nameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!formkey.currentState!.validate()) {
      // Switch to live validation so errors clear as the user types.
      if (_autovalidateMode != AutovalidateMode.onUserInteraction) {
        setState(() {
          _autovalidateMode = AutovalidateMode.onUserInteraction;
        });
      }
      return;
    }
    if (!agreedToTerms) {
      AppSnackBar.error(
        context,
        'You must agree to the processing of personal data',
      );
      return;
    }
    context.read<SignUpCubit>().SignUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      password2: confirmController.text,
      agreement: agreedToTerms,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OtpPage(
                userId: state.userid,
                email: emailController.text.trim(),
                isResetPassword: false,
              ),
            ),
          );
        } else if (state is SignUpFailure) {
          AppSnackBar.error(context, state.errormsg, onRetry: _submit);
        }
      },
      builder: (context, state) {
        final isLoading = state is SignUpLoading;
        return Form(
          key: formkey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                focusNode: nameNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => emailNode.requestFocus(),
                validator: (value) => Validators.name(
                  value,
                  requiredMsg: S.of(context).name_required,
                ),
                label: S.of(context).profile_name,
                hint: S.of(context).enter_name,
              ),
              SizedBox(height: 32),
              CustomTextField(
                controller: emailController,
                focusNode: emailNode,
                keyboardtype: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => passwordNode.requestFocus(),
                validator: (value) => Validators.email(
                  value,
                  requiredMsg: S.of(context).email_required,
                ),
                label: S.of(context).email,
                hint: S.of(context).enter_your_email,
              ),
              SizedBox(height: 32),
              CustomTextField(
                controller: passwordController,
                focusNode: passwordNode,
                isabvious: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => confirmNode.requestFocus(),
                label: S.of(context).password,
                hint: S.of(context).enter_your_password,
                validator: (value) => Validators.password(
                  value,
                  requiredMsg: S.of(context).password_required,
                ),
              ),
              SizedBox(height: 32),
              CustomTextField(
                controller: confirmController,
                focusNode: confirmNode,
                isabvious: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => isLoading ? null : _submit(),
                label: S.of(context).profile_confirm_pass,
                hint: S.of(context).confirm_your_password,
                validator: (value) => Validators.confirmPassword(
                  value,
                  passwordController.text,
                  mismatchMsg: S.of(context).passwords_must_match,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Checkbox(
                      fillColor: WidgetStateProperty.resolveWith(
                        (states) => Colors.white,
                      ),
                      checkColor: Color(0xff999999),
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => BorderSide(
                          color: Color(0xff999999),
                          width: 2,
                        ),
                      ),
                      value: agreedToTerms,
                      onChanged: (newvalue) {
                        setState(() {
                          agreedToTerms = newvalue ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: MultiColorText(
                        txt1: S.of(context).agree_processing,
                        txt2: S.of(context).personal_data,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  txt: "Sign Up",
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
