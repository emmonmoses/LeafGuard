// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:leafguard/models/company/company_booking_search.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompanyBookingService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/companybookings';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<CompanyBookingSearch?> getCompanyBookings(page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = CompanyBookingSearch.fromJson(map);

        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }
}
