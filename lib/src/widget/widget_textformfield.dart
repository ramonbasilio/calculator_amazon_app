import 'package:calculator_amazon_app/src/constants/colors.dart';
import 'package:calculator_amazon_app/src/provider/providerDBA1.dart';
import 'package:flutter/material.dart';

class WidgetTextFormField extends StatelessWidget {
  const WidgetTextFormField({
    super.key,
    required this.readProvider,
    required this.ValueController,
    required this.title,
    required this.moneySign,
    required this.suffixIcon,
  });

  final CalculusProviderDBA1 readProvider;
  final TextEditingController ValueController;
  final String title;
  final String moneySign;
  final Icon suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: ColorsConst.FONTECINZACLARO),
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white, fontSize: 25),
          onChanged: (value) {
            if (value.isNotEmpty) {
              readProvider.setCostFunc(
                  double.parse(ValueController.text.replaceAll(',', '.')));
            }
          },
          controller: ValueController,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorsConst.FUNDOCINZAFORMULARIO,
            prefix: Text(moneySign),
            prefixStyle: TextStyle(color: ColorsConst.FONTECINZACLARO),
            suffixIcon: IconButton(
                color: Colors.white,
                onPressed: () {
                  readProvider.zeroCostFunc();
                  ValueController.clear();
                },
                icon: suffixIcon),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
