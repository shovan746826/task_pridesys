import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionChecker {

  static Future<bool> isPermissionsGranted() async {
    bool isGranted = false;

    // সব permission একসাথে request করা
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,
      Permission.location,
      Permission.notification,
      Permission.microphone,
      Permission.videos,
      Permission.contacts,
      Permission.storage, // storage যোগ রাখা হলো
    ].request();

    isGranted =
        statuses.values.every((status) => status == PermissionStatus.granted);

    if (kDebugMode) {
      print(statuses[Permission.storage] ?? statuses[Permission.photos]);
    }

    return isGranted;
  }

  Future<bool> requestStoragePermission(BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    // For Android 13+ you may also request specific media types if needed:
    if (await Permission.photos.request().isGranted) {
      return true;
    }
    return false;
  }

}
