// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports
import 'package:leafguard/models/transactions/transaction.dart';
import 'package:leafguard/services/transaction/transactionFactory.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/transactions/transaction_preview.dart';
import 'package:provider/provider.dart';

class TransactionTable extends StatefulWidget {
  const TransactionTable({super.key});

  @override
  State<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
  List<Transaction> transactions = [];
  List<Transaction> _filteredTransactions = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  TransactionFactory? fnc;
  VariableService? getProperty = VariableService();
  String? searchResult = 'There are no transaction records';
  String? searchResultInvalid = 'There is no such transaction';
  String? reportName = 'serviceproviders';

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<TransactionFactory>(context, listen: false);
      await fnc!
          .getTransactions(fnc!.currentPage)
          .then((r) => {setVariables(fnc!)});

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

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchUser,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredTransactions.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshTransactions(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                          label: Text('Pr.Comm'),
                                        ),
                                        DataColumn(
                                          label: Text('Amount'),
                                        ),
                                        DataColumn(
                                          label: Row(
                                            children: [
                                              Text(''),
                                            ],
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                        _filteredTransactions.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              _filteredTransactions[element]
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
                                              _filteredTransactions[element]
                                                          .price !=
                                                      null
                                                  ? Text(
                                                      "Etb.${double.parse(_filteredTransactions[element].price.toString()).toStringAsFixed(2)}"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: AppTheme.main,
                                                      ),
                                                    )
                                                  : Text(
                                                      'No Price'.toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              _filteredTransactions[element]
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
                                                'Etb.${_filteredTransactions[element].taskerCommission!.amount}'
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  color: AppTheme.main,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredTransactions[element]
                                                          .total !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Container(
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: AppTheme.main,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${_filteredTransactions[element].total}'
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
                                              Row(
                                                children: [
                                                  IconButton(
                                                    tooltip: 'Details',
                                                    onPressed: () {
                                                      showModalSideSheet(
                                                        context: context,
                                                        width: 600,
                                                        ignoreAppBar: true,
                                                        body: PreviewTransaction(
                                                            transaction:
                                                                _filteredTransactions[
                                                                    element]),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .remove_red_eye_sharp,
                                                    ),
                                                  ),
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
                              searchResult!,
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
                        searchResultInvalid!,
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

  Widget get _searchUser {
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
                hintText: 'Search by transactionRef', border: InputBorder.none),
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
              searchTransaction(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(TransactionFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    transactions = fnc.transactions!;
    _filteredTransactions = transactions;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshTransactions(BuildContext context) async {
    await fnc!.getTransactions(fnc!.currentPage).then((r) => {
          setVariables(fnc!),
        });
  }

  searchTransaction(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredTransactions = transactions
        .where(
          (trn) =>
              // trn.bookingRef!
              //     .toLowerCase()
              //     .contains(getProperty!.search.searchText) ||
              trn.transactionRef!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredTransactions.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredTransactions = transactions;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
