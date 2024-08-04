// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports
import 'package:leafguard/models/service/service.dart';
import 'package:leafguard/services/services/serviceFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/service/service_preview.dart';

// Package Imports
import 'package:provider/provider.dart';

class ServiceTable extends StatefulWidget {
  const ServiceTable({super.key});

  @override
  State<ServiceTable> createState() => _ServiceTableState();
}

class _ServiceTableState extends State<ServiceTable> {
  List<Service> services = [];
  List<Service> _filteredServices = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  ServiceFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no service records';
  var searchResultInvalid = 'There is no such service record';

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
      fnc = Provider.of<ServiceFactory>(context, listen: false);
      await fnc!
          .getAllServices(fnc!.currentPage)
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
    if (_filteredServices.isEmpty) {
      _filteredServices = services;
      // services =
      //     Provider.of<ServiceFactory>(context, listen: false)
      //         .services;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchSubCategory,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredServices.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshSubCategories(context),
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
                                          label: Text('Provider'),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'CreatedBy',
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
                                      rows: List.generate(
                                        _filteredServices.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredServices[element]
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredServices[element]
                                                          .tasker !=
                                                      null
                                                  ? Text(
                                                      _filteredServices[element]
                                                          .tasker!
                                                          .taskerNumber!
                                                          .toUpperCase())
                                                  : const Text(
                                                      '',
                                                    ),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredServices[element]
                                                    .createdBy!
                                                    .toUpperCase(),
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
                                                        width: 550,
                                                        ignoreAppBar: true,
                                                        body: PreviewService(
                                                            service:
                                                                _filteredServices[
                                                                    element]),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .remove_red_eye_sharp,
                                                    ),
                                                  ),
                                                  if (getProperty!.permissions!
                                                      .where((permission) =>
                                                          permission.module ==
                                                          'Services')
                                                      .any((p) => p.actions!.any(
                                                          (action) => action
                                                              .name!
                                                              .contains(
                                                                  'delete')))) ...{
                                                    const VerticalDivider(),
                                                    IconButton(
                                                      tooltip: 'Delete',
                                                      onPressed: () {
                                                        delete(
                                                            _filteredServices[
                                                                element],
                                                            context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete_forever,
                                                      ),
                                                    ),
                                                  }
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

  Widget get _searchSubCategory {
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
              hintText: 'Search by name',
              border: InputBorder.none,
            ),
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
              searchSubCategory(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(ServiceFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    services = fnc.services;
    _filteredServices = services;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshSubCategories(BuildContext context) async {
    await fnc!
        .getAllServices(fnc!.currentPage)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from service list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteSubCategory(element.id, ctx);
        for (int i = 0; i < _filteredServices.length; i++) {
          if (_filteredServices[i].id == element.id) {
            setState(() {
              _filteredServices.remove(_filteredServices[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteSubCategory(id, ctx) async {
    final response = await Provider.of<ServiceFactory>(context, listen: false)
        .deleteService(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchSubCategory(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredServices = services
        .where((category) => category.name!
            .toLowerCase()
            .contains(getProperty!.search.searchText))
        .toList();

    if (_filteredServices.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredServices = services;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
