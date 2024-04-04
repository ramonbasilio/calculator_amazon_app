import 'package:calculator_amazon_app/src/constants/colors.dart';
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
              style: const TextStyle(color: Colors.white, fontSize: 25),
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
                filled: true,
                fillColor: ColorsConst.FUNDOCINZAFORMULARIO,
                suffixIcon: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        widget.resultController.text = '';
                        widget.eudoraValueController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear)),
                helperText: 'Valor Eudora R\$',
                helperStyle: TextStyle(color: ColorsConst.FONTECINZACLARO),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 25),
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
                filled: true,
                fillColor: ColorsConst.FUNDOCINZAFORMULARIO,
                suffixIcon: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        widget.resultController.text = '';
                        widget.percentController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear)),
                helperText: 'Marge %',
                helperStyle: TextStyle(color: ColorsConst.FONTECINZACLARO),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 25),
              readOnly: true,
              controller: widget.resultController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorsConst.FUNDOCINZAFORMULARIO,
                suffixIcon: IconButton(
                    color: Colors.white,
                    onPressed: () async {
                      if (widget.resultController.text.isNotEmpty) {
                        FlutterClipboard.copy(widget.resultController.text);
                      }
                    },
                    icon: const Icon(Icons.copy)),
                helperText: 'Resultado R\$',
                helperStyle: TextStyle(color: ColorsConst.FONTECINZACLARO),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
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
