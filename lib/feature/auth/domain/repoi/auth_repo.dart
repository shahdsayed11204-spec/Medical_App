import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/network/failures.dart';
import '../entities/uesr_entity.dart';


abstract class AuthRepo {
  Future<Either<Failures, UserEntity>> login(String email, String password,);
  Future<Either<Failures,UserEntity>> register(String email,String name,String password);
  Future<Either<Failures,UserEntity>> loginWithGoogle();
  Future<Either<Failures,UserEntity>> getCurrentUser();
  Future<Either<Failures,void>> logout();
  Future<Either<Failures,void>> updateProfile({
    required String name,
    String? phone,
    String? nickname,
    String? dateOfBirth,
    String? gender,
  });
  Future<Either<Failures,void>> changePassword({required String currentPassword, required String newPassword});
  Future<Either<Failures,String>> uploadProfilePhoto(File file);
}