// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/reviews/review_create.dart';
import 'package:leafguard/models/reviews/review_search.dart';
import 'package:leafguard/models/reviews/reviews.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class ReviewService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/reviews';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<ReviewSearch?> getReviews(page) async {
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
        var result = ReviewSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ReviewSearch> getReviewById(adminId) async {
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
        var result = ReviewSearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ReviewCreate?> createReview(ReviewCreate review) async {
    try {
      var content = jsonEncode(review.toJson());
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
        return review;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Reviews?> updateReview(Reviews updatedUser) async {
    try {
      var content = jsonEncode(updatedUser.toJson());
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
        return updatedUser;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteReview(adminId) async {
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
}
