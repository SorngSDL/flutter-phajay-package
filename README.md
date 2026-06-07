# Flutter Phajay Package

Flutter SDK for Phajay Payment Gateway.

This package is ready for public use and exposes the main payment API for QR generation and transaction status listening.

Supports:

- BCEL QR
- LDB QR
- Payment status listening
- WebSocket/socket-based payment events

---

## Installation

```yaml
dependencies:
  flutter_phajay_package: ^1.1.0
```

---

## Generate QR

```dart
import 'package:flutter_phajay_package/flutter_phajay_package.dart';

final client = PhajayClient(
  secretKey: 'YOUR_SECRET_KEY',
);

final qr = await client.createQr(
  bank: BankType.bcel,
  amount: 100000,
);
```

---

## Listen Payment

```dart
client.paymentStream.listen((event) {
  if (event.status == PaymentStatus.success) {
    print('Payment Success');
  }
});
```

---

## Wait Payment

```dart
await client.waitForPayment();
```

---

## Credits

Developed by : Sorng Sdr

Facebook:
https://www.facebook.com/msorng.saiydala.la