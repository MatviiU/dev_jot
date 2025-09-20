class AuthExceptions implements Exception {
  AuthExceptions(this.message);

  final String message;

  @override
  String toString() => 'AuthExceptions: $message';
}

class WeakPasswordException extends AuthExceptions {
  WeakPasswordException() : super('The password provided is too weak.');
}

class EmailAlreadyInUseException extends AuthExceptions {
  EmailAlreadyInUseException()
    : super('The account already exists for that email.');
}

class UserNotFoundException extends AuthExceptions {
  UserNotFoundException() : super('No user found for that email.');
}

class WrongPasswordException extends AuthExceptions {
  WrongPasswordException() : super('Wrong password provided for that user.');
}

class UnknownAuthException extends AuthExceptions {
  UnknownAuthException() : super('Something went wrong.');
}
