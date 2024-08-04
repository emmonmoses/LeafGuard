// Flutter Iports
// ignore_for_file: avoid_returning_null_for_void, unused_local_variable

import 'package:flutter/material.dart';
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/models/transactions/transaction.dart';
import 'package:leafguard/services/report/reportFactory.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/paginator.dart';
import 'package:provider/provider.dart';

class TransactionByAgentReport extends StatefulWidget {
  const TransactionByAgentReport({
    super.key,
  });

  @override
  State<TransactionByAgentReport> createState() =>
      _TransactionByAgentReportState();
}

class _TransactionByAgentReportState extends State<TransactionByAgentReport> {
  List<Agent> agents = [];
  List<Transaction> transactions = [];
  List<Transaction> _filteredTransactions = [];

  int page = 1, pages = 1;
  ReportFactory? fnc;
  VariableService? getProperty = VariableService();

  String? dropdownValue;
  String? reportName = 'agents', agentNumber = '';

  var searchResult = 'There are no ticket records';
  var searchResultInvalid = 'There is no such ticket record';
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<ReportFactory>(context, listen: false);
      await fnc!
          .getTransactionsByCreator(agentNumber, fnc!.currentPageATrans)
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

    return Scaffold(
      body: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchTransaction,
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: _filteredTransactions.length,
                    itemBuilder: (context, index) {
                      Transaction transact = _filteredTransactions[index];
                      return Visibility(
                        visible: getProperty!.isVisible,
                        child: const Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppTheme.kDefaultPadding * 0.75,
                            ),
                            // child: ListTile(
                            //   leading: transact.passengers!.isNotEmpty
                            //       ? Text(
                            //           transact.passengers!.length.toString(),
                            //           style: TextStyle(
                            //             color: transact.paymentStatus
                            //                 ? AppTheme.red
                            //                 : AppTheme.main,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         )
                            //       : Text(
                            //           '0',
                            //           style: TextStyle(
                            //             color: AppTheme.black,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //   title: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(transact.agent!.businessName!),
                            //       transact.bookingReference != null
                            //           ? Text(
                            //               transact.bookingReference
                            //                   .toString()
                            //                   .toUpperCase(),
                            //             )
                            //           : Text(
                            //               'No TransactionReference'.toUpperCase(),
                            //             ),
                            //     ],
                            //   ),
                            //   trailing: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         '${transact.totalTaxCurrency}.${double.parse(transact.totalAmount.toString()).toStringAsFixed(2)}',
                            //         style: TextStyle(
                            //           color: transact.paymentStatus
                            //               ? AppTheme.red
                            //               : AppTheme.main,
                            //         ),
                            //       ),
                            //       transact.booking!.airplaneName != null
                            //           ? Text(
                            //               transact.booking!.airplaneName
                            //                   .toString()
                            //                   .toUpperCase(),
                            //             )
                            //           : Text(
                            //               'No Airline'.toUpperCase(),
                            //             ),
                            //     ],
                            //   ),
                            // ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                PaginationWidget(
                  page: page,
                  pages: pages,
                  previous: fnc!.isPrevious ? goPreviousTransaction : null,
                  next: fnc!.isNextable ? goNextTransaction : null,
                ),
              ],
            ),
    );
  }

  Widget get _searchTransaction {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.black,
        // borderRadius: BorderRadius.circular(50),
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
                  Agent selectedAgent =
                      agents.firstWhere((agent) => agent.id == newValue);
                  searchController.text = selectedAgent.id!;
                  filterTransaction(selectedAgent.id!);
                  reportName = selectedAgent.agentNumber.toString();
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
                  value: agent.id,
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

  void setTransaction(ReportFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPageATrans;
    transactions = fnc.transactions;
    _filteredTransactions = transactions;
  }

  goNextAgent() {
    fnc!.goNextAgent().then((value) => setState(() => setAgents(fnc!)));
  }

  goPreviousAgent() {
    fnc!.goPreviousAgent().then((value) => setState(() => setAgents(fnc!)));
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

  refreshTransactions(BuildContext context) async {
    await fnc!
        .getTransactionsByCreator(agentNumber, fnc!.currentPageATrans)
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
}
