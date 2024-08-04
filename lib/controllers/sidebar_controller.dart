// ignore_for_file: prefer_typing_uninitialized_variables

// Project Imports
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/services/login/login_factory.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/services/main_api_endpoint.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/general/custom_expansion.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  final ScrollController _controllerOne = ScrollController();

  @override
  Widget build(BuildContext context) {
    var permissions =
        Provider.of<LoginFactory>(context, listen: false).permission;

    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(
              ApiEndPoint.sidebarLogo,
              width: 200.0,
            ),
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: false,
              controller: _controllerOne,
              child: ListView(
                controller: _controllerOne,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.defaultTextColor,
                    ),
                    height: MediaQuery.of(context).size.height * 1.6,
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (permissions!.any(
                            (permission) => permission.module == 'Dashboard'))
                          InkWell(
                            onTap: (() {
                              RouteService.dashboard(context);
                            }),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.home_rounded,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    "Dashboard",
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (permissions.any((permission) =>
                            permission.module == 'Admins' ||
                            permission.module == 'Sub Admins'))
                          CustomExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.group_outlined,
                                    color: AppTheme.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Administrators",
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget>[
                              if (permissions.any((permission) =>
                                  permission.module == 'Admins'))
                                InkWell(
                                  onTap: () {
                                    RouteService.administrators(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 9.0),
                                          child: Icon(
                                            Icons.arrow_right,
                                            color: AppTheme.white,
                                          ),
                                        ),
                                        Text(
                                          'Admins',
                                          style: TextStyle(
                                            color: AppTheme.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              if (permissions.any((permission) =>
                                  permission.module == 'Sub Admins'))
                                InkWell(
                                  onTap: () {
                                    RouteService.subAdministrators(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 9.0),
                                          child: Icon(
                                            Icons.arrow_right,
                                            color: AppTheme.white,
                                          ),
                                        ),
                                        Text(
                                          'Sub Admins',
                                          style: TextStyle(
                                            color: AppTheme.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        if (permissions.any(
                            (permission) => permission.module == 'Monitors'))
                          InkWell(
                            onTap: () {
                              RouteService.categories(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 9.0),
                                    child: Icon(
                                      Icons.library_books_rounded,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    'Monitors',
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (permissions.any((permission) =>
                            permission.module == 'Monitoring Statuses'))
                          InkWell(
                            onTap: (() {
                              RouteService.taxes(context);
                            }),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.remember_me_rounded,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    "Monitoring Statuses",
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (permissions.any(
                            (permission) => permission.module == 'Bookings'))
                          InkWell(
                            onTap: (() {
                              RouteService.bookings(context);
                            }),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.list_alt_outlined,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    "Bookings", // Tasks
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (permissions.any((permission) =>
                            permission.module == 'Main Categories'))
                          InkWell(
                            onTap: (() {
                              RouteService.maincategories(context);
                            }),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.group_work_rounded,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    "Main Categories",
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (permissions.any(
                            (permission) => permission.module == 'Services'))
                          InkWell(
                            onTap: () {
                              RouteService.subCategories(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 9.0),
                                    child: Icon(
                                      Icons.library_books_outlined,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    'Services', // Sub Categories
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        const Spacer(),
                        InkWell(
                          onTap: (() {
                            RouteService.signout(context);
                          }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.exit_to_app_rounded,
                                    color: AppTheme.white,
                                  ),
                                ),
                                Text(
                                  "Sign Out",
                                  style: TextStyle(
                                    color: AppTheme.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
