import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:calculator_amazon_app/src/utils/calculus.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin_setState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageDBA2 extends StatefulWidget {
  const PageDBA2({super.key});

  @override
  State<PageDBA2> createState() => _PageDBA2State();
}

class _PageDBA2State extends State<PageDBA2> {
  double valueProduct = 0.0;
  double gainValue = 0.0;
  double tax = 20.45;
  double taxTotal = 0.0;
  double taxPercent = 0.0;
  TextEditingController costValueController = TextEditingController();
  TextEditingController gainValueController = TextEditingController();
  TextEditingController eudoraValueController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  int selectedRadio = 1;
  double incomeValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.82,
              width: double.maxFinite,
              child: SizedBox(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'DBA Anúncio Maior R\$ 79,00',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        'Dica: se o custo do produto for menor à R\$ 55,08 com um lucro de 10%, utilize a calcuador DBA < R\$ 79.'),
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
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          const Text('Taxa DBA'),
                          ListTile(
                            title: const Text('500g ~ 1kg R\$ 20,45'),
                            leading: Radio(
                                value: 1,
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  setState(() {
                                    selectedRadio = value!;
                                    tax = 20.45;
                                  });
                                }),
                          ),
                          ListTile(
                            title: const Text('1kg ~ 2kg R\$ 21,45'),
                            leading: Radio(
                                value: 2,
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  setState(() {
                                    selectedRadio = value!;
                                    tax = 21.45;
                                  });
                                }),
                          ),
                        ],
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
                          (valueProduct < 79 && valueProduct != 0)
                              ? Text(
                                  'Valor Anúncio R\$ $valueProduct \nUTILIZE A CALCULADORA - DBA MENOR QUE R\$ 79,00',
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 20))
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
                    ),
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
                                        tax,
                                        double.parse(gainValueController.text
                                            .trimRight()),
                                        double.parse(costValueController.text
                                            .trimRight()
                                            .replaceAll(RegExp(r','), '.')));
                                    gainValue = Calculus.gainValueReal(
                                        valueProduct,
                                        int.parse(gainValueController.text
                                            .trimRight()),
                                        double.parse(costValueController.text
                                            .trimRight()
                                            .replaceAll(RegExp(r','), '.')));
                                    incomeValue = Calculus.incomeValue(
                                      productValue: valueProduct,
                                      tax: tax,
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
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
