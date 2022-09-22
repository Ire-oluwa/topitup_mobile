class WalletHistoryModel {
  int? walletId;
  String? purpose;
  String? amount;
  String? date;
  String? process;

  WalletHistoryModel({
    this.walletId,
    this.purpose,
    this.amount,
    this.date,
    this.process,
  });

  static WalletHistoryModel fromJson(json) => WalletHistoryModel(
        walletId: json['wallet_id'] as int?,
        purpose: json['purpose'] as String?,
        amount: json['amount'] as String?,
        date: json['date'] as String?,
        process: json['process'] as String?,
      );
}
