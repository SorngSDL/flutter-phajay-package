import '../enums/payment_status.dart';

class PaymentEvent {
  final PaymentStatus status;
  final Map<String, dynamic> rawData;

  const PaymentEvent({required this.status, required this.rawData});
}
