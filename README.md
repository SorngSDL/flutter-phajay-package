# Flutter Phajay Package

Flutter SDK for Phajay Payment Gateway.

A lightweight and production-ready Flutter SDK for generating QR payments and listening real-time payment status via WebSocket.

This package is designed to be simple, fast, and easy to integrate into any Flutter application.

---

## ✨ Features

- QR generation (BCEL, LDB)
- Real-time payment status via WebSocket
- Stream-based payment event listener
- Async wait for payment result
- Clean and simple SDK API
- Production-ready architecture

---

## 📦 Installation

```yaml
dependencies:
  flutter_phajay_package: ^1.1.2
```

---

## 🚀 Import
```dart 
import 'package:flutter_phajay_package/flutter_phajay_package.dart';
```

---

## 💳 Generate QR

```dart
final client = PhajayClient(
  secretKey: 'YOUR_SECRET_KEY',
);

final qr = await client.createQr(
  bank: BankType.bcel,
  amount: 100000,
);
```

---

## 📡 Listen Payment

```dart 
client.paymentStream.listen((event) {
  if (event.status == PaymentStatus.success) {
    print('Payment Success');
  }
});
```

---

## ⏳ Wait Payment

```dart
await client.waitForPayment();
```

---

## 👨‍💻 Credits

Developed by: Sorng Sdr

Facebook:
https://www.facebook.com/msorng.saiydala.la

---

