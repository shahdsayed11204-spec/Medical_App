import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../view/onboarding_view.dart';

class BuildBoardingItem extends StatelessWidget {
  const BuildBoardingItem({super.key, required this.model});
  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            width: double.infinity,
            child: Image(
              image: AssetImage(model.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Gap(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomText(
            text: '${model.title}',
            font: FontWeight.w700,
            size: 19,
            color: const Color(0xff111827),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomText(
            text: '${model.body}',
            font: FontWeight.w500,
            size: 14,
            color: const Color(0xff6B7280),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(20),
      ],
    );
  }
}