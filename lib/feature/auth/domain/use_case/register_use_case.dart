import 'package:dartz/dartz.dart';

import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../entities/uesr_entity.dart';
import '../repoi/auth_repo.dart';

class RegisterUsecase extends UseCase<UserEntity,RegisterParams > {
  AuthRepo repo;
  RegisterUsecase(this.repo);
  @override
  Future<Either<Failures, UserEntity>> call(RegisterParams params) {
    return repo.register(params.name, params.email, params.pass);
  }

}

class RegisterParams{
  String name;
  String email;
  String pass;
  RegisterParams(this.name, this.email, this.pass);
}