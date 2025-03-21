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
      return ((purchasePrice - 5000) / 100.ceil()) * 1.5;
    } else if (purchasePrice > 75000 && purchasePrice <= 540000) {
      return 1050 + ((purchasePrice - 75000) / 100.ceil()) * 3.5;
    } else if (purchasePrice > 540000 && purchasePrice <= 1000000) {
      return 17325 + ((purchasePrice - 540000) / 100.ceil()) * 4.5;
    } else {
      return 38025 + ((purchasePrice - 1000000) / 100.ceil()) * 5.75;
    }
  }

  // WA Stamp Duty
  double waCalculateStampDuty(double purchasePrice) {
    if (purchasePrice <= 120000) {
      return (purchasePrice / 100).ceil() * 1.9;
    } else if (purchasePrice > 120000 && purchasePrice <= 150000) {
      return 2280 + ((purchasePrice - 120000) / 100).ceil() * 2.85;
    } else if (purchasePrice > 150000 && purchasePrice <= 360000) {
      return 3135 + ((purchasePrice - 150000) / 100).ceil() * 3.8;
    } else if (purchasePrice > 360000 && purchasePrice <= 725000) {
      return 11115 + ((purchasePrice - 360000) / 100).ceil() * 4.75;
    } else {
      return 28453 + ((purchasePrice - 725000) / 100).ceil() * 5.15;
    }
  }

  // SA Stamp Duty
  double saCalculateStampDuty(double purchasePrice) {
    if (purchasePrice <= 12000) {
      return ((purchasePrice / 100).ceil()) * 1;
    } else if (purchasePrice > 12000 && purchasePrice <= 30000) {
      return 120 + ((purchasePrice - 12000) / 100).ceil() * 2;
    } else if (purchasePrice > 30000 && purchasePrice <= 50000) {
      return 480 + ((purchasePrice - 30000) / 100).ceil() * 3;
    } else if (purchasePrice > 50000 && purchasePrice <= 100000) {
      return 1080 + ((purchasePrice - 50000) / 100).ceil() * 3.5;
    } else if (purchasePrice > 100000 && purchasePrice <= 200000) {
      return 2830 + ((purchasePrice - 100000) / 100).ceil() * 4;
    } else if (purchasePrice > 200000 && purchasePrice <= 250000) {
      return 6830 + ((purchasePrice - 200000) / 100).ceil() * 4.25;
    } else if (purchasePrice > 250000 && purchasePrice <= 300000) {
      return 8955 + ((purchasePrice - 250000) / 100).ceil() * 4.75;
    } else if (purchasePrice > 300000 && purchasePrice <= 500000) {
      return 11330 + ((purchasePrice - 300000) / 100).ceil() * 5;
    } else {
      return 21330 + ((purchasePrice - 500000) / 100).ceil() * 5.5;
    }
  }

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
