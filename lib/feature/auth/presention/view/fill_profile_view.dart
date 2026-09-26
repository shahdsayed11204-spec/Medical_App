import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medicalapp/core/get_it.dart';
import 'package:medicalapp/feature/root/root_view.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_snackbar.dart';
import '../../../../core/shared/custom_text/custom_textformfiled.dart';
import '../../../../core/shared/navigator/navigatorendfinish.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/congratulations_dialog.dart';

class FillProfileView extends StatefulWidget {
  const FillProfileView({super.key});

  @override
  State<FillProfileView> createState() => _FillProfileViewState();
}

class _FillProfileViewState extends State<FillProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();

  static const _genders = ['Male', 'Female'];

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked == null) return;
    _dobController.text =
    '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
  }

  Future<void> _pickGender() async {
    FocusScope.of(context).unfocus();
    final value = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            for (final g in _genders)
              ListTile(
                title: Text(g),
                onTap: () => Navigator.pop(context, g),
              ),
            const Gap(8),
          ],
        ),
      ),
    );
    if (value != null) _genderController.text = value;
  }

  void save(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileCubit>().updateProfile(
      name: _nameController.text.trim(),
      nickname: _nicknameController.text.trim(),
      dateOfBirth: _dobController.text.trim(),
      gender: _genderController.text.trim(),
    );
  }

  void _pickImage() {
    // NOTE: still not connected — there is no image_picker (or equivalent)
    // dependency in pubspec.yaml, so there is no way to obtain a File to pass
    // to UploadProfilePhotoUseCase. That use case exists and is registered in
    // get_it, but nothing calls it yet. Add an image-picking package and wire
    // this to `UploadProfilePhotoUseCase` (already available via ProfileCubit
    // if you extend it) to finish this piece.
    ScaffoldMessenger.of(context).showSnackBar(
      customSnack(errorMsg: 'Image picker not connected yet', color: AppColors.secondaryColor),
    );
  }

  String? _required(String? v, String msg) =>
      (v == null || v.trim().isEmpty) ? msg : null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20, color: AppColors.titleColor),
            onPressed: () => Navigator.maybePop(context),
          ),
          title: CustomText(
            text: 'Fill Your Profile',
            size: 14,
            font: FontWeight.bold,
            color: AppColors.titleColor,
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccessState) {
                showCongratsDialog(
                  context,
                  onDone: () {
                    navigatorendfini(context, const RootView());
                  },
                );
              } else if (state is ProfileErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnack(errorMsg: state.message),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is ProfileLoadingState;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Gap(16),
                            // Avatar + edit badge
                            SizedBox(
                              width: 110,
                              height: 110,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFE5E7EB),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 70,
                                      color: Color(0xFFF3F4F6),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: _pickImage,
                                      child: Container(
                                        width: 26,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: const Icon(Icons.edit, size: 13, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(24),

                            CustomTextFormField(
                              controller: _nameController,
                              hint: 'Michael Jordan',
                              validator: (v) => _required(v, 'Name is required'),
                            ),
                            const Gap(12),
                            CustomTextFormField(
                              controller: _nicknameController,
                              hint: 'Nickname',
                              validator: (v) => _required(v, 'Nickname is required'),
                            ),
                            const Gap(12),
                            CustomTextFormField(
                              controller: _emailController,
                              hint: 'name@example.com',
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                final value = v?.trim() ?? '';
                                if (value.isEmpty) return 'Email is required';
                                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
                                return ok ? null : 'Enter a valid email';
                              },
                            ),
                            const Gap(12),
                            CustomTextFormField(
                              controller: _dobController,
                              hint: 'Date of Birth',
                              icon: Icons.calendar_month_outlined,
                              readOnly: true,
                              onTap: _pickDate,
                              validator: (v) => _required(v, 'Date of birth is required'),
                            ),
                            const Gap(12),
                            CustomTextFormField(
                              controller: _genderController,
                              hint: 'Gender',
                              readOnly: true,
                              onTap: _pickGender,
                              textInputAction: TextInputAction.done,
                              suffix: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.hintGrey,
                              ),
                              validator: (v) => _required(v, 'Select your gender'),
                            ),
                            const Gap(16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: CustomButton(
                      radius: 39,
                      text: 'Save',
                      width: double.infinity,
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
                      onTap: isLoading ? null : () => save,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}