import 'package:calculators/config/constants.dart';
import 'package:calculators/logic/mortgage_calculator/state_enum.dart';
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
  // Default State or Territory
  StateTerritory selectedState = StateTerritory.vic; // Default value

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
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
                  // State or Territory dropdown
                  DropdownMenu(
                    label: Text("State / Territory"),
                    width: mediaWidth - 64,
                    menuStyle: MenuStyle(
                      // Make menu same width as input fields
                      maximumSize: WidgetStateProperty.all(
                          Size.fromWidth(mediaWidth - 64)),
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
                    hintText: "State / Territory",
                    onSelected: (stateTerritory) {
                      setState(() {
                        selectedState = stateTerritory as StateTerritory;
                      });
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(
                        value: StateTerritory.vic,
                        label: "Victoria",
                      ),
                      DropdownMenuEntry(
                        value: StateTerritory.nsw,
                        label: "New South Wales",
                      ),
                      DropdownMenuEntry(
                        value: StateTerritory.qld,
                        label: "Queensland",
                      ),
                      DropdownMenuEntry(
                        value: StateTerritory.sa,
                        label: "South Australia",
                      ),
                      DropdownMenuEntry(
                        value: StateTerritory.wa,
                        label: "Western Australia",
                      ),
                      DropdownMenuEntry(
                        value: StateTerritory.nt,
                        label: "Northern Territory",
                      ),
                      DropdownMenuEntry(
                        value: StateTerritory.act,
                        label: "Australian Capital Territory",
                      ),
                      DropdownMenuEntry(
                        value: StateTerritory.tas,
                        label: "Tasmania",
                      ),
                    ],
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
                            // Stamp Duty
                            double stampDuty = 0;
                            switch (selectedState) {
                              case StateTerritory.vic:
                                stampDuty = mCLogic
                                    .vicCalculateStampDuty(mc.purchasePrice);
                                break;
                              case StateTerritory.nsw:
                                stampDuty = mCLogic
                                    .nswCalculateStampDuty(mc.purchasePrice);
                                break;
                              case StateTerritory.qld:
                                stampDuty = mCLogic
                                    .qldCalculateStampDuty(mc.purchasePrice);
                                break;
                              case StateTerritory.sa:
                                stampDuty = mCLogic
                                    .saCalculateStampDuty(mc.purchasePrice);
                                break;
                              case StateTerritory.wa:
                                stampDuty = mCLogic
                                    .waCalculateStampDuty(mc.purchasePrice);
                                break;
                              case StateTerritory.nt:
                                stampDuty = mCLogic
                                    .ntCalculateStampDuty(mc.purchasePrice);
                                break;
                              case StateTerritory.act:
                                stampDuty = mCLogic
                                    .actCalculateStampDuty(mc.purchasePrice);
                                break;
                              case StateTerritory.tas:
                                stampDuty = mCLogic
                                    .tasCalculateStampDuty(mc.purchasePrice);
                                break;
                            }

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
