class CreateQrResponse {
  final String qrCode;
  final String qrImage;
  final String transactionId;

  const CreateQrResponse({
    required this.qrCode,
    required this.qrImage,
    required this.transactionId,
  });

  factory CreateQrResponse.fromJson(Map<String, dynamic> json) {
    return CreateQrResponse(
      qrCode: json['qrCode'] ?? '',
      qrImage: json['qrImage'] ?? '',
      transactionId: json['transactionId'] ?? '',
    );
  }
}
