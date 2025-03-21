import 'package:calculators/config/constants.dart';
import 'package:calculators/ui/widgets/output_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/input_field_widget.dart';
import '../../data/models/mortgage_calculator_model.dart';
import '../../logic/mortgage_calculator/mortgage_calculator.dart';
import '../../logic/services/validation.dart';

class MortgageView extends StatefulWidget {
  /// UI for the [MortgageView]

  const MortgageView({super.key});

  @override
  State<MortgageView> createState() => _MortgageViewState();
}

class _MortgageViewState extends State<MortgageView> {
  // Input controllers
  final purchasePriceController = TextEditingController();
  final initialDepositController = TextEditingController();
  final interestRateController = TextEditingController();
  final loanTermController = TextEditingController();
  // Button state for animation
  bool isPressed = false;
  // Validate inputs
  final validate = Validation();
  // Number formatter for outputs
  final formatter = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: kAppBar,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: kPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 32,
                children: [
                  Text(
                    "Mortgage Calculator",
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                  // Purchase Price field
                  InputFieldWidget(
                    controller: purchasePriceController,
                    label: "Purchase Price",
                    icon: Icons.attach_money,
                  ),
                  // Initial Deposit field
                  InputFieldWidget(
                    controller: initialDepositController,
                    label: "Initial Deposit",
                    icon: Icons.attach_money,
                  ),
                  // Interest Rate field
                  InputFieldWidget(
                    controller: interestRateController,
                    label: "Interest Rate",
                    icon: Icons.percent,
                  ),
                  // Loan Term field
                  InputFieldWidget(
                    controller: loanTermController,
                    label: "Loan Term",
                    icon: Icons.schedule,
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
                          final purchasePrice = validate.validatePurchasePrice(
                              purchasePriceController.text.trim());
                          purchasePrice != null ? throw purchasePrice : null;
                          final initialDeposit =
                              validate.validateInitialDeposit(
                                  initialDepositController.text.trim());
                          initialDeposit != null ? throw initialDeposit : null;
                          final interestRate = validate.validateInterestRate(
                              interestRateController.text.trim());
                          interestRate != null ? throw interestRate : null;
                          final loanTerm = validate
                              .validateLoanTerm(loanTermController.text.trim());
                          loanTerm != null ? throw loanTerm : null;
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
                        // Create mortgage calculator object with valid inputs
                        final mc = MortgageCalculator(
                          purchasePrice:
                              double.parse(purchasePriceController.text.trim()),
                          initialDeposit: double.parse(
                              initialDepositController.text.trim()),
                          interestRate:
                              double.parse(interestRateController.text.trim()),
                          loanTerm:
                              double.parse(loanTermController.text.trim()),
                        );
                        // Create mortgage calculator logic object
                        final mCLogic = MortgageCalculatorLogic();
                        // Calculate mortgage values and display outputs
                        showDialog(
                          context: context,
                          builder: (context) {
                            // Calculate outputs
                            double stampDuty =
                                mCLogic.vicCalculateStampDuty(mc.purchasePrice);
                            double loanAmount = mCLogic.calculateFundsNeeded(
                                mc.initialDeposit, mc.purchasePrice, stampDuty);
                            double totalNumberWeeklyPayments = mCLogic
                                .calculateNumberWeeklyPayments(mc.loanTerm);
                            double weeklyPayment =
                                mCLogic.calculateWeeklyPayment(loanAmount,
                                    mc.interestRate, totalNumberWeeklyPayments);
                            double monthlyPayment = (weeklyPayment * 52) / 12;
                            double fortnightlyPayment = weeklyPayment * 2;
                            double annualPayment = weeklyPayment * 52;
                            double totalPayment = annualPayment * mc.loanTerm;
                            // Display outputs in dialog
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: kBorderRadius,
                                side: kBorderSide,
                              ),
                              title: const Text(
                                "Mortgage Calculation",
                                style: subHeadingStyle,
                              ),
                              content: Column(
                                spacing: 8,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Stamp Duty
                                  OutputValueWidget(
                                    label: "Stamp Duty:",
                                    value: "\$${formatter.format(stampDuty)}",
                                  ),
                                  // Loan Amount
                                  OutputValueWidget(
                                    label: "Loan Amount:",
                                    value: "\$${formatter.format(loanAmount)}",
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Repayments",
                                          style: outputValueStyle),
                                    ],
                                  ),
                                  // Annual repayment
                                  OutputValueWidget(
                                    label: "Annual:",
                                    value:
                                        "\$${formatter.format(annualPayment)}",
                                  ),
                                  // Monthly repayment
                                  OutputValueWidget(
                                    label: "Monthly:",
                                    value:
                                        "\$${formatter.format(monthlyPayment)}",
                                  ),
                                  // Fortnightly repayment
                                  OutputValueWidget(
                                    label: "Fortnightly:",
                                    value:
                                        "\$${formatter.format(fortnightlyPayment)}",
                                  ),
                                  // Weekly repayment
                                  OutputValueWidget(
                                    label: "Weekly:",
                                    value:
                                        "\$${formatter.format(weeklyPayment)}",
                                  ),
                                  // Total repayment
                                  OutputValueWidget(
                                    label: "Total:",
                                    value:
                                        "\$${formatter.format(totalPayment)}",
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
            ),
          ),
        ),
      ),
    );
  }
}
