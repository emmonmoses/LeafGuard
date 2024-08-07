// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/currency/currency_header.dart';
import 'package:leafguard/widgets/currency/currency_table.dart';

class CurrencyIndex extends StatefulWidget {
  const CurrencyIndex({super.key});

  @override
  State<CurrencyIndex> createState() => _CurrencyIndexState();
}

class _CurrencyIndexState extends State<CurrencyIndex> {
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
          const CurrencyHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const CurrencyTable(),
        ],
      ),
    );
  }
}
