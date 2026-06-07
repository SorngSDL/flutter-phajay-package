import 'package:flutter_phajay_package/flutter_phajay_package.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PaymentEvent should hold correct data', () {
    final event = PaymentEvent(
      status: PaymentStatus.success,
      rawData: const {'amount': 10000},
    );

    expect(event.status, PaymentStatus.success);
    expect(event.rawData['amount'], 10000);
  });
}
