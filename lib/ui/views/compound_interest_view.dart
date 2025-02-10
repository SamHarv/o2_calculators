import 'package:calculators/config/constants.dart';
import 'package:calculators/data/models/compound_interest_calculator_model.dart';
import 'package:calculators/logic/compound_interest_calculator/investment_frequency_enum.dart';
import 'package:calculators/ui/widgets/output_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../logic/compound_interest_calculator/compound_interest_calculator.dart';
import '../widgets/input_field_widget.dart';
import '../../logic/services/validation.dart';

class CompoundInterestView extends StatefulWidget {
  /// UI for the [CompoundInterestView]

  const CompoundInterestView({super.key});

  @override
  State<CompoundInterestView> createState() => _CompoundInterestViewState();
}

class _CompoundInterestViewState extends State<CompoundInterestView> {
  // Input controllers
  final initialInvestmentController = TextEditingController();
  final recurringInvestmentController = TextEditingController();
  final durationYearsController = TextEditingController();
  final annualInterestRateController = TextEditingController();
  // Investment frequency
  InvestmentFrequency investmentFrequency = InvestmentFrequency.none;
  // Button state for animation
  bool isPressed = false;
  // Validate inputs
  final validate = Validation();
  // Number formatter for outputs
  final formatter = NumberFormat('#,##0.00');
  // Recurring investment enabled
  bool recurringInvestmentEnabled = false;

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: kAppBar,
      body: SafeArea(
          child: Padding(
        padding: kPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            Text(
              "Compound Interest Calculator",
              textAlign: TextAlign.center,
              style: headingStyle,
            ),
            // Initial Investment field
            InputFieldWidget(
              controller: initialInvestmentController,
              label: "Initial Investment",
              icon: Icons.attach_money,
            ),
            // Frequency of recurring investment dropdown
            DropdownMenu(
              label: Text("Recurring Frequency"),
              width: double.infinity,
              menuStyle: MenuStyle(
                // Make menu same width as input fields
                maximumSize:
                    WidgetStateProperty.all(Size.fromWidth(mediaWidth - 64)),
                backgroundColor: WidgetStateProperty.all(white),
                elevation: WidgetStateProperty.all(8),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: kBorderRadius,
                    side: kBorderSide,
                  ),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
                filled: true,
                fillColor: white,
                labelStyle: inputFieldStyle,
              ),
              textStyle: inputFieldStyle,
              enableFilter: false,
              hintText: "Recurring Frequency",
              onSelected: (frequency) {
                // Enable/ disable recurring investment field based on frequency
                frequency == InvestmentFrequency.none
                    ? setState(() {
                        recurringInvestmentEnabled = false;
                        recurringInvestmentController.clear();
                      })
                    : setState(() {
                        recurringInvestmentEnabled = true;
                      });
                setState(() {
                  investmentFrequency = frequency!;
                });
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: InvestmentFrequency.none,
                  label: "None",
                ),
                DropdownMenuEntry(
                  value: InvestmentFrequency.daily,
                  label: "Daily",
                ),
                DropdownMenuEntry(
                  value: InvestmentFrequency.weekly,
                  label: "Weekly",
                ),
                DropdownMenuEntry(
                  value: InvestmentFrequency.fortnightly,
                  label: "Fortnightly",
                ),
                DropdownMenuEntry(
                  value: InvestmentFrequency.monthly,
                  label: "Monthly",
                ),
                DropdownMenuEntry(
                  value: InvestmentFrequency.annually,
                  label: "Annually",
                ),
              ],
            ),
            // Recurring Investment value field
            TextField(
              style: TextStyle(
                color: recurringInvestmentEnabled ? black : Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              enabled: recurringInvestmentEnabled,
              keyboardType: TextInputType.number, // Numeric inputs
              controller: recurringInvestmentController,
              decoration: InputDecoration(
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade900,
                    width: 3,
                  ),
                  borderRadius: kBorderRadius,
                ),
                prefixIcon: Icon(Icons.attach_money),
                filled: true,
                fillColor: white,
                labelText: "Recurring Investment",
                labelStyle: TextStyle(
                  color: recurringInvestmentEnabled ? black : Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Duration of Investment field
            InputFieldWidget(
              controller: durationYearsController,
              label: "Duration (Years)",
              icon: Icons.schedule,
            ),
            // Expected Interest Rate field
            InputFieldWidget(
              controller: annualInterestRateController,
              label: "Interest Rate",
              icon: Icons.percent,
            ),
            // Calculate button
            Tooltip(
              message: "Calculate",
              child: InkWell(
                borderRadius: kBorderRadius,
                onTap: () {
                  // Handle button press animation
                  setState(() {
                    isPressed = true;
                  });
                  Future.delayed(const Duration(milliseconds: 150))
                      .then((value) {
                    setState(() {
                      isPressed = false;
                    });
                  });
                  // Validate inputs
                  try {
                    final initialInvestment =
                        validate.validateInitialInvestment(
                            initialInvestmentController.text.trim());
                    initialInvestment != null ? throw initialInvestment : null;
                    if (recurringInvestmentEnabled) {
                      final recurringInvestment =
                          validate.validateRecurringInvestment(
                              recurringInvestmentController.text.trim());
                      recurringInvestment != null
                          ? throw recurringInvestment
                          : null;
                    }
                    final durationYears = validate.validateDurationYears(
                        durationYearsController.text.trim());
                    durationYears != null ? throw durationYears : null;
                    final annualInterestRate =
                        validate.validateAnnualInterestRate(
                            annualInterestRateController.text.trim());
                    annualInterestRate != null
                        ? throw annualInterestRate
                        : null;
                  } catch (e) {
                    // Display error dialog
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: kBorderRadius,
                              side: kBorderSide,
                            ),
                            title: Text(
                              e.toString(),
                              style: subHeadingStyle,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: black),
                                ),
                              ),
                            ],
                          );
                        });
                    return;
                  }
                  // Create compound interest calculator object with valid inputs
                  final cic = CompoundInterestCalculator(
                    initialInvestment:
                        double.parse(initialInvestmentController.text.trim()),
                    recurringInvestment: recurringInvestmentEnabled
                        ? double.parse(
                            recurringInvestmentController.text.trim())
                        : 0,
                    investmentFrequency: investmentFrequency,
                    durationYears:
                        int.parse(durationYearsController.text.trim()),
                    annualInterestRate:
                        double.parse(annualInterestRateController.text.trim()),
                  );
                  // Create compound interest calculator logic object
                  final cicLogic = CompoundInterestCalculatorLogic();
                  // Calculate compound interest values and display outputs
                  showDialog(
                    context: context,
                    builder: (context) {
                      // Calculate outputs
                      // Total amount invested
                      double totalInvestment =
                          cicLogic.calculateTotalInvestment(
                              cic.initialInvestment,
                              cic.recurringInvestment,
                              cic.investmentFrequency,
                              cic.durationYears);
                      // Value of investment for each year and total value
                      List<String> yearlyValues = [];
                      double totalValue = 0;
                      (yearlyValues, totalValue) = cicLogic.calculateTotalValue(
                        cic.initialInvestment,
                        cic.recurringInvestment,
                        cic.durationYears,
                        cic.annualInterestRate,
                        cic.investmentFrequency,
                      );
                      // Total interest earned
                      double totalInterest =
                          cicLogic.calculateTotalInterestEarned(
                        totalValue,
                        totalInvestment,
                      );
                      // Display outputs in dialog
                      return AlertDialog(
                        scrollable: true, // Allow scrolling for long outputs
                        shape: RoundedRectangleBorder(
                          borderRadius: kBorderRadius,
                          side: kBorderSide,
                        ),
                        title: const Text(
                          "Compound Interest Calculation",
                          style: subHeadingStyle,
                        ),
                        content: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Total amount invested
                            OutputValueWidget(
                              label: "Total Invested:",
                              value: "\$${formatter.format(totalInvestment)}",
                            ),
                            // Value of investment for each year
                            for (int i = 0; i < yearlyValues.length; i++)
                              OutputValueWidget(
                                label: "Year ${i + 1}:",
                                value: yearlyValues[i],
                              ),
                            // Total value of investment at end
                            OutputValueWidget(
                              label: "Total Value:",
                              value: "\$${formatter.format(totalValue)}",
                            ),
                            // Total interest earned
                            OutputValueWidget(
                              label: "Interest Earned:",
                              value: "\$${formatter.format(totalInterest)}",
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(color: black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                // Button
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: black, width: 3),
                    borderRadius: kBorderRadius,
                    boxShadow: [isPressed ? BoxShadow() : kShadow],
                  ),
                  child: Padding(
                    padding: kPadding,
                    child: Text(
                      "Calculate",
                      style: subHeadingStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
