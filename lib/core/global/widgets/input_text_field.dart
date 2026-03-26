
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/asset_config.dart';
import '../../config/color_config.dart';
import 'common_widgets.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  InputTextField({super.key,
    required this.labelText,
    this.controller,
    this.validator,
    this.hintText,
    this.hintStyle = const TextStyle(
      color: Colors.grey,
      height: 1.2,
    ),
    this.errorText,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.inputType,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled,
    this.formatter,
  });

  TextEditingController? controller = TextEditingController();
  final FormFieldValidator<String>? validator;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final int? maxLength;
  final int? maxLines;
  final Function(String)? onChanged;
  final TextInputType? inputType;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  bool obscureText;
  bool readOnly;
  final bool? enabled;
  final List<TextInputFormatter>? formatter;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,
          style: TextStyle(
            color: ColorConfig.textLabelColor,
            fontSize: 14.sp,
          ),
        ),

        SizedBox(height: 4.h),

        glassView(
          padding: EdgeInsets.zero,
          opacity: 0.5,
          color: ColorConfig.blackColor,
          child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              maxLines: maxLines,
              readOnly: readOnly,
              enabled: enabled,
              maxLength: maxLength,
              keyboardType: inputType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(
                color: ColorConfig.whiteColor,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: hintStyle,
                filled: true,
                fillColor: Colors.transparent,
                errorText: errorText,
                prefix: prefix,
                prefixIcon: prefixIcon,
                suffix: suffix,
                suffixIcon: suffixIcon,
                prefixIconConstraints: BoxConstraints(
                  minWidth: 40.w,
                  minHeight: 40.h,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 12.w,
                ),
              ),

            validator: validator,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
