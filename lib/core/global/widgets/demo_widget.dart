import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart' as math;

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final draggableScrollableController = DraggableScrollableController();
  bool _isExpanded = false;
  String _input = '';
  String _result = '';

  void _toggleKeypad() {
    setState(() => _isExpanded = !_isExpanded);

    draggableScrollableController.animateTo(
      _isExpanded ? 0.5 : 0.15, // full or collapsed
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    draggableScrollableController.addListener(() {
      setState(() {
        _isExpanded = draggableScrollableController.size >= 0.4;
      });

    });
  }

  void _onKeyTap(String key) {
    setState(() {
      if (key == 'AC') {
        _input = '';
        _result = '';
      } else if (key == '=') {
        _evaluateExpression();
      } else {
        _input += key;
      }
    });

    debugPrint("input: $_input");
    debugPrint("result: $_result");
    debugPrint("key: $key");
  }

  void _evaluateExpression() {
    try {
      final parser = math.Parser();
      final exp = parser.parse(
        _input.replaceAll('×', '*').replaceAll('÷', '/'),
      );
      final cm = math.ContextModel();
      final eval = exp.evaluate(math.EvaluationType.REAL, cm);
      setState(() => _result = eval.toString());
    } catch (e) {
      setState(() => _result = 'Error');
    }
  }

  Widget _buildKeypad(ScrollController scrollController) {
    final buttons = [
      '7', '8', '9', '/',
      '4', '5', '6', '*',
      '1', '2', '3', '-',
      '0', '.', 'AC', '+',
      '=',
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          controller: scrollController,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: buttons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final key = buttons[index];
            final isOperator = ['/', '*', '-', '+', '='].contains(key);

            return GestureDetector(
              onTap: () => _onKeyTap(key),
              child: Container(
                decoration: BoxDecoration(
                  color: key == 'AC'
                      ? Colors.redAccent
                      : key == '='
                      ? Colors.greenAccent[400]
                      : isOperator
                      ? Colors.orangeAccent
                      : Colors.grey[850],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    key,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            // Top display (input and result)
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  // Toggle button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        _isExpanded
                            ? Icons.keyboard_hide_rounded
                            : Icons.keyboard_rounded,
                        color: Colors.black87,
                        size: 28,
                      ),
                      onPressed: _toggleKeypad,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _input,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom draggable keypad
            Positioned.fill(
              child: DraggableScrollableSheet(
                controller: draggableScrollableController,
                snap: true,
                snapAnimationDuration: const Duration(milliseconds: 200),
                initialChildSize: 0.15,
                minChildSize: 0.15,
                maxChildSize: 0.5,
                builder: (context, scrollController) =>
                    _buildKeypad(scrollController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
