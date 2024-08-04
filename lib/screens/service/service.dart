// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/service/service_header.dart';
import 'package:leafguard/widgets/service/service_table.dart';

class ServiceIndex extends StatefulWidget {
  const ServiceIndex({super.key});

  @override
  State<ServiceIndex> createState() => _ServiceIndexState();
}

class _ServiceIndexState extends State<ServiceIndex> {
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
          const ServiceHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const ServiceTable(),
        ],
      ),
    );
  }
}
