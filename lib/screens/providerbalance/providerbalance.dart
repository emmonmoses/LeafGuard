// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/providerbalance/providerbalance_header.dart';
import 'package:leafguard/widgets/providerbalance/providerbalance_table.dart';

class ProviderBalanceIndex extends StatefulWidget {
  const ProviderBalanceIndex({super.key});

  @override
  State<ProviderBalanceIndex> createState() => _ProviderBalanceIndexState();
}

class _ProviderBalanceIndexState extends State<ProviderBalanceIndex> {
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
          const ProviderBalanceHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const ProviderBalanceTable(),
        ],
      ),
    );
  }
}

// class AppTheme {
// }
