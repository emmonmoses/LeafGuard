// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/agents/agent_header.dart';
import 'package:leafguard/widgets/agents/agent_table.dart';

class AgentIndex extends StatefulWidget {
  const AgentIndex({super.key});

  @override
  State<AgentIndex> createState() => _AgentIndexState();
}

class _AgentIndexState extends State<AgentIndex> {
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
          const AgentHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const AgentTable(),
        ],
      ),
    );
  }
}
