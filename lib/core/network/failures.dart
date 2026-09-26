import 'package:equatable/equatable.dart';
abstract class Failures extends Equatable{
  final String message;
  Failures({required this.message});
  List<Object> get props =>[message];
}

class ServerFailure extends Failures {
  final int ? statusCode;
  ServerFailure({required super.message, this.statusCode});
}

class NetworkFailure extends Failures{
  NetworkFailure():super(message: 'Check your internet connection');
}
class UnauthorizedFailure extends Failures {
  UnauthorizedFailure(): super(message: "Token , Session End , Try to Login again") ;
}

class NotFoundFailure extends Failures {
  NotFoundFailure(): super(message: "Not Found") ;
}
class UnExpectedFailure extends Failures {
  UnExpectedFailure(): super(message: "UnExpectedFailure") ;
}
class AuthFailure extends Failures {
  AuthFailure({required String message}): super(message: message) ;
}
