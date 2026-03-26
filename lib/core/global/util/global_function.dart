import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String formatToReadableNumber(num value) {
  if (value >= 1e9) {
    return '${(value / 1e9).toStringAsFixed(2)}B'; // Billion
  } else if (value >= 1e6) {
    return '${(value / 1e6).toStringAsFixed(2)}M'; // Million
  } else if (value >= 1e3) {
    return '${(value / 1e3).toStringAsFixed(2)}K'; // Thousand
  } else {
    return value.toString(); // Less than 1k, no formatting
  }
}


class TwoDigitAfterDecimalValueFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final regEx = RegExp(r'^\d*\.?\d{0,2}$');

    // Allow only if new input fully matches pattern
    if (regEx.hasMatch(newValue.text)) {
      return newValue;
    }

    // Otherwise, reject change and keep old value
    return oldValue;
  }
}


String formatNumber(num number) {
  final formatter = NumberFormat('#,##0.00', 'en_US');
  var factor = 10;
  return formatter.format(number * factor);
}


void copyToClipboard(BuildContext context, String textToCopy) {
  Clipboard.setData(ClipboardData(text: textToCopy));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Copied to clipboard!')),
  );
}

String formatIsoDate(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);
  return DateFormat('MMM d yyyy, hh:mm a').format(dateTime.toLocal());
}

String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime.toLocal());
}

String convertTo24Hour(String time12) {
  final dateTime = DateFormat('hh:mm a').parse(time12);
  return DateFormat('HH:mm').format(dateTime);
}

String convertTo12Hour(String time24) {
  final dateTime = DateFormat('hh:mm:ss').parse(time24);
  return DateFormat('hh:mm a').format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd MMM yyyy').format(dateTime.toLocal());
}

String getCurrentDate() {
  DateTime dateTime = DateTime.now();
  return DateFormat('MMMM yyyy').format(dateTime.toLocal());
}

String convertToYMD(String dateStr) {
  // Try parsing with weekday
  DateTime dateTime = DateFormat("dd MMM yyyy").parse(dateStr);
  return DateFormat("yyyy-MM-dd").format(dateTime);
}

String convertToDMY(String dateStr) {
  // Try parsing with weekday
  DateTime dateTime = DateFormat("yyyy-MM-dd").parse(dateStr);
  return DateFormat("dd MMM yyyy").format(dateTime);
}

DateTime convertStringToDate(String dateStr) {
  return DateFormat("yyyy-MM-dd").parse(dateStr);
}
  // Try parsing with weekday



String getDayLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final input = DateTime(date.year, date.month, date.day);

  final difference = today.difference(input).inDays;

  if (difference == 0) {
    return 'Today';
  } else if (difference == 1) {
    return 'Yesterday';
  } else {
    const dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return dayNames[date.weekday - 1];
  }
}

Color hexToColor(String hexString) {
  hexString = hexString.toUpperCase().replaceAll("#", "");
  if (hexString.length == 6) {
    hexString = "FF$hexString"; // Add full opacity if alpha is missing
  }
  return Color(int.parse(hexString, radix: 16));
}

String colorToHex(Color color) {
  return '#'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}'
      .toUpperCase();
}

final Map<String, bool> _debounceMap = {};
Future<void> debounceTap(BuildContext context,  VoidCallback? action, {String key = "click",int delayMilliseconds = 1000,}) async {
  if (_debounceMap[key] == true) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please wait sometime',
        style: TextStyle(
          color: Colors.red,
        ),
      )),
    );
    return;
  }
  _debounceMap[key] = true;
  action?.call();

  await Future.delayed(Duration(milliseconds: delayMilliseconds));
  _debounceMap[key] = false;
}

Map<String, String> decodeBasicAuthToken(String token) {
  final decodedBytes = base64Decode(token);
  final decodedString = utf8.decode(decodedBytes);

  final parts = decodedString.split(':');

  return {
    'email': parts[0],
    'password': parts[1],
  };
}

