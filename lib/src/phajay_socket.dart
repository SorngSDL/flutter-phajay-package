import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../flutter_phajay_package.dart';

class PhajaySocket {
  final String secretKey;

  io.Socket? _socket;

  final StreamController<PaymentEvent> _controller = StreamController<PaymentEvent>.broadcast();

  Stream<PaymentEvent> get stream => _controller.stream;

  PhajaySocket({required this.secretKey});

  bool get isConnected => _socket?.connected ?? false;

  Future<void> connect() async {
    if (isConnected) return;

    _socket = io.io(
      ApiConstant.socketUrl,
      io.OptionBuilder().setTransports(['websocket']).setQuery({'key': secretKey}).enableAutoConnect().build(),
    );

    _socket!.onConnect((_) {
      debugPrint('🔌 Socket connected');
    });

    _socket!.on('join::$secretKey', (data) {
      final payload = _normalize(data);
      final status = _mapStatus(payload['status']);

      _controller.add(
        PaymentEvent(
          status: status,
          rawData: payload,
        ),
      );
    });

    _socket!.onError((err) {
      _controller.add(
        PaymentEvent(
          status: PaymentStatus.failed,
          rawData: {'error': err.toString()},
        ),
      );
    });

    _socket!.onDisconnect((_) {
      debugPrint('🔌 Socket disconnected');
    });

    _socket!.connect();
  }

  Future<void> disconnect() async {
    _socket?.disconnect();
    _socket = null;
  }

  void dispose() {
    disconnect();
    _controller.close();
  }

  Map<String, dynamic> _normalize(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String) {
      try {
        return jsonDecode(data);
      } catch (_) {
        return {'message': data};
      }
    }
    return {'data': data};
  }

  PaymentStatus _mapStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'PAYMENT_COMPLETED':
      case 'SUCCESS':
      case 'COMPLETED':
      case 'SUCCEEDED':
        return PaymentStatus.success;

      case 'FAILED':
      case 'ERROR':
      case 'PAYMENT_FAILED':
        return PaymentStatus.failed;

      default:
        return PaymentStatus.pending;
    }
  }
}
