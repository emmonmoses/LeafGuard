// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:leafguard/models/agents/agent_search.dart';
import 'package:leafguard/models/bookings/booking_search.dart';
import 'package:leafguard/models/provider/provider_search.dart';
import 'package:leafguard/models/transactions/transaction_search.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

class ReportService {
  var searchUrl;
  final agentUrl = '${ApiEndPoint.endpoint}/agents';
  final taskerUrl = '${ApiEndPoint.endpoint}/taskers';
  final reportUrl = '${ApiEndPoint.endpoint}/reports';
  final bookingUrl = '${ApiEndPoint.endpoint}/newbookings';
  final transactionUrl = '${ApiEndPoint.endpoint}/transactions';

  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<AgentSearch?> getAgents(page) async {
    try {
      accessToken = await sharedPref.read(key);
      var searchUrl = "$agentUrl?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = AgentSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderSearch?> getServiceProviders(page) async {
    try {
      accessToken = await sharedPref.read(key);
      var searchUrl = "$taskerUrl?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ProviderSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('Error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  //// BOOKING REPORTING
  Future<BookingSearch?> getBookings(page) async {
    try {
      accessToken = await sharedPref.read(key);
      var searchUrl = "$bookingUrl?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = BookingSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<BookingSearch?> getBookingsByJobStatus(jobstatus, page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$reportUrl/bookings/$jobstatus?page=$page";
      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = BookingSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<BookingSearch?> getBookingsByCreator(createdBy, page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$reportUrl/bookings/creator/$createdBy?page=$page";
      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = BookingSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<BookingSearch?> getBookingsByCreatorAndJobStatus(
      createdBy, status, page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl =
          "$reportUrl/bookings/creator/$createdBy/jobstatus/$status?page=$page";
      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = BookingSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<BookingSearch?> getBookingsByCustomer(customerId, page) async {
    // try {
    accessToken = await sharedPref.read(key);
    searchUrl = "$reportUrl/bookings/customer/$customerId?page=$page";
    var response = await http.get(
      Uri.parse(searchUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var result = BookingSearch.fromJson(map);

      return result;
    } else {
      // throw Exception('error loading object');
      return null;
    }
    // }
    // catch (e) {
    //   throw Exception('Error during API call: $e');
    // }
  }

  Future<BookingSearch?> getBookingsByCategory(categoryId, page) async {
    // try {
    accessToken = await sharedPref.read(key);
    searchUrl = "$reportUrl/bookings/category/$categoryId?page=$page";
    var response = await http.get(
      Uri.parse(searchUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var result = BookingSearch.fromJson(map);

      return result;
    } else {
      // throw Exception('error loading object');
      return null;
    }
    // }
    // catch (e) {
    //   throw Exception('Error during API call: $e');
    // }
  }

  ////TRANSACTION REPORTING
  Future<TransactionSearch?> getTransactions(page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$transactionUrl?page=$page";
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
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<TransactionSearch?> getTransactionsByCreator(createdBy, page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$reportUrl/transactions/creator/$createdBy?page=$page";
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
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<TransactionSearch?> getTransactionsByCustomerId(
      page, customerId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$reportUrl/transactions/customer/$customerId?page=$page";
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
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }
}
