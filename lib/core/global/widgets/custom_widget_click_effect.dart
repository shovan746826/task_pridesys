import 'package:flutter/material.dart';

class CustomWidgetClickEffect extends StatefulWidget {
  const CustomWidgetClickEffect({
    super.key,
    required this.child,
    this.borderRadius, // large = more circular
    this.onTap,
    this.onLongPress,
  });

  final Widget child;
  final double? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  State<CustomWidgetClickEffect> createState() => _CustomWidgetClickEffectState();
}

class _CustomWidgetClickEffectState extends State<CustomWidgetClickEffect> {
  var padding = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,

        onTapCancel: () {
          setState(() {
            padding = 0;
          });
        },

        onTapUp: (_) {
          setState(() {
            padding = 0;
          });
        },
        onTapDown: (_) {
          setState(() {
            padding = 4;
          });
        },

        child: AnimatedContainer(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(50),
            borderRadius: widget.borderRadius == null ? null : BorderRadius.circular(widget.borderRadius ?? 0),
          ),
          duration: const Duration(milliseconds: 10),
          child: widget.child,
        )
    );
  }
}


