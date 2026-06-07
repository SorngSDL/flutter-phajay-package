import 'package:flutter_phajay_package/flutter_phajay_package.dart';
import 'package:flutter_phajay_package/src/phajay_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PhajayClient should initialize stream correctly', () {
    final client = PhajayClient(secretKey: 'TEST_KEY');

    expect(client.paymentStream, isA<Stream<PaymentEvent>>());

    client.dispose();
  });
}
