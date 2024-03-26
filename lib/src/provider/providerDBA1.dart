import 'package:flutter/material.dart';

class CalculusProviderDBA1 extends ChangeNotifier {
  double _gain = 0.00;
  double get gainValue => _gain;

  double _gainReal = 0.00;
  double get gainValueReal => _gainReal;

  double _cost = 0.00;
  double get costValue => _cost;

  double _productValue = 0.00;
  double get productValue => _productValue;

  double _income = 0.00;
  double get incomeValue => _income;

  double _taxTotal = 0.00;
  double get taxTotalValue => _taxTotal;

  double _taxPercent = 0.00;
  double get taxPercentValue => _taxPercent;

  void clearAll() {
    _cost = 0.00;
    _gain = 0.00;
    _productValue = 0.00;
    _gainReal = 0.00;
    _income = 0.00;
    _taxTotal = 0.00;
    _taxPercent = 0.00;
    notifyListeners();
  }

  void setCost(double costSet) {
    _cost = costSet;
    notifyListeners();
  }

  void setGain(double gainSet) {
    _gain = gainSet;
    notifyListeners();
  }

  void zeroCost() {
    _cost = 0.00;
    notifyListeners();
  }

  void zeroGain() {
    _gain = 0.00;
    notifyListeners();
  }

  void productValueDBA1({
    required double taxIn,
    required double costIn,
    required double gainIn,
  }) {
    double result = (taxIn + costIn) / (0.867 - (gainIn / 100));
    _productValue = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void incomeValueDBA1({
    required double productValue,
    required double tax,
  }) {
    double result = (0.87 * productValue) - tax;
    _income = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void gainValueRealDBA1({
    required double productValue,
    required double gain,
    required double cost,
  }) {
    double result = (productValue - 0.13 * productValue - 5.5 - cost);
    _gainReal = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void taxTotalDBA1({
    required double productValue,
    required double income,
  }) {
    double result = productValue - income;
    _taxTotal = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  taxPercentDBA1({
    required double productValue,
    required double taxTotal,
  }) {
    double result = (taxTotal / productValue) * 100;
    _taxPercent = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }
}
