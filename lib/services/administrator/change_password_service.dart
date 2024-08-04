import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:leafguard/models/administrator/admin_change_password.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

class PasswordChangeService {
  // ignore: prefer_typing_uninitialized_variables
  var accessToken;
  // String key = 'storedAccessTokenAgent';
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  final String apiUrl = "${ApiEndPoint.endpoint}/administrators/resetpwd";

  Future<String> changePassword(ChangeAdministratorPassword data) async {
    accessToken = await sharedPref.read(key);

    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode(data.toJson()),
    );

    String responseJson = response.body;

    Map<String, dynamic> responseData = json.decode(responseJson);

    String message = responseData['message'];
    if (response.statusCode == 200) {
      return "Password Changed";
    } else {
      return message;
    }
  }
}
