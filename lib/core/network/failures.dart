import 'package:equatable/equatable.dart';

/// `message` is now an error CODE (e.g. 'network', 'user-not-found').
/// The UI translates it with `context.errorText(message)`.
abstract class Failures extends Equatable {
  final String message;
  const Failures({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failures {
  final int? statusCode;
  const ServerFailure({required super.message, this.statusCode});
}

class NetworkFailure extends Failures {
  const NetworkFailure() : super(message: 'network');
}

class UnauthorizedFailure extends Failures {
  const UnauthorizedFailure() : super(message: 'unauthorized');
}

class NotFoundFailure extends Failures {
  const NotFoundFailure() : super(message: 'not-found');
}

class UnExpectedFailure extends Failures {
  const UnExpectedFailure() : super(message: 'unexpected');
}

class AuthFailure extends Failures {
  const AuthFailure({required super.message});
}

String cleanError(Object e) => e.toString().replaceFirst('Exception: ', '');