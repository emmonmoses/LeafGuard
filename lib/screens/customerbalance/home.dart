// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/screens/customerbalance/customerbalance.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/themes/app_theme.dart';
// Package Imports
import 'package:provider/provider.dart';

class CustomerBalanceHome extends StatefulWidget {
  static const routeName = '/customerbalances';

  const CustomerBalanceHome({super.key});

  @override
  State<CustomerBalanceHome> createState() => _CustomerBalanceHomeState();
}

class _CustomerBalanceHomeState extends State<CustomerBalanceHome> {
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
              child: CustomerBalanceIndex(),
            ),
          ],
        ),
      ),
    );
  }
}
