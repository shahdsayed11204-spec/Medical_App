import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../repoi/auth_repo.dart';

class UpdateProfileUseCase extends UseCase<void, UpdateProfileParams> {
  final AuthRepo repo;
  UpdateProfileUseCase(this.repo);
  @override
  Future<Either<Failures, void>> call(UpdateProfileParams params) {
    return repo.updateProfile(name: params.name, phone: params.phone);
  }
}

class UpdateProfileParams {
  final String name;
  final String? phone;
  UpdateProfileParams({required this.name, this.phone});
}