import 'package:calculator_amazon_app/src/constants/colors.dart';
import 'package:calculator_amazon_app/src/provider/providerDBA1.dart';
import 'package:calculator_amazon_app/src/utils/calculus.dart';
import 'package:calculator_amazon_app/src/utils/converter.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin_setState.dart';
import 'package:flutter/material.dart';

class Amazon extends StatefulWidget {
  const Amazon({super.key});

  @override
  State<Amazon> createState() => _AmazonState();
}

class _AmazonState extends State<Amazon> {
  TextEditingController costValueController = TextEditingController();
  TextEditingController gainValueController = TextEditingController();
  TextEditingController eudoraValueController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  double valueProduct = 0.0;
  double gainValue = 0.0;
  double incomeValue = 0.0;
  double taxTotal = 0.0;
  double taxPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAgina Amazon - Teste'),
      ),
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
                    'DBA Menor R\$ 79',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  ContainerCalcEudoraMarginSetState(
                    eudoraValueController: eudoraValueController,
                    percentController: percentController,
                    resultController: resultController,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    controller: costValueController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorsConst.FUNDOCINZAFORMULARIO,
                      prefix: const Text('R\$ '),
                      prefixStyle:
                          TextStyle(color: ColorsConst.FONTECINZACLARO),
                      suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              costValueController.clear();
                            });
                          },
                          icon: const Icon(Icons.clear)),
                      labelText: 'Valor do custo do produto',
                      labelStyle: TextStyle(color: ColorsConst.FONTECINZACLARO),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    controller: gainValueController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorsConst.FUNDOCINZAFORMULARIO,
                      prefix: const Text('% '),
                      prefixStyle:
                          TextStyle(color: ColorsConst.FONTECINZACLARO),
                      suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              gainValueController.clear();
                            });
                          },
                          icon: const Icon(Icons.clear)),
                      labelText: 'Valor do lucro (ref. 10%)',
                      labelStyle: TextStyle(color: ColorsConst.FONTECINZACLARO),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  // --------------------- RESULTADOS ---------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gainValueController.clear();
                                costValueController.clear();
                                valueProduct = 0.0;
                                incomeValue = 0.0;
                                taxTotal = 0.0;
                                gainValue = 0.0;
                              });
                            },
                            child: const Text('Limpar')),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              if (gainValueController.text.isNotEmpty ||
                                  costValueController.text.isNotEmpty) {
                                setState(() {
                                  valueProduct = Calculus.productValueDBA1(
                                      5.5,
                                      double.parse(gainValueController.text),
                                      double.parse(costValueController.text
                                          .replaceAll(RegExp(r','), '.')));
                                  gainValue = Calculus.gainValueReal(
                                      valueProduct,
                                      int.parse(gainValueController.text),
                                      double.parse(costValueController.text
                                          .replaceAll(RegExp(r','), '.')));
                                  incomeValue = Calculus.incomeValue(
                                    productValue: valueProduct,
                                    tax: 5.5,
                                  );
                                  taxTotal = Calculus.taxTotal(
                                      productValue: valueProduct,
                                      income: incomeValue);
                                  taxPercent = Calculus.taxPercent(
                                      productValue: valueProduct,
                                      taxTotal: taxTotal);
                                });
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
}

class Result extends StatefulWidget {
  const Result({
    super.key,
    required this.readProvider,
    required this.watchProvider,
  });

  final CalculusProviderDBA1 readProvider;
  final CalculusProviderDBA1 watchProvider;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  double valueProduct = 0.0;
  double gainValue = 0.0;
  double incomeValue = 0.0;
  double taxTotal = 0.0;
  double taxPercent = 0.0;
  @override
  void initState() {
    valueProduct = Calculus.productValueDBA1(
        5.5,
        double.parse(gainValueController.text),
        double.parse(costValueController.text.replaceAll(RegExp(r','), '.')));
    gainValue = Calculus.gainValueReal(
        valueProduct,
        int.parse(gainValueController.text),
        double.parse(costValueController.text.replaceAll(RegExp(r','), '.')));
    incomeValue = Calculus.incomeValue(
      productValue: valueProduct,
      tax: 5.5,
    );
    taxTotal =
        Calculus.taxTotal(productValue: valueProduct, income: incomeValue);
    taxPercent =
        Calculus.taxPercent(productValue: valueProduct, taxTotal: taxTotal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          valueProduct > 79
              ? Text(
                  'Valor Anúncio R\$ $valueProduct \nUTILIZE A CALCULADORA - DBA MAIOR QUE R\$ 79,00',
                  style: const TextStyle(color: Colors.red, fontSize: 20))
              : Text(
                  'Valor Anúncio R\$ $valueProduct',
                  style: const TextStyle(fontSize: 20),
                ),
          Text('Valor Receita R\$ $incomeValue',
              style: const TextStyle(fontSize: 20)),
          Text('Valor Lucro R\$ $gainValue',
              style: const TextStyle(fontSize: 20)),
          Text('Valor Taxas Totais R\$ $taxTotal',
              style: const TextStyle(fontSize: 20)),
          Text('Percentual taxa $taxPercent%',
              style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
