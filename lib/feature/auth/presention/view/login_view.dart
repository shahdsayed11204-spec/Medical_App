import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/core/shared/custom_text/custom_textformfiled.dart';
import 'package:medicalapp/core/shared/navigator/navigatorTo.dart';
import 'package:medicalapp/feature/auth/presention/view/forget_password_view.dart';
import 'package:medicalapp/feature/auth/presention/widgets/social_Button.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import 'create_account_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  InputDecoration _decoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    OutlineInputBorder border(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.hintGrey, fontSize: 14),
      prefixIcon: Icon(icon, color: AppColors.hintGrey, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.fieldFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: border(AppColors.fieldBorder),
      focusedBorder: border(AppColors.secondaryColor),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Gap(46),
                  Image.asset(
                    'assets/Images/Vector.png',
                    height: 64,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.local_hospital_outlined,
                      size: 64,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Gap(8),
                  Text.rich(
                    TextSpan        (
                      children: [
                        TextSpan(
                          text: 'Health',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Pal',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 22),
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  const Gap(25),
                  CustomText(
                    text: 'Hi, Welcome Back!',
                    size: 18,
                    font: FontWeight.w700,
                    color: AppColors.titleColor,
                  ),
                  const Gap(8),
                  CustomText(
                    text: "Hope you're doing fine.",
                    size: 12,
                    color: AppColors.hintGrey,
                  ),
                  const Gap(25),

                  CustomTextFormField(
                    controller: _emailController,
                    hint: 'Your Email',
                    icon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email is required';
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Gap(14),


                  CustomTextFormField(
                    controller: _passwordController,
                    hint: 'Password',
                    icon: Icons.lock_outline_rounded,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _signIn(),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password is required';
                      if (v.length < 6) return 'At least 6 characters';
                      return null;
                    },
                  ),
                  const Gap(15),
                  CustomButton(
                    text: 'Sign In',
                    width: double.infinity,
                    height: 50,
                    radius: 30,
                    gap: _isLoading ? 10 : 0,
                    widget: _isLoading
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : null,
                    onTap: _isLoading ? null : _signIn,
                  ),
                  const Gap(14),
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.fieldBorder)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CustomText(text: 'or', size: 13, color: AppColors.hintGrey),
                      ),
                      const Expanded(child: Divider(color: AppColors.fieldBorder)),
                    ],
                  ),
                  const Gap(14),
                  SocialButton(
                    label: 'Sign In with Google',

                    onTap: () {},
                    ImagePath: 'assets/Images/Google - Original.png',
                  ),
                  const Gap(12),
                  SocialButton(
                    label: 'Sign In with Facebook',

                    onTap: () {}, ImagePath: 'assets/Images/_Facebook.png',
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () {
                      navigatorTo(context, ForgetPasswordView());
                    },
                    child: CustomText(
                      text: 'Forgot password?',
                      size: 13,
                      color: AppColors.linkBlue,
                      font: FontWeight.w500,
                    ),
                  ),
                  const Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Don't have an account yet? ",
                        size: 12,
                        color: AppColors.hintGrey,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigatorTo(context, CreateAccountView());
                        },
                        child: CustomText(
                          text: 'Sign up',
                          size: 12,
                          color: AppColors.linkBlue,
                          font: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

