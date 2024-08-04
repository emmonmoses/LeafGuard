// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/service/service_create.dart';
import 'package:leafguard/models/service/service_search.dart';
import 'package:leafguard/models/service/service_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class ServiceProvider {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/subcategories';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<ServiceSearch?> getServices(page) async {
    try {
      accessToken = await sharedPref.read(key);

      var searchUrl = "$baseUrl?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ServiceSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ServiceSearch> getServiceById(serviceId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$serviceId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ServiceSearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ServiceCreate?> createService(ServiceCreate service) async {
    try {
      var content = jsonEncode(service.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = '$baseUrl/admin';

      var response = await http.post(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return service;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ServiceUpdate?> updateService(ServiceUpdate updatedService) async {
    try {
      var content = jsonEncode(updatedService.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = '$baseUrl/editbyadmin';

      var response = await http.patch(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        return updatedService;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteService(serviceId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$serviceId";

      var response = await http.delete(
        Uri.parse(searchUrl),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      return response.statusCode;
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }
}
