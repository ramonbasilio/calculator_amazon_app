import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:calculator_amazon_app/src/provider/providerDBA1.dart';
import 'package:calculator_amazon_app/src/utils/calculus.dart';
import 'package:calculator_amazon_app/src/utils/converter.dart';
import 'package:calculator_amazon_app/src/widget/container_calc.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin_setState.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageDBA1Final extends StatelessWidget {
  PageDBA1Final({super.key});
  TextEditingController costValueController = TextEditingController();
  TextEditingController gainValueController = TextEditingController();

  TextEditingController eudoraValueController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var readProvider = context.read<CalculusProviderDBA1>();
    var watchProvider = context.watch<CalculusProviderDBA1>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10),
            height: 700,
            width: double.infinity,
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'DBA Anúncio Menor R\$ 79,00',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                      'Dica: se o custo do produto for igual à R\$ 55,08 com um lucro de 10%, o valor do anuncio será de R\$ 78,98. Valores acima disso, o anúncio seŕa maior que R\$ 79,00.'),
                  ContainerCalcEudoraMarginSetState(
                    eudoraValueController: eudoraValueController,
                    percentController: percentController,
                    resultController: resultController,
                  ),
                  TextFormField(
                    onChanged: (_) {
                      readProvider.setCostFunc(double.parse(
                          costValueController.text.replaceAll(',', '.')));
                    },
                    controller: costValueController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(
                      prefix: const Text('R\$ '),
                      suffixIcon: IconButton(
                          onPressed: () {
                            readProvider.zeroCostFunc();
                            costValueController.clear();
                          },
                          icon: const Icon(Icons.clear)),
                      labelText: 'Valor do custo do produto',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    onChanged: (_) {
                      readProvider.setGainFunc(double.parse(
                          gainValueController.text.replaceAll(',', '.')));
                    },
                    controller: gainValueController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(
                      prefix: const Text('% '),
                      suffixIcon: IconButton(
                          onPressed: () {
                            readProvider.zeroGainFunc();
                            gainValueController.clear();
                          },
                          icon: const Icon(Icons.clear)),
                      labelText: 'Valor do lucro (ref. 10%)',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        readProvider.productValueDBA1 > 79
                            ? Text(
                                'Valor Anúncio R\$ ${ConverterClass.convertDouble(watchProvider.productValueDBA1)} \nUTILIZE A CALCULADORA - DBA MAIOR QUE R\$ 79,00',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 20))
                            : Text(
                                'Valor Anúncio R\$ ${ConverterClass.convertDouble(watchProvider.productValueDBA1)}',
                                style: const TextStyle(fontSize: 20),
                              ),
                        Text(
                            'Valor Receita R\$ ${ConverterClass.convertDouble(watchProvider.incomeValueDBA1)}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Valor Lucro R\$ ${ConverterClass.convertDouble(watchProvider.gainValueRealDBA1)}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Valor Taxas Totais R\$ ${ConverterClass.convertDouble(watchProvider.taxTotalValueDBA1)}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Percentual taxa ${ConverterClass.convertDouble(watchProvider.taxPercentValueDBA1)}%',
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              gainValueController.clear();
                              costValueController.clear();
                              readProvider.clearAllFunc();
                            },
                            child: const Text('Limpar')),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              if (gainValueController.text.isNotEmpty ||
                                  costValueController.text.isNotEmpty) {
                                readProvider.productValueDBA1Func(
                                  taxIn: 5.5,
                                  costIn: watchProvider.costValueDBA1,
                                  gainIn: watchProvider.gainValueDBA1,
                                );

                                readProvider.incomeValueDBA1Func(
                                  productValue: watchProvider.productValueDBA1,
                                  tax: 5.5,
                                );

                                readProvider.gainValueRealDBA1Func(
                                  productValue: watchProvider.productValueDBA1,
                                  gain: watchProvider.gainValueDBA1,
                                  cost: watchProvider.costValueDBA1,
                                );

                                readProvider.taxTotalDBA1Func(
                                  productValue: watchProvider.productValueDBA1,
                                  income: watchProvider.incomeValueDBA1,
                                );

                                readProvider.taxPercentDBA1Func(
                                    productValue: watchProvider.productValueDBA1,
                                    taxTotal: watchProvider.taxTotalValueDBA1);
                              }
                            },
                            child: const Text('Calcular')),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  _showModalBottomSheet(BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.amber.shade100,
        );
      },
    );
  }
}
