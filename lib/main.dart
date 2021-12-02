import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Convertidor de Unidades",
    home: MyCalculator(),
  ));
}

class MyCalculator extends StatefulWidget {
  @override
  MyCalculatorState createState() => MyCalculatorState();
}

class MyCalculatorState extends State<MyCalculator> {
  double _numberForm = 0;
  String? _startMeasure;
  String? _convertedMeasure;
  double _result = 0;
  String _resultMessage = "";
  @override
  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;

    double sizeY = MediaQuery.of(context).size.height;

    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );
    final spacer = Padding(padding: EdgeInsets.only(bottom: sizeY / 40));
    final List<String> _measures = [
      "Metros",
      "Kilometros",
      "Gramos",
      "Kilogramos",
      "Pies",
      "Millas",
      "Onzas",
      "Libras",
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Convertidor de Unidades"),
      ),
      body: Container(
          width: sizeX,
          padding: EdgeInsets.all(sizeX / 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Valor",
                  style: labelStyle,
                ),
                spacer,
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Porfavor ingrese la cantidad a convertir",
                  ),
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberForm = rv;
                      });
                    }
                  },
                ),
                spacer,
                Text("Unidad actual", style: labelStyle),
                spacer,
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
                    onStartMeasureChanged(value.toString());
                  },
                ),
                Text(
                  "Unidad a Convertir",
                  style: labelStyle,
                ),
                spacer,
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
                    onConvertedMeasureChanged(value.toString());
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      convert();
                    },
                    child: Text("Convertir")),
                spacer,
                Text(
                  _resultMessage,
                  style: labelStyle,
                )
              ],
            ),
          )),
    );
  }

  void onConvertedMeasureChanged(String value) {
    setState(() {
      _convertedMeasure = value;
    });
  }

  void onStartMeasureChanged(String value) {
    setState(() {
      _startMeasure = value;
    });
  }

  void convert() {
    if (_startMeasure == null ||
        _convertedMeasure == null ||
        _numberForm == 0) {
      return;
    }

    final int w = 8;
    var formulas;
    Map<String, int> mesuares = {
      "Metros": 0,
      "Kilometros": 1,
      "Gramos": 2,
      "Kilogramos": 3,
      "Pies": 4,
      "Millas": 5,
      "Onzas": 6,
      "Libras": 7,
    };
    formulas = {
      "0": [1, 0.001, 0, 0, 3.28, 0.000621, 0, 0],
      "1": [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
      "2": [0, 0, 1, 0.001, 0, 0, 0.002204, 0.035274],
      '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
      '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
      '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
      '6': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
      '7': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    };

    try {
      int? nFrom = mesuares[_startMeasure];
      int? nTo = mesuares[_convertedMeasure];
      double multiplier = formulas[nFrom.toString()][nTo];
      _result = _numberForm * multiplier;
      setState(() {
        if (_result == 0) {
          _resultMessage = "No se puede realizar la conversion";
        } else {
          _resultMessage =
              "${_numberForm} ${_startMeasure} son ${_result} ${_convertedMeasure}";
        }
      });
    } catch (e) {
      _resultMessage = e.toString();
    }
  }
}
