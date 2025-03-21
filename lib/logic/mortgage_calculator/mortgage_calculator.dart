import 'dart:math';

class MortgageCalculatorLogic {
  /// [MortgageCalculatorLogic] is a class that contains the calculationd for
  /// the mortgage calculator.

  // Calculate stamp duty based on the purchase price
  double vicCalculateStampDuty(double purchasePrice) {
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

  // NSW Stamp Duty
  double nswCalculateStampDuty(double purchasePrice) {
    if (purchasePrice <= 17000) {
      return (purchasePrice / 100) * 1.25;
    } else if (purchasePrice > 17000 && purchasePrice <= 36000) {
      return 212 + ((purchasePrice - 17000) / 100) * 1.5;
    } else if (purchasePrice > 36000 && purchasePrice <= 97000) {
      return 497 + ((purchasePrice - 36000) / 100) * 1.75;
    } else if (purchasePrice > 97000 && purchasePrice <= 364000) {
      return 1564 + ((purchasePrice - 97000) / 100) * 3.5;
    } else if (purchasePrice > 364000 && purchasePrice <= 1212000) {
      return 10909 + ((purchasePrice - 364000) / 100) * 4.5;
    } else if (purchasePrice > 1212000 && purchasePrice <= 3636000) {
      return 49069 + ((purchasePrice - 1212000) / 100) * 5.5;
    } else {
      return 182389 + ((purchasePrice - 3636000) / 100) * 7;
    }
  }

  // QLD Stamp Duty
  double qldCalculateStampDuty(double purchasePrice) {
    if (purchasePrice <= 5000) {
      return 0;
    } else if (purchasePrice > 5000 && purchasePrice <= 75000) {
      return ((purchasePrice - 5000).ceil()) / 100 * 1.5;
    } else if (purchasePrice > 75000 && purchasePrice <= 540000) {
      return 1050 + ((purchasePrice - 75000).ceil()) / 100 * 3.5;
    } else if (purchasePrice > 540000 && purchasePrice <= 1000000) {
      return 17325 + ((purchasePrice - 540000).ceil()) / 100 * 4.5;
    } else {
      return 38025 + ((purchasePrice - 1000000).ceil()) / 100 * 5.75;
    }
  }

  // WA Stamp Duty

  // SA Stamp Duty

  // TAS Stamp Duty

  // ACT Stamp Duty

  // NT Stamp Duty

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
