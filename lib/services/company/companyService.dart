// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:leafguard/models/company/company.dart';
import 'package:leafguard/models/company/company_create.dart';
import 'package:leafguard/models/company/company_search.dart';
import 'package:leafguard/models/company/company_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:http/http.dart' as http;

class CompanyService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/companies';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<dynamic> createCompany(CompanyCreate model) async {
    try {
      var content = jsonEncode(model.toJson());
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
        return 'Company Created Successfully';
      } else {
        var map = jsonDecode(response.body);
        return map['details'];
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<CompanySearch?> getCompanies(page) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = CompanySearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Company?> getCompanyById(companyId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$companyId";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = Company.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<dynamic> updateCompany(UpdateCompany model) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;
      var content = jsonEncode(model.toJson());
      http.Response response = await http.patch(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        return "Company Updated Successfully";
      } else {
        var res = jsonDecode(response.body);
        return res['message'];
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<dynamic> deleteCompany(companyId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$companyId";

      http.Response response = await http.delete(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        var map = jsonDecode(response.body);
        return map['message'];
      } else {
        var map = jsonDecode(response.body);
        return map['message'];
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<dynamic> uploadCompanyLogo(
      {required attachmentStream,
      required attachmentSize,
      required attachmentName}) async {
    searchUrl = "$baseUrl/upload";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    var request = http.MultipartRequest("POST", Uri.parse(searchUrl));
    request.headers.addAll(headers);

    // add selected file with request
    request.files.add(http.MultipartFile(
      "avatar",
      attachmentStream,
      attachmentSize,
      filename: attachmentName,
    ));

    request.send().then(
      (result) async {
        http.Response.fromStream(result).then((response) {
          return response.body;
        });
      },
    ).catchError((err) => err);
  }
}
