import 'package:flutter/material.dart';

class CalculusProviderDBA1 extends ChangeNotifier {
  double _gain = 0.00;
  double get gainValueDBA1 => _gain;

  double _gainReal = 0.00;
  double get gainValueRealDBA1 => _gainReal;

  double _cost = 0.00;
  double get costValueDBA1 => _cost;

  double _productValue = 0.00;
  double get productValueDBA1 => _productValue;

  double _income = 0.00;
  double get incomeValueDBA1 => _income;

  double _taxTotal = 0.00;
  double get taxTotalValueDBA1 => _taxTotal;

  double _taxPercent = 0.00;
  double get taxPercentValueDBA1 => _taxPercent;

  double _resultMargin = 0.0;
  double get resultMarginDBA1 => _resultMargin;

  double _eudoraValue = 0.0;
  double get eudoraValueDBA1 => _eudoraValue;

  double _margin = 0.0;
  double get marginValueDBA1 => _margin;

  void setEudoraValueFunc(double value) {
    _eudoraValue = value;
    notifyListeners();
  }

  void setMarginValueFunc(double value) {
    _margin = value;
    notifyListeners();
  }

  void clearResultFunc() {
    _resultMargin = 0.0;
    notifyListeners();
  }

  void clearAllFunc() {
    _cost = 0.00;
    _gain = 0.00;
    _productValue = 0.00;
    _gainReal = 0.00;
    _income = 0.00;
    _taxTotal = 0.00;
    _taxPercent = 0.00;
    notifyListeners();
  }

  void setCostFunc(double costSet) {
    _cost = costSet;
    notifyListeners();
  }

  void setGainFunc(double gainSet) {
    _gain = gainSet;
    notifyListeners();
  }

  void zeroCostFunc() {
    _cost = 0.00;
    notifyListeners();
  }

  void zeroGainFunc() {
    _gain = 0.00;
    notifyListeners();
  }

  void productValueDBA1Func({
    required double taxIn,
    required double costIn,
    required double gainIn,
  }) {
    double result = (taxIn + costIn) / (0.867 - (gainIn / 100));
    _productValue = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void incomeValueDBA1Func({
    required double productValue,
    required double tax,
  }) {
    double result = (0.87 * productValue) - tax;
    _income = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void gainValueRealDBA1Func({
    required double productValue,
    required double gain,
    required double cost,
  }) {
    double result = (productValue - 0.13 * productValue - 5.5 - cost);
    _gainReal = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void taxTotalDBA1Func({
    required double productValue,
    required double income,
  }) {
    double result = productValue - income;
    _taxTotal = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void taxPercentDBA1Func({
    required double productValue,
    required double taxTotal,
  }) {
    double result = (taxTotal / productValue) * 100;
    _taxPercent = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }

  void calcMarginFunc({required double eudoraValue, required double margin}) {
    double result = eudoraValue * (100 - margin) / 100;
    _resultMargin = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }
}
