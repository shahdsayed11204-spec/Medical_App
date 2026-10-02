import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/enities/clinic_entity.dart';

class ClinicModel {
  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviews;
  final String distance;
  final String type;
  final String imageUrl;
  final double lat;
  final double lng;

  ClinicModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.type,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  });

  factory ClinicModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return ClinicModel(
      id: doc.id,
      name: d['name'] as String? ?? '',
      address: d['address'] as String? ?? '',
      rating: (d['rating'] as num?)?.toDouble() ?? 0,
      reviews: (d['reviews'] as num?)?.toInt() ?? 0,
      distance: d['distance'] as String? ?? '',
      type: d['type'] as String? ?? 'Hospital',
      imageUrl: d['imageUrl'] as String? ?? '',
      lat: (d['lat'] as num?)?.toDouble() ?? 0,
      lng: (d['lng'] as num?)?.toDouble() ?? 0,
    );
  }

  ClinicEntity toEntity() => ClinicEntity(
    id: id,
    name: name,
    address: address,
    rating: rating,
    reviews: reviews,
    distance: distance,
    type: type,
    imageUrl: imageUrl,
    lat: lat,
    lng: lng,
  );
}