// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/billing/billing_header.dart';
import 'package:leafguard/widgets/billing/billing_table.dart';

class BillingIndex extends StatefulWidget {
  const BillingIndex({super.key});

  @override
  State<BillingIndex> createState() => _BillingIndexState();
}

class _BillingIndexState extends State<BillingIndex> {
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
          const BillingHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const BillingTable(),
        ],
      ),
    );
  }
}
