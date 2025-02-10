import 'dart:math';

class MortgageCalculatorLogic {
  /// [MortgageCalculatorLogic] is a class that contains the calculationd for
  /// the mortgage calculator.

  // Calculate stamp duty based on the purchase price
  double calculateStampDuty(double purchasePrice) {
    if (purchasePrice <= 25000) {
      return purchasePrice * 0.014;
    } else if (purchasePrice > 25000 && purchasePrice <= 130000) {
      return 350 + ((purchasePrice - 25000) * 0.024);
    } else if (purchasePrice > 130000 && purchasePrice <= 960000) {
      return 2870 + ((purchasePrice - 130000) * 0.06);
    } else if (purchasePrice > 960000 && purchasePrice <= 2000000) {
      return purchasePrice * 0.055;
    } else {
      return 110000 + ((purchasePrice - 2000000) * 0.065);
    }
  }

  // Calculate money needed to borrow to purchase the house
  double calculateFundsNeeded(
      double startingBalance, double purchasePrice, double stampDuty) {
    return purchasePrice + stampDuty - startingBalance;
  }

  // Calculate the number of weekly payments based on the loan term
  double calculateNumberWeeklyPayments(double loanTerm) {
    return loanTerm * 52;
  }

  // THE formula
  // Calculate the weekly mortgage repayment amount with interest
  double calculateWeeklyPayment(
      double fundsNeeded, double interestRate, totalNumberWeeklyPayments) {
    double processedInterestRate = interestRate / 100 / 52;
    return fundsNeeded *
        ((processedInterestRate *
                pow((1 + processedInterestRate), totalNumberWeeklyPayments)) /
            (pow((1 + processedInterestRate), totalNumberWeeklyPayments) - 1));
  }
}
