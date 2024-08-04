// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/billing/billing.dart';
import 'package:leafguard/models/billing/billing_create.dart';
import 'package:leafguard/models/billing/billing_search.dart';
import 'package:leafguard/models/billing/billing_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class BillingService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/billings';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<BillingSearch> getBillings(page) async {
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
        var result = BillingSearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Billing> getBillingById(billingId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$billingId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = Billing.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<BillingCreate?> createBilling(BillingCreate billing) async {
    try {
      var content = jsonEncode(billing.toJson());
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
        return billing;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<BillingUpdate?> updateBilling(BillingUpdate updatedBilling) async {
    try {
      var content = jsonEncode(updatedBilling.toJson());
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
        return updatedBilling;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteBilling(billingId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$billingId";

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

  Future<BillingSearch> filterBillingPeriod(billingId, page) async {
    try {
      accessToken = await sharedPref.read(key);
      var searchUrl = "$baseUrl/filter/$billingId?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = BillingSearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }
}
