// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/provider/provider_header.dart';
import 'package:leafguard/widgets/provider/provider_table.dart';

class ProviderIndex extends StatefulWidget {
  const ProviderIndex({super.key});

  @override
  State<ProviderIndex> createState() => _ProviderIndexState();
}

class _ProviderIndexState extends State<ProviderIndex> {
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
          const ProviderHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const ProviderTable(),
        ],
      ),
    );
  }
}
