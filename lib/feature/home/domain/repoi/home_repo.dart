import 'package:dartz/dartz.dart';

import '../../../../core/network/failures.dart';
import '../enities/clinic_entity.dart';

abstract class HomeRepo {
  Future<Either<Failures, List<ClinicEntity>>> getClinics();
}