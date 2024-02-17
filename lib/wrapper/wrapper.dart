import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey_app/components/bottom_nav_bar.dart';
import 'package:journey_app/controller/permission_handler.dart';
import 'package:journey_app/screens/permission_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    PermissionsHandler permissionsHandler = Get.put(PermissionsHandler());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Obx(
        () => (permissionsHandler.checkPermission())
            ? const BottomNavBar()
            : const Scaffold(
                body: SafeArea(
                  child: permissionpage(),
                ),
              ),
      ),
    );
  }
}
