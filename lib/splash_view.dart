import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medicalapp/core/shared/navigator/navigatorTo.dart';
import '../../core/constant/app_colors.dart';
import 'feature/onboarding/presentation/view/onboarding_view.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => animate = true);
    });
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
   navigatorTo(context, OnboardingView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 751.0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: animate ? 1 : 0,
            child: Image.asset('assets/Images/Splash.png',width: double.infinity,height: 751.0,fit: BoxFit.contain,),
          ),
        ),
      ),
    );
  }
}
