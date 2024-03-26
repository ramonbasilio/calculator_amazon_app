import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:calculator_amazon_app/src/provider/providerDBA1.dart';
import 'package:calculator_amazon_app/src/utils/calculus.dart';
import 'package:calculator_amazon_app/src/utils/converter.dart';
import 'package:calculator_amazon_app/src/widget/container_calc.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin.dart';
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
    var readProvider2 = context.read<CalcEudora>();
    var watchProvider2 = context.watch<CalcEudora>();
    resultController.text = watchProvider2.resultMargin.toString();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10),
            height: 750,
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
                  ContainerCalcEudoraMargin(
                    readProvider2: readProvider2,
                    eudoraValueController: eudoraValueController,
                    watchProvider2: watchProvider2,
                    percentController: percentController,
                    resultController: resultController,
                  ),
                  TextFormField(
                    onChanged: (_) {
                      readProvider.setCost(double.parse(
                          costValueController.text.replaceAll(',', '.')));
                    },
                    controller: costValueController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(
                      prefix: const Text('R\$ '),
                      suffixIcon: IconButton(
                          onPressed: () {
                            readProvider.zeroCost();
                            costValueController.clear();
                          },
                          icon: const Icon(Icons.clear)),
                      labelText: 'Valor do custo do produto',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    onChanged: (_) {
                      readProvider.setGain(double.parse(
                          gainValueController.text.replaceAll(',', '.')));
                    },
                    controller: gainValueController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(
                      prefix: const Text('% '),
                      suffixIcon: IconButton(
                          onPressed: () {
                            readProvider.zeroGain();
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
                        readProvider.productValue > 79
                            ? Text(
                                'Valor Anúncio R\$ ${ConverterClass.convertDouble(watchProvider.productValue)} \nUTILIZE A CALCULADORA - DBA MAIOR QUE R\$ 79,00',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 20))
                            : Text(
                                'Valor Anúncio R\$ ${ConverterClass.convertDouble(watchProvider.productValue)}',
                                style: const TextStyle(fontSize: 20),
                              ),
                        Text(
                            'Valor Receita R\$ ${ConverterClass.convertDouble(watchProvider.incomeValue)}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Valor Lucro R\$ ${ConverterClass.convertDouble(watchProvider.gainValueReal)}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Valor Taxas Totais R\$ ${ConverterClass.convertDouble(watchProvider.taxTotalValue)}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Percentual taxa ${ConverterClass.convertDouble(watchProvider.taxPercentValue)}%',
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (gainValueController.text.isNotEmpty ||
                              costValueController.text.isNotEmpty) {
                            readProvider.productValueDBA1(
                              taxIn: 5.5,
                              costIn: watchProvider.costValue,
                              gainIn: watchProvider.gainValue,
                            );

                            readProvider.incomeValueDBA1(
                              productValue: watchProvider.productValue,
                              tax: 5.5,
                            );

                            readProvider.gainValueRealDBA1(
                              productValue: watchProvider.productValue,
                              gain: watchProvider.gainValue,
                              cost: watchProvider.costValue,
                            );

                            readProvider.taxTotalDBA1(
                              productValue: watchProvider.productValue,
                              income: watchProvider.incomeValue,
                            );

                            readProvider.taxPercentDBA1(
                                productValue: watchProvider.productValue,
                                taxTotal: watchProvider.taxTotalValue);
                          }
                        },
                        child: const Text('Calcular')),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          gainValueController.clear();
                          costValueController.clear();
                          readProvider.clearAll();
                        },
                        child: const Text('Limpar')),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
