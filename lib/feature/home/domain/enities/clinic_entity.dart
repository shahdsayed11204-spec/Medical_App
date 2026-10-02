class ClinicEntity {
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

  const ClinicEntity({
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
}