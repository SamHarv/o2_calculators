import 'dart:io';

import '../../data/models/compound_interest_calculator_model.dart';
import 'investment_frequency_enum.dart';

void compoundInterestCalculator() {
  double initialInvestment = 0; // Temp initial investment amount
  double recurringInvestment = 0; // Temp recurring investment amount
  InvestmentFrequency investmentFrequency =
      InvestmentFrequency.annually; // Temp investment frequency
  int durationYears = 0; // Temp investment duration in years
  double annualInterestRate = 0; // Temp annual interest rate

  print("\nWelcome to the Compound Interest Calculator!");

  // Input initial investment
  print("\nPlease enter the amount of your initial investment:");
  try {
    initialInvestment = double.parse(stdin.readLineSync()!);
  } catch (e) {
    print("An error occurred: $e");
    exit(0);
  }
  print(
      "\nYour initial investment is: \$${initialInvestment.toStringAsFixed(2)}");

  // Input whether there is a recurring investment
  print(
      "\nDo you intend to invest more at recurring intervals? Please enter a number:");
  print("1. Yes");
  print("2. No");
  int choice = 0;
  try {
    choice = int.parse(stdin.readLineSync()!);
  } catch (e) {
    print("An error occurred: $e");
    exit(0);
  }
  switch (choice) {
    case 1:
      // Input recurring investment amount
      print("\nPlease enter the amount of your recurring investment:");
      try {
        recurringInvestment = double.parse(stdin.readLineSync()!);
      } catch (e) {
        print("An error occurred: $e");
        exit(0);
      }
      print(
          "\nYour recurring investment is: \$${recurringInvestment.toStringAsFixed(2)}");

      // Input recurring investment frequency
      print(
          "\nPlease select the number corresponding to the frequency of your recurring investment:");
      print("1. Daily");
      print("2. Weekly");
      print("3. Fortnightly");
      print("4. Monthly");
      print("5. Annually");
      try {
        choice = int.parse(stdin.readLineSync()!);
      } catch (e) {
        print("An error occurred: $e");
        exit(0);
      }
      switch (choice) {
        case 1:
          investmentFrequency = InvestmentFrequency.daily;
          break;
        case 2:
          investmentFrequency = InvestmentFrequency.weekly;
          break;
        case 3:
          investmentFrequency = InvestmentFrequency.fortnightly;
          break;
        case 4:
          investmentFrequency = InvestmentFrequency.monthly;
          break;
        case 5:
          investmentFrequency = InvestmentFrequency.annually;
          break;
        default:
          print("Invalid choice. Please try again.");
      }
      print(
          "\nYour recurring investment frequency is ${investmentFrequency.name}");
      break;
    // No recurring investment
    case 2:
      print("\nYou have chosen not to make recurring investments.");
      break;
    default:
      print("Invalid choice. Please try again.");
  }

  // Input investment duration
  print("\nPlease enter the duration of your investment in years:");
  try {
    durationYears = int.parse(stdin.readLineSync()!);
  } catch (e) {
    print("An error occurred: $e");
    exit(0);
  }
  print("\nYour investment duration is: $durationYears years");

  // Input annual interest rate
  print("\nPlease enter the annual interest rate you expect to average (%):");
  try {
    annualInterestRate = double.parse(stdin.readLineSync()!);
  } catch (e) {
    print("An error occurred: $e");
    exit(0);
  }
  print("\nYour annual interest rate is: $annualInterestRate%");

  // Create CompoundInterestCalculator object for calculations
  CompoundInterestCalculator cic = CompoundInterestCalculator(
    initialInvestment: initialInvestment,
    recurringInvestment: recurringInvestment,
    investmentFrequency: investmentFrequency,
    durationYears: durationYears,
    annualInterestRate: annualInterestRate,
  );

  print("\nCalculating...");
  print("\n======================================================\n");

  // Calculate total investment amount
  double totalInvestment = cic.calculateTotalInvestment(initialInvestment,
      recurringInvestment, investmentFrequency, durationYears);

  // Calculate total value of investment including interest
  double totalValue = 0;
  switch (investmentFrequency) {
    case InvestmentFrequency.daily:
      totalValue = cic.dailyFrequencyTotalValue(initialInvestment,
          recurringInvestment, durationYears, annualInterestRate);
      break;
    case InvestmentFrequency.weekly:
      totalValue = cic.weeklyFrequencyTotalValue(initialInvestment,
          recurringInvestment, durationYears, annualInterestRate);
      break;
    case InvestmentFrequency.fortnightly:
      totalValue = cic.fortnightlyFrequencyTotalValue(initialInvestment,
          recurringInvestment, durationYears, annualInterestRate);
      break;
    case InvestmentFrequency.monthly:
      totalValue = cic.monthlyFrequencyTotalValue(initialInvestment,
          recurringInvestment, durationYears, annualInterestRate);
      break;
    case InvestmentFrequency.annually:
      totalValue = cic.annualFrequencyTotalValue(initialInvestment,
          recurringInvestment, durationYears, annualInterestRate);
      break;
  }

  // Calculate total interest earned
  double totalInterestEarned =
      cic.calculateTotalInterestEarned(totalInvestment, totalValue);

  // Output results
  print("\n======================================================");
  print(
      "You invested a total of \$${(totalInvestment).toStringAsFixed(2)} over $durationYears years.");
  print("The total amount saved is \$${(totalValue).toStringAsFixed(2)}");
  print(
      "You earned \$${(totalInterestEarned).toStringAsFixed(2)} on interest alone");
  print("======================================================\n");
}
