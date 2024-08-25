import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';



void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '';
  String result = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        displayText = '';
        result = '';
      } else if (buttonText == 'C') {
        if (displayText.isNotEmpty) {
          displayText = displayText.substring(0, displayText.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          // Replace X with * for multiplication
          String expressionText = displayText.replaceAll('X', '*');
          Expression expression = Expression.parse(expressionText);
          final evaluator = const ExpressionEvaluator();
          var evalResult = evaluator.eval(expression, {});
          result = evalResult.toString();
        } catch (e) {
          result = 'Error';
        }
      } else {
        displayText += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculator',
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
        ),
       backgroundColor:Color.fromARGB(255, 0, 145, 255) , 
       actions: [
        IconButton(icon: Icon(Icons.settings), 
        onPressed: () {
        },
        ),
       ], 
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 230, 11),
                    ),
                  ),
                  Text(
                    result,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 21, 255, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 185, 202, 247),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
          Row(
            children: [
              buildButton('AC', Color.fromARGB(255, 217, 117, 250)),
              buildButton('C',  Color.fromARGB(255, 104, 176, 254)),
              buildButton('%',  Color.fromARGB(255, 104, 176, 254)),
              buildButton('/',  Color.fromARGB(255, 104, 176, 254)),
            ],
          ),
          Row(
            children: [
              buildButton('7', Color.fromARGB(252, 0, 60, 255)),
              buildButton('8', Color.fromARGB(252, 0, 60, 255) ),
              buildButton('9', Color.fromARGB(252, 0, 60, 255)),
              buildButton('*', Color.fromARGB(255, 104, 176, 254)), // Changed X to *
            ],
          ),
          Row(
            children: [
              buildButton('4', Color.fromARGB(252, 0, 60, 255)),
              buildButton('5', Color.fromARGB(252, 0, 60, 255)),
              buildButton('6', Color.fromARGB(252, 0, 60, 255)),
              buildButton('-',  Color.fromARGB(255, 104, 176, 254)),
            ],
          ),
          Row(
            children: [
              buildButton('1', Color.fromARGB(252, 0, 60, 255)),
              buildButton('2', Color.fromARGB(252, 0, 60, 255)),
              buildButton('3', Color.fromARGB(252, 0, 60, 255)),
              buildButton('+',  Color.fromARGB(255, 104, 176, 254)),
            ],
          ),
          Row(
            children: [
              buildButton('00', Color.fromARGB(252, 0, 60, 255)),
              buildButton('0', Color.fromARGB(252, 0, 60, 255)),
              buildButton('.', Color.fromARGB(252, 0, 60, 255)),
              buildButton('=',  Color.fromARGB(252, 0, 60, 255)),
            ],
          ),
        ],
      ),
          )
      ],
      ),
    );
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(1),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(20),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }
}
