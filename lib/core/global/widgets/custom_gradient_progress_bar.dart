import 'package:flutter/material.dart';

import '../../config/color_config.dart';

class GradientProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final double height;

  const GradientProgressBar({
    Key? key,
    required this.value,
    this.height = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300, // background color
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Gradient foreground
              Container(
                width: constraints.maxWidth * value,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorConfig.primaryColor, ColorConfig.primaryColor, ColorConfig.redColor], // 💙 blue gradient
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
