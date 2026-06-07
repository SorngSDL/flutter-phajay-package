import 'package:flutter_phajay_package/src/phajay_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'create client',
    () {
      final client = PhajayClient(
        secretKey: 'test',
      );

      expect(
        client,
        isA<PhajayClient>(),
      );
    },
  );
}
