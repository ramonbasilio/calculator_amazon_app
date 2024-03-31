import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:calculator_amazon_app/src/provider/providerDBA1.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ContainerCalcEudoraMarginSetState extends StatefulWidget {
  const ContainerCalcEudoraMarginSetState({
    super.key,
    required this.eudoraValueController,
    required this.percentController,
    required this.resultController,
  });

  final TextEditingController eudoraValueController;
  final TextEditingController percentController;
  final TextEditingController resultController;

  @override
  State<ContainerCalcEudoraMarginSetState> createState() =>
      _ContainerCalcEudoraMarginState();
}

class _ContainerCalcEudoraMarginState
    extends State<ContainerCalcEudoraMarginSetState> {
  double valueResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 120,
            child: TextFormField(
              onChanged: (String value) {
                if (value.isEmpty) {
                  setState(() {
                    widget.resultController.text = '';
                  });
                }
                if (widget.eudoraValueController.text.isNotEmpty &&
                    widget.percentController.text.isNotEmpty) {
                  setState(() {
                    valueResult = calcMarginFunc(
                      eudoraValue:
                          double.parse(value.toString().replaceAll(',', '.')),
                      margin: double.parse(widget.percentController.text
                          .toString()
                          .replaceAll(',', '.')),
                    );
                    widget.resultController.text = valueResult.toString();
                    print(valueResult);
                  });
                }
              },
              controller: widget.eudoraValueController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.resultController.text = '';
                        widget.eudoraValueController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear)),
                helperText: 'Valor Eudora R\$',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 80,
            child: TextFormField(
              onChanged: (String value) {
                if (value.isEmpty) {
                  setState(() {
                    widget.resultController.text = '';
                  });
                }
                if (widget.eudoraValueController.text.isNotEmpty &&
                    widget.percentController.text.isNotEmpty) {
                  setState(() {
                    valueResult = calcMarginFunc(
                      eudoraValue: double.parse(widget
                          .eudoraValueController.text
                          .toString()
                          .replaceAll(',', '.')),
                      margin:
                          double.parse(value.toString().replaceAll(',', '.')),
                    );
                    widget.resultController.text = valueResult.toString();
                    print(valueResult);
                  });
                }
              },
              controller: widget.percentController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.resultController.text = '';
                        widget.percentController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear)),
                helperText: 'Margin %',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 120,
            height: 80,
            child: TextFormField(
              readOnly: true,
              controller: widget.resultController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      if (widget.resultController.text.isNotEmpty) {
                        FlutterClipboard.copy(widget.resultController.text);
                      }
                    },
                    icon: const Icon(Icons.copy)),
                helperText: 'Resultado R\$',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calcMarginFunc({required double eudoraValue, required double margin}) {
    double result = eudoraValue * (100 - margin) / 100;
    return double.parse(result.toStringAsFixed(2));
  }
}
