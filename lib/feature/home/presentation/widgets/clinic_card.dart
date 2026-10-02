import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/app_colors.dart';
import '../../domain/enities/clinic_entity.dart';

class ClinicCard extends StatelessWidget {
  const ClinicCard({super.key, required this.clinic, this.width, this.detailed = false});

  final ClinicEntity clinic;
  final double? width;
  final bool detailed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: detailed ? 105 : 110,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: clinic.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.fieldFill),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.fieldFill,
                child: const Icon(Icons.local_hospital_outlined, color: AppColors.hintGrey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinic.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                  ),
                  textScaler: const TextScaler.linear(1.0),
                ),
                if (detailed) ...[
                  const Gap(4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 11, color: AppColors.hintGrey),
                      const Gap(3),
                      Expanded(
                        child: Text(
                          clinic.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, color: AppColors.hintGrey),
                          textScaler: const TextScaler.linear(1.0),
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Text(
                        clinic.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                        textScaler: const TextScaler.linear(1.0),
                      ),
                      const Gap(3),
                      ...List.generate(
                        5,
                            (i) => Icon(
                          Icons.star,
                          size: 10,
                          color: i < clinic.rating.round() ? Colors.orange : Colors.grey.shade300,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '(${clinic.reviews} Reviews)',
                        style: const TextStyle(fontSize: 9, color: AppColors.hintGrey),
                        textScaler: const TextScaler.linear(1.0),
                      ),
                    ],
                  ),
                  const Divider(height: 14, color: AppColors.fieldBorder),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        clinic.distance,
                        style: const TextStyle(fontSize: 9, color: AppColors.hintGrey),
                        textScaler: const TextScaler.linear(1.0),
                      ),
                      Text(
                        clinic.type,
                        style: const TextStyle(fontSize: 9, color: AppColors.hintGrey),
                        textScaler: const TextScaler.linear(1.0),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}