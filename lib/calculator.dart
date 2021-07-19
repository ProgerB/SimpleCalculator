import 'dart:developer' as matn;

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 30.0;
  double resultFontSize = 0.0;
  Color resultColor = Colors.black;

  buttonPressed(String buttonText) {
    setState(() {
      var listElement = ['×', '÷', '-', '+', '.', '%'];
      var lastStr = equation[equation.length - 1];

      hisoblash(expression) {
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

        } catch (e) {
          result = '0';
        }
      }

      if (listElement.contains(buttonText)) {
        matn.log("Button text: " + buttonText);
        if (listElement.contains(lastStr)) {
          equation = equation.substring(0, equation.length - 1) + buttonText;
          return;
        }
      }
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        resultFontSize = 0.0;
        resultColor = Colors.black;
      } else if (buttonText == "⌫") {
        resultColor = Colors.black;
        result = equation;
        resultFontSize = 0.0;

        matn.log(equation);
        equation = equation.substring(0, equation.length - 1);
        if (!(equation == '')) {
          hisoblash(equation);
        }
        matn.log(equation);

        if (equation == "") {
          equation = '0';
        }
      } else if (buttonText == "=") {
        var history = equation;
        equationFontSize = 30;
        resultFontSize = 15;
        matn.log(equation);
        if (listElement.contains(lastStr)) {
          equation = equation.substring(0, equation.length - 1);
        }
        hisoblash(equation);

        equation = result;
        result = history;
        if (equation == 'Infinity') {
          equation = 'not divisible by 0';
        }
      } else {
        if (equation == "0" || equation == 'not divisible by 0') {
          resultFontSize = 0.0;
          resultColor = Colors.black;
          equation = buttonText;

          hisoblash(equation);
        } else {
          resultFontSize = 0.0;
          resultColor = Colors.black;
          equation = equation + buttonText;
          hisoblash(equation);
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color textColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      // color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: const BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: const EdgeInsets.all(16.0),
        color: buttonColor,
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.normal, color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              // height: 150,
              padding: const EdgeInsets.fromLTRB(0, 220, 30, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: resultColor),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            const Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("C", 1, Colors.grey.shade100, Colors.red.shade400),
                buildButton(
                    "⌫", 1, Colors.grey.shade100, Colors.green.shade400),
                buildButton(
                    "%", 1, Colors.grey.shade100, Colors.green.shade400),
                buildButton("÷", 1, Colors.grey.shade100, Colors.green.shade400)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("7", 1, Colors.grey.shade100, Colors.black54),
                buildButton("8", 1, Colors.grey.shade100, Colors.black54),
                buildButton("9", 1, Colors.grey.shade100, Colors.black54),
                buildButton("×", 1, Colors.grey.shade100, Colors.green.shade400)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("4", 1, Colors.grey.shade100, Colors.black54),
                buildButton("5", 1, Colors.grey.shade100, Colors.black54),
                buildButton("6", 1, Colors.grey.shade100, Colors.black54),
                buildButton("+", 1, Colors.grey.shade100, Colors.green.shade400)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("1", 1, Colors.grey.shade100, Colors.black54),
                buildButton("2", 1, Colors.grey.shade100, Colors.black54),
                buildButton("3", 1, Colors.grey.shade100, Colors.black54),
                buildButton("-", 1, Colors.grey.shade100, Colors.green.shade400)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton(".", 1, Colors.grey.shade100, Colors.black54),
                buildButton("0", 1, Colors.grey.shade100, Colors.black54),
                buildButton("00", 1, Colors.grey.shade100, Colors.black54),
                buildButton("=", 1, Colors.green.shade400, Colors.white)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
