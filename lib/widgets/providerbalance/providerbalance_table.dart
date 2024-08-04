// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports

// Flutter Iports

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/providerBalance/provider.dart';
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

class ProviderBalanceTable extends StatefulWidget {
  const ProviderBalanceTable({super.key});

  @override
  State<ProviderBalanceTable> createState() => _ProviderBalanceTableState();
}

class _ProviderBalanceTableState extends State<ProviderBalanceTable> {
  List<ProviderBalance> providersBalance = [];
  List<ProviderBalance> _filteredProvidersBalance = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  BalanceFactory? fnb;
  VariableService? getProperty = VariableService();

  var searchResult = 'There are no provider balance record';
  var searchResultInvalid = 'There is no such provider balance';

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
          .getTaskerBalances(fnb!.currentPage)
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
    if (_filteredProvidersBalance.isEmpty) {
      _filteredProvidersBalance = providersBalance;
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
                          child: _filteredProvidersBalance.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  child: RefreshIndicator(
                                    onRefresh: () =>
                                        refreshAgentsBalance(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: DataTable(
                                            columns: const [
                                              DataColumn(
                                                label: Text('Provider'),
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
                                              _filteredProvidersBalance.length,
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
                                                              color: _filteredProvidersBalance[
                                                                              element]
                                                                          .taskerBalance ==
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
                                                              '${ApiEndPoint.getProviderImage}/${_filteredProvidersBalance[element].tasker!.avatar}',
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 8.0,
                                                          ),
                                                          child: _filteredProvidersBalance[
                                                                          element]
                                                                      .tasker!
                                                                      .name !=
                                                                  null
                                                              ? Text(
                                                                  _filteredProvidersBalance[
                                                                          element]
                                                                      .tasker!
                                                                      .name!
                                                                      .toUpperCase(),
                                                                )
                                                              : Text(
                                                                  _filteredProvidersBalance[
                                                                          element]
                                                                      .tasker!
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
                                                        _filteredProvidersBalance[
                                                                element]
                                                            .tasker!
                                                            .taskerNumber!
                                                            .toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    _filteredProvidersBalance[
                                                                    element]
                                                                .taskerBalance !=
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
                                                              color: _filteredProvidersBalance[
                                                                              element]
                                                                          .taskerBalance ==
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
                                                                'ETB.${_filteredProvidersBalance[element].taskerBalance!.toStringAsFixed(2)}',
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
                                                              color: _filteredProvidersBalance[
                                                                              element]
                                                                          .taskerBalance ==
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
                                                      _filteredProvidersBalance[
                                                                      element]
                                                                  .transactionDate !=
                                                              null
                                                          ? DateFormat(
                                                                  'dd-MM-yyyy hh:mm:ss a')
                                                              .format(_filteredProvidersBalance[
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
                                                                'Providers Wallet')
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
                                                                  .rechargeProviderBalance(
                                                                context,
                                                                _filteredProvidersBalance[
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
                hintText: 'Search by provider or providerNo',
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
    providersBalance = fnb.providersbalance;
    _filteredProvidersBalance =
        providersBalance.where((provider) => provider.tasker != null).toList();
  }

  goNext() {
    fnb!.goNext().then((value) => setState(() => setVariables(fnb!)));
  }

  goPrevious() {
    fnb!.goPrevious().then((value) => setState(() => setVariables(fnb!)));
  }

  refreshAgentsBalance(BuildContext context) async {
    await fnb!
        .getTaskerBalances(fnb!.currentPage)
        .then((r) => {setVariables(fnb!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'Delete ${element.businessName.toUpperCase()}',
        'Are you sure you wish to delete ${element.businessName.toUpperCase()} from the providers balance list?');
    if (action == DialogAction.yes) {
      setState(() {
        deleteBalance(element.id, ctx);
        for (int i = 0; i < _filteredProvidersBalance.length; i++) {
          if (_filteredProvidersBalance[i].id == element.id) {
            setState(() {
              _filteredProvidersBalance.remove(_filteredProvidersBalance[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteBalance(id, ctx) async {
    final response = await Provider.of<BalanceFactory>(context, listen: false)
        .deleteBalanceTasker(id);
    snackBarNotification(ctx, ToasterService.successMsg);

    return response;
  }

  searchBalance(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredProvidersBalance = providersBalance
        .where(
          (provider) =>
              provider.tasker!.name!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              provider.tasker!.taskerNumber!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredProvidersBalance.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredProvidersBalance = providersBalance
          .where((provider) => provider.tasker != null)
          .toList();

      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
