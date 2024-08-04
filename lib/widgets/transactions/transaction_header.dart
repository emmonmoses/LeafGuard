// Projects Imports
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class TransactionHeader extends StatefulWidget {
  const TransactionHeader({super.key});

  @override
  State<TransactionHeader> createState() => _TransactionHeaderState();
}

class _TransactionHeaderState extends State<TransactionHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              tooltip: 'Menu',
              icon: const Icon(
                Icons.menu,
                color: AppTheme.defaultTextColor,
              ),
              onPressed:
                  Provider.of<custom.MenuController>(context, listen: false)
                      .controlMenu,
            ),
          Text(
            "Transactions",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          // if (!AppResponsive.isMobile(context)) ...{
          //   const Spacer(),
          //   Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(right: 8.0),
          //         child: InkWell(
          //           onTap: () {
          //             RouteService.newTask(context);
          //           },
          //           child: navigationIcon(
          //             icon: Icons.add,
          //             title: Text(
          //               'New Booking',
          //               style: Theme.of(context).textTheme.titleSmall?.copyWith(
          //                     color: AppTheme.main,
          //                   ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   )
          // }
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
