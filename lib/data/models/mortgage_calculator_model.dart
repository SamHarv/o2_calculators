class MortgageCalculator {
  /// [MortgageCalculator] model class

  /// [purchasePrice]: The price of the property
  final double purchasePrice;

  /// [initialDeposit]: The initial deposit paid by the buyer
  final double initialDeposit;

  /// [interestRate]: The interest rate of the mortgage
  final double interestRate;

  /// [loanTerm]: The term of the mortgage
  final double loanTerm;

  MortgageCalculator({
    required this.purchasePrice,
    required this.initialDeposit,
    required this.interestRate,
    required this.loanTerm,
  });
}
