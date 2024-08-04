// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports
import 'package:intl/intl.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway.dart';
import 'package:leafguard/services/paymentgateway/paymentGatewayFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/screens/paymentgateway/edit_paymentgateway.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class PaymentGatewayTable extends StatefulWidget {
  const PaymentGatewayTable({super.key});

  @override
  State<PaymentGatewayTable> createState() => _PaymentGatewayTableState();
}

class _PaymentGatewayTableState extends State<PaymentGatewayTable> {
  List<PaymentGateway> paymentgateways = [];
  List<PaymentGateway> _filteredPaymentGateway = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  PaymentFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no paymentgateway records';
  var searchResultInvalid = 'There is no such paymentgateway';

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
      fnc = Provider.of<PaymentFactory>(context, listen: false);
      await fnc!
          .getAllPaymentGateways(fnc!.currentPage)
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
    if (_filteredPaymentGateway.isEmpty) {
      _filteredPaymentGateway = paymentgateways;
      // paymentgateways =
      //     Provider.of<PaymentFactory>(context, listen: false).paymentgateways;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchGateway,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredPaymentGateway.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshPaymentGateways(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('Gateway'),
                                        ),
                                        DataColumn(
                                          label: Text('Alias'),
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
                                        )),
                                      ],
                                      // rows: const [],
                                      rows: List.generate(
                                        _filteredPaymentGateway.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredPaymentGateway[element]
                                                    .gateway_name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredPaymentGateway[element]
                                                          .alias !=
                                                      null
                                                  ? Text(
                                                      _filteredPaymentGateway[
                                                              element]
                                                          .alias
                                                          .toString(),
                                                    )
                                                  : Text(
                                                      'No Alias'.toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              _filteredPaymentGateway[element]
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
                                                DateFormat('dd-MM-yyyy').format(
                                                    _filteredPaymentGateway[
                                                            element]
                                                        .createdAt!),
                                              ),
                                            ),
                                            DataCell(Row(
                                              children: [
                                                if (getProperty!.permissions!
                                                    .where((permission) =>
                                                        permission.module ==
                                                        'Payment Gateways')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'create'))))
                                                  IconButton(
                                                    tooltip: 'Update',
                                                    onPressed: () {
                                                      updatePaymentGateway(
                                                          _filteredPaymentGateway[
                                                              element]);
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                const VerticalDivider(),
                                                if (getProperty!.permissions!
                                                    .where((permission) =>
                                                        permission.module ==
                                                        'Payment Gateways')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'delete'))))
                                                  IconButton(
                                                    tooltip: 'Delete',
                                                    onPressed: () {
                                                      delete(
                                                          _filteredPaymentGateway[
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

  Widget get _searchGateway {
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
              searchPaymentGateway(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(PaymentFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    paymentgateways = fnc.paymentgateways;
    _filteredPaymentGateway = paymentgateways;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshPaymentGateways(BuildContext context) async {
    await fnc!
        .getAllPaymentGateways(fnc!.currentPage)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.gateway_name.toUpperCase()} from paymentgateway list');
    if (action == DialogAction.yes) {
      setState(() {
        deletePaymentGateway(element.id, ctx);
        for (int i = 0; i < _filteredPaymentGateway.length; i++) {
          if (_filteredPaymentGateway[i].id == element.id) {
            setState(() {
              _filteredPaymentGateway.remove(_filteredPaymentGateway[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deletePaymentGateway(id, ctx) async {
    final response = await Provider.of<PaymentFactory>(context, listen: false)
        .deletePaymentGateway(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchPaymentGateway(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredPaymentGateway = paymentgateways
        .where(
          (paymentgateway) => paymentgateway.gateway_name!
              .toLowerCase()
              .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredPaymentGateway.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredPaymentGateway = paymentgateways;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updatePaymentGateway(paymentgateway) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditPaymentGateway(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: paymentgateway,
        ),
      ),
    );
  }
}
