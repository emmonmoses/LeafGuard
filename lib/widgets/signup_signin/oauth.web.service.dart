// Project Imports
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:leafguard/widgets/signup_signin/oauth.main.dart';

// Flutter Imports
import 'package:flutter/material.dart';

class OAuthWebService with ChangeNotifier {
  String idTokenString = '';
  String accessToken = '';

  authenticate() async {
    var tokenResp = await Identity.authenticate(
      uri: Uri.parse(ApiEndPoint.authorisationUrl),
      clientId: 'flutter_web',
      scopes: ['email', 'openid', 'profile'],
    );
    idTokenString = tokenResp.idTokenString;
    SharedPref sharedPref = SharedPref();
    await sharedPref.save('accesstoken', idTokenString);
    notifyListeners();
  }
}
