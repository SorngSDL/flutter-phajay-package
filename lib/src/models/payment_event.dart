import 'package:flutter_phajay_package/flutter_phajay_package.dart';

class PaymentEvent {
  final PaymentStatus status;
  final Map<String, dynamic> rawData;

  PaymentEvent({
    required this.status,
    required this.rawData,
  });
}
