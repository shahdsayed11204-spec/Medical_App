import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.icon, // now optional (Fill Your Profile fields have no prefix icon)
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.readOnly = false, // for date / gender pickers
    this.onTap,
    this.suffix,
    this.validator,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      cursorColor: AppColors.secondaryColor,
      style: const TextStyle(fontSize: 14, color: AppColors.titleColor),
      onFieldSubmitted: onFieldSubmitted,
      decoration: _decoration(),
      validator: validator,
    );
  }

  InputDecoration _decoration() {
    OutlineInputBorder border(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.hintGrey, fontSize: 14),
      prefixIcon:
      icon == null ? null : Icon(icon, color: AppColors.hintGrey, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.fieldFill,
      contentPadding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: icon == null ? 14 : 0,
      ),
      enabledBorder: border(AppColors.fieldBorder),
      focusedBorder: border(AppColors.secondaryColor),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent),
    );
  }
}