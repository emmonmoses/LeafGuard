// Projects Imports
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/screens/tax/create_tax.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class TaxHeader extends StatefulWidget {
  const TaxHeader({super.key});

  @override
  State<TaxHeader> createState() => _TaxHeaderState();
}

class _TaxHeaderState extends State<TaxHeader> {
  VariableService getProperty = VariableService();

  @override
  void initState() {
    getProperty.getPermissions(context);
    super.initState();
  }

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
            "Tax",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            if (getProperty.permissions!
                .where((permission) => permission.module == 'Taxes')
                .any((p) => p.actions!
                    .any((action) => action.name!.contains('create'))))
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: newTax,
                      child: navigationIcon(
                        icon: Icons.add,
                        title: Text(
                          'New Tax',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
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

  newTax() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CreateTax(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }
}
