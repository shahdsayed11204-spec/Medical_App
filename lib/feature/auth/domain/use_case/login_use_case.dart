
import 'package:dartz/dartz.dart';

import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../entities/uesr_entity.dart';
import '../repoi/auth_repo.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepo repo;
  LoginUseCase(this.repo);
  Future<Either<Failures, UserEntity>> call(LoginParams params) async {
    return await repo.login(params.email, params.password);
  }
}
class LoginParams {
  final String email;
  final String password;
  LoginParams(this.email, this.password);
}