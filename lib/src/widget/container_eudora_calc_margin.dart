import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:calculator_amazon_app/src/provider/providerDBA1.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ContainerCalcEudoraMargin extends StatelessWidget {
  const ContainerCalcEudoraMargin({
    super.key,
    required this.readProvider,
    required this.eudoraValueController,
    required this.watchProvider,
    required this.percentController,
    required this.resultController,
  });

  final CalculusProviderDBA1 readProvider;
  final TextEditingController eudoraValueController;
  final CalculusProviderDBA1 watchProvider;
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
            width: 120,
            child: TextFormField(
              onChanged: (String value) {
                if (value.isEmpty) {
                  readProvider.clearResultFunc();
                  readProvider.setMarginValueFunc(0.0);
                }

                if (value.isNotEmpty) {
                  readProvider.setEudoraValueFunc(double.parse(
                      eudoraValueController.text.replaceAll(',', '.')));
                  readProvider.calcMarginFunc(
                      eudoraValue: watchProvider.eudoraValueDBA1,
                      margin: watchProvider.marginValueDBA1);
                }
              },
              controller: eudoraValueController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      readProvider.clearResultFunc();
                      eudoraValueController.clear();
                      readProvider.setEudoraValueFunc(0.0);
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
                  readProvider.clearResultFunc();
                  readProvider.setMarginValueFunc(0.0);
                }
                if (value.isNotEmpty) {
                  readProvider.setMarginValueFunc(double.parse(
                      percentController.text.replaceAll(',', '.')));
                  readProvider.calcMarginFunc(
                      eudoraValue: watchProvider.eudoraValueDBA1,
                      margin: watchProvider.marginValueDBA1);
                }
              },
              controller: percentController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      readProvider.clearResultFunc();
                      percentController.clear();
                      readProvider.setMarginValueFunc(0.0);
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
              controller: resultController,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      FlutterClipboard.copy(
                          watchProvider.resultMarginDBA1.toString());
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
