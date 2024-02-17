import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_app/constants/theme.dart';
import 'package:journey_app/controller/geo_coding.dart';
import 'package:journey_app/controller/service.dart';
import 'package:journey_app/screens/home_screen.dart';
import 'package:latlong2/latlong.dart';

class LocationScreen extends StatefulWidget {
  final MapController mapController;
  const LocationScreen({super.key, required this.mapController});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());

  Service service = Get.put(Service());

  @override
  void initState() {
    super.initState();
    service.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: tWhite,
        appBar: AppBar(
          backgroundColor: tBlue,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Location",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: tWhite,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.to(
                const HomePage(),
              );
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: tWhite,
              size: 24,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: tWhite,
          ),
          child: Column(
            children: [
              Text(
                geocodingLocation.name.value,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: tBlue,
                ),
              ),
              Container(
                height: screenSize.height * 0.77,
                decoration: BoxDecoration(
                  color: tBlack.withOpacity(0.02),
                ),
                child: FlutterMap(
                  mapController: widget.mapController,
                  options: MapOptions(
                    keepAlive: true,
                    center: LatLng(service.latitude, service.longitude),
                    zoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: "dev.fleaflet.flutter_map.example",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(service.latitude, service.longitude),
                          child: const Icon(
                            CupertinoIcons.location_solid,
                            color: tBlue,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
