// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

// Project Imports

import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/services/administrator/adminFactory.dart';
import 'package:leafguard/services/agent/agentFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/dashboard/calender_widget.dart';
import 'package:leafguard/widgets/dashboard/header_widget.dart';
import 'package:leafguard/widgets/dashboard/agent_data_widget.dart';

// Package Imports
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/dashboard';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userid = "";
  String username = "";
  String userrole = "";
  String userno = "";
  String usercreation = "";
  String useremail = "";

  List<Agent> agents = [];
  List<Agent> _filteredAgents = [];

  int page = 1, pages = 1, pendingConfirm = 0, confirmed = 0;

  AgentFactory? fnc;
  Administrator? admin;
  AdministratorFactory? fnd;
  SharedPref sharedPrefs = SharedPref();
  VariableService? getProperty = VariableService();

  @override
  void initState() {
    super.initState();

    getAdmin().then((_) {
      fnc = Provider.of<AgentFactory>(context, listen: false);
      fnd = Provider.of<AdministratorFactory>(context, listen: false);

      Future.wait([
        fnc!.getAgents(getProperty!.search.page),
        fnd!.getAdminById(userid),
      ]).then(
        (results) {
          setVariables(fnc!);
          admin = results[1];

          setState(() {
            username = admin!.name!;
            userrole = admin!.role!;
            // userno = admin!.adminNumber!;
            userno = admin!.adminNumber ?? '';

            useremail = admin!.email!;
            usercreation = admin!.createdAt.toString();
          });
        },
      );
    });
  }

  Future<void> getAdmin() async {
    userid = await sharedPrefs.read('storedUserId') ?? '';
  }

  void setVariables(AgentFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    agents = fnc.agents;
    _filteredAgents = agents;

    pendingConfirm = _filteredAgents.where((user) => user.status == 0).length;
    confirmed = _filteredAgents.where((user) => user.status == 1).length;
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
            /// Side Navigation Menu
            /// Only show in desktop
            if (AppResponsive.isDesktop(context))
              const Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            Expanded(
              flex: 4,
              // child: Dashboard(), from /views/dashboard
              child: Container(
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
                                  // const NotificationCardWidget(), from /widgets/dashboard
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.defaultTextColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppTheme.white,
                                                ),
                                                children: [
                                                  const TextSpan(
                                                      text: "Hello "),
                                                  TextSpan(
                                                    text: username,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "You have $pendingConfirm agents\nthat are pending verification and $confirmed verified agent(s).\nclick below to view",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.white,
                                                height: 1.5,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                RouteService.agents(context);
                                              },
                                              child: Text(
                                                "Read More",
                                                style: TextStyle(
                                                  color: AppTheme.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      const CalendarWidget(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // ProfileCardWidget(), from /widgets/dashboard
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                // ClipRRect(
                                                //   borderRadius:
                                                //       BorderRadius.circular(
                                                //           1000),
                                                //   child: Image.asset(
                                                //     "assets/user.png",
                                                //     height: 60,
                                                //     width: 60,
                                                //   ),
                                                // ),
                                                const CircleAvatar(
                                                  radius: AppTheme.avatarSize,
                                                  backgroundImage: AssetImage(
                                                    ApiEndPoint.adminLogo,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      username,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    Text(
                                                        userrole.toUpperCase()),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Divider(
                                              thickness:
                                                  AppTheme.dividerThickness,
                                              color: AppTheme.main,
                                            ),
                                            profileListTile(
                                              'Email',
                                              useremail,
                                            ),
                                            profileListTile(
                                              "Created On",
                                              usercreation.length > 10
                                                  ? usercreation.substring(
                                                      0, 10)
                                                  : '$usercreation...',
                                            ),
                                            customerListTile(
                                                "Total Agents",
                                                _filteredAgents.length
                                                    .toString()),
                                            profileListTile("AdminNo# ",
                                                userno.toUpperCase()),
                                          ],
                                        ),
                                      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileListTile(text, value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.defaultTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget customerListTile(text, value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Container(
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.main,
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appversionTile(txt, icon, text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(txt),
          Icon(
            icon,
            color: AppTheme.main,
          ),
          Text(text),
        ],
      ),
    );
  }
}
