// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leafguard/models/signin/forget_password.dart';
import 'package:leafguard/models/signin/forget_password_response.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/themes/app_theme.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String email; // Add email parameter

  const ForgetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email; // Set initial value of TextField
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.green,
        title: Text(
          'Reset Password'.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.white,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _buildEmailTextField(),
            const SizedBox(height: 20),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        // style: const TextStyle(color: AppTheme.defaultTextColor),
        keyboardType: TextInputType.text,
        readOnly: true,
        controller: _emailController,
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: "Enter your email",
          hintStyle: TextStyle(
            color: AppTheme.grey,
          ),
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
        '${ApiEndPoint.endpoint}/subadministrators/forgot/password';
    final String email = _emailController.text;

    final UserEmail emailModel = UserEmail(email: email);

    if (_emailController.text.isEmpty) {
      snackBarNotification(context, ToasterService.emptyFields);
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
          snackBarNotification(context, resetResponse.message!);
        }
      } else if (response.statusCode == 404) {
        final Map<String, dynamic> errorBody = jsonDecode(response.body);
        final PasswordResetResponse resetResponse =
            PasswordResetResponse.fromJson(errorBody);

        if (resetResponse.error != null) {
          snackBarErr(context, resetResponse.error!);
        }
      } else {
        snackBarErr(context, ToasterService.errorMsg);
      }
    } catch (error) {
      // Handle error
    }
  }

  void passwordPasswordSent() {
    snackBarNotification(context, ToasterService.successMsg);
  }
}
