// ignore_for_file: unnecessary_string_interpolations, camel_case_types

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class apidatafetch extends GetxController {
  Future fetchApiData(String search) async {
    Map<String, String> queryparams = {
      'query': '$search',
      'limit': '30',
      'offset': '0',
      'units': 'km',
      'location_id': '1',
      'currency': 'INR',
      'sort': 'relevance',
      'lang': 'en_US',
    };

    var url = 'https://travel-advisor.p.rapidapi.com/locations/search';

    http.Response request = await http.get(
      Uri.tryParse(url)!.replace(
        queryParameters: queryparams,
      ),
      headers: {
        'X-RapidAPI-Key': 'a3a83aff98msh6e058671b51b35ap181d3djsnb00e969cf917',
        'X-RapidAPI-Host': 'travel-advisor.p.rapidapi.com',
        'useQueryString': 'true',
      },
    );
  }
}
