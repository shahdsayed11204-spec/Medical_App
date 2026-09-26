import 'package:dartz/dartz.dart';

import '../../../../core/network/failures.dart';
import '../entities/uesr_entity.dart';
import '../repoi/auth_repo.dart';

class LoginWithGoogleUseCase {
  final AuthRepo repo;

  LoginWithGoogleUseCase(this.repo);

  Future<Either<Failures, UserEntity>> call() {
    return repo.loginWithGoogle();
  }
}
