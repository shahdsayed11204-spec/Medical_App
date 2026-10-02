import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/feature/auth/presention/view/login_view.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_textformfiled.dart';
import '../../../../core/shared/navigator/navigatorendfinish.dart';
import '../../../local/l10n_ext.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _reset() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: call your reset-password API, then land on Login.
    navigatorendfini(context, const LoginView());
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;

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
                const Gap(24),
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
                  TextSpan(
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
                  text: t.createNewPassword,
                  size: 16,
                  font: FontWeight.bold,
                  color: AppColors.titleColor,
                ),
                const Gap(6),
                CustomText(
                  text: t.newPasswordHint,
                  size: 11,
                  color: AppColors.hintGrey,
                ),
                const Gap(24),
                CustomTextFormField(
                  controller: _passwordController,
                  hint: t.password,
                  icon: Icons.lock_outline,
                  obscureText: _obscure1,
                  suffix: IconButton(
                    icon: Icon(
                      _obscure1
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18,
                      color: AppColors.hintGrey,
                    ),
                    onPressed: () => setState(() => _obscure1 = !_obscure1),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return t.passwordRequired;
                    return v.length < 6 ? t.passwordMin : null;
                  },
                ),
                const Gap(12),
                CustomTextFormField(
                  controller: _confirmController,
                  hint: t.confirmPassword,
                  icon: Icons.lock_outline,
                  obscureText: _obscure2,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _reset(),
                  suffix: IconButton(
                    icon: Icon(
                      _obscure2
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18,
                      color: AppColors.hintGrey,
                    ),
                    onPressed: () => setState(() => _obscure2 = !_obscure2),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return t.confirmPasswordRequired;
                    return v != _passwordController.text
                        ? t.passwordsNotMatch
                        : null;
                  },
                ),
                const Gap(24),
                CustomButton(
                  radius: 30,
                  text: t.resetPassword,
                  width: double.infinity,
                  onTap: _reset,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}