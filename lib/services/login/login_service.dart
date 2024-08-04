// ignore_for_file: depend_on_referenced_packages

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/signin/signin.dart';
import 'package:leafguard/models/signin/signin_response.dart';
import 'package:leafguard/services/main_api_endpoint.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  var loginUrl = "${ApiEndPoint.endpoint}/administrators/login";
  SharedPref sharedPref = SharedPref();
  VariableService getProperty = VariableService();
  // dynamic ctx;

  Future<SignInResponse?> signIn(SignIn loginUser) async {
    try {
      var content = jsonEncode(loginUser.toJson());

      http.Response response = await http.post(
        Uri.parse(loginUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
        },
      );

      final responseJson = jsonDecode(response.body);
      var result = SignInResponse.fromJson(responseJson);

      final prefs = await SharedPreferences.getInstance();

      if (response.statusCode == 200) {
        String id = '${result.id}';
        String name = '${result.name}';
        String role = '${result.role}';
        String email = '${result.email}';
        String admin = '${result.admin}';
        String token = '${result.token}';
        String createdOn = '${result.created}';
        prefs.setString('storedUserName', name);
        prefs.setString('storedUserRole', role);
        prefs.setString('storedAccessToken', token);
        prefs.setString('storedToken', token);
        prefs.setString('storedUserId', id);
        prefs.setString('storedAdmin', admin);
        prefs.setString('storedUserName', name);
        prefs.setString('storedUserRole', role);
        prefs.setString('storedUserEmail', email);
        prefs.setString('storedAccessToken', token);
        prefs.setString('storedToken', token);
        prefs.setString('userSignUpDate', createdOn);

        // snackBarSuccess(ctx, ToasterService.successMsg);

        return result;
      } else if (response.statusCode == 400) {
        return result;
      } else {
        final errorResponse = jsonDecode(response.body);
        var error = SignInResponse.fromJson(errorResponse);
        // toastError(errorResponse.toString());
        return error;
      }
    } catch (e) {
      // throw Exception('Error during API call: $e');
      return null;
    }
  }
}
