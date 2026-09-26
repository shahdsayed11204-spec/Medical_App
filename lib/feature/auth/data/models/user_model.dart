class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String nickname;
  final String dateOfBirth;
  final String gender;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.photoUrl = '',
    this.nickname = '',
    this.dateOfBirth = '',
    this.gender = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      photoUrl: json['photoUrl'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'nickname': nickname,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
    };
  }
}