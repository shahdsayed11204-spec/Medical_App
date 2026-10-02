import 'package:dartz/dartz.dart';

import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../enities/clinic_entity.dart';
import '../repoi/home_repo.dart';

class GetClinicsUseCase extends UseCaseNoParams<List<ClinicEntity>> {
  final HomeRepo repo;
  GetClinicsUseCase(this.repo);

  @override
  Future<Either<Failures, List<ClinicEntity>>> call() => repo.getClinics();
}