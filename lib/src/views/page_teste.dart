import 'package:calculator_amazon_app/src/views/page_home.dart';
import 'package:flutter/material.dart';

class PageTeste extends StatelessWidget {
  const PageTeste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => PageHome()),);
            },
            child: Container(
              
              width: double.maxFinite,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Image.asset(
                'assets/amazon_logo.png',
                height: 100,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all()),
            child: Image.asset(
              'assets/ml_logo.jpeg',
              height: 100,
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all()),
            child: Image.asset(
              'assets/shopee_logo.png',
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
