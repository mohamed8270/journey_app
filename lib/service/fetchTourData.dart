// ignore_for_file: constant_identifier_names, non_constant_identifier_names, avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:journey_app/modals/tour_modal.dart';

class FetchTourData extends GetxController {
  var SearchController = TextEditingController();
  Future<void> searchTourLocation() async {
    final String search = SearchController.toString();
    if (search.isNotEmpty) {
      await FetchDataApi(search);
    }
  }

  Future<List<TourModal>> FetchDataApi(String search) async {
    Map<String, String> queryParams = {
      'query': '${search}',
      'limit': '30',
      'offset': '0',
      'units': 'km',
      'location_id': '1',
      'currency': 'INR',
      'sort': 'relevance',
      'lang': 'en_US',
    };

    var URL = 'https://travel-advisor.p.rapidapi.com/locations/search';

    http.Response ResponseData = await http.get(
      Uri.tryParse(URL)!.replace(queryParameters: queryParams),
      headers: {
        'X-RapidAPI-Key': dotenv.env['API_KEY'].toString(),
        'X-RapidAPI-Host': 'travel-advisor.p.rapidapi.com',
        "useQueryString": "true",
      },
    );

    if (ResponseData.statusCode == 200) {
      Map<String, dynamic> resJson = jsonDecode(ResponseData.body);
      List<dynamic> jsonList = resJson['data'];
      List<TourModal> tourOut =
          jsonList.map((dynamic e) => TourModal.fromJson(e)).toList();
      return tourOut;
    } else {
      print('Failed to fetch data: ${ResponseData.statusCode}');
      print('Response body: ${ResponseData.body}');
      throw Exception('Failed to fetch data');
    }
  }
}
