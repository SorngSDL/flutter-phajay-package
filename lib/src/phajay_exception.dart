class PhajayException implements Exception {
  final String message;

  const PhajayException(
    this.message,
  );

  @override
  String toString() {
    return 'PhajayException: $message';
  }
}
