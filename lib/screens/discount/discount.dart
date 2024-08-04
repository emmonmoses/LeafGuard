// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/discount/discount_header.dart';
import 'package:leafguard/widgets/discount/discount_table.dart';

class DiscountIndex extends StatefulWidget {
  const DiscountIndex({super.key});

  @override
  State<DiscountIndex> createState() => _DiscountIndexState();
}

class _DiscountIndexState extends State<DiscountIndex> {
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
          const DiscountHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const DiscountTable(),
        ],
      ),
    );
  }
}
