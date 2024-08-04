// Project Imports
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/administrator/admin_header.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/administrator/admin_table.dart';

class AdministratorIndex extends StatefulWidget {
  const AdministratorIndex({super.key});

  @override
  State<AdministratorIndex> createState() => _AdministratorIndexState();
}

class _AdministratorIndexState extends State<AdministratorIndex> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.bgWhiteMixin,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        children: [
          const AdministratorHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const AdministratorTable(),
        ],
      ),
    );
  }
}
