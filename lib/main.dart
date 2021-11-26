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
  //Declaracion de Variables
  double _numberForm = 0;
  String? _startMeasure;
  String? _convertedMeasure;
  String _resultMessage = "";
  double _result = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> _measures = [
      "Metros",
      "Kilometros",
      "Gramos",
      "Kilogramos",
      "Pies",
      "Millas",
      "Onzas",
      "Libras"
    ];
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: "Conversor de Unidades",
      // ignore: prefer_const_constructors
      home: Scaffold(
        appBar: AppBar(
          title: Text("Convertidor de unidades"),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberForm = rv;
                      });
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Ingrese la cantidad a convertir")),
              DropdownButton(
                isExpanded: true,
                value: _startMeasure,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  /* Continuara... */
                  onStartedMeasureChanged(value.toString());
                },
              ),
              DropdownButton(
                isExpanded: true,
                value: _convertedMeasure,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  /* Continuara... */
                  onStartedMeasureChanged(value.toString());
                },
              ),
              ElevatedButton(onPressed: (){},child: Text("Convertir"),)
            ],
          ),
        ),
      ),
    );
  }

  void onConvertedMeasureChanged(String value) {
    setState(() {
      _convertedMeasure = value;
    });
  }

  void onStartedMeasureChanged(String value) {
    setState(() {
      _convertedMeasure = value;
    });
  }
}
