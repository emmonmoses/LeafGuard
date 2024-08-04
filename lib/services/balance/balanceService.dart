// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:leafguard/models/customerBalance/customer.dart';
import 'package:leafguard/models/customerBalance/customer_balance_create.dart';
import 'package:leafguard/models/customerBalance/customer_balance_search.dart';
import 'package:leafguard/models/customerBalance/customer_balance_update.dart';
import 'package:leafguard/models/providerBalance/provider.dart';
import 'package:leafguard/models/providerBalance/provider_balance_create.dart';
import 'package:leafguard/models/providerBalance/provider_balance_search.dart';
import 'package:leafguard/models/providerBalance/provider_balance_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

class BalanceService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/balance';

  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  // provider endpoints
  Future<ProviderBalanceSearch?> getTaskerBalances(page) async {
    try {
      accessToken = await sharedPref.read(key);
      var searchUrl = "$baseUrl/tasker?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ProviderBalanceSearch.fromJson(map);

        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderBalance> getTaskerBalanceByBalanceId(balanceId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/tasker/$balanceId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ProviderBalance.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderBalance> getBalanceByTaskerNo(taskerNo) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/tasker/$taskerNo";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ProviderBalance.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderBalanceCreate?> createBalanceTasker(
      ProviderBalanceCreate balance) async {
    try {
      var content = jsonEncode(balance.toJson());
      accessToken = await sharedPref.read(key);

      var response = await http.post(
        Uri.parse('$baseUrl/tasker'),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return balance;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderBalanceUpdate?> rechargeBalanceTasker(
      ProviderBalanceUpdate updatedBalance) async {
    try {
      var content = jsonEncode(updatedBalance.toJson());
      accessToken = await sharedPref.read(key);

      var response = await http.patch(
        Uri.parse('$baseUrl/tasker'),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        return updatedBalance;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteBalanceTasker(balanceId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/tasker/$balanceId";

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

  // customer endpoints
  Future<CustomerBalanceSearch> getCustomerBalances(page) async {
    try {
      accessToken = await sharedPref.read(key);
      var searchUrl = "$baseUrl/customer?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = CustomerBalanceSearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<CustomerBalance> getCustomerBalanceByBalanceId(balanceId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/customer/$balanceId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = CustomerBalance.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<CustomerBalance> getBalanceByCustomerNo(customerNo) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/customer/$customerNo";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = CustomerBalance.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<CustomerBalanceCreate?> createBalanceCustomer(
      CustomerBalanceCreate balance) async {
    try {
      var content = jsonEncode(balance.toJson());
      accessToken = await sharedPref.read(key);

      var response = await http.post(
        Uri.parse('$baseUrl/customer'),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return balance;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<CustomerBalanceUpdate?> rechargeBalanceCustomer(
      CustomerBalanceUpdate updatedBalance) async {
    try {
      var content = jsonEncode(updatedBalance.toJson());
      accessToken = await sharedPref.read(key);

      var response = await http.patch(
        Uri.parse('$baseUrl/customer'),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        return updatedBalance;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteBalanceCustomer(balanceId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/tasker/$balanceId";

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
