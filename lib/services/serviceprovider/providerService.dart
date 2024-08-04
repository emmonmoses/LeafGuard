// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Project imports:
import 'package:leafguard/models/provider/provider_create.dart';
import 'package:leafguard/models/provider/provider_create_return.dart';
import 'package:leafguard/models/provider/provider_search.dart';
import 'package:leafguard/models/provider/provider_update.dart';
import 'package:leafguard/models/upload/upload.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

class TaskerService {
  var searchUrl;
  final baseUrlA = '${ApiEndPoint.endpoint}/taskers/admin';
  final baseUrl = '${ApiEndPoint.endpoint}/taskers';
  final logoUrl = '${ApiEndPoint.endpoint}/taskers/image';
  final uploadUrl = '${ApiEndPoint.endpoint}/taskers/upload';

  var accessToken;
  String key = 'storedAccessToken';
  SharedPref sharedPref = SharedPref();

  Future<ProviderSearch?> getServiceProviders(page) async {
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
        var result = ProviderSearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderCreateReturn> getServiceProviderById(providerId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$providerId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ProviderCreateReturn.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderCreateReturn?> getServiceProviderByTaskerNumber(
      providerId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/number/$providerId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = ProviderCreateReturn.fromJson(map);

        return result;
      } else {
        return null;
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
      await input.onChange.first; // Wait for the user to select a file

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

  Future<ProviderCreate?> createServiceProvider(ProviderCreate user) async {
    try {
      var content = jsonEncode(user.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrlA;

      var response = await http.post(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return user;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<ProviderUpdate?> updateServiceProvider(
      ProviderUpdate updatedProvider) async {
    try {
      var content = jsonEncode(updatedProvider.toJson());
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
        return updatedProvider;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteServiceProvider(providerId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$providerId";

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

  Future<dynamic> verifyProvider(providerId) async {
    accessToken = await sharedPref.read(key);

    searchUrl = '$baseUrl/verify/provider/$providerId';

    var response = await http.patch(
      Uri.parse(searchUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      try {
        var providerUpdate =
            ProviderUpdate.fromJson(json.decode(response.body));
        return providerUpdate;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
