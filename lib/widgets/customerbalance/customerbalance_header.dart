// Projects Imports

// Flutter Iports
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/themes/app_theme.dart';

// Package Imports
import 'package:provider/provider.dart';

class CustomerBalanceHeader extends StatefulWidget {
  const CustomerBalanceHeader({super.key});

  @override
  State<CustomerBalanceHeader> createState() => _CustomerBalanceHeaderState();
}

class _CustomerBalanceHeaderState extends State<CustomerBalanceHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              tooltip: 'Menu',
              icon: Icon(
                Icons.menu,
                color: AppTheme.black,
              ),
              onPressed:
                  Provider.of<custom.MenuController>(context, listen: false)
                      .controlMenu,
            ),
          Text(
            "Customer Wallet",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget navigationIcon({icon, title}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
          ),
        ),
        Container(
          child: title,
        )
      ],
    );
  }
}
