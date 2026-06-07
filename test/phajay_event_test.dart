import 'package:flutter_phajay_package/phajay_payment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('payment event', () {
    const event = PaymentEvent(status: PaymentStatus.success, rawData: {'amount': 10000});

    expect(event.status, PaymentStatus.success);

    expect(event.rawData['amount'], 10000);
  });
}
