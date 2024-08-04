// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/customerbalance/customerbalance_header.dart';
import 'package:leafguard/widgets/customerbalance/customerbalance_table.dart';

class CustomerBalanceIndex extends StatefulWidget {
  const CustomerBalanceIndex({super.key});

  @override
  State<CustomerBalanceIndex> createState() => _CustomerBalanceIndexState();
}

class _CustomerBalanceIndexState extends State<CustomerBalanceIndex> {
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
          const CustomerBalanceHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const CustomerBalanceTable(),
        ],
      ),
    );
  }
}

// class AppTheme {
// }
