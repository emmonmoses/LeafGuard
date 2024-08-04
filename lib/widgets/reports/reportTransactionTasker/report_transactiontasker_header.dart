// Projects Imports
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class ReportTransactionTaskerHeader extends StatefulWidget {
  const ReportTransactionTaskerHeader({super.key});

  @override
  State<ReportTransactionTaskerHeader> createState() =>
      _ReportTransactionTaskerHeaderState();
}

class _ReportTransactionTaskerHeaderState
    extends State<ReportTransactionTaskerHeader> {
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
            "Transactions By Tasker",
            style: Theme.of(context).textTheme.titleMedium,
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
