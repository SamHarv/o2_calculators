class Validation {
  /// Class to validate user input

  String? validatePurchasePrice(String value) {
    if (value.isEmpty) {
      return 'Purchase Price is required';
    } else if (double.tryParse(value) == null) {
      return 'Purchase Price must be a number';
    }
    return null;
  }

  String? validateInitialDeposit(String value) {
    if (value.isEmpty) {
      return 'Initial Deposit is required';
    } else if (double.tryParse(value) == null) {
      return 'Initial Deposit must be a number';
    }
    return null;
  }

  String? validateInterestRate(String value) {
    if (value.isEmpty) {
      return 'Interest Rate is required';
    } else if (double.tryParse(value) == null) {
      return 'Interest Rate must be a number';
    }
    return null;
  }

  String? validateLoanTerm(String value) {
    if (value.isEmpty) {
      return 'Loan Term is required';
    } else if (double.tryParse(value) == null) {
      return 'Loan Term must be a number';
    }
    return null;
  }
}
