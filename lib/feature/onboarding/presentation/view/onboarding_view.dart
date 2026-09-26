import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/core/shared/custom_text/coustom_taxt.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/navigator/navigatorendfinish.dart';
import '../../../auth/presention/view/login_view.dart';
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

List<OnboardingModel> boarding = [
  OnboardingModel(
    image: 'assets/Images/Image.png',
    title: 'Meet Doctors Online',
    body: 'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
  ),
  OnboardingModel(
    image: 'assets/Images/Image (1).png',
    title: 'Connect with Specialists',
    body: 'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
  ),
  OnboardingModel(
    image: 'assets/Images/Image (2).png',
    title: 'Thousands of Online Specialists',
    body: 'Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.',
  ),
];

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final boardController = PageController();
  bool isLast = false;

  @override
  void dispose() {
    boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() => isLast = true);
                  } else {
                    setState(() => isLast = false);
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) {
                  return BuildBoardingItem(model: boarding[index]);
                },
                itemCount: boarding.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                text: isLast ? 'Get Started' : 'Next',
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
            Gap(20),
            SmoothPageIndicator(
              controller: boardController,
              count: boarding.length,
              effect: ExpandingDotsEffect(
                dotColor: AppColors.secondaryColor.withOpacity(0.3),
                activeDotColor: AppColors.secondaryColor,
                dotHeight: 8,
                expansionFactor: 3,
                dotWidth: 8,
                spacing: 6.0,
              ),
            ),
            Gap( 12),
            TextButton(
              onPressed: () {
                navigatorendfini(context, const LoginView());
              },
              child:  CustomText(
                text: 'Skip',
                color: Color(0xff6B7280),
                font: FontWeight.w600,
                size: 14,
              ),
            ),
             Gap( 12),
          ],
        ),
      ),
    );
  }
}