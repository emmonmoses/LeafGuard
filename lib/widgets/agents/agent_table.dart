// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, use_build_context_synchronously
// Projects Imports

import 'package:intl/intl.dart';
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/screens/agents/agent_forgot_password.dart';
import 'package:leafguard/screens/agents/edit_agent.dart';
import 'package:leafguard/services/agent/agentFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/agents/agent_preview.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class AgentTable extends StatefulWidget {
  const AgentTable({super.key});

  @override
  State<AgentTable> createState() => _AgentTableState();
}

class _AgentTableState extends State<AgentTable> {
  List<Agent> agents = [];
  List<Agent> _filteredAgents = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  AgentFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no agent records';
  var searchResultInvalid = 'There is no such agent';

  // Use a GlobalKey for DataTable
  final GlobalKey<_AgentTableState> dataTableKeyAgent =
      GlobalKey<_AgentTableState>();

  @override
  void initState() {
    getProperty!.getPermissions(context);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<AgentFactory>(context);
      await fnc!.getAgents(fnc!.currentPage).then((r) => {setVariables(fnc!)});

      setState(() {
        getProperty!.isLoading = false;
      });
      getProperty!.isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_filteredAgents.isEmpty) {
      _filteredAgents = agents;
      // agents =
      //     Provider.of<AgentFactory>(context, listen: false).admins;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchAgent,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredAgents.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshAdmins(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      key: dataTableKeyAgent,
                                      columns: const [
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Agent'),
                                        ),
                                        DataColumn(
                                          label: Text('Email'),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Status',
                                            style: TextStyle(
                                              color: AppTheme.defaultTextColor,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text('Created'),
                                        ),
                                        DataColumn(
                                          label: Row(
                                            children: [
                                              Text(''),
                                            ],
                                          ),
                                        ),
                                      ],
                                      // rows: const [],
                                      rows: List.generate(
                                        _filteredAgents.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredAgents[element]
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                '${_filteredAgents[element].agentNumber}'
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredAgents[element].email !=
                                                      null
                                                  ? Text(
                                                      _filteredAgents[element]
                                                          .email
                                                          .toString()
                                                          .toUpperCase(),
                                                    )
                                                  : Text(
                                                      'No Email'.toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              _filteredAgents[element].status !=
                                                      1
                                                  ? Tooltip(
                                                      message: 'Not Verified',
                                                      child: Icon(
                                                        Icons.cancel,
                                                        color: AppTheme.red,
                                                      ),
                                                    )
                                                  : Tooltip(
                                                      message: 'Verified',
                                                      child: Icon(
                                                        Icons.verified_sharp,
                                                        color: AppTheme.green,
                                                      ),
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
                                              Row(
                                                children: [
                                                  IconButton(
                                                    tooltip: 'View',
                                                    onPressed: () {
                                                      showModalSideSheet(
                                                        context: context,
                                                        width: 550,
                                                        ignoreAppBar: true,
                                                        body: PreviewAgent(
                                                          user: _filteredAgents[
                                                              element],
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  if (getProperty!.permissions!
                                                      .where((permission) =>
                                                          permission.module ==
                                                          'Agents')
                                                      .any((p) => p.actions!.any(
                                                          (action) => action
                                                              .name!
                                                              .contains(
                                                                  'create')))) ...{
                                                    IconButton(
                                                      tooltip: 'Update',
                                                      onPressed: () {
                                                        updateAgent(
                                                            _filteredAgents[
                                                                element]);
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  },
                                                  if (getProperty!.permissions!
                                                      .where((permission) =>
                                                          permission.module ==
                                                          'Agents')
                                                      .any((p) => p.actions!.any(
                                                          (action) => action
                                                              .name!
                                                              .contains(
                                                                  'delete')))) ...{
                                                    IconButton(
                                                      tooltip: 'Delete',
                                                      onPressed: () {
                                                        delete(
                                                            _filteredAgents[
                                                                element],
                                                            context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete_forever,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: 'Reset Password',
                                                      onPressed: () {
                                                        showModalSideSheet(
                                                          context: context,
                                                          width: 550,
                                                          ignoreAppBar: true,
                                                          body:
                                                              ForgetPasswordScreen(
                                                            email:
                                                                _filteredAgents[
                                                                        element]
                                                                    .email!,
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.replay,
                                                      ),
                                                    ),
                                                  },
                                                  const VerticalDivider(),
                                                  _filteredAgents[element]
                                                              .status !=
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
                                                            color:
                                                                AppTheme.main,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
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
                Visibility(
                  visible: getProperty!.isInvisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        searchResultInvalid,
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

  Widget get _searchAgent {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.defaultTextColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListTile(
        leading: IconButton(
          tooltip: 'Clear Search',
          icon: Icon(
            Icons.cancel,
            color: AppTheme.main,
          ),
          onPressed: () {
            setState(() {
              clearSearch();
            });
          },
        ),
        title: Container(
          padding: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            color: AppTheme.white,
          ),
          child: TextFormField(
            style: const TextStyle(color: AppTheme.defaultTextColor),
            controller: searchController,
            decoration: const InputDecoration(
                hintText: 'Search by name, agentNuber or email',
                border: InputBorder.none),
          ),
        ),
        trailing: IconButton(
          tooltip: 'Click to Search',
          icon: Icon(
            Icons.search,
            color: AppTheme.main,
          ),
          onPressed: () {
            setState(() {
              searchAgent(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(AgentFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    agents = fnc.agents;
    _filteredAgents = agents;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshAdmins(BuildContext context) async {
    await fnc!.getAgents(fnc!.currentPage).then((r) => {setVariables(fnc!)});
  }

  void delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from agent list');
    if (action == DialogAction.yes) {
      // Update _filteredAgents directly
      _filteredAgents.removeWhere((agent) => agent.id == element.id);

      // Refresh DataTable
      refreshDataTable();

      // Delete agent
      deleteAgent(element.id, ctx);

      snackBarNotification(ctx, ToasterService.successMsg);
    }
  }

  deleteAgent(id, ctx) async {
    final response =
        await Provider.of<AgentFactory>(context, listen: false).deleteAgent(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
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
    dataTableKeyAgent.currentState?.build(context);
  }

  searchAgent(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredAgents = agents
        .where(
          (agent) =>
              agent.email!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              agent.name!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              agent.agentNumber!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredAgents.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredAgents = agents;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateAgent(agent) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditAgent(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: agent,
        ),
      ),
    );
  }
}
