import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_image_view.dart';

class CustomImageButtonWithClickEffect extends StatefulWidget {
  const CustomImageButtonWithClickEffect({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconSize = 24,
    this.color = Colors.transparent,
    this.size = 56,
    this.borderRadius, // large = more circular
  });

  final VoidCallback onTap;
  final String icon;
  final double iconSize;
  final Color color;
  final double size;
  final double? borderRadius;

  @override
  State<CustomImageButtonWithClickEffect> createState() => _CustomImageButtonWithClickEffectState();
}

class _CustomImageButtonWithClickEffectState extends State<CustomImageButtonWithClickEffect> {
  var padding = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
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
            child: Container(
              height: widget.size.h,
              width: widget.size.w,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius == null ? null : BorderRadius.circular(widget.borderRadius ?? 0),
              ),

              child: CustomImageView(
                imagePath: widget.icon,
                radius: widget.borderRadius == null ? null : BorderRadius.circular(widget.borderRadius ?? 0),
                height: widget.size.h,
                width: widget.size.w,
              ),
            )
        )
    );
  }
}


