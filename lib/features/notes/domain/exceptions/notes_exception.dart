class NotesException implements Exception {
  NotesException(this.message);

  final String message;

  @override
  String toString() => 'NotesException: $message';
}

class UserNotFoundExceptionWithUid extends NotesException {
  UserNotFoundExceptionWithUid() : super('No user found for that uid.');
}

class NoteNotFoundForUpdateException extends NotesException {
  NoteNotFoundForUpdateException()
    : super('Note ID cannot be empty for an update');
}

class NoteNotFoundForDeleteException extends NotesException {
  NoteNotFoundForDeleteException()
    : super('Note ID cannot be empty for deletion');
}
