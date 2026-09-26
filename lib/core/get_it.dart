import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../feature/auth/data/data_sources/auth_remote_datasource.dart';
import '../feature/auth/data/repo_imp/auth_repo_impl.dart';
import '../feature/auth/domain/repoi/auth_repo.dart';
import '../feature/auth/domain/use_case/change_password_usecase.dart';
import '../feature/auth/domain/use_case/get_current_user_usecase.dart';
import '../feature/auth/domain/use_case/login_google_usecase.dart';
import '../feature/auth/domain/use_case/login_use_case.dart';
import '../feature/auth/domain/use_case/logout_usecase.dart';
import '../feature/auth/domain/use_case/register_use_case.dart';
import '../feature/auth/domain/use_case/update_profile_usecase.dart';
import '../feature/auth/domain/use_case/upload_profile_photo_usecase.dart';
import '../feature/auth/presention/cubit/auth_cubit.dart';

final getIt= GetIt.instance;

Future<void>setup()async{
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance,);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);


  getIt.registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImp(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));

  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(getIt()));
  getIt.registerLazySingleton<LoginWithGoogleUseCase>(
        () => LoginWithGoogleUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
        () => GetCurrentUserUseCase(getIt()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton<UpdateProfileUseCase>(
        () => UpdateProfileUseCase(getIt()),
  );
  getIt.registerLazySingleton<ChangePasswordUseCase>(
        () => ChangePasswordUseCase(getIt()),
  );
  getIt.registerLazySingleton<UploadProfilePhotoUseCase>(
        () => UploadProfilePhotoUseCase(getIt()),
  );

  getIt.registerFactory(() => AuthCubit(getIt(), getIt(), getIt()));

  // getIt.registerFactory(
  //       () => ProfileCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  // );
}