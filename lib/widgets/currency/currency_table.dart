// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports
import 'package:leafguard/models/currency/currency.dart';
import 'package:leafguard/services/currency/currencyFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/screens/currency/edit_currency.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class CurrencyTable extends StatefulWidget {
  const CurrencyTable({super.key});

  @override
  State<CurrencyTable> createState() => _CurrencyTableState();
}

class _CurrencyTableState extends State<CurrencyTable> {
  List<Currency> currencies = [];
  List<Currency> _filteredCurrencies = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  CurrencyFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no currency records';
  var searchResultInvalid = 'There is no such currency';

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<CurrencyFactory>(context, listen: false);
      await fnc!
          .getAllCurrencies(fnc!.currentPage)
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
    if (_filteredCurrencies.isEmpty) {
      _filteredCurrencies = currencies;
      // currencies =
      //     Provider.of<CurrencyFactory>(context, listen: false).currencies;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchCurrency,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredCurrencies.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshCurrencies(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Code'),
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
                                          label: Text('Symbol'),
                                        ),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            Text(''),
                                          ],
                                        )),
                                      ],
                                      // rows: const [],
                                      rows: List.generate(
                                        _filteredCurrencies.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredCurrencies[element]
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredCurrencies[element]
                                                          .code !=
                                                      null
                                                  ? Text(
                                                      _filteredCurrencies[
                                                              element]
                                                          .code
                                                          .toString()
                                                          .toUpperCase(),
                                                    )
                                                  : Text(
                                                      'No Email'.toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              _filteredCurrencies[element]
                                                          .status !=
                                                      1
                                                  ? Tooltip(
                                                      message: 'In Active',
                                                      child: Icon(
                                                        Icons.verified_sharp,
                                                        color: AppTheme.red,
                                                      ),
                                                    )
                                                  : Tooltip(
                                                      message: 'Active',
                                                      child: Icon(
                                                        Icons.verified_sharp,
                                                        color: AppTheme.green,
                                                      ),
                                                    ),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredCurrencies[element]
                                                    .symbol!,
                                              ),
                                            ),
                                            DataCell(Row(
                                              children: [
                                                IconButton(
                                                  tooltip: 'Update',
                                                  onPressed: () {
                                                    updateCurrency(
                                                        _filteredCurrencies[
                                                            element]);
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const VerticalDivider(),
                                                IconButton(
                                                  tooltip: 'Delete',
                                                  onPressed: () {
                                                    delete(
                                                        _filteredCurrencies[
                                                            element],
                                                        context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_forever,
                                                  ),
                                                ),
                                              ],
                                            )),
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

  Widget get _searchCurrency {
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
                hintText: 'Search by name', border: InputBorder.none),
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
              searchCurrency(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(CurrencyFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    currencies = fnc.currencies;
    _filteredCurrencies = currencies;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshCurrencies(BuildContext context) async {
    await fnc!
        .getAllCurrencies(getProperty!.search.page)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from currency list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteCurrency(element.id, ctx);
        for (int i = 0; i < _filteredCurrencies.length; i++) {
          if (_filteredCurrencies[i].id == element.id) {
            setState(() {
              _filteredCurrencies.remove(_filteredCurrencies[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteCurrency(id, ctx) async {
    final response = await Provider.of<CurrencyFactory>(context, listen: false)
        .deleteCurrency(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchCurrency(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredCurrencies = currencies
        .where(
          (currency) => currency.name!
              .toLowerCase()
              .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredCurrencies.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredCurrencies = currencies;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateCurrency(currency) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditCurrency(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: currency,
        ),
      ),
    );
  }
}
