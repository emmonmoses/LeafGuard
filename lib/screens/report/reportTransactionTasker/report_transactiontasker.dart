import 'package:flutter/material.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/screens/report/reportTransactionTasker/report_transactiontasker_index.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ReportTransactionTasker extends StatefulWidget {
  static const routeName = '/report/transactiontasker';

  const ReportTransactionTasker({super.key});

  @override
  State<ReportTransactionTasker> createState() => _ReportUnPaidState();
}

class _ReportUnPaidState extends State<ReportTransactionTasker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: Provider.of<custom.MenuController>(context, listen: false)
          .scaffoldKey,
      backgroundColor: AppTheme.bgSideMenu,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AppResponsive.isDesktop(context))
              const Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            const Expanded(flex: 4, child: ReportTransactionTaskerIndex()),
          ],
        ),
      ),
      floatingActionButton: AppResponsive.isMobile(context)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'cancelFab',
                  onPressed: () {
                    RouteService.routeDashboard(context);
                  },
                  backgroundColor: AppTheme.red,
                  mini: true,
                  child: const Icon(Icons.close),
                ),
              ],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  save(ctx) {}
}
