sealed class TipException implements Exception {
  TipException(this.message);

  final String message;

  @override
  String toString() => 'TipException: $message';
}

class FetchTipException extends TipException {
  FetchTipException() : super('Failed to fetch tip');
}

class UnknownTipException extends TipException {
  UnknownTipException() : super('Unknown tip error');
}
