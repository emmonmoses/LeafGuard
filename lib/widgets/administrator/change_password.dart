import 'package:flutter/material.dart';
import 'package:leafguard/models/administrator/admin_change_password.dart';
import 'package:leafguard/services/administrator/change_password_service.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordChangePopup extends StatefulWidget {
  const PasswordChangePopup({super.key});

  @override
  State<PasswordChangePopup> createState() => _PasswordChangePopupState();
}

class _PasswordChangePopupState extends State<PasswordChangePopup> {
  final TextEditingController agentIdController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final PasswordChangeService passwordChangeService = PasswordChangeService();
  VariableService getProperty = VariableService();
  bool isChangingPassword = false;

  String id = "";

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('storedUserId') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600.0,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Material(
              child: TextFormField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      getProperty.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        getProperty.passwordVisible =
                            !getProperty.passwordVisible;
                      });
                    },
                  ),
                  labelText: 'Old Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the value as needed
                  ),
                ),
                obscureText: !getProperty.passwordVisible,
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              child: TextFormField(
                obscureText: !getProperty.newpasswordVisible,
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the value as needed
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      getProperty.newpasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        getProperty.newpasswordVisible =
                            !getProperty.newpasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              child: TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the value as needed
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      getProperty.confirmpasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        getProperty.confirmpasswordVisible =
                            !getProperty.confirmpasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !getProperty.confirmpasswordVisible,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green)),
              onPressed: isChangingPassword ? null : _changePassword,
              child: isChangingPassword
                  ? const CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.greenAccent,
                    )
                  : const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() async {
    setState(() {
      isChangingPassword = true;
    });

    final adminId = id;
    final oldPassword = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (adminId.isEmpty ||
        oldPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      // Check if any of the fields are empty and show an error message.
      snackBarErrorMessage(context, ToasterService.emptyFields);
      setState(() {
        isChangingPassword = false;
      });
      return;
    }

    if (newPassword != confirmPassword) {
      // Check if the new password and confirm password match.
      snackBarErrorMessage(context, ToasterService.newandconfirmpassword);
      setState(() {
        isChangingPassword = false;
      });
      return;
    }

    final data = ChangeAdministratorPassword(
      administratorId: id,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    final passwordChanged = await passwordChangeService.changePassword(data);

    setState(() {
      isChangingPassword = false;
    });

    if (passwordChanged == "Password Changed") {
      // ignore: use_build_context_synchronously
      snackBarNotification(context, ToasterService.passwordchanged);

      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else if (passwordChanged == "Old password is incorrect") {
      // ignore: use_build_context_synchronously
      snackBarErrorMessage(context, ToasterService.incorrectoldpassword);
    } else {
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    }
  }
}
