import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/network/failures.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../domain/entities/uesr_entity.dart';
import '../../domain/repoi/auth_repo.dart';
import '../data_sources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo{
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepoImpl(this.authRemoteDatasource);

  UserEntity _toEntity(UserModel user) => UserEntity(
    name: user.name,
    email: user.email,
    phone: user.phone,
    photoUrl: user.photoUrl,
    nickname: user.nickname,
    dateOfBirth: user.dateOfBirth,
    gender: user.gender,
  );

  @override
  Future<Either<Failures, UserEntity>> login(String email, String password) async {
    try {
      final user = await authRemoteDatasource.login(email, password);
      return Right(_toEntity(user));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? e.code));
    } catch (e) {
      print('🔥 FIRESTORE ERROR: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> register(String name, String email, String password) async {
    try {
      final user = await authRemoteDatasource.registerNewUser(name: name, email: email, password: password);
      return Right(_toEntity(user));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? e.code));
    } catch (e) {
      print('🔥 FIRESTORE ERROR: $e');
      return Left(ServerFailure(message: e.toString()));

    }
  }

  @override
  Future<Either<Failures, UserEntity>> loginWithGoogle() async {
    try {
      final user = await authRemoteDatasource.loginWithGoogle();
      return Right(_toEntity(user));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> getCurrentUser() async {
    try {
      final user = await authRemoteDatasource.getCurrentUser();
      return Right(_toEntity(user));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> logout() async {
    try {
      await authRemoteDatasource.logout();
      await CacheHelper.clearData();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> updateProfile({
    required String name,
    String? phone,
    String? nickname,
    String? dateOfBirth,
    String? gender,
  }) async {
    try {
      await authRemoteDatasource.updateProfile(
        name: name,
        phone: phone,
        nickname: nickname,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> changePassword({required String currentPassword, required String newPassword}) async {
    try {
      await authRemoteDatasource.changePassword(currentPassword: currentPassword, newPassword: newPassword);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> uploadProfilePhoto(File file) async {
    try {
      final url = await authRemoteDatasource.uploadProfilePhoto(file);
      return Right(url);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}