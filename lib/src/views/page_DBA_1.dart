import 'package:calculator_amazon_app/src/utils/calculus.dart';
import 'package:flutter/material.dart';

class PageDBA1 extends StatefulWidget {
  const PageDBA1({super.key});

  @override
  State<PageDBA1> createState() => _PageDBA1State();
}

class _PageDBA1State extends State<PageDBA1> {
  double valueProduct = 0.0;
  double gainValue = 0.0;
  double incomeValue = 0.0;
  double taxTotal = 0.0;
  double taxPercent = 0.0;
  TextEditingController costValueController = TextEditingController();
  TextEditingController gainValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        valueProduct > 79
                            ? Text(
                                'Valor Anúncio R\$ $valueProduct \nUTILIZE A CALCULADORA - DBA MAIOR QUE R\$ 79,00',
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
                  SizedBox(
                    width: double.infinity,
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
                                  productValue: valueProduct, taxTotal: taxTotal);
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
                            valueProduct = 0.0;
                            incomeValue = 0.0;
                            taxTotal = 0.0;
                            gainValue = 0.0;
                          });
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
