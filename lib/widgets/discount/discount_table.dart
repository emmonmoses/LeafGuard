// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports

import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/screens/discount/edit_discount.dart';
import 'package:leafguard/services/discount/discountFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class DiscountTable extends StatefulWidget {
  const DiscountTable({super.key});

  @override
  State<DiscountTable> createState() => _DiscountTableState();
}

class _DiscountTableState extends State<DiscountTable> {
  List<Discount> discounts = [];
  List<Discount> _filteredDiscounts = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  DiscountFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no discount records';
  var searchResultInvalid = 'There is no such discount';

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
      fnc = Provider.of<DiscountFactory>(context, listen: false);
      await fnc!
          .getAllDiscounts(fnc!.currentPage)
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
    if (_filteredDiscounts.isEmpty) {
      _filteredDiscounts = discounts;
      // discounts =
      //     Provider.of<DiscountFactory>(context, listen: false).discounts;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchDiscount,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredDiscounts.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshDiscounts(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('Discount'),
                                        ),
                                        // const DataColumn(
                                        //   label: Text('Type'),
                                        // ),
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
                                        _filteredDiscounts.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                  '${_filteredDiscounts[element].name!}(${_filteredDiscounts[element].code!})'
                                                      .toUpperCase()),
                                            ),
                                            DataCell(
                                              Text(
                                                '${_filteredDiscounts[element].amount_percentage!}%'
                                                    .toString()
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredDiscounts[element]
                                                            .description!
                                                            .length >
                                                        37
                                                    ? _filteredDiscounts[
                                                            element]
                                                        .description!
                                                        .substring(0, 37)
                                                    : _filteredDiscounts[
                                                            element]
                                                        .description!
                                                        .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredDiscounts[element]
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
                                                if (getProperty!.permissions!
                                                    .where((permission) =>
                                                        permission.module ==
                                                        'Discounts')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'create'))))
                                                  IconButton(
                                                    tooltip: 'Update',
                                                    onPressed: () {
                                                      updateDiscount(
                                                          _filteredDiscounts[
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
                                                        'Discounts')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'delete')))) ...{
                                                  const VerticalDivider(),
                                                  IconButton(
                                                    tooltip: 'Delete',
                                                    onPressed: () {
                                                      delete(
                                                          _filteredDiscounts[
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

  Widget get _searchDiscount {
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
              searchDiscount(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(DiscountFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    discounts = fnc.discounts;
    _filteredDiscounts = discounts;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshDiscounts(BuildContext context) async {
    await fnc!
        .getAllDiscounts(fnc!.currentPage)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from discount list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteDiscount(element.id, ctx);
        for (int i = 0; i < _filteredDiscounts.length; i++) {
          if (_filteredDiscounts[i].id == element.id) {
            setState(() {
              _filteredDiscounts.remove(_filteredDiscounts[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteDiscount(id, ctx) async {
    final response = await Provider.of<DiscountFactory>(context, listen: false)
        .deleteDiscount(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchDiscount(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredDiscounts = discounts
        .where(
          (currency) => currency.name!
              .toLowerCase()
              .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredDiscounts.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredDiscounts = discounts;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateDiscount(currency) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditDiscount(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: currency,
        ),
      ),
    );
  }
}
