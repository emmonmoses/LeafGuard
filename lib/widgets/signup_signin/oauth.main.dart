// ignore: avoid_web_libraries_in_flutter
import 'package:openid_client/openid_client.dart';

import 'oauth.dart'
    if (dart.library.io) 'oauth.io.dart'
    if (dart.library.html) 'oauth.web.dart' as oauth;

abstract class Identity {
  Identity._();

  static Future<TokenResponse> authenticate({
    required Uri uri,
    required String clientId,
    List<String>? scopes,
  }) async {
    return oauth.authentication(uri, clientId, scopes ?? const []);
  }
}

extension TokenResponseExtensions on TokenResponse {
  String get idTokenString => toJson()['id_token'];
}
