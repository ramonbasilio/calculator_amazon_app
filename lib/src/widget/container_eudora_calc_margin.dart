import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ContainerCalcEudoraMargin extends StatelessWidget {
  const ContainerCalcEudoraMargin({
    super.key,
    required this.readProvider2,
    required this.eudoraValueController,
    required this.watchProvider2,
    required this.percentController,
    required this.resultController,
  });

  final CalcEudora readProvider2;
  final TextEditingController eudoraValueController;
  final CalcEudora watchProvider2;
  final TextEditingController percentController;
  final TextEditingController resultController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 150,
            child: TextFormField(
              onChanged: (String value) {
                if (value.isEmpty) {
                  readProvider2.clearResult();
                  readProvider2.setMarginValue(0.0);
                }
    
                if (value.isNotEmpty) {
                  readProvider2.setEudoraValue(double.parse(
                      eudoraValueController.text
                          .replaceAll(',', '.')));
                  readProvider2.calcMargin(
                      eudoraValue: watchProvider2.eudoraValue,
                      margin: watchProvider2.marginValue);
                }
              },
              controller: eudoraValueController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      readProvider2.clearResult();
                      eudoraValueController.clear();
                      readProvider2.setEudoraValue(0.0);
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
                  readProvider2.clearResult();
                  readProvider2.setMarginValue(0.0);
                }
                if (value.isNotEmpty) {
                  readProvider2.setMarginValue(double.parse(
                      percentController.text
                          .replaceAll(',', '.')));
                  readProvider2.calcMargin(
                      eudoraValue: watchProvider2.eudoraValue,
                      margin: watchProvider2.marginValue);
                }
              },
              controller: percentController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      readProvider2.clearResult();
                      percentController.clear();
                      readProvider2.setMarginValue(0.0);
                    },
                    icon: const Icon(Icons.clear)),
                helperText: 'Margin %',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 80,
            child: TextFormField(
              readOnly: true,
              controller: resultController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      FlutterClipboard.copy(
                          watchProvider2.resultMargin.toString());
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
}
