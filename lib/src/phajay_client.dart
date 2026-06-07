import 'dart:async';

import 'package:dio/dio.dart';

import 'constants/api_constant.dart';
import 'enums/bank_type.dart';
import 'enums/payment_status.dart';
import 'models/create_qr_response.dart';
import 'models/payment_event.dart';
import 'phajay_socket.dart';

class PhajayClient {
  final String secretKey;

  late final Dio _dio;

  late final PhajaySocket _socket;

  PhajayClient({required this.secretKey}) {
    _dio = Dio();

    _socket = PhajaySocket(secretKey: secretKey);
  }

  Stream<PaymentEvent> get paymentStream => _socket.stream;

  Future<void> connect() async {
    await _socket.connect();
  }

  Future<void> disconnect() async {
    await _socket.disconnect();
  }

  Future<CreateQrResponse> createQr({
    required BankType bank,
    required int amount,
    String description = 'Payment',
  }) async {
    final endpoint = switch (bank) {
      BankType.bcel => ApiConstant.createBCEL,
      BankType.ldb => ApiConstant.createLDB,
    };

    final response = await _dio.post(
      ApiConstant.baseUrl + endpoint,
      options: Options(headers: {'Content-Type': 'application/json', 'secretKey': secretKey}),
      data: {'amount': amount, 'description': description},
    );

    if (response.statusCode == 200) {
      return CreateQrResponse.fromJson(response.data);
    }

    throw Exception('Failed to create QR');
  }

  Future<PaymentEvent> waitForPayment({Duration timeout = const Duration(minutes: 5)}) async {
    return paymentStream.firstWhere((event) => event.status == PaymentStatus.success).timeout(timeout);
  }

  void dispose() {
    _socket.dispose();
  }
}
