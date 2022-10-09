import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userQuestion = '';
  var userAnswar = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Column(
          children: [
            Expanded(
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                          padding: const EdgeInsets.all(25),
                          alignment: Alignment.centerRight,
                          child: Text(
                            userQuestion,
                            style: const TextStyle(fontSize: 50),
                          )),
                      Container(
                          padding: const EdgeInsets.all(25),
                          alignment: Alignment.centerRight,
                          child: Text(
                            userAnswar,
                            style: const TextStyle(fontSize: 50),
                          )),
                    ]),
              ),
            ),
            Expanded(
                flex: 2,
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        // Clear Button
                        if (index == 0) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = '';
                                userAnswar = '';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.green,
                            textColor: Colors.white,
                            size: 27.0,
                          );
                        }
                        // Delete Button
                        else if (index == 1) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            size: 27.0,
                          );
                        }
                        //Equal Button
                        else if (index == buttons.length - 1) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                            size: 27.0,
                          );
                        }
                        //Rest of all Button
                        else {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.deepPurple,
                            size: 27.0,
                          );
                        }
                      }),
                ))
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswar = eval.toString();
  }
}
