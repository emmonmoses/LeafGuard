// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports

// Flutter Iports

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/customerBalance/customer.dart';
import 'package:leafguard/services/balance/balanceFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/widgets/general/paginator.dart';
import 'package:leafguard/widgets/mobile_listviews/wallet_listview.dart';

// Package Imports
import 'package:provider/provider.dart';

class CustomerBalanceTable extends StatefulWidget {
  const CustomerBalanceTable({super.key});

  @override
  State<CustomerBalanceTable> createState() => _CustomerBalanceTableState();
}

class _CustomerBalanceTableState extends State<CustomerBalanceTable> {
  List<CustomerBalance> customersBalance = [];
  List<CustomerBalance> _filteredCustomersBalance = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  BalanceFactory? fnb;
  VariableService? getProperty = VariableService();

  var searchResult = 'There are no customer balance record';
  var searchResultInvalid = 'There is no such customer balance';

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
      fnb = Provider.of<BalanceFactory>(context, listen: false);
      await fnb!
          .getCustomerBalances(fnb!.currentPage)
          .then((r) => {setVariables(fnb!)});

      setState(() {
        getProperty!.isLoading = false;
      });
      getProperty!.isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_filteredCustomersBalance.isEmpty) {
      _filteredCustomersBalance = customersBalance;
    }

    return AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)
        ? Container(
            child: getProperty!.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      _searchBalance,
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
                          child: _filteredCustomersBalance.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  child: RefreshIndicator(
                                    onRefresh: () =>
                                        refreshCustomersBalance(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: DataTable(
                                            columns: const [
                                              DataColumn(
                                                label: Text('Customer'),
                                              ),
                                              DataColumn(
                                                label: Text('No.#'),
                                              ),
                                              DataColumn(
                                                label: Text('Balance'),
                                              ),
                                              DataColumn(
                                                label: Text('Last Recharge'),
                                              ),
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  Text(''),
                                                ],
                                              )),
                                            ],
                                            rows: List.generate(
                                              _filteredCustomersBalance.length,
                                              (element) => DataRow(
                                                cells: [
                                                  DataCell(
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color: _filteredCustomersBalance[
                                                                              element]
                                                                          .customerBalance ==
                                                                      0
                                                                  ? AppTheme.red
                                                                  : AppTheme
                                                                      .green,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                              '${ApiEndPoint.getCustomerImage}/${_filteredCustomersBalance[element].customer!.avatar}',
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 8.0,
                                                          ),
                                                          child: _filteredCustomersBalance[
                                                                          element]
                                                                      .customer!
                                                                      .name !=
                                                                  null
                                                              ? Text(
                                                                  _filteredCustomersBalance[
                                                                          element]
                                                                      .customer!
                                                                      .name!
                                                                      .toUpperCase(),
                                                                )
                                                              : Text(
                                                                  _filteredCustomersBalance[
                                                                          element]
                                                                      .customer!
                                                                      .username!
                                                                      .toUpperCase(),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8.0,
                                                      ),
                                                      child: Text(
                                                        _filteredCustomersBalance[
                                                                element]
                                                            .customer!
                                                            .customerNumber!
                                                            .toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    _filteredCustomersBalance[
                                                                    element]
                                                                .customerBalance !=
                                                            null
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10),
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: _filteredCustomersBalance[
                                                                              element]
                                                                          .customerBalance ==
                                                                      0
                                                                  ? AppTheme
                                                                      .black
                                                                  : AppTheme
                                                                      .main,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'ETB.${_filteredCustomersBalance[element].customerBalance!.toStringAsFixed(2)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppTheme
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10),
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: _filteredCustomersBalance[
                                                                              element]
                                                                          .customerBalance ==
                                                                      0
                                                                  ? AppTheme
                                                                      .black
                                                                  : AppTheme
                                                                      .main,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                50,
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '\$.${0.toStringAsFixed(2)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppTheme
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      _filteredCustomersBalance[
                                                                      element]
                                                                  .transactionDate !=
                                                              null
                                                          ? DateFormat(
                                                                  'dd-MM-yyyy hh:mm:ss a')
                                                              .format(_filteredCustomersBalance[
                                                                      element]
                                                                  .transactionDate!)
                                                          : 'None',
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Row(
                                                      children: [
                                                        if (getProperty!
                                                            .permissions!
                                                            .where((permission) =>
                                                                permission
                                                                    .module ==
                                                                'Customers Wallet')
                                                            .any((p) => p
                                                                .actions!
                                                                .any((action) =>
                                                                    action.name!
                                                                        .contains(
                                                                            'create'))))
                                                          IconButton(
                                                            tooltip:
                                                                'Recharge Wallet',
                                                            onPressed: () {
                                                              RouteService
                                                                  .rechargeCustomerBalance(
                                                                context,
                                                                _filteredCustomersBalance[
                                                                        element]
                                                                    .id,
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.add_card,
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
                        previous: fnb!.isPrevious ? goPrevious : null,
                        next: fnb!.isNextable ? goNext : null,
                      ),
                    ],
                  ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: BalanceListView(),
                ),
              ],
            ),
          );
  }

  Widget get _searchBalance {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.black,
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
                hintText: 'Search by customer or customerNo',
                border: InputBorder.none),
          ),
        ),
        trailing: IconButton(
          tooltip: 'Click to Search',
          icon: Icon(Icons.search, color: AppTheme.main),
          onPressed: () {
            setState(() {
              searchBalance(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(BalanceFactory fnb) {
    pages = fnb.totalPages;
    page = fnb.currentPage;
    customersBalance = fnb.customersbalance;
    _filteredCustomersBalance =
        customersBalance.where((client) => client.customer != null).toList();
  }

  goNext() {
    fnb!.goNextCustomer().then((value) => setState(() => setVariables(fnb!)));
  }

  goPrevious() {
    fnb!
        .goPreviousCustomer()
        .then((value) => setState(() => setVariables(fnb!)));
  }

  refreshCustomersBalance(BuildContext context) async {
    await fnb!
        .getCustomerBalances(fnb!.currentPage)
        .then((r) => {setVariables(fnb!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'Delete ${element.customerNumber.toUpperCase()}',
        'Are you sure you wish to delete ${element.customerNumber.toUpperCase()} from the customer balance list?');
    if (action == DialogAction.yes) {
      setState(() {
        deleteBalance(element.id, ctx);
        for (int i = 0; i < _filteredCustomersBalance.length; i++) {
          if (_filteredCustomersBalance[i].id == element.id) {
            setState(() {
              _filteredCustomersBalance.remove(_filteredCustomersBalance[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteBalance(id, ctx) async {
    final response = await Provider.of<BalanceFactory>(context, listen: false)
        .deleteBalanceCustomer(id);
    snackBarNotification(ctx, ToasterService.successMsg);

    return response;
  }

  searchBalance(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredCustomersBalance = customersBalance
        .where(
          (cus) =>
              cus.customer!.name!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              cus.customer!.customerNumber!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredCustomersBalance.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredCustomersBalance =
          customersBalance.where((client) => client.customer != null).toList();

      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
