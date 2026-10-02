import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../local/l10n_ext.dart';

Future<void> showCongratsDialog(
    BuildContext context, {
      required VoidCallback onDone,
      Duration delay = const Duration(seconds: 3),
    }) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (_) => const CongratsDialog(),
  );
  await Future.delayed(delay);
  if (!context.mounted) return;
  onDone();
}

class CongratsDialog extends StatelessWidget {
  const CongratsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;

    return PopScope(
      canPop: false, // block back button while redirecting
      child: Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.successMint,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.shield, size: 46, color: Colors.white),
                    Icon(Icons.check, size: 22, color: AppColors.secondaryColor),
                  ],
                ),
              ),
              const Gap(20),
              CustomText(
                text: t.congratulations,
                size: 14,
                font: FontWeight.bold,
                color: AppColors.titleColor,
              ),
              const Gap(8),
              CustomText(
                text: t.accountReady,
                size: 10,
                color: AppColors.hintGrey,
              ),
              const Gap(18),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.hintGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}