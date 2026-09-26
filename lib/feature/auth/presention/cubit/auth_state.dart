abstract class AuthState {}

class InitState extends AuthState {}

class LoadingState extends AuthState {}

class SuccessState extends AuthState {}

class ErrorState extends AuthState {
  final String message;
  ErrorState(this.message);
}