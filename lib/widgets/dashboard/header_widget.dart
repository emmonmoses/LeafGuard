// ignore_for_file: library_private_types_in_public_api

// Project Imports
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/administrator/change_password.dart';

// Package Imports
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed:
                  Provider.of<custom.MenuController>(context, listen: false)
                      .controlMenu,
            ),
          Text("Dashboard", style: Theme.of(context).textTheme.titleSmall),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.person_2_rounded,
                  ),
                  tooltip: 'Change Password',
                  onPressed: () {
                    // RouteService.changeAdminPassword(context);
                    // Call function to show modal popup
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const PasswordChangePopup();
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                  ),
                  tooltip: 'Exit Application',
                  onPressed: () {
                    RouteService.signout(context);
                  },
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.send,
                //   ),
                //   tooltip: 'Send Notification',
                //   onPressed: () {
                //     // RouteService.sendnotification(context);
                //   },
                // ),

                // navigationIcon(icon: Icons.send),
                // navigationIcon(icon: Icons.notifications_none_rounded),
              ],
            ),
          }
        ],
      ),
    );
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
      ),
    );
  }
}
