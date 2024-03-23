import 'package:calculator_amazon_app/src/utils/calculus.dart';
import 'package:flutter/material.dart';

class PageDBA2 extends StatefulWidget {
  const PageDBA2({super.key});

  @override
  State<PageDBA2> createState() => _PageDBA2State();
}

class _PageDBA2State extends State<PageDBA2> {
  double valueProduct = 0.0;
  double gainValue = 0.0;
  double tax = 0.0;
  TextEditingController costValueController = TextEditingController();
  TextEditingController gainValueController = TextEditingController();
  int selectedRadio = 1;
  double incomeValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(10),
              height: 720,
              width: double.maxFinite,
              color: Colors.grey.shade300,
              child: SizedBox(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'DBA Anúncio Maior R\$ 79,00',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        'Dica: se o custo do produto for menor à R\$ 55,08 com um lucro de 10%, utilize a calcuador DBA < R\$ 79.'),
                    TextFormField(
                      controller: costValueController,
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                          Text('Valor lucro R\$ $gainValue',
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
                                    tax,
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
                                  tax: 5.5,
                                );
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