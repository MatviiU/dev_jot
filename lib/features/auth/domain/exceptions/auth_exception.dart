class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthExceptions: $message';
}

class WeakPasswordException extends AuthException {
  WeakPasswordException() : super('The password provided is too weak.');
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException()
    : super('The account already exists for that email.');
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super('No user found for that email.');
}

class WrongPasswordException extends AuthException {
  WrongPasswordException() : super('Wrong password provided for that user.');
}

class UnknownAuthException extends AuthException {
  UnknownAuthException() : super('Something went wrong.');
}
