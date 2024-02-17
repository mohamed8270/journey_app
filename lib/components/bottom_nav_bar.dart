// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_app/constants/theme.dart';
import 'package:journey_app/controller/geo_coding.dart';
import 'package:journey_app/controller/permission_handler.dart';
import 'package:journey_app/controller/service.dart';
import 'package:journey_app/screens/home_screen.dart';
import 'package:journey_app/screens/location_screen.dart';
import 'package:latlong2/latlong.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Service service = Get.put(Service());
  GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());
  PermissionsHandler permissionsController = Get.put(PermissionsHandler());

  late MapController myController;
  int currentIndex = 0;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    myController = MapController(); // Initialize myController in initState()

    screens = [
      const HomePage(),
      LocationPage(mapController: myController), // Pass myController here
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: tBlack,
              width: 0.1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: tWhite,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          iconSize: 16,
          currentIndex: currentIndex,
          selectedLabelStyle: const TextStyle(
            color: tBlue,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: tBlack.withOpacity(0.3),
          selectedItemColor: tBlue,
          unselectedLabelStyle: GoogleFonts.poppins(
            color: tBlack.withOpacity(0.3),
            fontSize: 10,
          ),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            () async {
              await service.getLocation();
              myController.move(
                  LatLng(service.latitude, service.longitude), 18.0);
              geocodingLocation.getPlacemark(
                  service.latitude, service.longitude);
              myController.latLngToScreenPoint(
                  LatLng(service.latitude, service.longitude));
            };
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.network(
                'https://www.svgrepo.com/show/524643/home-angle-2.svg',
                color: tBlack.withOpacity(0.3),
                height: 22,
                width: 22,
              ),
              activeIcon: SvgPicture.network(
                'https://www.svgrepo.com/show/524643/home-angle-2.svg',
                color: tBlue,
                height: 22,
                width: 22,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.network(
                'https://www.svgrepo.com/show/532539/location-pin.svg',
                color: tBlack.withOpacity(0.3),
                height: 22,
                width: 22,
              ),
              activeIcon: SvgPicture.network(
                'https://www.svgrepo.com/show/532539/location-pin.svg',
                color: tBlue,
                height: 22,
                width: 22,
              ),
              label: 'Location',
            ),
          ],
        ),
      ),
    );
  }
}
