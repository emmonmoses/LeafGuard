// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:http/http.dart' as http;
import 'package:leafguard/models/transactions/transaction_search.dart';
import 'dart:convert';

import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

class TransactionService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/transactions';

  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<TransactionSearch?> getTransactions(page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl?page=$page";
      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = TransactionSearch.fromJson(map);

        return result;
      } else {
        return null;
        // throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<TransactionSearch?> getTransactionsByCreator(page, createdBy) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/creator/$createdBy?page=$page";
      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = TransactionSearch.fromJson(map);

        return result;
      } else {
        return null;
        // throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }
}
