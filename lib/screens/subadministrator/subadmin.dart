// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/subadministrator/subadmin_header.dart';
import 'package:leafguard/widgets/subadministrator/subadmin_table.dart';

class SubAdministratorIndex extends StatefulWidget {
  const SubAdministratorIndex({super.key});

  @override
  State<SubAdministratorIndex> createState() => _SubAdministratorIndexState();
}

class _SubAdministratorIndexState extends State<SubAdministratorIndex> {
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
          const SubAdministratorHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const SubAdministratorTable(),
        ],
      ),
    );
  }
}
