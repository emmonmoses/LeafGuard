// ignore_for_file: use_build_context_synchronously, unused_local_variable

// Project Imports
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/screens/signup_signin.dart/authorisation_modal.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:openid_client/openid_client_io.dart' as a_client;
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:openid_client/openid_client_browser.dart' as w_client;
import 'package:leafguard/screens/dashboard/home_page.dart';
// import 'package:leafguard/widgets/signup_signin/oauth.main.dart';
import 'package:leafguard/widgets/signup_signin/oauth.web.service.dart';

// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildFormSignIn extends StatefulWidget {
  const BuildFormSignIn({
    Key? key,
  }) : super(key: key);

  @override
  BuildFormSignInState createState() => BuildFormSignInState();
}

class BuildFormSignInState extends State<BuildFormSignIn> {
  late GlobalKey<FormState> _formKeySign;
  var isLoading = false;
  bool invalidCredential = false;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    _formKeySign = GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// DEFAULT IMPLEMENTATION MOBILE: NOT TESTED BUT SEEMS TO WORK FROM DOCS
  authenticateApp() async {
    // print(wClient.Issuer.knownIssuers);
    // create the client
    var issuer =
        await a_client.Issuer.discover(Uri.parse(ApiEndPoint.authorisationUrl));
    var client = a_client.Client(issuer, "flutter_admin");

    // create function to open browser with url
    urlLauncher(url) async {
      if (await canLaunchUrl(url)) {
        // await launchUrl(url, forceWebView: true);
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    // create an authenticator
    var authenticator = a_client.Authenticator(
      client,
      scopes: {'email', 'openid', 'profile'},
      port: 42313, // 42313appHost
      urlLancher: urlLauncher,
    );

    // starts the authentication
    var c = await authenticator.authorize();
    // var tokenResponse = await c.getTokenResponse();
    // close the webview when finished
    closeInAppWebView();
    // var access_token = tokenResponse.accessToken;

    /**
      * sample code to use access_token
      */

    // var url = '${ApiEndPoint.authDevHost}/securepage';
    // var response = await http.get(url, headers: {'Authorization', 'Bearer $access_token'});
    // print(access_token);
    // return the user info

    // var userInfo = await c.getUserInfo();

    // return userInfo;
  }

  /// DEFAULT IMPLEMENTATION WEB: DOES NOT WORK
  authenticateWeb() async {
    // create the client
    var uri = Uri(
      scheme: 'https',
      host: ApiEndPoint.serverUrl,
      // port: 5000,
    );
    var issuer = await w_client.Issuer.discover(uri);
    var client = w_client.Client(issuer, 'flutter_web');
    // create an authenticator
    var authenticator =
        w_client.Authenticator(client, scopes: {'email', 'openid', 'profile'});
    // get the credential
    var c = await authenticator.credential;
    if (c == null) {
      // starts the authentication
      return authenticator.authorize();
      // print('idt ${credential?.idToken}');
    } else {
      // return user info
      return await c.getTokenResponse();
    }
  }

  /// THIS IMPLEMENTATION WORKS FOR WEB AND MOBILE
  authenticateWebHack() async {
    // var tokenResp = await Identity.authenticate(
    //   uri: Uri.parse(ApiEndPoint.authHost),
    //   clientId: 'fFENQSYuBD5b7L',
    //   scopes: ['email', 'openid', 'profile', 'read:api'],
    // );

    // var accessToken = tokenResp.accessToken;
    // await sharedPref.save(context)('accesstoken', accessToken);

    // if (accessToken != "") {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomePage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
    // } else {
    //   invalidCredential = true;
    // }
    // return accessToken;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeySign,
      child: Container(
        width: 430,
        height: 450,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            invalidCredential
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    child: Center(
                      child: snackBarNotification(
                          context, ToasterService.authError),
                    ),
                  )
                : Container(),
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 9.0, bottom: 15.0, left: 9.0, right: 9.0),
                      child: Consumer<OAuthWebService>(
                        builder: (context, oauthservice, child) {
                          return TextButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)),
                              foregroundColor: WidgetStateProperty.all<Color>(
                                AppTheme.defaultTextColor,
                              ),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                    color: AppTheme.defaultTextColor,
                                  ),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Login--',
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () {
                              // authenticateWebHack();
                              // oauthservice.authenticate();
                              showModalSideSheet(
                                context: context,
                                width: 550,
                                ignoreAppBar: true,
                                body: const AuthorisationModal(),
                              );
                            },
                          );
                        },
                      )),
                ),
              ],
            ),
            Opacity(
              opacity: isLoading ? 1.0 : 0,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
