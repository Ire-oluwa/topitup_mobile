class WalletBalanceModel {
  String? walletBalance;
  String? bonusBalance;

  WalletBalanceModel({
    this.walletBalance,
    this.bonusBalance,
  });

  static WalletBalanceModel fromJson(json) => WalletBalanceModel(
        walletBalance: json['wallet_balance'] as String?,
        bonusBalance: json['bonus_balance'] as String?,
      );
}
