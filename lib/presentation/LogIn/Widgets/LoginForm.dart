import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/Core/Validators.dart';
import 'package:graduation_project/business_logic/Auth/LoginCubit/login_cubit.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/ForgetPasswordScreens/ForgetPassword.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isRememberMe = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  static const _rememberedEmailKey = 'remembered_email';

  @override
  void initState() {
    super.initState();
    final remembered = CacheHelper.getData(_rememberedEmailKey) as String?;
    final hasRemembered = remembered != null && remembered.isNotEmpty;
    if (hasRemembered) {
      emailController.text = remembered;
      isRememberMe = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      (hasRemembered ? passwordNode : emailNode).requestFocus();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  Future<void> _handleLoginSuccess() async {
    if (isRememberMe) {
      await CacheHelper.saveData(
        key: _rememberedEmailKey,
        value: emailController.text.trim(),
      );
    } else {
      await CacheHelper.removeData(_rememberedEmailKey);
    }
    if (!mounted) return;
    // Trigger a fresh profile fetch now that the token is cached. Fire-and-
    // forget so navigation isn't blocked on the network round-trip.
    context.read<ProfileCubit>().getMainData();
    final mode = CacheHelper.getData('mode') as String? ?? 'l';
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => mode == 'l' ? LearingHome() : Translationhome(),
      ),
    );
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
    context.read<LoginCubit>().Login(
      email: emailController.text.trim(),
      password: passwordController.text,
      rememberMe: isRememberMe,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _handleLoginSuccess();
        } else if (state is LoginFailure) {
          AppSnackBar.error(context, state.errmsg, onRetry: _submit);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return Form(
          key: formkey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
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
                hint: "Enter Your Email",
              ),
              SizedBox(height: 36),
              CustomTextField(
                controller: passwordController,
                focusNode: passwordNode,
                isabvious: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => isLoading ? null : _submit(),
                label: S.of(context).password,
                hint: "Enter Your Password",
                validator: (value) => Validators.password(
                  value,
                  requiredMsg: S.of(context).password_required,
                ),
              ),
              SizedBox(height: 10),
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
                      value: isRememberMe,
                      onChanged: (newvalue) {
                        setState(() {
                          isRememberMe = newvalue ?? false;
                        });
                      },
                    ),
                    Text(
                      S.of(context).remember,
                      style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (buildcontext) {
                              return Forgetpassword();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  txt: "Log In",
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
