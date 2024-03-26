import 'package:flutter/material.dart';

class CalcEudora extends ChangeNotifier {
  double _resultMargin = 0.0;
  double get resultMargin => _resultMargin;

  double _eudoraValue = 0.0;
  double get eudoraValue => _eudoraValue;

  double _margin = 0.0;
  double get marginValue => _margin;

  void setEudoraValue(double value) {
    _eudoraValue = value;
    notifyListeners();
  }

  void setMarginValue(double value) {
    _margin = value;
    notifyListeners();
  }

  void clearResult() {
    _resultMargin = 0.0;
    notifyListeners();
  }

  void calcMargin({required double eudoraValue, required double margin}) {
    double result = eudoraValue * (100 - margin) / 100;
    _resultMargin = double.parse(result.toStringAsFixed(2));
    notifyListeners();
  }
}
