import 'package:calculator_amazon_app/src/constants/colors.dart';
import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:calculator_amazon_app/src/views/page_DBA_1.dart';
import 'package:calculator_amazon_app/src/views/page_DBA_2.dart';
import 'package:calculator_amazon_app/src/views/page_FBA.dart';
import 'package:calculator_amazon_app/src/views/page_kangu.dart';
import 'package:calculator_amazon_app/src/views/page_DBA1_final.dart';
import 'package:calculator_amazon_app/src/widget/container_eudora_calc_margin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int indexCurrent = 0;
  final List<Widget> screens = [
    PageDBA1Final(),
    const PageDBA2(),
    const PageFBA(),
    const PageKangu()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/amazon_logo.png',
              width: 120,
            )),
        body: screens[indexCurrent],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          iconSize: 0,
          backgroundColor: ColorsConst.FUNDOCINZAFORMULARIO,
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
