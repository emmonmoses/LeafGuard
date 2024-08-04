// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/tax/tax_header.dart';
import 'package:leafguard/widgets/tax/tax_table.dart';

class TaxIndex extends StatefulWidget {
  const TaxIndex({super.key});

  @override
  State<TaxIndex> createState() => _TaxIndexState();
}

class _TaxIndexState extends State<TaxIndex> {
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
          const TaxHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const TaxTable(),
        ],
      ),
    );
  }
}
