import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/shared/custom_text/coustom_taxt.dart';
import '../../domain/enities/clinic_entity.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/clinic_card.dart';

class _Category {
  final String label;
  final IconData icon;
  final Color color;
  const _Category(this.label, this.icon, this.color);
}

const _categories = [
  _Category('Dentistry', Icons.medical_services_outlined, Color(0xFFE5A0A5)),
  _Category('Cardiology', Icons.monitor_heart_outlined, Color(0xFFA9D3B5)),
  _Category('Pulmonology', Icons.air, Color(0xFFF6B58F)),
  _Category('General', Icons.local_hospital_outlined, Color(0xFFB7A6E0)),
  _Category('Neurology', Icons.psychology_outlined, Color(0xFF5FA79B)),
  _Category('Gastroen..', Icons.restaurant_outlined, Color(0xFF3B2A6B)),
  _Category('Laborato..', Icons.science_outlined, Color(0xFFE5B8B8)),
  _Category('Vaccinat..', Icons.vaccines_outlined, Color(0xFF9FDCE8)),
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const Gap(14),
              _searchBar(),
              const Gap(16),
              _banner(),
              const Gap(20),
              _sectionTitle('Categories'),
              const Gap(12),
              _categoriesGrid(),
              const Gap(20),
              _sectionTitle('Nearby Medical Centers'),
              const Gap(12),
              _nearbyList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: 'Location', size: 11, color: AppColors.hintGrey),
            const Gap(2),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColors.titleColor),
                const Gap(4),
                CustomText(
                  text: 'Seattle, USA',
                  size: 12,
                  font: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
                const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.titleColor),
              ],
            ),
          ],
        ),
      ),
      Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.fieldFill),
        child: const Icon(Icons.notifications_none, size: 18, color: AppColors.titleColor),
      ),
    ],
  );

  Widget _searchBar() => TextField(
    cursorColor: AppColors.secondaryColor,
    decoration: InputDecoration(
      hintText: 'Search doctor...',
      hintStyle: const TextStyle(color: AppColors.hintGrey, fontSize: 13),
      prefixIcon: const Icon(Icons.search, color: AppColors.hintGrey, size: 20),
      filled: true,
      fillColor: AppColors.fieldFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );

  Widget _banner() => Container(
    height: 90,
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [Color(0xFF3F8F86), Color(0xFF6FB3A8)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Looking for\nSpecialist Doctors?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
          textScaler: TextScaler.linear(1.0),
        ),
        const Gap(4),
        Text(
          'Schedule an appointment with\nour top doctors.',
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 9),
          textScaler: const TextScaler.linear(1.0),
        ),
      ],
    ),
  );

  Widget _sectionTitle(String t) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(text: t, size: 13, font: FontWeight.w700, color: AppColors.titleColor),
      CustomText(text: 'See All', size: 11, color: AppColors.hintGrey),
    ],
  );

  Widget _categoriesGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _categories.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.78,
    ),
    itemBuilder: (_, i) {
      final c = _categories[i];
      return Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: c.color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(c.icon, color: Colors.white, size: 26),
          ),
          const Gap(6),
          CustomText(
            text: c.label,
            size: 10,
            font: FontWeight.w500,
            color: AppColors.titleColor,
            maxLines: 1,
          ),
        ],
      );
    },
  );

  Widget _nearbyList() => SizedBox(
    height: 190,
    child: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is ClinicsErrorState) {
          return Center(
            child: GestureDetector(
              onTap: () => context.read<HomeCubit>().getClinics(),
              child: CustomText(
                text: '${state.message}\nTap to retry',
                size: 11,
                color: Colors.redAccent,
              ),
            ),
          );
        }
        if (state is ClinicsSuccessState) {
          if (state.clinics.isEmpty) {
            return Center(
              child: CustomText(
                text: 'No medical centers yet',
                size: 12,
                color: AppColors.hintGrey,
              ),
            );
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.clinics.length,
            separatorBuilder: (_, __) => const Gap(12),
            itemBuilder: (_, i) =>
                ClinicCard(clinic: state.clinics[i], width: 170),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    ),
  );
}

