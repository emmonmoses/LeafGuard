// Project Imports
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/widgets/dashboard/header_widget.dart';
import 'package:leafguard/widgets/dashboard/calender_widget.dart';
import 'package:leafguard/widgets/dashboard/profile_card_widget.dart';
import 'package:leafguard/widgets/dashboard/notification_card_widget.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/dashboard/agent_data_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          /// Header Part
          const HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const NotificationCardWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        if (AppResponsive.isMobile(context)) ...{
                          const CalendarWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                        },
                        const AgentDashboardDataWidget(),
                      ],
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Column(
                          children: [
                            CalendarWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            ProfileCardWidget(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
