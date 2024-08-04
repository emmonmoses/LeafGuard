// ignore_for_file: use_build_context_synchronously, must_be_immutable

// Project Imports
import 'package:leafguard/screens/signup_signin.dart/authorisation_modal.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/signup_signin/oauth.web.service.dart';

// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return const DesktopNavbar();
    });
  }
}

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Image.asset(
                ApiEndPoint.appLogo,
                width: 190.0,
              ),
            ],
          ),
          Row(
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
                    Consumer<OAuthWebService>(
                      builder: (context, oauthservice, child) {
                        return TextButton(
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
    );
  }
}

class MobileNavbar extends StatelessWidget {
  const MobileNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(children: <Widget>[
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineMedium,
            children: [
              WidgetSpan(
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: const CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(ApiEndPoint.appLogo),
                  ),
                ),
              ),
              // TextSpan(
              //   text: "LeafGuard",
              //   style: TextStyle(color: AppColor.custom),
              // ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppTheme.defaultTextColor,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: AppTheme.white,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
