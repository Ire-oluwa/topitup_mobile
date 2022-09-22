class RechargeHistoryModel {
  int? recId;
  String? username;
  String? website;
  String? phone;
  String? amount;
  String? source;
  String? status;
  String? serviceName;
  String? responseCode;
  String? payStatus;
  String? dateAdded;
  int? vendorId;
  int? apiId;
  int? uploadId;

  RechargeHistoryModel({
    this.recId,
    this.username,
    this.website,
    this.phone,
    this.amount,
    this.source,
    this.status,
    this.serviceName,
    this.responseCode,
    this.payStatus,
    this.dateAdded,
    this.vendorId,
    this.apiId,
    this.uploadId,
  });

  static RechargeHistoryModel fromJson(json) => RechargeHistoryModel(
        recId: json['rec_id'] as int?,
        username: json['username'] as String?,
        website: json['website'] as String?,
        phone: json['phone'] as String?,
        amount: json['amount'] as String?,
        source: json['source'] as String?,
        status: json['status'] as String?,
        serviceName: json['service_name'] as String?,
        responseCode: json['responseCode'] as String?,
        payStatus: json['pay_status'] as String?,
        dateAdded: json['date_added'] as String?,
        vendorId: json['vendor_id'] as int?,
        apiId: json['api_id'] as int?,
        uploadId: json['upload_id'] as int?,
      );
}
