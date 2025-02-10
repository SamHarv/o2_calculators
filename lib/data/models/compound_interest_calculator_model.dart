import '../../logic/compound_interest_calculator/investment_frequency_enum.dart';

class CompoundInterestCalculator {
  /// [CompoundInterestCalculator] model class

  /// [initialInvestment]: The initial investment amount
  final double initialInvestment;

  /// [recurringInvestment]: Recurring investment amount
  final double recurringInvestment;

  /// [investmentFrequency]: Frequency of recurring investment
  final InvestmentFrequency investmentFrequency;

  /// [durationYears]: Duration of investment in years
  final int durationYears;

  /// [annualInterestRate]: Annual interest rate
  final double annualInterestRate;

  CompoundInterestCalculator({
    required this.initialInvestment,
    required this.recurringInvestment,
    required this.investmentFrequency,
    required this.durationYears,
    required this.annualInterestRate,
  });
}
