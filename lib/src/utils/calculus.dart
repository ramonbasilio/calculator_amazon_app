class Calculus {
  static double productValueDBA1(double tax, double gain, double cost) {
    double result = (tax + cost) / (0.867 - (gain / 100));
    return double.parse(result.toStringAsFixed(2));
  }

  static double gainValueReal(double productValue, int gain, double cost) {
    double result = (productValue - 0.13 * productValue - 5.5 - cost);
    return double.parse(result.toStringAsFixed(2));
  }

  static double incomeValue({
    required double productValue,
    required double tax,
  }) {
    double result =  (0.87 * productValue) - tax;
     return double.parse(result.toStringAsFixed(2));
  }
}
