import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../../../core/shared/custom_text/custom_bottom.dart';
import '../../../../core/shared/custom_text/custom_snackbar.dart';
import '../../../../core/shared/custom_text/custom_textformfiled.dart';
import '../../../../core/shared/navigator/navigatorendfinish.dart';
import '../../../local/l10n_ext.dart';
import '../../../root/view/root_view.dart';
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

  /// Language-independent value: send THIS to Firestore, never the displayed text.
  String? _genderValue; // 'male' | 'female'

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
    final t = context.l10n;
    final options = {'male': t.male, 'female': t.female};

    final value = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            for (final entry in options.entries)
              ListTile(
                title: Text(entry.value),
                onTap: () => Navigator.pop(sheetContext, entry.key),
              ),
            const Gap(8),
          ],
        ),
      ),
    );
    if (value != null) {
      _genderValue = value;
      _genderController.text = options[value]!;
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    showCongratsDialog(
      context,
      onDone: () => navigatorendfini(context, RootView()),
    );
  }

  void _pickImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnack(
        errorMsg: context.l10n.imagePickerNotConnected,
        color: AppColors.secondaryColor,
      ),
    );
  }

  String? _required(String? v, String msg) =>
      (v == null || v.trim().isEmpty) ? msg : null;

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;

    return Scaffold(
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
          text: t.fillYourProfile,
          size: 14,
          font: FontWeight.bold,
          color: AppColors.titleColor,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Gap(16),
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
                            PositionedDirectional(
                              end: 0,
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
                                  child: const Icon(Icons.edit,
                                      size: 13, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(24),
                      CustomTextFormField(
                        controller: _nameController,
                        hint: t.name,
                        validator: (v) => _required(v, t.nameRequired),
                      ),
                      const Gap(12),
                      CustomTextFormField(
                        controller: _nicknameController,
                        hint: t.nickname,
                        validator: (v) => _required(v, t.nicknameRequired),
                      ),
                      const Gap(12),
                      CustomTextFormField(
                        controller: _emailController,
                        hint: t.email,
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
                        controller: _dobController,
                        hint: t.dateOfBirth,
                        icon: Icons.calendar_month_outlined,
                        readOnly: true,
                        onTap: _pickDate,
                        validator: (v) => _required(v, t.dobRequired),
                      ),
                      const Gap(12),
                      CustomTextFormField(
                        controller: _genderController,
                        hint: t.gender,
                        readOnly: true,
                        onTap: _pickGender,
                        textInputAction: TextInputAction.done,
                        suffix: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.hintGrey,
                        ),
                        validator: (v) => _required(v, t.genderRequired),
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
                text: t.save,
                width: double.infinity,
                onTap: _save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}