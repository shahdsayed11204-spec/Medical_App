import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../repoi/auth_repo.dart';

class LogoutUseCase extends UseCaseNoParams<void> {
  final AuthRepo repo;
  LogoutUseCase(this.repo);
  @override
  Future<Either<Failures, void>> call() => repo.logout();
}