import 'package:bloc/bloc.dart';

import '../../domain/use_case/get_clinics_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetClinicsUseCase getClinicsUseCase;

  HomeCubit(this.getClinicsUseCase) : super(ClinicsInitState());

  Future<void> getClinics() async {
    emit(ClinicsLoadingState());

    final result = await getClinicsUseCase.call();

    if (isClosed) return;

    result.fold(
          (error) => emit(ClinicsErrorState(error.message)),
          (clinics) => emit(ClinicsSuccessState(clinics)),
    );
  }
}