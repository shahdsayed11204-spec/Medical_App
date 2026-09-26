


import 'package:bloc/bloc.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../domain/use_case/login_google_usecase.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/register_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUsecase registerUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  AuthCubit(this.loginUseCase, this.registerUseCase, this.loginWithGoogleUseCase)
      : super(InitState());

  Future<void> login(String email, String password) async {
    emit(LoadingState());

    final result = await loginUseCase.call(
      LoginParams(email, password),
    );

    if (isClosed) return;

    result.fold(
          (error) => emit(ErrorState(error.message)),
          (data) async {
        await CacheHelper.saveData(
          key: 'userName',
          value: data.name,
        );

        emit(SuccessState());
      },

    );
  }

  Future<void> register(
      String name,
      String email,
      String password,
      ) async
  {
    emit(LoadingState());

    final result = await registerUseCase.call(
      RegisterParams(name, email, password),
    );

    if (isClosed) return;

    result.fold(
          (error) => emit(ErrorState(error.message)),
          (data) async {
        await CacheHelper.saveData(
          key: 'userName',
          value: data.name,
        );

        emit(SuccessState());
      },
    );
  }


  Future<void> loginWithGoogle() async {
    print('Google Login Started');

    emit(LoadingState());

    final result = await loginWithGoogleUseCase.call();

    print('Google Login Result: $result');

    if (isClosed) return;

    result.fold(
          (error) {
        print('Google Login Error: ${error.message}');
        emit(ErrorState(error.message));
      },
          (data) {
        print('Google Login Success: ${data.name}');
        CacheHelper.saveData(
          key: 'userName',
          value: data.name,
        );
        emit(SuccessState());
      },
    );
  }
}