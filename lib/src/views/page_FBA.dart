import 'package:calculator_amazon_app/src/utils/calculus.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin_setState.dart';
import 'package:flutter/material.dart';

class PageFBA extends StatefulWidget {
  const PageFBA({super.key});

  @override
  State<PageFBA> createState() => _PageFBAState();
}

class _PageFBAState extends State<PageFBA> {
  double valueProduct = 0.0;
  double gainValue = 0.0;
  double tax = 0.0;
  double taxTotal = 0.0;
  double taxPercent = 0.0;
  TextEditingController costValueController = TextEditingController();
  TextEditingController gainValueController = TextEditingController();
    TextEditingController eudoraValueController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  int selectedRadio = 1;
  double incomeValue = 0.0;

  static const Map<String, double> taxFBAMap = {
    '0g    ~  100g  -> R\$ 14,05': 14.05,
    '100g  ~  200g  -> R\$ 14,55': 14.55,
    '200g  ~  300g  -> R\$ 15,05': 15.05,
    '400g  ~  500g  -> R\$ 16,25': 16.25,
    '500g  ~  750g  -> R\$ 16,85': 16.85,
    '750g  ~  1,0kg -> R\$ 17,85': 17.45,
    '1,5kg ~  1,5kg -> R\$ 18,85': 18.45,
  };
  double? taxFBA = 14.05;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(10),
              height: 720,
              width: double.maxFinite,
              child: SizedBox(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'FBA',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ContainerCalcEudoraMarginSetState(
                      eudoraValueController: eudoraValueController,
                      percentController: percentController,
                      resultController: resultController,
                    ),
                    TextFormField(
                      controller: costValueController,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      decoration: InputDecoration(
                        prefix: const Text('R\$ '),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                costValueController.clear();
                              });
                            },
                            icon: const Icon(Icons.clear)),
                        labelText: 'Valor do custo do produto',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      controller: gainValueController,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      decoration: InputDecoration(
                        prefix: const Text('% '),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                gainValueController.clear();
                              });
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
                      child: DropdownButton(
                        items: taxFBAMap
                            .map((key, value) {
                              return MapEntry(
                                  key,
                                  DropdownMenuItem(
                                      value: value, child: Text(key)));
                            })
                            .values
                            .toList(),
                        value: taxFBA,
                        onChanged: (double? value) {
                          if (value != null) {
                            setState(() {
                              taxFBA = value;
                            });
                          }
                        },
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
                          Text(
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
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (gainValueController.text.isNotEmpty ||
                                costValueController.text.isNotEmpty) {
                              setState(() {
                                valueProduct = Calculus.productValueDBA1(
                                    taxFBA!,
                                    double.parse(
                                        gainValueController.text.trimRight()),
                                    double.parse(costValueController.text
                                        .trimRight()
                                        .replaceAll(RegExp(r','), '.')));
                                gainValue = Calculus.gainValueReal(
                                    valueProduct,
                                    int.parse(
                                        gainValueController.text.trimRight()),
                                    double.parse(costValueController.text
                                        .trimRight()
                                        .replaceAll(RegExp(r','), '.')));
                                incomeValue = Calculus.incomeValue(
                                  productValue: valueProduct,
                                  tax: taxFBA!,
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              gainValueController.clear();
                              costValueController.clear();
                              incomeValue = 0.0;
                              valueProduct = 0.0;
                              gainValue = 0.0;
                            });
                          },
                          child: const Text('Limpar')),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
