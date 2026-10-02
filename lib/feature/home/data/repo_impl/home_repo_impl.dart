import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/failures.dart';
import '../../domain/enities/clinic_entity.dart';
import '../../domain/repoi/home_repo.dart';
import '../home_datasource/home_remote_datasource.dart';


class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDatasource remoteDatasource;
  HomeRepoImpl(this.remoteDatasource);

  @override
  Future<Either<Failures, List<ClinicEntity>>> getClinics() async {
    try {
      final models = await remoteDatasource.getClinics();
      return Right(models.map((m) => m.toEntity()).toList());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}