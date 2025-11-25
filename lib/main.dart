import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData.dark(),
      home: CalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        _calculateResult();
      } else {
        _input += value;
      }
    });
  }

  void _calculateResult() {
    try {
      String finalInput = _input.replaceAll('×', '*').replaceAll('÷', '/');

      final result = _evaluateExpression(finalInput);
      _result = result.toString();
    } catch (e) {
      _result = 'Error';
    }
  }

  double _evaluateExpression(String expression) {
    final operators = ['+', '-', '*', '/'];
    for (var op in operators) {
      if (expression.contains(op)) {
        final parts = expression.split(op);
        final num1 = double.parse(parts[0]);
        final num2 = double.parse(parts[1]);
        switch (op) {
          case '+':
            return num1 + num2;
          case '-':
            return num1 - num2;
          case '*':
            return num1 * num2;
          case '/':
            return num1 / num2;
        }
      }
    }
    return double.parse(expression);
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(24),
            backgroundColor: color ?? Colors.grey[800],
          ),
          child: Text(text, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text('Simple Calculator'),
  centerTitle: true,
  actions: [
    IconButton(
      icon: Icon(Icons.history),
      onPressed: () {
        // _showHistory();
      },
    ),
  ],
),

      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _input,
                    style: TextStyle(fontSize: 32, color: Colors.white70),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('÷', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('×', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton('C', color: Colors.red),
              _buildButton('0'),
              _buildButton('=', color: Colors.green),
              _buildButton('+', color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
