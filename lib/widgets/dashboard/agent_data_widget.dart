// ignore_for_file: library_private_types_in_public_api, avoid_returning_null_for_void

// Project Imports
import 'package:intl/intl.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/services/agent/agentFactory.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/widgets/general/paginator.dart';
import 'package:provider/provider.dart';

class AgentDashboardDataWidget extends StatefulWidget {
  const AgentDashboardDataWidget({super.key});

  @override
  _AgentDashboardDataWidgetState createState() =>
      _AgentDashboardDataWidgetState();
}

class _AgentDashboardDataWidgetState extends State<AgentDashboardDataWidget> {
  List<Agent> agents = [];
  List<Agent> _filteredAgents = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  AgentFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no agent records';

  // Use a GlobalKey for DataTable
  final GlobalKey<_AgentDashboardDataWidgetState> dataTableKeyD =
      GlobalKey<_AgentDashboardDataWidgetState>();

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<AgentFactory>(context, listen: false);
      await fnc!
          .getAgents(getProperty!.search.page)
          .then((r) => {setVariables(fnc!)});

      setState(() {
        getProperty!.isLoading = false;
      });
      getProperty!.isInit = false;
    }

    fnc!.currentPage = 1;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Unverified Agents",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    InkWell(
                      onTap: () => RouteService.agents(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.main,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ),
                        child: Text(
                          "View Agents",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: AppTheme.dividerThickness,
                  color: AppTheme.main,
                ),
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _filteredAgents.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshUsers(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      key: dataTableKeyD,
                                      columns: const [
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Email'),
                                        ),
                                        DataColumn(
                                          label: Text('Created'),
                                        ),
                                        DataColumn(
                                          label: Text(''),
                                        ),
                                      ],
                                      rows: List.generate(
                                        _filteredAgents.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredAgents[element]
                                                    .username!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredAgents[element].email !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        Icon(
                                                          Icons.cancel,
                                                          color: AppTheme.red,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 4.0),
                                                          child: Text(
                                                            _filteredAgents[
                                                                    element]
                                                                .email
                                                                .toString()
                                                                .toUpperCase(),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: AppTheme.red,
                                                        ),
                                                        Text(
                                                          'No Email'
                                                              .toUpperCase(),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                            DataCell(
                                              Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                    _filteredAgents[element]
                                                        .createdAt!),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredAgents[element].status !=
                                                      1
                                                  ? IconButton(
                                                      tooltip: 'Verify',
                                                      onPressed: () {
                                                        verify(
                                                            _filteredAgents[
                                                                element],
                                                            context);
                                                      },
                                                      icon: Icon(
                                                        Icons.check,
                                                        color: AppTheme.main,
                                                      ),
                                                    )
                                                  : Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              searchResult,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                  ),
                ),
                PaginationWidget(
                  page: page,
                  pages: pages,
                  previous: fnc!.isPrevious ? goPrevious : null,
                  next: fnc!.isNextable ? goNext : null,
                ),
              ],
            ),
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  void setVariables(AgentFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    agents = fnc.agents;
    _filteredAgents = agents.where((agent) => agent.status == 0).toList();
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  void verify(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'Agent Verification',
        'Are you sure you wish to verify agent number ${element.agentNumber.toUpperCase()}?');
    if (action == DialogAction.yes) {
      // Update _filteredAgents directly
      // (Assuming verifyAgent adds the agent back with updated status)
      _filteredAgents = await verifyAgent(element.id, ctx);

      // Refresh DataTable
      refreshDataTable();

      snackBarNotification(ctx, ToasterService.successMsg);
    }
  }

  verifyAgent(id, ctx) async {
    final response =
        await Provider.of<AgentFactory>(context, listen: false).verifyAgent(id);
    snackBarNotification(ctx, response);
    return response;
  }

  void refreshDataTable() {
    dataTableKeyD.currentState?.build(context);
  }

  refreshUsers(BuildContext context) async {
    await fnc!
        .getAgents(getProperty!.search.page)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.username.toUpperCase()} from the clients list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteAgent(element.id, ctx);
        // setVariables(fnc!);
      });
    } else {
      setState(() => null);
    }
  }

  deleteAgent(id, ctx) async {
    final response =
        await Provider.of<AgentFactory>(context, listen: false).deleteAgent(id);
    setVariables(fnc!);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }
}
