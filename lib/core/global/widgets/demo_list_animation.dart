import 'package:flutter/material.dart';


class AnimatedColumnDemo extends StatefulWidget {
  @override
  _AnimatedColumnDemoState createState() => _AnimatedColumnDemoState();
}

class _AnimatedColumnDemoState extends State<AnimatedColumnDemo>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  final int itemCount = 5;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      itemCount,
          (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      ),
    );

    _slideAnimations = _controllers
        .map((controller) => Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    ))
        .toList();

    _runAnimations();
  }

  void _runAnimations() async {
    for (var controller in _controllers) {
      await Future.delayed(Duration(milliseconds: 500));
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated Column')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
              (index) => SlideTransition(
            position: _slideAnimations[index],
            child: FadeTransition(
              opacity: _controllers[index],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  child: Text(
                    'Item ${index + 1}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
