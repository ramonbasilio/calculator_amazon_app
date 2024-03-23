import 'package:calculator_amazon_app/src/views/page_DBA_1.dart';
import 'package:calculator_amazon_app/src/views/page_DBA_2.dart';
import 'package:calculator_amazon_app/src/views/page_FBA.dart';
import 'package:calculator_amazon_app/src/views/page_kangu.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int indexCurrent = 0;
  final List<Widget> screens = [
    const PageDBA1(),
    const PageDBA2(),
    const PageFBA(),
    const PageKangu()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: const Text('Calculadora Amazon')),
        body: screens[indexCurrent],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          iconSize: 0,
          backgroundColor: Colors.blue[700],
          type: BottomNavigationBarType.fixed,
          currentIndex: indexCurrent,
          onTap: (int value) {
            setState(() {
              indexCurrent = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                label: 'DBA < R\$ 79',
                icon: Icon(
                  Icons.abc,
                )),
            BottomNavigationBarItem(
                label: 'DBA > R\$ 79',
                icon: Icon(
                  Icons.abc,
                )),
            BottomNavigationBarItem(
                label: 'FBA',
                icon: Icon(
                  Icons.abc,
                )),
            BottomNavigationBarItem(
                label: 'Envio\nPróprio',
                icon: Icon(
                  Icons.abc,
                )),
          ],
        ));
  }
}
