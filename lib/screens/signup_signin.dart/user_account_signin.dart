// ignore_for_file: use_build_context_synchronously

// Project imports
import 'package:leafguard/screens/signup_signin.dart/authorisation_modal.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/navabar/navbar.dart';

// Flutter imports
import 'package:flutter/material.dart';

class UserSignScreen extends StatefulWidget {
  static const routeName = '/';

  const UserSignScreen({Key? key}) : super(key: key);

  @override
  UserSignScreenState createState() => UserSignScreenState();
}

class UserSignScreenState extends State<UserSignScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: AppResponsive(
          desktop: Column(
            children: [
              const Navbar(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 180),
                // padding: const EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 25),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ApiEndPoint.loginPageLogo,
                                    // width: 120.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // RichText(
                        //   textAlign: TextAlign.center,
                        //   text: TextSpan(
                        //     style: Theme.of(context).textTheme.headlineMedium,
                        //     children: const [
                        //       TextSpan(
                        //         text: "Welcome to LeafGuard \nAdmin Panel",
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           color: AppTheme.defaultTextColor,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          mobile: Padding(
            padding: const EdgeInsets.symmetric(vertical: 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Row(
                //       children: [
                //         Image.asset(
                //           ApiEndPoint.appLogo,
                //           width: 190.0,
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headlineMedium,
                          children: const [
                            TextSpan(
                              text: "Welcome to LeafGuard \nAdmin Panel",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.defaultTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.main,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: AppTheme.white,
                              ),
                            ),
                            onPressed: () {
                              showModalSideSheet(
                                context: context,
                                width: 550,
                                ignoreAppBar: true,
                                body: const AuthorisationModal(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
