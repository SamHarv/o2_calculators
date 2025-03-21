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

    test('WA Stamp Duty Calculation', () {
      // Test the WA stamp duty calculation
      // Test 1
      expect(mortgageCalculatorLogic.waCalculateStampDuty(10000), 190.0);
      // Test 2
      expect(mortgageCalculatorLogic.waCalculateStampDuty(120000), 2280.0);
      // Test 3
      expect(mortgageCalculatorLogic.waCalculateStampDuty(121000), 2308.5);
      // Test 4
      expect(mortgageCalculatorLogic.waCalculateStampDuty(150000), 3135.0);
      // Test 5
      expect(mortgageCalculatorLogic.waCalculateStampDuty(151000), 3173.0);
      // Test 6
      expect(mortgageCalculatorLogic.waCalculateStampDuty(360000), 11115.0);
      // Test 7
      expect(mortgageCalculatorLogic.waCalculateStampDuty(361000), 11162.5);
      // Test 8
      expect(mortgageCalculatorLogic.waCalculateStampDuty(725000), 28452.5);
      // Test 9
      expect(mortgageCalculatorLogic.waCalculateStampDuty(726000), 28504.5);
    });

    test('SA Stamp Duty Calculation', () {
      // Test the SA stamp duty calculation
      // Test 1
      expect(mortgageCalculatorLogic.saCalculateStampDuty(12000), 120.0);
      // Test 2
      expect(mortgageCalculatorLogic.saCalculateStampDuty(12001), 122.0);
      // Test 3
      expect(mortgageCalculatorLogic.saCalculateStampDuty(30000), 480.0);
      // Test 4
      expect(mortgageCalculatorLogic.saCalculateStampDuty(30001), 483.0);
      // Test 5
      expect(mortgageCalculatorLogic.saCalculateStampDuty(50000), 1080.0);
      // Test 6
      expect(mortgageCalculatorLogic.saCalculateStampDuty(50001), 1083.5);
      // Test 7
      expect(mortgageCalculatorLogic.saCalculateStampDuty(100000), 2830.0);
      // Test 8
      expect(mortgageCalculatorLogic.saCalculateStampDuty(100001), 2834.0);
      // Test 9
      expect(mortgageCalculatorLogic.saCalculateStampDuty(200000), 6830.0);
      // Test 10
      expect(mortgageCalculatorLogic.saCalculateStampDuty(200001), 6834.25);
      // Test 11
      expect(mortgageCalculatorLogic.saCalculateStampDuty(250000), 8955.0);
      // Test 12
      expect(mortgageCalculatorLogic.saCalculateStampDuty(250001), 8959.75);
      // Test 13
      expect(mortgageCalculatorLogic.saCalculateStampDuty(300000), 11330.0);
      // Test 14
      expect(mortgageCalculatorLogic.saCalculateStampDuty(300001), 11335.0);
      // Test 15
      expect(mortgageCalculatorLogic.saCalculateStampDuty(500000), 21330.0);
      // Test 16
      expect(mortgageCalculatorLogic.saCalculateStampDuty(500001), 21335.5);
    });
  });
}
