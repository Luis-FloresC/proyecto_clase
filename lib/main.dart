// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyCalculator());
}

class MyCalculator extends StatefulWidget {
  @override
  MyCalculatorState createState() => MyCalculatorState();
}

class MyCalculatorState extends State<MyCalculator> {
  double _numberForm = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: "Conversor de Unidades",
      // ignore: prefer_const_constructors
      home: Scaffold(
        appBar: AppBar(
          title: Text("Convertidor de unidades"),
        ),
        body: Center(
          child: TextField(
              onChanged: (text) {
                var rv = double.tryParse(text);
                if (rv != null) {
                  setState(() {
                    _numberForm = rv;
                  });
                }
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Ingrese la cantidad a convertir")),
        ),
      ),
    );
  }
}
