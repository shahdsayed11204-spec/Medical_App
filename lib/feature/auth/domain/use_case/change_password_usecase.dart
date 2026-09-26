import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../repoi/auth_repo.dart';

class ChangePasswordUseCase extends UseCase<void, ChangePasswordParams> {
  final AuthRepo repo;
  ChangePasswordUseCase(this.repo);
  @override
  Future<Either<Failures, void>> call(ChangePasswordParams params) {
    return repo.changePassword(currentPassword: params.currentPassword, newPassword: params.newPassword);
  }
}

class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;
  ChangePasswordParams({required this.currentPassword, required this.newPassword});
}