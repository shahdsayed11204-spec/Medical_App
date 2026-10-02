import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../home/domain/enities/clinic_entity.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';
import '../../../home/presentation/widgets/clinic_card.dart';


class NearbyView extends StatefulWidget {
  const NearbyView({super.key});

  @override
  State<NearbyView> createState() => _NearbyViewState();
}

class _NearbyViewState extends State<NearbyView> {
  final _mapController = MapController();
  final _pageController = PageController(viewportFraction: 0.78);
  int _selected = 0;

  // Seattle fallback until geolocator is wired
  static const _fallbackCenter = LatLng(47.6062, -122.3321);

  @override
  void dispose() {
    _pageController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _select(List<ClinicEntity> items, int i) {
    setState(() => _selected = i);
    _mapController.move(LatLng(items[i].lat, items[i].lng), 14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final items = state is ClinicsSuccessState
              ? state.clinics
              : const <ClinicEntity>[];
          final center = items.isEmpty
              ? _fallbackCenter
              : LatLng(items.first.lat, items.first.lng);

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(initialCenter: center, initialZoom: 13),
                children: [
                  TileLayer(
                    urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.medicalapp',
                  ),
                  MarkerLayer(
                    markers: [
                      for (var i = 0; i < items.length; i++)
                        Marker(
                          point: LatLng(items[i].lat, items[i].lng),
                          width: 44,
                          height: 52,
                          child: GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                i,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                              _select(items, i);
                            },
                            child: Icon(
                              Icons.location_on,
                              size: i == _selected ? 48 : 38,
                              color: i == _selected
                                  ? AppColors.secondaryColor
                                  : AppColors.hintGrey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: TextField(
                    cursorColor: AppColors.secondaryColor,
                    decoration: InputDecoration(
                      hintText: 'Search Doctor, Hospital',
                      hintStyle: const TextStyle(
                          color: AppColors.hintGrey, fontSize: 12),
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.hintGrey, size: 20),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              if (state is ClinicsLoadingState)
                const Center(child: CircularProgressIndicator()),
              Positioned(
                left: 0,
                right: 0,
                bottom: 96,
                height: 190,
                child: items.isEmpty
                    ? const SizedBox.shrink()
                    : PageView.builder(
                  controller: _pageController,
                  itemCount: items.length,
                  onPageChanged: (i) => _select(items, i),
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ClinicCard(clinic: items[i], detailed: true),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}