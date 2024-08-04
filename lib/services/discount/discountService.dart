// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/discount/discount_create.dart';
import 'package:leafguard/models/discount/discount_search.dart';
import 'package:leafguard/models/discount/discount_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class DiscountService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/coupons';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<DiscountSearch?> getDiscounts(page) async {
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
        var result = DiscountSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Discount> getDiscountById(couponId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$couponId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = Discount.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<DiscountCreate?> createDiscount(DiscountCreate coupon) async {
    try {
      var content = jsonEncode(coupon.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      http.Response response = await http.post(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return coupon;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<DiscountUpdate?> updateDiscount(DiscountUpdate updatedDiscount) async {
    try {
      var content = jsonEncode(updatedDiscount.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      http.Response response = await http.patch(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        return updatedDiscount;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteDiscount(couponId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$couponId";

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
