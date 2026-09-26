import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/feature/auth/presention/view/fill_profile_view.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_textformfiled.dart';
import '../../../../core/shared/navigator/navigatorTo.dart';
import '../widgets/social_Button.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    navigatorTo(context, const FillProfileView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(40),
                Image.asset(
                  'assets/Images/Vector.png',
                  height: 48,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.local_hospital_outlined,
                    size: 48,
                    color: AppColors.secondaryColor,
                  ),
                ),
                const Gap(6),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Health',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Pal',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(fontSize: 14),
                  textScaler: const TextScaler.linear(1.0),
                ),
                const Gap(28),
                CustomText(
                  text: 'Create Account',
                  size: 16,
                  font: FontWeight.bold,
                  color: AppColors.titleColor,
                ),
                const Gap(4),
                CustomText(
                  text: 'We are here to help you!',
                  size: 11,
                  color: AppColors.hintGrey,
                ),
                const Gap(24),

                CustomTextFormField(
                  controller: _nameController,
                  hint: 'Your Name',
                  icon: Icons.person_outline,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                const Gap(12),
                CustomTextFormField(
                  controller: _emailController,
                  hint: 'Your Email',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty) return 'Email is required';
                    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
                    return ok ? null : 'Enter a valid email';
                  },
                ),
                const Gap(12),
                CustomTextFormField(
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    return v.length < 6 ? 'At least 6 characters' : null;
                  },
                ),
                const Gap(20),
                CustomButton(
                  text: 'Create Account',
                  width: double.infinity,
                  onTap: _submit,
                ),
                const Gap(16),
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.fieldBorder)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomText(
                        text: 'or',
                        size: 11,
                        color: AppColors.hintGrey,
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.fieldBorder)),
                  ],
                ),
                const Gap(16),

                SocialButton(
                  label: 'Continue with Google',
                  ImagePath: 'assets/Images/Google - Original.png',
                  onTap: () {},
                ),
                const Gap(10),
                SocialButton(
                  label: 'Continue with Facebook',
                  ImagePath: 'assets/Images/_Facebook.png',
                  onTap: () {
                  },
                ),
                const Gap(28),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Do you have an account? ',
                      size: 11,
                      color: AppColors.hintGrey,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: CustomText(
                        text: 'Sign in',
                        size: 11,
                        font: FontWeight.w600,
                        color: AppColors.linkBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}