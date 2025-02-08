import '../../logic/compound_interest_calculator/investment_frequency_enum.dart';

class CompoundInterestCalculator {
  final double initialInvestment; // Initial investment amount
  final double recurringInvestment; // Recurring investment amount
  final InvestmentFrequency
      investmentFrequency; // Frequency of recurring investment
  final int durationYears; // Duration of investment in years
  final double annualInterestRate; // Annual interest rate

  CompoundInterestCalculator({
    required this.initialInvestment,
    required this.recurringInvestment,
    required this.investmentFrequency,
    required this.durationYears,
    required this.annualInterestRate,
  });

  // Calculate the total amount invested
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
    }
  }

  // Calculate the total interest earned
  double calculateTotalInterestEarned(
      double totalInvestment, double totalValue) {
    return totalValue - totalInvestment;
  }

  // If investmentFrequency is annual, calculate total value of investment
  // including interest
  double annualFrequencyTotalValue(double initialInvestment,
      double recurringInvestment, int duration, double annualInterestRate) {
    double interestRate = annualInterestRate / 100;
    double total = initialInvestment;
    for (int i = 1; i < duration + 1; i++) {
      total = (total + (total * interestRate)) + recurringInvestment;
      print("Year $i: \$${total.toStringAsFixed(2)}");
    }
    return total;
  }

  // If investmentFrequency is monthly, calculate total value of investment
  // including interest
  double monthlyFrequencyTotalValue(double initialInvestment,
      double recurringInvestment, int duration, double annualInterestRate) {
    double interestRate = annualInterestRate / 100;
    double total = initialInvestment;
    for (int i = 1; i < duration + 1; i++) {
      total = total + (total * interestRate);
      for (int j = 1; j < 13; j++) {
        total = total + recurringInvestment;
      }
      print("Year $i: \$${total.toStringAsFixed(2)}");
    }
    return total;
  }

  // If investmentFrequency is fortnightly, calculate total value of investment
  // including interest
  double fortnightlyFrequencyTotalValue(double initialInvestment,
      double recurringInvestment, int duration, double annualInterestRate) {
    double interestRate = annualInterestRate / 100;
    double total = initialInvestment;
    for (int i = 1; i < duration + 1; i++) {
      total = total + (total * interestRate);
      for (int j = 1; j < 27; j++) {
        total = total + recurringInvestment;
      }
      print("Year $i: \$${total.toStringAsFixed(2)}");
    }
    return total;
  }

  // If investmentFrequency is weekly, calculate total value of investment
  // including interest
  double weeklyFrequencyTotalValue(double initialInvestment,
      double recurringInvestment, int duration, double annualInterestRate) {
    double interestRate = annualInterestRate / 100;
    double total = initialInvestment;
    for (int i = 1; i < duration + 1; i++) {
      total = total + (total * interestRate);
      for (int j = 1; j < 53; j++) {
        total = total + recurringInvestment;
      }
      print("Year $i: \$${total.toStringAsFixed(2)}");
    }
    return total;
  }

  // If investmentFrequency is daily, calculate total value of investment
  // including interest
  double dailyFrequencyTotalValue(double initialInvestment,
      double recurringInvestment, int duration, double annualInterestRate) {
    double interestRate = annualInterestRate / 100;
    double total = initialInvestment;
    for (int i = 1; i < duration + 1; i++) {
      total = total + (total * interestRate);
      for (int j = 1; j < 366; j++) {
        total = total + recurringInvestment;
      }
      print("Year $i: \$${total.toStringAsFixed(2)}");
    }
    return total;
  }
}
