import 'dart:io';

import 'package:task/core/global/util/app_device_info.dart' as SharedPreference;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';



var fcmToken = "";
var appVersion = "";
var phoneModel = "";
var deviceId = "";
var phoneOs = "";
var osVersion = "";
var accessToken = "";

Future<String?> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  // var androidId = const AndroidId();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor!;
    return deviceId; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.id;
    return deviceId; //TODO: unique ID on Android
  }
}

Future<String?> getOsVersion() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    osVersion = iosDeviceInfo.systemVersion;
    return iosDeviceInfo.systemVersion; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    osVersion = androidDeviceInfo.version.release;
    return androidDeviceInfo.version.release; // unique ID on Android
  }
}

Future<String?> getPhoneBrand() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    phoneModel = iosDeviceInfo.model;
    return iosDeviceInfo.model; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    phoneModel = androidDeviceInfo.model;
    return androidDeviceInfo.model; // unique ID on Android
  }
}

Future<String?> getOs() async {
  if (Platform.isIOS) {
    // import 'dart:io'
    phoneOs = "ios";
    return "ios"; // unique ID on iOS
  } else {
    phoneOs = "android";
    return "android"; // unique ID on Android
  }
}

Future<void> generateFCMTokenAsDeviceToken() async {
  await Firebase.initializeApp();
  var _messaging = FirebaseMessaging.instance;
  _messaging.getToken().then((fcm) {
    debugPrint('Fcm on login page :: ${fcm!}');
    if (fcm.isNotEmpty) {
      fcmToken = fcm;
    }
  });
}

initDeviceData() async {
  await getDeviceId();
  await getOsVersion();
  await getPhoneBrand();
  await getOs();
  // await generateFCMTokenAsDeviceToken();
  await getAppVersion();
  await getAccessToken();
}

getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;
  // appPackageID = packageInfo.packageName;
  return packageInfo.version;
}

getAccessToken() async {
  accessToken = await SharedPreference.getAccessToken();
  return accessToken;
}
