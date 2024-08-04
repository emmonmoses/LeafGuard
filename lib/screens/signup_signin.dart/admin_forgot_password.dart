// Project imports:

import 'dart:convert';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:leafguard/models/signin/forget_password.dart';
import 'package:leafguard/models/signin/forget_password_response.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Package Imports

class AdminForgotPassword extends StatefulWidget {
  const AdminForgotPassword({super.key});

  @override
  State<AdminForgotPassword> createState() => _AdminForgotPasswordState();
}

class _AdminForgotPasswordState extends State<AdminForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: AppTheme.sizeBoxHeight,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -40,
                  height: AppTheme.sizeBoxHeight,
                  width: width,
                  child: FadeAnimation(
                    1,
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background-6.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: AppTheme.sizeBoxHeight,
                  width: width + 20,
                  child: FadeAnimation(
                    1.3,
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background-5.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: _buildEmailTextField(),
                ),
                const SizedBox(height: 20),
                _buildSendButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      // readOnly: true,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: InkWell(
        onTap: () => {
          _resetPassword(context),
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.main,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: Center(
            child: Text(
              "Send Password",
              style: TextStyle(color: AppTheme.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword(BuildContext context) async {
    const String apiUrl =
        '${ApiEndPoint.endpoint}/administrators/forgot/password';
    final String email = _emailController.text;

    final UserEmail emailModel = UserEmail(email: email);

    if (_emailController.text.isEmpty) {
      showToast(ToasterService.emptyFields);
      return;
    }

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(emailModel.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final PasswordResetResponse resetResponse =
            PasswordResetResponse.fromJson(responseBody);

        if (resetResponse.message != null) {
          showToast(resetResponse.message!);
        }
      } else if (response.statusCode == 404) {
        final Map<String, dynamic> errorBody = jsonDecode(response.body);
        final PasswordResetResponse resetResponse =
            PasswordResetResponse.fromJson(errorBody);

        if (resetResponse.error != null) {
          showToast(resetResponse.error!);
        }
      } else {
        showToast(ToasterService.errorMsg);
      }
    } catch (error) {
      showToast(error.toString());
    }
  }

  void showToast(String message) {
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.grey,
    //   textColor: Colors.white,
    // );
  }

  void passwordPasswordSent() {
    showToast(ToasterService.successMsg);
  }
}
