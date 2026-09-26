class UserEntity {
  final String email;
  final String name;
  final String phone;
  final String photoUrl;

  UserEntity({
    required this.email,
    required this.name,
    this.phone = '',
    this.photoUrl = '',
  });
}