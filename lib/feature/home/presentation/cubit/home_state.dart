
import '../../domain/enities/clinic_entity.dart';

abstract class HomeState {}

class ClinicsInitState extends HomeState {}

class ClinicsLoadingState extends HomeState {}

class ClinicsSuccessState extends HomeState {
  final List<ClinicEntity> clinics;
  ClinicsSuccessState(this.clinics);
}

class ClinicsErrorState extends HomeState {
  final String message;
  ClinicsErrorState(this.message);
}