import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/reports/reportTransactionAgent/report_transactionagent_header.dart';
import 'package:leafguard/widgets/reports/reportTransactionAgent/report_transactionagent_table.dart';

class ReportTransactionAgentIndex extends StatefulWidget {
  const ReportTransactionAgentIndex({super.key});

  @override
  State<ReportTransactionAgentIndex> createState() =>
      _ReportTransactionAgentIndexState();
}

class _ReportTransactionAgentIndexState
    extends State<ReportTransactionAgentIndex> {
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
          const ReportTransactionAgentHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const ReportTransactionAgentTable(),
        ],
      ),
    );
  }
}
