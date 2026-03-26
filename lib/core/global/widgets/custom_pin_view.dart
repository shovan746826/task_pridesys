import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../config/color_config.dart';
import '../../config/theme_config.dart';



class CustomPinView extends StatelessWidget {
  const CustomPinView({super.key,
    required this.validator,
    this.obsecureText = false,
    this.onCompleted,
    this.autoFocus = false,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.pinTheme,
    this.onChanged});

  final TextEditingController? controller;
  final FormFieldValidator<String> validator;
  final Function(String)? onCompleted;
  final bool? obsecureText;
  final bool autoFocus;
  final Function(String)? onChanged;
  final bool enabled;
  final bool readOnly;
  final PinTheme? pinTheme;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      validator: validator,
      length: 6,
      readOnly: true,
      autofocus: true,
      enabled: enabled,
      onChanged: onChanged,
      defaultPinTheme: pinTheme ?? defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      preFilledWidget: Text("●", style: TextStyle(fontSize: 36, color: ColorConfig.whiteColor.withOpacity(0.25)),),
      // obscuringCharacter: "*",
      obscureText: obsecureText ?? false,
      showCursor: true,
      onCompleted: onCompleted,
      // focusNode: focusNode,
    );
  }
}


class CustomPinViewBottomSheet extends StatelessWidget {
  CustomPinViewBottomSheet({
    super.key, this.obsecureText = false, this.onCompleted,  this.autoFocus = false,
    this.controller, this.onChange, this.isPinClearNeeded = true});

  final TextEditingController? controller;
  final Function(String)? onCompleted;
  final bool? obsecureText;
  final bool autoFocus;
  final Function(String)? onChange;
  bool? isPinClearNeeded = true;

  @override
  Widget build(BuildContext context) {
    isPinClearNeeded == true ? controller?.clear() : null;
    return Pinput(
      enabled: false,
      readOnly: true,
      controller: controller,
      length: 6,
      defaultPinTheme: defaultPinThemeForPin,
      focusedPinTheme: focusedPinThemeForPin,
      submittedPinTheme: submittedPinThemeForPin,
      preFilledWidget: Text("●", style: TextStyle(fontSize: 20, color: ColorConfig.textColorSecondary.withOpacity(0.25)),),
      // obscuringCharacter: "*",
      obscureText: true,
      showCursor: false,
      onChanged: onChange,
      // focusNode: focusNode,
    );
  }
}
