class FintechState {
  final double accountBalance;
  final List<String> transactionHistory;

 const FintechState({
    this.accountBalance = 0.0,
    this.transactionHistory = const <String>[],
  });

  FintechState copyWith(
    {
        double? accountBalance,
  List<String>? transactionHistory
    }
  ) {
    return FintechState(
accountBalance: accountBalance??this.accountBalance,
transactionHistory: transactionHistory??this.transactionHistory
    );
  }
}
