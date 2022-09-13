class TransactionResponseModel {
  bool? status;
  String? serverMessage;
  int? rechargeId;
  dynamic amountCharged;
  dynamic afterBalance;
  dynamic bonusEarned;
  dynamic textStatus;

  TransactionResponseModel({
    this.status,
    this.serverMessage,
    this.rechargeId,
    this.amountCharged,
    this.afterBalance,
    this.bonusEarned,
    this.textStatus,
  });

  static TransactionResponseModel fromJson(json) => TransactionResponseModel(
        status: json['status'] as bool?,
        serverMessage: json['server_message'] as String?,
        rechargeId: json['recharge_id'] as int?,
        amountCharged: json['amount_charged'] as dynamic,
        afterBalance: json['after_balance'] as dynamic,
        bonusEarned: json['bonus_earned'] as dynamic,
        textStatus: json['text_status'] as dynamic,
      );
}
