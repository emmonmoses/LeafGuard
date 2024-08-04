// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Project imports:
import 'package:leafguard/models/bookings/booking_search.dart';
import 'package:leafguard/models/cancellation/cancel_action_object.dart';
import 'package:leafguard/models/upload/upload.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

class BookingService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/newbookings';
  final logoUrl = '${ApiEndPoint.endpoint}/newbookings/image';
  final uploadUrl = '${ApiEndPoint.endpoint}/newbookings/upload';

  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<BookingSearch?> getBookings(page) async {
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
        var result = BookingSearch.fromJson(map);

        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<BookingSearch> getBookingById(bookingId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$bookingId";

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
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<dynamic> uploadImage() async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = uploadUrl;

      final input = FileUploadInputElement();
      input.accept =
          'image/*'; // Set accepted file types (in this case, images)
      input.click(); // Trigger the file picker dialog
      await input.onChange.first; // Wait for the task to select a file

      final file = input.files!.first;
      final formData = FormData();

      formData.appendBlob('image', file);

      var response = await http.post(
        Uri.parse(searchUrl),
        body: formData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final upload = Upload.fromJson(responseData);

        return upload.avatar;
      } else {
        // toastError('Error uploading image');
        throw Exception('Error uploading image');
      }
    } catch (e) {
      // toastError(e);
      throw Exception('Error during API call: $e');
    }
  }

  Future<Uint8List> getTaskerLogo(imageName) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$logoUrl/$imageName";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Error loading image');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteBooking(bookingId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$bookingId";

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

  Future<String?> cancelBooking(CancelActionObject action, bookingId) async {
    var content = jsonEncode(action.toJson());
    accessToken = await sharedPref.read(key);

    searchUrl = '$baseUrl/cancel/$bookingId';

    var response = await http.patch(
      Uri.parse(searchUrl),
      body: content,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return 'Booking Cancelled';
    } else {
      return null;
    }
  }
}
