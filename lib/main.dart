import 'package:calculator_amazon_app/src/provider/providerCalcEudora.dart';
import 'package:calculator_amazon_app/src/provider/providerDBA1.dart';
import 'package:calculator_amazon_app/src/views/page_DBA_1.dart';
import 'package:calculator_amazon_app/src/views/page_home.dart';
import 'package:calculator_amazon_app/src/views/page_DBA1_final.dart';
import 'package:calculator_amazon_app/src/widget/container_calc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CalcEudora(),
    ),
    ChangeNotifierProvider(
      create: (context) => CalculusProviderDBA1(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade300,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: PageHome(),
    );
  }
}
