import 'investment_frequency_enum.dart';

class CompoundInterestCalculatorLogic {
  /// [CompoundInterestCalculatorLogic] is a class that contains the
  /// calculations for the compound interest calculator.

  /// Calculate the total amount invested
  double calculateTotalInvestment(
      double initialInvestment,
      double recurringInvestment,
      InvestmentFrequency investmentFrequency,
      int durationYears) {
    int duration = 0;
    switch (investmentFrequency) {
      case InvestmentFrequency.daily:
        duration = durationYears * 365;
        return initialInvestment + (recurringInvestment * duration);
      case InvestmentFrequency.weekly:
        duration = durationYears * 52;
        return initialInvestment + (recurringInvestment * duration);
      case InvestmentFrequency.fortnightly:
        duration = durationYears * 26;
        return initialInvestment + (recurringInvestment * duration);
      case InvestmentFrequency.monthly:
        duration = durationYears * 12;
        return initialInvestment + (recurringInvestment * duration);
      case InvestmentFrequency.annually:
        duration = durationYears;
        return initialInvestment + (recurringInvestment * duration);
      case InvestmentFrequency.none:
        return initialInvestment;
    }
  }

  /// Calculate the total value of the investment
  /// Returns a list of yearly values and the total value
  (List<String>, double) calculateTotalValue(
    double initialInvestment,
    double recurringInvestment,
    int duration,
    double annualInterestRate,
    InvestmentFrequency investmentFrequency,
  ) {
    final interestRate = annualInterestRate / 100;
    double total = initialInvestment;
    int occurrences = 2;
    List<String> yearlyValues = [];
    switch (investmentFrequency) {
      case InvestmentFrequency.annually:
        occurrences = 2;
        break;
      case InvestmentFrequency.monthly:
        occurrences = 13;
        break;
      case InvestmentFrequency.fortnightly:
        occurrences = 27;
        break;
      case InvestmentFrequency.weekly:
        occurrences = 53;
        break;
      case InvestmentFrequency.daily:
        occurrences = 366;
        break;
      case InvestmentFrequency.none:
        occurrences = 1;
        break;
    }
    for (int i = 1; i < duration + 1; i++) {
      total = total + (total * interestRate);
      for (int j = 1; j < occurrences; j++) {
        total = total + recurringInvestment;
      }
      yearlyValues.add("\$${total.toStringAsFixed(2)}");
    }
    return (yearlyValues, total);
  }

  /// Calculate the total interest earned
  double calculateTotalInterestEarned(
      double totalInvestment, double totalValue) {
    return totalValue - totalInvestment;
  }
}
