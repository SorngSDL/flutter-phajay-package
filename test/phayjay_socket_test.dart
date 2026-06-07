import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_phajay_package/phajay_payment.dart';

void main() {
  test('PhajayClient should initialize stream correctly', () {
    final client = PhajayClient(secretKey: 'TEST_KEY');

    expect(client.paymentStream, isA<Stream<PaymentEvent>>());

    client.dispose();
  });
}
