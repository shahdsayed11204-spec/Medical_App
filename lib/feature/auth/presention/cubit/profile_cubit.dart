import 'package:bloc/bloc.dart';

import '../../domain/use_case/update_profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileCubit(this.updateProfileUseCase) : super(ProfileInitState());

  Future<void> updateProfile({
    required String name,
    String? phone,
    String? nickname,
    String? dateOfBirth,
    String? gender,
  }) async {
    emit(ProfileLoadingState());

    final result = await updateProfileUseCase.call(
      UpdateProfileParams(
        name: name,
        phone: phone,
        nickname: nickname,
        dateOfBirth: dateOfBirth,
        gender: gender,
      ),
    );

    if (isClosed) return;

    result.fold(
          (error) => emit(ProfileErrorState(error.message)),
          (_) => emit(ProfileSuccessState()),
    );
  }
}