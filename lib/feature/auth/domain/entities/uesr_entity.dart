class UserEntity {
  final String email;
  final String name;
  final String phone;
  final String photoUrl;
  final String nickname;
  final String dateOfBirth;
  final String gender;

  UserEntity({
    required this.email,
    required this.name,
    this.phone = '',
    this.photoUrl = '',
    this.nickname = '',
    this.dateOfBirth = '',
    this.gender = '',
  });
}