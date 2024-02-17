// ignore_for_file: unrelated_type_equality_checks, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_app/constants/theme.dart';
import 'package:journey_app/controller/permission_handler.dart';

class permissionpage extends StatefulWidget {
  const permissionpage({super.key});

  @override
  State<permissionpage> createState() => _permissionpageState();
}

class _permissionpageState extends State<permissionpage> {
  PermissionsHandler permissionsHandler = Get.put(PermissionsHandler());
  String url =
      'https://static.vecteezy.com/system/resources/previews/005/073/066/original/enable-location-services-pop-up-permission-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg';

  bool first = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: tWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height * 0.25,
              width: screenSize.width * 0.75,
              decoration: BoxDecoration(
                color: tBlue.withOpacity(0.1),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Journey Voyager",
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: tBlue,
                  ),
                ),
                Text(
                  "Specially for Touristers!",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: tBlue.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              height: screenSize.height * 0.055,
              width: screenSize.width * 0.4,
              decoration: BoxDecoration(
                color: tBlue.withOpacity(0.09),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "All you set!",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: tBlue,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (!first) {
                        permissionsHandler.requestPermissions();
                        setState(() {
                          first = true;
                        });
                      } else {
                        permissionsHandler.checkServiceAfterDenied();
                      }
                    },
                    icon: Icon(
                      Icons.settings_outlined,
                      color: tBlue.withOpacity(0.5),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: screenSize.height * 0.045,
              width: screenSize.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location Permission",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: tBlue,
                    ),
                  ),
                  (permissionsHandler.locationPermission == true)
                      ? const Icon(
                          CupertinoIcons.checkmark_alt_circle,
                          color: Colors.green,
                          size: 24,
                        )
                      : const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                          size: 24,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
