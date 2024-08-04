import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/reports/reportTransactionTasker/report_transactiontasker_header.dart';
import 'package:leafguard/widgets/reports/reportTransactionTasker/report_transactiontasker_table.dart';

class ReportTransactionTaskerIndex extends StatefulWidget {
  const ReportTransactionTaskerIndex({super.key});

  @override
  State<ReportTransactionTaskerIndex> createState() =>
      _ReportUnPaidIndexState();
}

class _ReportUnPaidIndexState extends State<ReportTransactionTaskerIndex> {
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
          const ReportTransactionTaskerHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const ReportTransactionTaskerTable(),
        ],
      ),
    );
  }
}
