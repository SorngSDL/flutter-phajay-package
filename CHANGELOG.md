## 1.1.1

Public SDK update for pub.dev release.

### Features
- Public SDK exported via `flutter_phajay_package`
- Added Phajay payment QR generation support
- Socket-based real-time payment status listener
- Support for BCEL and LDB bank QR creation
- Automatic payment event stream handling

### Improvements
- Simplified SDK usage (no manual socket handling required)
- Improved internal socket connection stability
- Standardized payment event structure using `PaymentStatus` enum
- Improved API consistency for production use

### Notes
- This version is the first stable public release of the SDK

## 1.1.0

Public SDK update for publishing.

Features:

- Public API export via flutter_phajay_package
- Updated Phajay payment endpoint support
- Socket-based payment status listening
- QR generation for BCEL and LDB

## 1.0.0

Initial release.

Features:

- Generate BCEL QR
- Generate LDB QR
- Listen payment status
- Wait payment success
- WebSocket support