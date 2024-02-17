// ignore_for_file: prefer_typing_uninitialized_variables, unrelated_type_equality_checks

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';

class PermissionsHandler extends GetxController {
  var allPermissionsGranted = "0".obs;
  var locationPermission = false.obs;
  Location location = Location();

  @override
  void onInit() {
    super.onInit();
    checkService();
  }

  bool checkPermission() {
    if (allPermissionsGranted.value == "1") {
      return true;
    } else {
      return false;
    }
  }

  void checkService() async {
    if (await Permission.location.request().isGranted) {
      allPermissionsGranted.value = "1";
    } else {
      (await Permission.location.isGranted == true)
          ? locationPermission.value = true
          : null;
    }
  }

  void requestPermissions() async {
    await Permission.location.request();
    checkService();
  }

  void checkServiceAfterDenied() async {
    if (!await Permission.location.request().isGranted) {
      AppSettings.openAppSettings();
    }
    checkService();
  }
}
