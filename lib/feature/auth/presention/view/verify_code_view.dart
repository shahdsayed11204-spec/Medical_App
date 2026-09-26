import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/feature/auth/presention/view/reset_password_view.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_snackbar.dart';
import '../../../../core/shared/navigator/navigatorTo.dart';


const _otpLength = 5;

class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({super.key, required this.email});

  final String email;

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  late final List<TextEditingController> _controllers =
  List.generate(_otpLength, (_) => TextEditingController());
  late final List<FocusNode> _focusNodes =
  List.generate(_otpLength, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_code.length == _otpLength) FocusScope.of(context).unfocus();
    setState(() {});
  }

  void _verify() {
    if (_code.length < _otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnack(errorMsg: 'Enter the full code', color: Colors.redAccent),
      );
      return;
    }
    // TODO: verify _code against your backend before navigating.
    navigatorTo(context, const ResetPasswordView());
  }

  void _resend() {
    // TODO: call your resend-code API with widget.email.
    ScaffoldMessenger.of(context).showSnackBar(
      customSnack(errorMsg: 'Code resent to ${widget.email}', color: AppColors.secondaryColor),
    );
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
          child: Column(
            children: [
              const Gap(30),
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
                TextSpan (
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
              const Gap(32),
              CustomText(
                text: 'Verify Code',
                size: 20,
                font: FontWeight.bold,
                color: AppColors.titleColor,
              ),
              const Gap(6),
              CustomText(
                text: 'Enter the the code\nwe just sent you on your registered Email',
                size: 14,
                color: AppColors.hintGrey,
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_otpLength, (i) {
                  return Padding(
                    padding: EdgeInsets.only(right: i == _otpLength - 1 ? 0 : 10),
                    child: SizedBox(
                      width: 50,
                      height: 48,
                      child: TextField(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        cursorColor: AppColors.secondaryColor,
                        style: const TextStyle(fontSize: 16, color: AppColors.titleColor),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: AppColors.fieldFill,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.fieldBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.secondaryColor),
                          ),
                        ),
                        onChanged: (v) => _onChanged(i, v),
                      ),
                    ),
                  );
                }),
              ),
              const Gap(24),
              CustomButton(
                radius: 30,
                text: 'Verify',
                width: double.infinity,
                onTap: _verify,
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Didn't get the Code? ",
                    size: 12,
                    color: AppColors.hintGrey,
                  ),
                  GestureDetector(
                    onTap: _resend,
                    child: CustomText(
                      text: 'Resend',
                      size: 13,
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
    );
  }
}