import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/feature/auth/presention/view/verify_code_view.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_textformfiled.dart';
import '../../../../core/shared/navigator/navigatorTo.dart';


class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (!_formKey.currentState!.validate()) return;
    navigatorTo(context, VerifyCodeView(email: _emailController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20, color: AppColors.titleColor),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(30 ),
                Image.asset(
                  'assets/Images/Vector.png',
                  height: 64,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.local_hospital_outlined,
                    size: 64,
                    color: AppColors.secondaryColor,
                  ),
                ),
                const Gap(6),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Health',
                        style: TextStyle(fontWeight: FontWeight.w300, color: AppColors.secondaryColor,fontSize: 20),
                      ),
                      TextSpan(
                        text: 'Pal',
                        style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.secondaryColor,fontSize: 20),
                      ),
                    ],
                  ),
                  style: const TextStyle(fontSize: 14),
                  textScaler: const TextScaler.linear(1.0),
                ),
                const Gap(32),
                CustomText(
                  text: 'Forget Password?',
                  size: 20,
                  font: FontWeight.bold,
                  color: AppColors.titleColor,
                ),
                const Gap(6),
                CustomText(
                  text: 'Enter your Email, we will send you a verification code.',
                  size: 14,
                  color: AppColors.hintGrey,
                ),
                const Gap(26),
                CustomTextFormField(
                  controller: _emailController,
                  hint: 'Your Email',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _sendCode(),
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty) return 'Email is required';
                    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
                    return ok ? null : 'Enter a valid email';
                  },
                ),
                const Gap(30),
                CustomButton(
                  radius: 30,
                  text: 'Send Code',
                  width: double.infinity,
                  onTap: _sendCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}