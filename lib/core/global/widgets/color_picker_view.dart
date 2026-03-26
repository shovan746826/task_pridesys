import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/color_config.dart';

class ColorPickerView extends StatefulWidget {
  const ColorPickerView({super.key});

  @override
  State<ColorPickerView> createState() => _ColorPickerViewState();
}

class _ColorPickerViewState extends State<ColorPickerView> {
  Color currentColor = ColorConfig.primaryColor; // initial color
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // Selected Color Circle
          // Container(
          //   width: 72.w,
          //   height: 72.h,
          //   decoration: BoxDecoration(
          //     color: currentColor,
          //     shape: BoxShape.circle,
          //   ),
          //   child: Icon(Icons.wallet, color: Colors.white, size: 32.sp),
          // ),
          //
          // SizedBox(height: 12.h),
          //
          // // HEX Code
          // Text(
          //   "#${currentColor.value.toRadixString(16).substring(2).toUpperCase()}",
          //   style: TextStyle(
          //     fontSize: 16.sp,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),


          // Circular Wheel Picker
          ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) {
              setState(() {
                currentColor = color;
              });
            },
            pickerAreaHeightPercent: 0.8,
            paletteType: PaletteType.hueWheel,
            enableAlpha: false,
            displayThumbColor: true,
            labelTypes: const [], // hide labels
          ),


          // Bottom Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // RESET
              TextButton(
                onPressed: () {
                  setState(() {
                    currentColor = ColorConfig.primaryColor;
                  });
                },
                child: const Text(
                  "RESET",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              // CANCEL
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              // OK
              ElevatedButton(
                onPressed: () => Navigator.pop(context, currentColor),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: const Text("Set"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
