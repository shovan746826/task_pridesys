import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/PermissionChecker.dart';

class BaseController extends ChangeNotifier{

  onNotifyListeners(){
    notifyListeners();
  }



  Future<void> onRefresh(WidgetRef ref) async {

  }



  setAllPermission() async{
    PermissionChecker.isPermissionsGranted();
  }

}