import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/core/shared/custom_text/custom_textformfiled.dart';
import 'package:medicalapp/core/shared/navigator/navigatorTo.dart';
import 'package:medicalapp/feature/auth/presention/view/forget_password_view.dart';
import 'package:medicalapp/feature/auth/presention/widgets/social_Button.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/get_it.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_snackbar.dart';
import '../../../../core/shared/navigator/navigator_replace.dart';
import '../../../root/root_view.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'create_account_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  InputDecoration  decoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    OutlineInputBorder border(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.hintGrey, fontSize: 14),
      prefixIcon: Icon(icon, color: AppColors.hintGrey, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.fieldFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: border(AppColors.fieldBorder),
      focusedBorder: border(AppColors.secondaryColor),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<AuthCubit,AuthState>(
            listener: ( context,  state) {
              if (state is SuccessState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(customSnack(errorMsg: 'Success',color: Colors.green,icon: Icons.done));
                navigatorReplace(context,  RootView());
              }

              if (state is ErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnack(errorMsg: state.message)
                );
              }
              if (state is LoadingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnack(errorMsg: 'Loading...' ,color: Colors.amber,)
                );
              }
            },
            builder: ( context,  state) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Gap(46),
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
                          TextSpan        (
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
                          text: 'Hi, Welcome Back!',
                          size: 18,
                          font: FontWeight.w700,
                          color: AppColors.titleColor,
                        ),
                        const Gap(8),
                        CustomText(
                          text: "Hope you're doing fine.",
                          size: 12,
                          color: AppColors.hintGrey,
                        ),
                        const Gap(25),

                        CustomTextFormField(
                          controller: emailController,
                          hint: 'Your Email',
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Email is required';
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const Gap(14),


                        CustomTextFormField(
                          controller: passwordController,
                          hint: 'Password',
                          icon: Icons.lock_outline_rounded,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_){
                              if (!formKey.currentState!.validate())
                              {};
                              setState(() => isLoading = true);
                              try {
                                 Future.delayed(const Duration(seconds: 1));
                              } finally {
                                if (mounted) setState(() => isLoading = false);
                              }
                          },
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Password is required';
                            if (v.length < 6) return 'At least 6 characters';
                            return null;
                          },
                        ),
                        const Gap(15),
                        CustomButton(
                          text: 'Sign In',
                          width: double.infinity,
                          height: 50,
                          radius: 30,
                          gap: isLoading ? 10 : 0,
                          widget: isLoading
                              ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : null,
                          onTap: isLoading ? null : (){
                            if(formKey.currentState!.validate()){
                              context.read<AuthCubit>().login(emailController.text.trim(), passwordController.text.trim());
                            }
                          },
                        ),
                        const Gap(14),
                        Row(
                          children: [
                            const Expanded(child: Divider(color: AppColors.fieldBorder)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: CustomText(text: 'or', size: 13, color: AppColors.hintGrey),
                            ),
                            const Expanded(child: Divider(color: AppColors.fieldBorder)),
                          ],
                        ),
                        const Gap(14),
                        SocialButton(
                          label: 'Continue with Google',
                          ImagePath: 'assets/Images/Google - Original.png',
                          onTap: () {
                            print('Google Button Tapped');
                            context.read<AuthCubit>().loginWithGoogle();
                          },
                        ),
                        const Gap(12),
                        SocialButton(
                          label: 'Sign In with Facebook',
                          onTap: () {}, ImagePath: 'assets/Images/_Facebook.png',
                        ),
                        const Gap(20),
                        GestureDetector(
                          onTap: () {
                            navigatorTo(context, ForgetPasswordView());
                          },
                          child: CustomText(
                            text: 'Forgot password?',
                            size: 13,
                            color: AppColors.linkBlue,
                            font: FontWeight.w500,
                          ),
                        ),
                        const Gap(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Don't have an account yet? ",
                              size: 12,
                              color: AppColors.hintGrey,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigatorTo(context, CreateAccountView());
                              },
                              child: CustomText(
                                text: 'Sign up',
                                size: 12,
                                color: AppColors.linkBlue,
                                font: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

