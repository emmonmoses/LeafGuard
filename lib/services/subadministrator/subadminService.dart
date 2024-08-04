// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/models/administrator/admin_search.dart';
import 'package:leafguard/models/administrator/subadmin_create.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class SubAdministratorService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/subadministrators';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<AdministratorSearch?> getSubAdmins(page) async {
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
        var result = AdministratorSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<AdministratorSearch> getSubAdminById(adminId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$adminId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = AdministratorSearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<SubAdministratorCreate?> createSubAdmin(
      SubAdministratorCreate admin) async {
    try {
      var content = jsonEncode(admin.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      var response = await http.post(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return admin;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Administrator?> updateSubAdmin(Administrator updatedAdmin) async {
    try {
      var content = jsonEncode(updatedAdmin.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      var response = await http.patch(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        return updatedAdmin;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteSubAdmin(adminId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$adminId";

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

  Future deleteRole(roleId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/role/$roleId";

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
