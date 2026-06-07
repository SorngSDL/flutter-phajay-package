import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'constants/api_constant.dart';
import 'enums/payment_status.dart';
import 'models/payment_event.dart';

class PhajaySocket {
  final String secretKey;

  io.Socket? _socket;

  final StreamController<PaymentEvent> _controller = StreamController.broadcast();

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
      debugPrint('🔌 Connected to Phajay socket');
    });

    _socket!.on('join::$secretKey', (data) {
      debugPrint('💰 Payment received: $data');
      final payload = _normalizeEventData(data);

      if (payload['status'] == 'success' || payload['status'] == 'completed') {
        _controller.add(PaymentEvent(status: PaymentStatus.success, rawData: payload));
      } else if (payload['status'] == 'failed' || payload['status'] == 'error') {
        _controller.add(PaymentEvent(status: PaymentStatus.failed, rawData: payload));
      } else {
        _controller.add(PaymentEvent(status: PaymentStatus.pending, rawData: payload));
      }
    });

    _socket!.onConnectError((err) {
      debugPrint('❌ Connect error: $err');
      _controller.add(PaymentEvent(status: PaymentStatus.failed, rawData: {'error': err.toString()}));
    });

    _socket!.onError((err) {
      debugPrint('❌ Error: $err');
      _controller.add(PaymentEvent(status: PaymentStatus.failed, rawData: {'error': err.toString()}));
    });

    _socket!.onDisconnect((_) {
      debugPrint('🔌 Disconnected');
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

  Map<String, dynamic> _normalizeEventData(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String) {
      try {
        return jsonDecode(data) as Map<String, dynamic>;
      } catch (_) {
        return {'message': data};
      }
    }
    return {'data': data};
  }
}
