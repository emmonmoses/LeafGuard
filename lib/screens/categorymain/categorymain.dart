// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/categorymain/maincategory_header.dart';
import 'package:leafguard/widgets/categorymain/maincategory_table.dart';

class MainCategoryIndex extends StatefulWidget {
  const MainCategoryIndex({super.key});

  @override
  State<MainCategoryIndex> createState() => _MainCategoryIndexState();
}

class _MainCategoryIndexState extends State<MainCategoryIndex> {
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
          const MainCategoryHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const MainCategoryTable(),
        ],
      ),
    );
  }
}
