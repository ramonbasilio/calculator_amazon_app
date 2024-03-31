import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';

class ContainerCalc extends StatelessWidget {
  BuildContext contextContainer;
  ContainerCalc({required this.contextContainer, super.key});

  TextEditingController eudoraValueController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  @override
  Widget build(BuildContext contextContainer) {
    var readProvider = contextContainer.read<CalcEudora>();
    var watchProvider = contextContainer.watch<CalcEudora>();

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
                  readProvider.clearResult();
                  readProvider.setMarginValue(0.0);
                }

                if (value.isNotEmpty) {
                  readProvider.setEudoraValue(double.parse(
                      eudoraValueController.text.replaceAll(',', '.')));
                  readProvider.calcMargin(
                      eudoraValue: watchProvider.eudoraValue,
                      margin: watchProvider.marginValue);
                }
              },
              controller: eudoraValueController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      readProvider.clearResult();
                      eudoraValueController.clear();
                      readProvider.setEudoraValue(0.0);
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
                  readProvider.clearResult();
                  readProvider.setMarginValue(0.0);
                }
                if (value.isNotEmpty) {
                  readProvider.setMarginValue(double.parse(
                      percentController.text.replaceAll(',', '.')));
                  readProvider.calcMargin(
                      eudoraValue: watchProvider.eudoraValue,
                      margin: watchProvider.marginValue);
                }
              },
              controller: percentController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      readProvider.clearResult();
                      percentController.clear();
                      readProvider.setMarginValue(0.0);
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
                          watchProvider.resultMargin.toString());
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
