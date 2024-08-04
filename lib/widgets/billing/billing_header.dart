// Projects Imports
import 'package:leafguard/screens/billing/create_billing.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class BillingHeader extends StatefulWidget {
  const BillingHeader({super.key});

  @override
  State<BillingHeader> createState() => _BillingHeaderState();
}

class _BillingHeaderState extends State<BillingHeader> {
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
            "Billing Cycle",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: newBilling,
                    child: navigationIcon(
                      icon: Icons.add,
                      title: Text(
                        'New Billing',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppTheme.main,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          }
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

  newBilling() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CreateBilling(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }
}
