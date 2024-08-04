// Project Imports
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/company/company_header.dart';
import 'package:leafguard/widgets/company/company_table.dart';

// Flutter Imports
import 'package:flutter/material.dart';

class CompanyIndex extends StatefulWidget {
  const CompanyIndex({super.key});

  @override
  State<CompanyIndex> createState() => _CompanyIndexState();
}

class _CompanyIndexState extends State<CompanyIndex> {
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
          const CompanyHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const CompanyTable(),
        ],
      ),
    );
  }
}
