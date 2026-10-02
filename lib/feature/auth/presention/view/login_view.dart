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

import '../../../local/l10n_ext.dart';
import '../../../root/view/root_view.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'create_account_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;

    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnack(
                    errorMsg: t.success,
                    color: Colors.green,
                    icon: Icons.done,
                  ),
                );
                navigatorReplace(context, RootView());
              }
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnack(errorMsg: context.errorText(state.message)),
                );
              }
              if (state is LoadingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnack(errorMsg: t.loading, color: Colors.amber),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is LoadingState;
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
                          TextSpan(
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
                          text: t.loginTitle,
                          size: 18,
                          font: FontWeight.w700,
                          color: AppColors.titleColor,
                        ),
                        const Gap(8),
                        CustomText(
                          text: t.loginSubtitle,
                          size: 12,
                          color: AppColors.hintGrey,
                        ),
                        const Gap(25),
                        CustomTextFormField(
                          controller: emailController,
                          hint: t.yourEmail,
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return t.emailRequired;
                            }
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(v.trim())) {
                              return t.emailInvalid;
                            }
                            return null;
                          },
                        ),
                        const Gap(14),
                        CustomTextFormField(
                          controller: passwordController,
                          hint: t.password,
                          icon: Icons.lock_outline_rounded,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(context),
                          validator: (v) {
                            if (v == null || v.isEmpty) return t.passwordRequired;
                            if (v.length < 6) return t.passwordMin;
                            return null;
                          },
                        ),
                        const Gap(15),
                        CustomButton(
                          text: t.signIn,
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
                          onTap: isLoading ? null : () => _submit(context),
                        ),
                        const Gap(14),
                        Row(
                          children: [
                            const Expanded(
                                child: Divider(color: AppColors.fieldBorder)),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              child: CustomText(
                                text: t.or,
                                size: 13,
                                color: AppColors.hintGrey,
                              ),
                            ),
                            const Expanded(
                                child: Divider(color: AppColors.fieldBorder)),
                          ],
                        ),
                        const Gap(14),
                        SocialButton(
                          label: t.continueWithGoogle,
                          ImagePath: 'assets/Images/Google - Original.png',
                          onTap: () => context.read<AuthCubit>().loginWithGoogle(),
                        ),
                        const Gap(12),
                        SocialButton(
                          label: t.signInWithFacebook,
                          onTap: () {},
                          ImagePath: 'assets/Images/_Facebook.png',
                        ),
                        const Gap(20),
                        GestureDetector(
                          onTap: () => navigatorTo(context, ForgetPasswordView()),
                          child: CustomText(
                            text: t.forgotPassword,
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
                              text: t.noAccountYet,
                              size: 12,
                              color: AppColors.hintGrey,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  navigatorTo(context, CreateAccountView()),
                              child: CustomText(
                                text: t.signUp,
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