import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/core/get_it.dart';
import 'package:medicalapp/feature/auth/presention/cubit/auth_cubit.dart';
import 'package:medicalapp/feature/auth/presention/view/fill_profile_view.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_snackbar.dart';
import '../../../../core/shared/custom_text/custom_textformfiled.dart';
import '../../../../core/shared/navigator/navigatorTo.dart';
import '../../../local/l10n_ext.dart';
import '../cubit/auth_state.dart';
import '../widgets/social_Button.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );
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
                    errorMsg: t.registrationSuccess,
                    color: Colors.green,
                    icon: Icons.done,
                  ),
                );
                navigatorTo(context, const FillProfileView());
              } else if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnack(errorMsg: context.errorText(state.message)),
                );
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Gap(40),
                        Image.asset(
                          'assets/Images/Vector.png',
                          height: 48,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.local_hospital_outlined,
                            size: 48,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        const Gap(6),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Health',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Pal',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          style: const TextStyle(fontSize: 14),
                          textScaler: const TextScaler.linear(1.0),
                        ),
                        const Gap(28),
                        CustomText(
                          text: t.createAccount,
                          size: 16,
                          font: FontWeight.bold,
                          color: AppColors.titleColor,
                        ),
                        const Gap(4),
                        CustomText(
                          text: t.createAccountSubtitle,
                          size: 11,
                          color: AppColors.hintGrey,
                        ),
                        const Gap(24),
                        CustomTextFormField(
                          controller: nameController,
                          hint: t.yourName,
                          icon: Icons.person_outline,
                          validator: (v) =>
                          (v == null || v.trim().isEmpty) ? t.nameRequired : null,
                        ),
                        const Gap(12),
                        CustomTextFormField(
                          controller: emailController,
                          hint: t.yourEmail,
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            final value = v?.trim() ?? '';
                            if (value.isEmpty) return t.emailRequired;
                            final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(value);
                            return ok ? null : t.emailInvalid;
                          },
                        ),
                        const Gap(12),
                        CustomTextFormField(
                          controller: passwordController,
                          hint: t.password,
                          icon: Icons.lock_outline,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _register(context),
                          validator: (v) {
                            if (v == null || v.isEmpty) return t.passwordRequired;
                            return v.length < 6 ? t.passwordMin : null;
                          },
                        ),
                        const Gap(20),
                        CustomButton(
                          text: t.createAccount,
                          width: double.infinity,
                          onTap: state is LoadingState
                              ? null
                              : () => _register(context),
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            const Expanded(
                                child: Divider(color: AppColors.fieldBorder)),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomText(
                                text: t.or,
                                size: 11,
                                color: AppColors.hintGrey,
                              ),
                            ),
                            const Expanded(
                                child: Divider(color: AppColors.fieldBorder)),
                          ],
                        ),
                        const Gap(16),
                        SocialButton(
                          label: t.continueWithGoogle,
                          ImagePath: 'assets/Images/Google - Original.png',
                          onTap: () => context.read<AuthCubit>().loginWithGoogle(),
                        ),
                        const Gap(10),
                        SocialButton(
                          label: t.continueWithFacebook,
                          ImagePath: 'assets/Images/_Facebook.png',
                          onTap: () {},
                        ),
                        const Gap(28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: t.haveAccount,
                              size: 11,
                              color: AppColors.hintGrey,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.maybePop(context),
                              child: CustomText(
                                text: t.signIn,
                                size: 11,
                                font: FontWeight.w600,
                                color: AppColors.linkBlue,
                              ),
                            ),
                          ],
                        ),
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