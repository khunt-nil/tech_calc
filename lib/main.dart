// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(TechCalcApp());
}

class TechCalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechCalc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String expression = '';
  String result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        expression = '';
        result = '';
      } else if (value == '=') {
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (error) {
          result = 'Error';
        }
      } else if (value == '!') {
        try {
          int number = int.parse(expression);
          result = '${_Factorial(number)}';
        } catch (error) {
          result = 'Error';
        }
      } else if (value == 'log') {
        try {
          double number = double.parse(expression);
          result = '${log(number)}';
        } catch (error) {
          result = 'Error';
        }
      } else if (value == 'e') {
        expression +=
            '2.718281828459045'; // Approximate value of Euler's number
      } else {
        expression += value;
      }
    });
  }

  // ignore: non_constant_identifier_names
  int _Factorial(int n) {
    if (n <= 1) return 1;
    return n * _Factorial(n - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechCalc'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                expression,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                result,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        _buildButtonRow(['7', '8', '9', '/']),
        _buildButtonRow(['4', '5', '6', '*']),
        _buildButtonRow(['1', '2', '3', '-']),
        _buildButtonRow(['0', '.', '=', '+']),
        _buildButtonRow(['C', '(', ')', '^']),
        _buildButtonRow(['%', '!', 'log', 'e']), // Added log and e buttons
      ],
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((String buttonText) {
        return _buildButton(buttonText);
      }).toList(),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
