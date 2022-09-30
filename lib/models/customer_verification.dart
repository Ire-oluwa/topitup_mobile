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

class CustomerMeterVerification {
  String? textStatus;
  String? customerName;
  String? customerAddress;
  String? customerNumber;
  String? meterNumber;

  CustomerMeterVerification({
    this.textStatus,
    this.customerName,
    this.customerAddress,
    this.customerNumber,
    this.meterNumber,
  });

  static CustomerMeterVerification fromJson(json) => CustomerMeterVerification(
      textStatus: json['text_status'] as String?,
      customerName: json['name'] as String?,
      customerAddress: json['address'] as String?,
      customerNumber: json['number'] as String?,
      meterNumber: json['meterNumber'] as String?);
}
