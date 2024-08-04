// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports

import 'package:intl/intl.dart';
import 'package:leafguard/models/billing/billing.dart';
import 'package:leafguard/screens/billing/edit_billing.dart';
import 'package:leafguard/services/billing/billingFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class BillingTable extends StatefulWidget {
  const BillingTable({super.key});

  @override
  State<BillingTable> createState() => _BillingTableState();
}

class _BillingTableState extends State<BillingTable> {
  List<Billing> billings = [];
  List<Billing> _filteredBillings = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  BillingFactory? fnc;
  String? dropdownValue;
  // String? billingName = '2023-08-17:2024-08-16';

  VariableService? getProperty = VariableService();
  var searchResult = 'There are no billing records';
  var searchResultInvalid = 'There is no such billing';

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<BillingFactory>(context);
      await fnc!
          .getAllBillings(fnc!.currentPage)
          .then((r) => {setBilling(fnc!)});

      setState(() {
        getProperty!.isLoading = false;
      });
      getProperty!.isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_filteredBillings.isEmpty) {
      _filteredBillings = billings;
      // billings =
      //     Provider.of<BillingFactory>(context, listen: false).billings;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchBilling,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredBillings.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshBillings(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('Billing Perion'),
                                        ),
                                        DataColumn(
                                          label: Text('Start'),
                                        ),
                                        DataColumn(
                                          label: Text('End'),
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
                                        _filteredBillings.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(_filteredBillings[element]
                                                  .billingcycyle!
                                                  .toUpperCase()),
                                            ),
                                            DataCell(
                                              Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                  _filteredBillings[element]
                                                      .start_date!,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                  _filteredBillings[element]
                                                      .end_date!,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredBillings[element]
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
                                            DataCell(Row(
                                              children: [
                                                IconButton(
                                                  tooltip: 'Update',
                                                  onPressed: () {
                                                    updateBilling(
                                                        _filteredBillings[
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
                                                        _filteredBillings[
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

  Widget get _searchBilling {
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
              clearFilter();
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
                hintText: 'Search by name or email', border: InputBorder.none),
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
              filterBilling(searchController.text);
            });
          },
        ),
      ),
    );
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setBilling(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setBilling(fnc!)));
  }

  refreshBillings(BuildContext context) async {
    await fnc!.getAllBillings(fnc!.currentPage).then((r) => {setBilling(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
      context,
      'DeleteConfirmation',
      'Are you sure you wish to delete ${element.billingcycyle} from billing list',
    );
    if (action == DialogAction.yes) {
      setState(() {
        deleteBilling(element.id, ctx);
        for (int i = 0; i < _filteredBillings.length; i++) {
          if (_filteredBillings[i].id == element.id) {
            setState(() {
              _filteredBillings.remove(_filteredBillings[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteBilling(id, ctx) async {
    final response = await Provider.of<BillingFactory>(context, listen: false)
        .deleteBilling(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  void setBilling(BillingFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    billings = fnc.billings;
    _filteredBillings = billings;
  }

  refreshBilling(BuildContext context) async {
    await fnc!
        .getAllBillings(getProperty!.search.page)
        .then((r) => {setBilling(fnc!)});
  }

  filterBilling(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredBillings = billings
        .where(
          (bill) =>
              bill.billingcycyle!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              bill.billingcycyle!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredBillings.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearFilter() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredBillings = billings;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateBilling(currency) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditBilling(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: currency,
        ),
      ),
    );
  }
}
