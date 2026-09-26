import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../repoi/auth_repo.dart';

class UpdateProfileUseCase extends UseCase<void, UpdateProfileParams> {
  final AuthRepo repo;
  UpdateProfileUseCase(this.repo);
  @override
  Future<Either<Failures, void>> call(UpdateProfileParams params) {
    return repo.updateProfile(
      name: params.name,
      phone: params.phone,
      nickname: params.nickname,
      dateOfBirth: params.dateOfBirth,
      gender: params.gender,
    );
  }
}

class UpdateProfileParams {
  final String name;
  final String? phone;
  final String? nickname;
  final String? dateOfBirth;
  final String? gender;
  UpdateProfileParams({
    required this.name,
    this.phone,
    this.nickname,
    this.dateOfBirth,
    this.gender,
  });
}