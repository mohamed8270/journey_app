// ignore_for_file: avoid_print, unused_field, unused_import

import 'package:flutter/material.dart';

import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:journey_app/controller/geo_coding.dart';
import 'package:location/location.dart';

class Service extends GetxController {
  final _hasCallSupport = true.obs();
  var latitude = 0.0.obs();
  var longitude = 0.0.obs();
  GeocodingLocation geocodingLocation = GeocodingLocation();
  void initState() {
    super.onInit();
  }

  Future<void> getLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();
    print(locationData.longitude);
    print(locationData.latitude);
    latitude = locationData.latitude ?? 78.0;
    longitude = locationData.longitude ?? 78.0;
    await geocodingLocation.getPlacemark(latitude, longitude);
  }
}
