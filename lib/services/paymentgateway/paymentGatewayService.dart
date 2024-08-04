// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/paymentgateway/paymentgateway.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway_create.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway_search.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class PaymentGatewayService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/paymentgateways';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<PaymentGatewaySearch?> getPaymentGateways(page) async {
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
        var result = PaymentGatewaySearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<PaymentGateway> getPaymentGatewayById(paymentGatewayId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$paymentGatewayId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = PaymentGateway.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<PaymentGatewayCreate?> createPaymentGateway(
      PaymentGatewayCreate paymentGateway) async {
    try {
      var content = jsonEncode(paymentGateway.toJson());
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
        return paymentGateway;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<PaymentGatewayUpdate?> updatePaymentGateway(
      PaymentGatewayUpdate updatedPaymentGateway) async {
    try {
      var content = jsonEncode(updatedPaymentGateway.toJson());
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
        return updatedPaymentGateway;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deletePaymentGateway(paymentGatewayId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$paymentGatewayId";

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
