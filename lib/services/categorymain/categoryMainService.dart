// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/category_main/category_main.dart';
import 'package:leafguard/models/category_main/category_main_create.dart';
import 'package:leafguard/models/category_main/category_main_search.dart';
import 'package:leafguard/models/category_main/category_main_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class MainCategoryService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/maincategories';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<MainCategorySearch?> getMainCategories(page) async {
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
        var result = MainCategorySearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<MainCategory> getMainCategoryById(categoryId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$categoryId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = MainCategory.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<MainCategoryCreate?> createMainCategory(
      MainCategoryCreate category) async {
    try {
      var content = jsonEncode(category.toJson());
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
        return category;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<MainCategoryUpdate?> updateMainCategory(
      MainCategoryUpdate updatedCategory) async {
    try {
      var content = jsonEncode(updatedCategory.toJson());
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
        return updatedCategory;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteMainCategory(categoryId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$categoryId";

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
