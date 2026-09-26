import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/use_case.dart';
import '../repoi/auth_repo.dart';

class UploadProfilePhotoUseCase extends UseCase<String, File> {
  final AuthRepo repo;
  UploadProfilePhotoUseCase(this.repo);
  @override
  Future<Either<Failures, String>> call(File params) {
    return repo.uploadProfilePhoto(params);
  }
}