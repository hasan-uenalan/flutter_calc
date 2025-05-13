import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '0';
  final operators = ['+', '-', '*', '/'];

  void resetInput(){
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
  void checkValidInput(String buttonText){
    String inputLastChar = input[input.length - 1];

    List<String> numbers = input.split(RegExp(r'(\+|\-|\*|\/)'));
    if(numbers[numbers.length-1].length == 1){
      // check last character is a 0 to avoid leading zeroes
      if(inputLastChar == '0' && buttonText == '0'){
        return; 
      }
      // check if next character should overwrite 0
      if(inputLastChar == '0' && buttonText != '0' && !operators.contains(buttonText)){
        input = input.substring(0,input.length-1)+buttonText;
        return;
      }
    }

    // check if last character is an operator and replace it
    if(operators.contains(inputLastChar) && operators.contains(buttonText)){
      input = input.substring(0,input.length-1)+buttonText;
    }
    else{
      input += buttonText;
    }

  }


  void calculate(String input){
    List<String> tokens = input.split(RegExp(r'(\+|\-|\*|\/)'));
    List<String> operators = input.replaceAll(RegExp(r'[0-9]'), '').split('');

    for (var token in tokens) {
      print(token);
    }

    for (var operator in operators) {
      print(operator);
    }
  }

  String addition(String a, String b) {
    return (int.parse(a) + int.parse(b)).toString();
  }

  final List<List<String>> buttons = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', '*'],
    ['1', '2', '3', '+'],
    ['C', '0', '=', '-'],
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
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
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                Center( 
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: buttons.map((row) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: row.map((text) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ElevatedButton(
                            onPressed: () {
                              displayInput(text);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 60),
                            ),
                            child: Text(
                              text,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
                ),
              ],  
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Basic Calculator'),
        ),
        
      ),
    );
  }
}

