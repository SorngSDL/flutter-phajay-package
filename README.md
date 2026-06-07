# Flutter Phajay Package

Flutter SDK for Phajay Payment Gateway.

Supports:

- BCEL QR
- LDB QR
- Payment WebSocket
- Payment Status Listener

---

## Installation

```yaml
dependencies:
  flutter_phajay_package: ^1.0.0
```

---

## Generate QR

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