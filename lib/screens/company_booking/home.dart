// Project Imports
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/screens/company_booking/company_booking.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
// Flutter Imports
import 'package:flutter/material.dart';
// Package Imports
import 'package:provider/provider.dart';

class CompanyBookingHome extends StatefulWidget {
  static const routeName = '/companybooking';

  const CompanyBookingHome({super.key});

  @override
  State<CompanyBookingHome> createState() => _CompanyBookingHomeState();
}

class _CompanyBookingHomeState extends State<CompanyBookingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: Provider.of<custom.MenuController>(context, listen: false)
          .scaffoldKey,
      backgroundColor: AppTheme.bgSideMenu,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Side Navigation Menu
            /// Only show in desktop
            if (AppResponsive.isDesktop(context))
              const Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            const Expanded(
              flex: 4,
              child: CompanyBookingIndex(),
            ),
          ],
        ),
      ),
    );
  }
}
