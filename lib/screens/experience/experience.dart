// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/experience/experience_header.dart';
import 'package:leafguard/widgets/experience/experience_table.dart';

class ExperienceIndex extends StatefulWidget {
  const ExperienceIndex({super.key});

  @override
  State<ExperienceIndex> createState() => _ExperienceIndexState();
}

class _ExperienceIndexState extends State<ExperienceIndex> {
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
          const ExperienceHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const ExperienceTable(),
        ],
      ),
    );
  }
}
