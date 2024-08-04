// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/witness/witness_create.dart';
import 'package:leafguard/models/witness/witness_search.dart';
import 'package:leafguard/models/witness/witness_update.dart';
import 'package:leafguard/models/witness/witnessresponse.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class WitnessService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/witness';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<WitnessSearch?> getWitnesses(page) async {
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
        var result = WitnessSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<WitnessSearch> getWitnessById(witnessId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$witnessId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = WitnessSearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<List<WitnessResponse>?> getWitnessByTaskerId(taskerId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/tasker/$taskerId"; // 650959aff2b6f67b15957faa

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        List<WitnessResponse> result = [];
        jsonDecode(response.body).forEach((e) {
          result.add(WitnessResponse.fromJson(e));
        });

        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<WitnessCreate?> createWitness(WitnessCreate witness) async {
    try {
      var content = jsonEncode(witness.toJson());
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
        return witness;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<WitnessUpdate?> updateWitness(WitnessUpdate updatedWitness) async {
    try {
      var content = jsonEncode(updatedWitness.toJson());
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
        return updatedWitness;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteAllWitness(witnessId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$witnessId";

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

  Future deleteSpecificWitness(witnessId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$witnessId/witnesses";

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
