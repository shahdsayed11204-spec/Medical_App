import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../local/locale_cubit.dart';
import '../view/onboarding_view.dart';

class BuildBoardingItem extends StatelessWidget {
  const BuildBoardingItem({super.key, required this.model});
  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image(
                  image: AssetImage(model.image),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.read<LocaleCubit>().toggle();
                    },
                    icon: Icon(
                      Icons.translate_outlined,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomText(
            text: model.title, // تم إزالة العلامات الزائدة ${} لأن المتغير String بالفعل
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
            text: model.body, // تم إزالة العلامات الزائدة
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