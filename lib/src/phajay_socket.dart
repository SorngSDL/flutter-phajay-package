import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'enums/payment_status.dart';
import 'models/payment_event.dart';

class PhajaySocket {
  final String secretKey;

  WebSocketChannel? _channel;

  final StreamController<PaymentEvent> _controller = StreamController.broadcast();

  Stream<PaymentEvent> get stream => _controller.stream;

  PhajaySocket({required this.secretKey});

  bool get isConnected => _channel != null;

  Future<void> connect() async {
    final encodedKey = secretKey.replaceAll(r'$', '%24');

    final url = Uri.parse('wss://portal.phajay.co/?key=$encodedKey');

    _channel = WebSocketChannel.connect(url);

    _channel!.stream.listen(
      (message) {
        try {
          final json = jsonDecode(message as String);

          if (json['status'] == 'success') {
            _controller.add(PaymentEvent(status: PaymentStatus.success, rawData: json));
          } else {
            _controller.add(PaymentEvent(status: PaymentStatus.pending, rawData: json));
          }
        } catch (_) {}
      },
      onError: (error) {
        _controller.add(PaymentEvent(status: PaymentStatus.failed, rawData: {'error': error.toString()}));
      },
    );
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
    _channel = null;
  }

  void dispose() {
    disconnect();
    _controller.close();
  }
}
