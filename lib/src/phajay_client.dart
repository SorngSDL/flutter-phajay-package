import 'dart:async';
import 'package:dio/dio.dart';

import 'constants/api_constant.dart';
import 'enums/bank_type.dart';
import 'enums/payment_status.dart';
import 'models/create_qr_response.dart';
import 'models/payment_event.dart';
import 'phajay_socket.dart';

/// Main SDK client for Phajay Payment.
/// Used to create QR and listen payment status.
class PhajayClient {
  final String secretKey;

  late final Dio _dio;
  late final PhajaySocket _socket;

  bool _initialized = false;

  PhajayClient({required this.secretKey}) {
    _dio = Dio();
    _socket = PhajaySocket(secretKey: secretKey);
  }

  Future<void> _init() async {
    if (_initialized) return;
    await _socket.connect();
    _initialized = true;
  }

  Stream<PaymentEvent> get paymentStream => _socket.stream;

  Future<CreateQrResponse> createQr({
    required BankType bank,
    required int amount,
    String description = 'Payment',
  }) async {
    await _init();

    final endpoint = switch (bank) {
      BankType.bcel => ApiConstant.createBCEL,
      BankType.ldb => ApiConstant.createLDB,
    };

    final response = await _dio.post(
      ApiConstant.baseUrl + endpoint,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'secretKey': secretKey,
      }),
      data: {
        'amount': amount,
        'description': description,
      },
    );

    return CreateQrResponse.fromJson(response.data);
  }

  Future<PaymentEvent> waitForPayment({
    Duration timeout = const Duration(minutes: 5),
  }) async {
    await _init();

    return paymentStream.firstWhere((e) => e.status == PaymentStatus.success).timeout(timeout);
  }

  Future<void> cancel() async {
    await _socket.disconnect();
    _initialized = false;
  }

  void dispose() {
    _socket.dispose();
  }
}
