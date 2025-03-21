import 'package:test/test.dart';
import 'package:calculators/logic/mortgage_calculator/mortgage_calculator.dart';

void main() {
  group('Mortgage Calculator Logic', () {
    final mortgageCalculatorLogic = MortgageCalculatorLogic();
    test('VIC Stamp Duty Calculation', () {
      // Test the VIC stamp duty calculation
      // Test 1
      expect(mortgageCalculatorLogic.vicCalculateStampDuty(10000), 140.0);
      // Test 2
      expect(mortgageCalculatorLogic.vicCalculateStampDuty(30000), 470.0);
      // Test 3
      expect(mortgageCalculatorLogic.vicCalculateStampDuty(150000), 4070.0);
      // Test 4
      expect(mortgageCalculatorLogic.vicCalculateStampDuty(600000), 31070.0);
      // Test 5
      expect(mortgageCalculatorLogic.vicCalculateStampDuty(1000000), 55000.0);
      // Test 5
      expect(mortgageCalculatorLogic.vicCalculateStampDuty(3000000), 175000.0);
    });

    test('NSW Stamp Duty Calculation', () {
      // Test the NSW stamp duty calculation
      // Test 1
      expect(mortgageCalculatorLogic.nswCalculateStampDuty(10000), 125.0);
      // Test 2
      expect(mortgageCalculatorLogic.nswCalculateStampDuty(20000), 257.0);
      // Test 3
      expect(mortgageCalculatorLogic.nswCalculateStampDuty(40000), 567.0);
      // Test 4
      expect(mortgageCalculatorLogic.nswCalculateStampDuty(100000), 1669.0);
      // Test 5
      expect(mortgageCalculatorLogic.nswCalculateStampDuty(400000), 12529.0);
      // Test 6
      expect(mortgageCalculatorLogic.nswCalculateStampDuty(1500000), 64909.0);
      // Test 7
      expect(mortgageCalculatorLogic.nswCalculateStampDuty(3636000), 182389.0);
    });

    test('QLD Stamp Duty Calculation', () {
      // Test the QLD stamp duty calculation
      // Test 1
      expect(mortgageCalculatorLogic.qldCalculateStampDuty(5000), 0.0);
      // Test 2
      expect(mortgageCalculatorLogic.qldCalculateStampDuty(74000), 1035.0);
      // Test 3
      expect(mortgageCalculatorLogic.qldCalculateStampDuty(500000), 15925.0);
      // Test 4
      expect(mortgageCalculatorLogic.qldCalculateStampDuty(800000), 29025.0);
      // Test 5
      expect(mortgageCalculatorLogic.qldCalculateStampDuty(2000000), 95525.0);
    });
  });
}
