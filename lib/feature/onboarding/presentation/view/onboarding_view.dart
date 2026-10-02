import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/core/shared/custom_text/coustom_taxt.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/navigator/navigatorendfinish.dart';
import '../../../auth/presention/view/login_view.dart';
import '../../../local/l10n_ext.dart';
import '../widgets/build_boarding_item.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String body;
  OnboardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

/// Was a global const list; it must be a function now because it needs context.
List<OnboardingModel> buildBoarding(BuildContext context) {
  final t = context.l10n;
  return [
    OnboardingModel(
      image: 'assets/Images/Image.png',
      title: t.onboardingTitle1,
      body: t.onboardingBody1,
    ),
    OnboardingModel(
      image: 'assets/Images/Image (1).png',
      title: t.onboardingTitle2,
      body: t.onboardingBody2,
    ),
    OnboardingModel(
      image: 'assets/Images/Image (2).png',
      title: t.onboardingTitle3,
      body: t.onboardingBody3,
    ),
  ];
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  static const _pagesCount = 3;
  final boardController = PageController();
  bool isLast = false;

  @override
  void dispose() {
    boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boarding = buildBoarding(context);
    final t = context.l10n;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  setState(() => isLast = index == _pagesCount - 1);
                },
                controller: boardController,
                itemBuilder: (context, index) {
                  return BuildBoardingItem(model: boarding[index]);
                },
                itemCount: _pagesCount,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                text: isLast ? t.getStarted : t.next,
                onTap: () {
                  if (isLast) {
                    navigatorendfini(context, const LoginView());
                  } else {
                    boardController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                radius: 30,
              ),
            ),
            const Gap(20),
            SmoothPageIndicator(
              controller: boardController,
              count: _pagesCount,
              effect: ExpandingDotsEffect(
                dotColor: AppColors.secondaryColor.withOpacity(0.3),
                activeDotColor: AppColors.secondaryColor,
                dotHeight: 8,
                expansionFactor: 3,
                dotWidth: 8,
                spacing: 6.0,
              ),
            ),
            const Gap(12),
            TextButton(
              onPressed: () {
                navigatorendfini(context, const LoginView());
              },
              child: CustomText(
                text: t.skip,
                color: const Color(0xff6B7280),
                font: FontWeight.w600,
                size: 14,
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}