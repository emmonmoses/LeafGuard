// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/transactions/transaction_header.dart';
import 'package:leafguard/widgets/transactions/transaction_table.dart';

class TransactionIndex extends StatefulWidget {
  const TransactionIndex({super.key});

  @override
  State<TransactionIndex> createState() => _TransactionIndexState();
}

class _TransactionIndexState extends State<TransactionIndex> {
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
          const TransactionHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const TransactionTable(),
        ],
      ),
    );
  }
}
