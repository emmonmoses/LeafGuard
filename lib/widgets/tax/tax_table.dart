// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports

import 'package:leafguard/models/tax/tax.dart';
import 'package:leafguard/screens/tax/edit_tax.dart';
import 'package:leafguard/services/tax/taxFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class TaxTable extends StatefulWidget {
  const TaxTable({super.key});

  @override
  State<TaxTable> createState() => _TaxTableState();
}

class _TaxTableState extends State<TaxTable> {
  List<Tax> taxes = [];
  List<Tax> _filteredTaxes = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  TaxFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no tax records';
  var searchResultInvalid = 'There is no such tax';

  @override
  void initState() {
    getProperty!.getPermissions(context);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // fnc!.currentPage = 1;

    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<TaxFactory>(context, listen: false);
      await fnc!
          .getAllTaxes(fnc!.currentPage)
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
    if (_filteredTaxes.isEmpty) {
      _filteredTaxes = taxes;
      // taxes =
      //     Provider.of<TaxFactory>(context, listen: false).taxes;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchTax,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredTaxes.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshTaxs(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('Tax'),
                                        ),
                                        DataColumn(
                                          label: Text('Rate'),
                                        ),
                                        DataColumn(
                                          label: Text('Description'),
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
                                            label: Row(
                                          children: [
                                            Text(''),
                                          ],
                                        )),
                                      ],
                                      // rows: const [],
                                      rows: List.generate(
                                        _filteredTaxes.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(_filteredTaxes[element]
                                                  .name!
                                                  .toUpperCase()),
                                            ),
                                            DataCell(
                                              Text(
                                                '${_filteredTaxes[element].amount_percentage!}%'
                                                    .toString()
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredTaxes[element]
                                                            .description!
                                                            .length >
                                                        37
                                                    ? _filteredTaxes[element]
                                                        .description!
                                                        .substring(0, 37)
                                                    : _filteredTaxes[element]
                                                        .description!
                                                        .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredTaxes[element].status !=
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
                                            DataCell(Row(
                                              children: [
                                                if (getProperty!.permissions!
                                                    .where((permission) =>
                                                        permission.module ==
                                                        'Taxes')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'create'))))
                                                  IconButton(
                                                    tooltip: 'Update',
                                                    onPressed: () {
                                                      updateTax(_filteredTaxes[
                                                          element]);
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                if (getProperty!.permissions!
                                                    .where((permission) =>
                                                        permission.module ==
                                                        'Taxes')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'delete')))) ...{
                                                  const VerticalDivider(),
                                                  IconButton(
                                                    tooltip: 'Delete',
                                                    onPressed: () {
                                                      delete(
                                                          _filteredTaxes[
                                                              element],
                                                          context);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                    ),
                                                  ),
                                                }
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

  Widget get _searchTax {
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
              searchTax(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(TaxFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    taxes = fnc.taxes;
    _filteredTaxes = taxes;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshTaxs(BuildContext context) async {
    await fnc!.getAllTaxes(fnc!.currentPage).then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from tax list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteTax(element.id, ctx);
        for (int i = 0; i < _filteredTaxes.length; i++) {
          if (_filteredTaxes[i].id == element.id) {
            setState(() {
              _filteredTaxes.remove(_filteredTaxes[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteTax(id, ctx) async {
    final response =
        await Provider.of<TaxFactory>(context, listen: false).deleteTax(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchTax(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredTaxes = taxes
        .where(
          (currency) => currency.name!
              .toLowerCase()
              .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredTaxes.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredTaxes = taxes;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateTax(currency) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditTax(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: currency,
        ),
      ),
    );
  }
}
