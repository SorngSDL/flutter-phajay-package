import 'package:flutter_phajay_package/phajay_payment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('connect websocket', () async {
    final client = PhajayClient(secretKey: 'YOUR_SECRET_KEY');

    await client.connect();

    expect(client.paymentStream, isA<Stream<PaymentEvent>>());

    client.dispose();
  });
}
