// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, library_prefixes
// Projects Imports
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/models/transactions/transaction.dart';
import 'package:leafguard/services/report/reportFactory.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/mobile_listviews/transaction_agent_report.dart';
import 'package:provider/provider.dart';

class ReportTransactionAgentTable extends StatefulWidget {
  const ReportTransactionAgentTable({super.key});

  @override
  State<ReportTransactionAgentTable> createState() =>
      _ReportTransactionAgentTableState();
}

class _ReportTransactionAgentTableState
    extends State<ReportTransactionAgentTable> {
  List<Agent> agents = [];
  List<Transaction> transactions = [];
  List<Transaction> _filteredTransactions = [];

  int page = 1, pages = 1;
  ReportFactory? fnc;
  VariableService? getProperty = VariableService();

  String? dropdownValue;
  String? reportName = 'agents', agentNumber = '';
  var searchResult = 'There are no transaction records';
  var searchResultInvalid = 'There is no such transaction record';
  TextEditingController searchController = TextEditingController();

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<ReportFactory>(context, listen: false);
      await fnc!
          .getTransactions(fnc!.currentPageTrans)
          .then((r) => {setTransaction(fnc!)});

      await fnc!
          .getAgents(fnc!.currentPageAgent)
          .then((r) => {setAgents(fnc!)});

      setState(() {
        getProperty!.isLoading = false;
      });
      getProperty!.isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_filteredTransactions.isEmpty) {
      _filteredTransactions = transactions;
    }

    return AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)
        ? Container(
            child: getProperty!.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      _searchTransaction,
                      Visibility(
                        visible: getProperty!.isVisible,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: _filteredTransactions.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  child: RefreshIndicator(
                                    onRefresh: () =>
                                        refreshTransactions(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: DataTable(
                                            columns: const [
                                              DataColumn(
                                                label: Text('TRRef#'),
                                              ),
                                              DataColumn(
                                                label: Text('Price'),
                                              ),
                                              DataColumn(
                                                label: Text('No.Hrs'),
                                              ),
                                              DataColumn(
                                                label: Text('BasePrice'),
                                              ),
                                              DataColumn(
                                                label: Text('Tax'),
                                              ),
                                              DataColumn(
                                                label: Text('Comm'),
                                              ),
                                              DataColumn(
                                                label: Text('Ag.Comm'),
                                              ),
                                              DataColumn(
                                                label: Text('Amount'),
                                              ),
                                              DataColumn(
                                                label: Text(''),
                                              ),
                                            ],
                                            rows: List.generate(
                                              _filteredTransactions.length,
                                              (element) => DataRow(
                                                cells: [
                                                  DataCell(
                                                    _filteredTransactions[
                                                                    element]
                                                                .transactionRef !=
                                                            null
                                                        ? Text(
                                                            _filteredTransactions[
                                                                    element]
                                                                .transactionRef
                                                                .toString()
                                                                .toUpperCase(),
                                                          )
                                                        : Text(
                                                            'No TransactionReference'
                                                                .toUpperCase(),
                                                          ),
                                                  ),
                                                  DataCell(
                                                    _filteredTransactions[
                                                                    element]
                                                                .price !=
                                                            null
                                                        ? Text(
                                                            "Etb.${double.parse(_filteredTransactions[element].price.toString()).toStringAsFixed(2)}"
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  AppTheme.main,
                                                            ),
                                                          )
                                                        : Text(
                                                            'No Price'
                                                                .toUpperCase(),
                                                          ),
                                                  ),
                                                  DataCell(
                                                    _filteredTransactions[
                                                                    element]
                                                                .totalHoursWorked !=
                                                            null
                                                        ? Text(
                                                            _filteredTransactions[
                                                                    element]
                                                                .totalHoursWorked
                                                                .toString()
                                                                .toUpperCase(),
                                                          )
                                                        : Text(
                                                            'No Hours Worked'
                                                                .toUpperCase(),
                                                          ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      'Etb.${_filteredTransactions[element].basePrice}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: AppTheme.main,
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      'Etb.${_filteredTransactions[element].tax!.amount}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: AppTheme.main,
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      'Etb.${_filteredTransactions[element].adminCommission!.amount}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: AppTheme.main,
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      'Etb.${_filteredTransactions[element].agentCommission!.amount}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: AppTheme.main,
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    _filteredTransactions[
                                                                    element]
                                                                .total !=
                                                            null
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 8.0),
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: AppTheme
                                                                    .main,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Etb.${_filteredTransactions[element].total}'
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      color: AppTheme
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const Text(
                                                            '',
                                                          ),
                                                  ),
                                                  DataCell(
                                                    IconButton(
                                                      tooltip: 'Print Receipt',
                                                      icon: const Icon(
                                                        Icons.print,
                                                      ),
                                                      onPressed: () {
                                                        getProperty?.printTransactionPDF(
                                                            _filteredTransactions[
                                                                element],
                                                            _filteredTransactions[
                                                                    element]
                                                                .transactionRef);
                                                      },
                                                    ),
                                                  )
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                        previous:
                            fnc!.isPrevious ? goPreviousTransaction : null,
                        next: fnc!.isNextable ? goNextTransaction : null,
                      ),
                    ],
                  ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Flex(
              direction: Axis.vertical,
              children: [
                Expanded(child: TransactionByAgentReport()),
              ],
            ),
          );
  }

  Widget get _searchTransaction {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.black,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListTile(
        leading: IconButton(
          tooltip: 'Clear Filter',
          icon: Icon(
            Icons.cancel,
            color: AppTheme.main,
          ),
          onPressed: () {
            clearFilter(context);
          },
        ),
        title: Container(
          padding: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            color: AppTheme.white,
          ),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(
              Icons.arrow_drop_down,
              color: AppTheme.black,
            ),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 0,
              color: AppTheme.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
                if (newValue != null) {
                  Agent selectedAgent = agents
                      .firstWhere((agent) => agent.agentNumber == newValue);
                  searchController.text = selectedAgent.agentNumber!;
                  filterTransaction(selectedAgent.agentNumber!);
                  reportName = selectedAgent.agentNumber;
                } else {
                  searchController.text = '';
                }
              });
            },
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('Filter by agent'),
              ),
              ...agents.map<DropdownMenuItem<String>>((Agent agent) {
                return DropdownMenuItem<String>(
                  value: agent.agentNumber,
                  child: Text(agent.agentNumber!),
                );
              }).toList(),
            ],
          ),
        ),
        trailing: IconButton(
          tooltip: 'Generate PDF',
          icon: Icon(
            Icons.print,
            color: AppTheme.main,
          ),
          onPressed: () {
            getProperty?.generateAgentTransactionPDF(
                _filteredTransactions, reportName);
          },
        ),
      ),
    );
  }

  void setAgents(ReportFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPageAgent;
    agents = fnc.agents.where((agent) => agent.role != 'admin').toList();
  }

  goNextAgent() {
    fnc!.goNextAgent().then((value) => setState(() => setAgents(fnc!)));
  }

  goPreviousAgent() {
    fnc!.goPreviousAgent().then((value) => setState(() => setAgents(fnc!)));
  }

  void setTransaction(ReportFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPageTrans;
    transactions = fnc.transactions;
    _filteredTransactions = transactions
        .where(
          (trn) => trn.createdBy!.startsWith('AG'),
        )
        .toList();
  }

  refreshTransactions(BuildContext context) async {
    await fnc!
        .getTransactions(fnc!.currentPageTrans)
        .then((r) => {setTransaction(fnc!)});
  }

  filterTransaction(String val) {
    fnc = Provider.of<ReportFactory>(context, listen: false);
    fnc!.getTransactionsByCreator(val, fnc!.currentPageATrans).then(
          (r) => setState(
            () => setTransaction(fnc!),
          ),
        );
  }

  clearFilter(BuildContext contex) {
    refreshTransactions(contex);
    setState(() {
      dropdownValue = null;
      reportName = 'agents';
    });
  }

  goNextTransaction() {
    fnc!
        .goNextAgentTransaction()
        .then((value) => setState(() => setTransaction(fnc!)));
  }

  goPreviousTransaction() {
    fnc!
        .goPreviousAgentTransaction()
        .then((value) => setState(() => setTransaction(fnc!)));
  }
}
