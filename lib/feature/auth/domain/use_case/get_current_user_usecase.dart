import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../entities/uesr_entity.dart';
import '../repoi/auth_repo.dart';

class GetCurrentUserUseCase extends UseCaseNoParams<UserEntity> {
  final AuthRepo repo;
  GetCurrentUserUseCase(this.repo);
  @override
  Future<Either<Failures, UserEntity>> call() => repo.getCurrentUser();
}