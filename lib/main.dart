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
  int count = 0;
  String input = '';  

  void resetInput(){
    input = '';
  }

  void displayInput(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        resetInput();
      } else if (buttonText == '=') {
        // Perform calculation
      } else {
        input += buttonText;
      }
    });
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

