import 'package:calculators/ui/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/mortgage_calculator_model.dart';
import '../../logic/mortgage_calculator/mortgage_calculator.dart';
import '../../logic/services/validation.dart';

class MortgageView extends StatefulWidget {
  const MortgageView({super.key});

  @override
  State<MortgageView> createState() => _MortgageViewState();
}

class _MortgageViewState extends State<MortgageView> {
  final purchasePriceController = TextEditingController();
  final initialDepositController = TextEditingController();
  final interestRateController = TextEditingController();
  final loanTermController = TextEditingController();
  bool isPressed = false;
  final validate = Validation();

  final formatter = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            Text(
              "Mortgage Calculator",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            InputFieldWidget(
              controller: purchasePriceController,
              label: "Purchase Price",
              icon: Icons.attach_money,
            ),
            InputFieldWidget(
              controller: initialDepositController,
              label: "Initial Deposit",
              icon: Icons.attach_money,
            ),
            InputFieldWidget(
              controller: interestRateController,
              label: "Interest Rate",
              icon: Icons.percent,
            ),
            InputFieldWidget(
              controller: loanTermController,
              label: "Loan Term",
              icon: Icons.schedule,
            ),
            Tooltip(
              message: "Calculate",
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () {
                  setState(() {
                    isPressed = true;
                  });
                  Future.delayed(const Duration(milliseconds: 150))
                      .then((value) {
                    setState(() {
                      isPressed = false;
                    });
                  });
                  try {
                    final purchasePrice = validate.validatePurchasePrice(
                        purchasePriceController.text.trim());
                    purchasePrice != null ? throw purchasePrice : null;
                    final initialDeposit = validate.validateInitialDeposit(
                        initialDepositController.text.trim());
                    initialDeposit != null ? throw initialDeposit : null;
                    final interestRate = validate.validateInterestRate(
                        interestRateController.text.trim());
                    interestRate != null ? throw interestRate : null;
                    final loanTerm = validate
                        .validateLoanTerm(loanTermController.text.trim());
                    loanTerm != null ? throw loanTerm : null;
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            title: Text(
                              e.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        });
                    return;
                  }
                  final mc = MortgageCalculator(
                    purchasePrice:
                        double.parse(purchasePriceController.text.trim()),
                    initialDeposit:
                        double.parse(initialDepositController.text.trim()),
                    interestRate:
                        double.parse(interestRateController.text.trim()),
                    loanTerm: double.parse(loanTermController.text.trim()),
                  );
                  final mCLogic = MortgageCalculatorLogic();
                  showDialog(
                    context: context,
                    builder: (context) {
                      double stampDuty =
                          mCLogic.calculateStampDuty(mc.purchasePrice);
                      double loanAmount = mCLogic.calculateFundsNeeded(
                          mc.initialDeposit, mc.purchasePrice, stampDuty);
                      double totalNumberWeeklyPayments =
                          mCLogic.calculateNumberWeeklyPayments(mc.loanTerm);
                      double weeklyPayment = mCLogic.calculateWeeklyPayment(
                          loanAmount,
                          mc.interestRate,
                          totalNumberWeeklyPayments);
                      double monthlyPayment = (weeklyPayment * 52) / 12;
                      double fortnightlyPayment = weeklyPayment * 2;
                      double annualPayment = weeklyPayment * 52;
                      double totalPayment = annualPayment * mc.loanTerm;
                      formatter.format(stampDuty);
                      formatter.format(loanAmount);
                      formatter.format(annualPayment);
                      formatter.format(monthlyPayment);
                      formatter.format(fortnightlyPayment);
                      formatter.format(weeklyPayment);
                      formatter.format(totalPayment);
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        title: const Text(
                          "Mortgage Calculation",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        content: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Stamp Duty:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${formatter.format(stampDuty)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Loan Amount:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${formatter.format(loanAmount)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Repayments",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Annual:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${formatter.format(annualPayment)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Monthly:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${formatter.format(monthlyPayment)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fortnightly:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${formatter.format(fortnightlyPayment)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Weekly:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${formatter.format(weeklyPayment)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${formatter.format(totalPayment)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                              style: TextStyle(color: Colors.black),
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
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      isPressed
                          ? BoxShadow()
                          : BoxShadow(
                              color: Colors.black,
                              blurRadius: 8,
                              offset: Offset(4, 4),
                              blurStyle: BlurStyle.solid,
                            ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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
