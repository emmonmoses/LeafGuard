// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/cancellationrule/cancellationrule_header.dart';
import 'package:leafguard/widgets/cancellationrule/cancellationrule_table.dart';

class CancellationIndex extends StatefulWidget {
  const CancellationIndex({super.key});

  @override
  State<CancellationIndex> createState() => _CancellationIndexState();
}

class _CancellationIndexState extends State<CancellationIndex> {
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
          const CancellationHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const CancellationRuleTable(),
        ],
      ),
    );
  }
}
