// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/witness/witness_header.dart';
import 'package:leafguard/widgets/witness/witness_table.dart';

class WitnessIndex extends StatefulWidget {
  const WitnessIndex({super.key});

  @override
  State<WitnessIndex> createState() => _WitnessIndexState();
}

class _WitnessIndexState extends State<WitnessIndex> {
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
          const WitnessHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const WitnessTable(),
        ],
      ),
    );
  }
}
