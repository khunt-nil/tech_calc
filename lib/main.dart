import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(TechCalcApp());
}

class TechCalcApp extends StatelessWidget {
  const TechCalcApp({super.key});

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
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String expression = '';
  String result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        expression = '';
        result = '';
      } else if (value == '=') {
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else if (value == '⌫') {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else {
        expression += value;
      }
    });
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
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                result,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
        _buildButtonRow(['AC', '⌫', '%', '/']),
        _buildButtonRow(['7', '8', '9', '*']),
        _buildButtonRow(['4', '5', '6', '-']),
        _buildButtonRow(['1', '2', '3', '+']),
        _buildButtonRow(['00', '0', '.', '=']),
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
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24,color: Colors.black),
          ),
        ),
      ),
    );
  }
}
