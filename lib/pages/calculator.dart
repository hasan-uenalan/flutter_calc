import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '0';
  final operators = ['+', '-', '*', '/'];
  static Color colorNumber = Colors.grey;
  static Color colorOperands = const Color.fromARGB(255, 247, 183, 10);

  List<String> calc_history = ['1+1 = 2', '2+2 = 5'];

  void resetInput() {
    input = '0';
  }

  void displayInput(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        resetInput();
      } else if (buttonText == '=') {
        calculate(input);
      } else {
        checkValidInput(buttonText);
      }
    });
  }

  // checks if incoming input is valid
  void checkValidInput(String buttonText) {
    String inputLastChar = input[input.length - 1];

    if ((input.length > 12)) {
      input = "less numbers pls";
      return;
    }

    List<String> numbers = input.split(RegExp(r'(\+|\-|\*|\/)'));
    if (numbers[numbers.length - 1].length == 1) {
      // check last character is a 0 to avoid leading zeroes
      if (inputLastChar == '0' && buttonText == '0') {
        return;
      }
      // check if next character should overwrite 0
      if (inputLastChar == '0' &&
          buttonText != '0' &&
          !operators.contains(buttonText)) {
        input = input.substring(0, input.length - 1) + buttonText;
        return;
      }
    }

    // check if last character is an operator and replace it
    if (operators.contains(inputLastChar) && operators.contains(buttonText)) {
      input = input.substring(0, input.length - 1) + buttonText;
    } else {
      input += buttonText;
    }
  }

  void calculate(String textInput) {
    input = evaluateExpression(textInput);
  }

  String evaluateExpression(String input) {
    try {
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      String roundedResult = result.toStringAsFixed(2);
      calc_history.insert(0,'$input = $roundedResult');
      return roundedResult;
    } catch (e) {}
    return input;
  }

  final List<List<Map<String, dynamic>>> buttons = [
    [
      {'text': '7', 'color': colorNumber},
      {'text': '8', 'color': colorNumber},
      {'text': '9', 'color': colorNumber},
      {'text': '/', 'color': colorOperands},
    ],
    [
      {'text': '4', 'color': colorNumber},
      {'text': '5', 'color': colorNumber},
      {'text': '6', 'color': colorNumber},
      {'text': '*', 'color': colorOperands},
    ],
    [
      {'text': '1', 'color': colorNumber},
      {'text': '2', 'color': colorNumber},
      {'text': '3', 'color': colorNumber},
      {'text': '+', 'color': colorOperands},
    ],
    [
      {'text': '.', 'color': Colors.red},
      {'text': '0', 'color': colorNumber},
      {'text': '=', 'color': Colors.green},
      {'text': '-', 'color': colorOperands},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black, // Black background
                borderRadius: BorderRadius.circular(30), // Rounded edges
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SizedBox(
                width: 300,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        input,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          buttons.map((row) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  row.map((btn) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          displayInput(btn['text']);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(60, 60),
                                          maximumSize: Size(60, 60),
                                          backgroundColor: btn['color'],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          btn['text'],
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 500,
                height: 600,
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  reverse: true,
                  // padding: const EdgeInsets.all(16),
                  itemCount: calc_history.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 40,
                      child: Text(
                        calc_history[index],
                        style: TextStyle(color: Colors.black, fontSize: 25)
                        )
                    );
                  }
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
