class CustomerCableVerification {
  String? textStatus;
  String? customerName;
  String? smartCardNumber;

  CustomerCableVerification({
    this.textStatus,
    this.customerName,
    this.smartCardNumber,
  });

  static CustomerCableVerification fromJson(json) => CustomerCableVerification(
      textStatus: json['text_status'] as String?,
      customerName: json['name'] as String?,
      smartCardNumber: json['smartcard']);
}
