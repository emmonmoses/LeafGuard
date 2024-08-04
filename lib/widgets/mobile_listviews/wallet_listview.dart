// Flutter Iports
// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/providerBalance/provider.dart';
import 'package:leafguard/services/balance/balanceFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/widgets/general/paginator.dart';
import 'package:provider/provider.dart';

class BalanceListView extends StatefulWidget {
  const BalanceListView({
    super.key,
  });

  @override
  State<BalanceListView> createState() => _BalanceTableState();
}

class _BalanceTableState extends State<BalanceListView> {
  List<ProviderBalance> agentsBalance = [];
  List<ProviderBalance> filteredBalances = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  BalanceFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no balance balance records';
  var searchResultInvalid = 'There is no such balance balance';
  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<BalanceFactory>(context);
      fnc!
          .getTaskerBalances(getProperty!.search.page)
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
    if (filteredBalances.isEmpty) {
      filteredBalances = agentsBalance;
    }

    return Scaffold(
      body: Column(
        children: [
          _searchBalance,
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: filteredBalances.length,
              itemBuilder: (context, index) {
                ProviderBalance balance = filteredBalances[index];
                return Visibility(
                  visible: getProperty!.isVisible,
                  child: InkWell(
                    onTap: () {
                      RouteService.rechargeProviderBalance(
                        context,
                        balance.id,
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.kDefaultPadding * 0.75,
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: balance.taskerBalance == 0
                                        ? AppTheme.red
                                        : AppTheme.main,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    '${ApiEndPoint.getProviderImage}/${balance.tasker!.avatar}',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(balance.tasker!.name!),
                              ),
                            ],
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: balance.taskerBalance == 0
                                  ? AppTheme.black
                                  : AppTheme.main,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '\$.${balance.taskerBalance!.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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

  Widget get _searchBalance {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppTheme.kDefaultPadding * 0.75),
      child: Card(
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
          title: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                hintText: 'Search by name or email', border: InputBorder.none),
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
      ),
    );
  }

  void setVariables(BalanceFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    agentsBalance = fnc.providersbalance;
    filteredBalances = agentsBalance
        .where((balance) => balance.tasker!.role != 'admin')
        .toList();
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshBalances(BuildContext context) async {
    await fnc!
        .getTaskerBalances(getProperty!.search.page)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'Delete ${element.businessName.toUpperCase()}',
        'Are you sure you wish to delete ${element.businessName.toUpperCase()} from the agentsBalance balance list?');
    if (action == DialogAction.yes) {
      setState(() {
        deleteBalance(element.id, ctx);
      });
    } else {
      setState(() => null);
    }
  }

  deleteBalance(id, ctx) async {
    final response = await Provider.of<BalanceFactory>(context, listen: false)
        .deleteBalanceTasker(id);
    snackBarNotification(ctx, ToasterService.successMsg);

    return response;
  }

  searchBalance(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    filteredBalances = agentsBalance
        .where(
          (balance) =>
              balance.tasker!.email!
                      .toLowerCase()
                      .contains(getProperty!.search.searchText) &&
                  balance.tasker!.role != 'admin' ||
              balance.tasker!.name!
                      .toLowerCase()
                      .contains(getProperty!.search.searchText) &&
                  balance.tasker!.role != 'admin',
        )
        .toList();

    if (filteredBalances.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      filteredBalances = agentsBalance
          .where((balance) => balance.tasker!.role != 'admin')
          .toList();
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
