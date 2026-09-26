import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/shared/custom_text/coustom_taxt.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    required this.label,
    this.onTap,
    required this.ImagePath,
  });

  final String label;
  final VoidCallback? onTap;
  final String ImagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE8EAEE)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePath),
            const Gap(8),
            CustomText(
              text: label,
              size: 13,
              font: FontWeight.w500,
              color: const Color(0xFF1F2A37),
            ),
          ],
        ),
      ),
    );
  }
}