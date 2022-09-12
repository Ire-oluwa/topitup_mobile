class TransactionResponseModel {
  String? serverMessage;
  bool? status;
  int? errorCode;
  String? textStatus;
  TransactionResponseData? data;

  TransactionResponseModel({
    this.serverMessage,
    this.status,
    this.errorCode,
    this.textStatus,
    this.data,
  });

  static TransactionResponseModel fromJson(json) => TransactionResponseModel(
        serverMessage: json['server_message'] as String?,
        status: json['status'] as bool?,
        errorCode: json['error_code'] as int?,
        textStatus: json['text_status'] as String?,
        data: json['data'] as TransactionResponseData?,
      );
}

class TransactionResponseData {
  bool? status;
  String? serverMessage;
  int? rechargeId;
  String? amountCharged;
  String? afterBalance;
  String? bonusEarned;
  String? textStatus;

  TransactionResponseData({
    this.status,
    this.serverMessage,
    this.rechargeId,
    this.amountCharged,
    this.afterBalance,
    this.bonusEarned,
    this.textStatus,
  });

  static TransactionResponseData fromJson(json) => TransactionResponseData(
        status: json['status'] as bool?,
        serverMessage: json['server_message'] as String?,
        rechargeId: json['recharge_id'] as int?,
        amountCharged: json['amount_charged'] as String?,
        afterBalance: json['after_balance'] as String?,
        bonusEarned: json['bonus_earned'] as String?,
        textStatus: json['text_status'] as String?,
      );
}
