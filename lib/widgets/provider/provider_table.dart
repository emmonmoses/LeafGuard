// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void
// Projects Imports
import 'package:intl/intl.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/models/witness/witnessresponse.dart';
import 'package:leafguard/screens/provider/provider_forgot_password.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/witness/witnessFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/provider/provider_preview.dart';

// Package Imports
import 'package:provider/provider.dart';

class ProviderTable extends StatefulWidget {
  const ProviderTable({super.key});

  @override
  State<ProviderTable> createState() => _ProviderTableState();
}

class _ProviderTableState extends State<ProviderTable> {
  List<ServiceProvider> serviceproviders = [];
  List<ServiceProvider> _filteredServiceProviders = [];
  TextEditingController searchController = TextEditingController();
  WitnessFactory? fnf;
  List<WitnessResponse>? witnesses;
  bool isLoading = false;
  int page = 1, pages = 1;
  ServiceProviderFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no provider records';
  var searchResultInvalid = 'There is no such provider';

  @override
  void initState() {
    getProperty!.getPermissions(context);
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    await getServiceProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: refreshProviders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return _buildProvidersTable();
        }
      },
    );
  }

  Widget _buildProvidersTable() {
    return Column(
      children: [
        _searchUser,
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
            child: _filteredServiceProviders.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: RefreshIndicator(
                      onRefresh: () => refreshProviders(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: DataTable(
                              // key: dataTableKeyProvider,
                              columns: const [
                                DataColumn(
                                  label: Text('Name'),
                                ),
                                DataColumn(
                                  label: Text('Provider'),
                                ),
                                DataColumn(
                                  label: Text('Email'),
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
                              rows: List.generate(
                                _filteredServiceProviders.length,
                                (element) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        '${_filteredServiceProviders[element].name}'
                                            .toUpperCase(),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '${_filteredServiceProviders[element].taskerNumber}'
                                            .toUpperCase(),
                                      ),
                                    ),
                                    DataCell(
                                      _filteredServiceProviders[element]
                                                  .email !=
                                              null
                                          ? Text(
                                              _filteredServiceProviders[element]
                                                  .email
                                                  .toString()
                                                  .toUpperCase(),
                                            )
                                          : Text(
                                              'No Email'.toUpperCase(),
                                            ),
                                    ),
                                    DataCell(
                                      _filteredServiceProviders[element]
                                                  .status !=
                                              1
                                          ? Tooltip(
                                              message: 'Not Verified',
                                              child: Icon(
                                                Icons.cancel,
                                                color: AppTheme.red,
                                              ),
                                            )
                                          : Tooltip(
                                              message: 'Verified',
                                              child: Icon(
                                                Icons.verified_sharp,
                                                color: AppTheme.green,
                                              ),
                                            ),
                                    ),
                                    DataCell(
                                      Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            _filteredServiceProviders[element]
                                                .createdAt!),
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
                                                body: PreviewProvider(
                                                    provider:
                                                        _filteredServiceProviders[
                                                            element]),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.remove_red_eye_sharp,
                                            ),
                                          ),
                                          if (getProperty!.permissions!
                                              .where((permission) =>
                                                  permission.module ==
                                                  'Service Providers')
                                              .any((p) => p.actions!.any(
                                                  (action) =>
                                                      action.name ==
                                                      'create_service providers')))
                                            IconButton(
                                              tooltip: 'Update',
                                              onPressed: () {
                                                RouteService.updateTasker(
                                                  context,
                                                  _filteredServiceProviders[
                                                          element]
                                                      .id,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                              ),
                                            ),
                                          if (getProperty!.permissions!
                                              .where((permission) =>
                                                  permission.module ==
                                                  'Service Providers')
                                              .any((p) => p.actions!.any((action) =>
                                                  action.name ==
                                                  'delete_service providers'))) ...{
                                            IconButton(
                                              tooltip: 'Delete',
                                              onPressed: () {
                                                delete(
                                                    _filteredServiceProviders[
                                                        element],
                                                    context);
                                              },
                                              icon: const Icon(
                                                Icons.delete_forever,
                                              ),
                                            ),
                                            IconButton(
                                              tooltip: 'Reset Password',
                                              onPressed: () {
                                                showModalSideSheet(
                                                  context: context,
                                                  width: 550,
                                                  ignoreAppBar: true,
                                                  body: ForgetPasswordScreen(
                                                    email:
                                                        _filteredServiceProviders[
                                                                element]
                                                            .email!,
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.replay,
                                              ),
                                            ),
                                          },
                                          const VerticalDivider(),
                                          if (getProperty!.permissions!
                                              .where((permission) =>
                                                  permission.module ==
                                                  'Service Providers')
                                              .any((p) => p.actions!.any(
                                                  (action) =>
                                                      action.name ==
                                                      'create_service providers')))
                                            _filteredServiceProviders[element]
                                                        .status !=
                                                    1
                                                ? isLoading
                                                    ? CircularProgressIndicator(
                                                        color: AppTheme.main,
                                                      )
                                                    : IconButton(
                                                        tooltip: 'Verify',
                                                        onPressed: () async {
                                                          await getWitness(
                                                              _filteredServiceProviders[
                                                                  element],
                                                              context);
                                                          // verify(
                                                          //     _filteredServiceProviders[
                                                          //         element],
                                                          //     context);
                                                        },
                                                        icon: Icon(
                                                          Icons.check,
                                                          color: AppTheme.main,
                                                        ),
                                                      )
                                                : Container(),
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
              borderRadius: BorderRadius.circular(20),
            ),
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
                hintText: 'Search by name, providerNumber or email',
                border: InputBorder.none),
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
              searchProvider(searchController.text);
            });
          },
        ),
      ),
    );
  }

  getServiceProvider() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<ServiceProviderFactory>(context, listen: false);
      await fnc!
          .getAllServiceProviders(fnc!.currentPage)
          .then((r) => {setVariables(fnc!)});

      setState(() {
        getProperty!.isLoading = false;
      });
      getProperty!.isInit = false;
    }
  }

  void setVariables(ServiceProviderFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    serviceproviders = fnc.serviceproviders;
    _filteredServiceProviders = serviceproviders;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.username.toUpperCase()} from the providers list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteProvider(element.id, ctx);
        for (int i = 0; i < _filteredServiceProviders.length; i++) {
          if (_filteredServiceProviders[i].id == element.id) {
            setState(() {
              _filteredServiceProviders.remove(_filteredServiceProviders[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteProvider(id, ctx) async {
    final response =
        await Provider.of<ServiceProviderFactory>(context, listen: false)
            .deleteServiceProvider(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  getWitness(element, context) async {
    setState(() {
      isLoading = true;
    });

    fnf = Provider.of<WitnessFactory>(context, listen: false);
    witnesses = await fnf!.getWitnessByTaskerId(element.id);

    setState(() {
      isLoading = false;
    });

    verify(element, context);
  }

  verify(element, ctx) async {
    if (witnesses == null || witnesses!.isEmpty) {
      snackBarErr(ctx, 'No WitnessFound, Add Witness for this provider');
      return;
    }

    final action = await ConfirmationDialog.yesAbortDialog(
      context,
      'Provider verification',
      'Are you sure you wish to verify provider number ${element.taskerNumber.toUpperCase()}?',
    );

    if (action == DialogAction.yes) {
      await verifyProvider(element.id, ctx);
      setState(() {
        refreshProviders();
      });
    }
  }

  verifyProvider(id, ctx) async {
    try {
      await Provider.of<ServiceProviderFactory>(context, listen: false)
          .verifyProvider(id);
      snackBarNotification(ctx, ToasterService.successMsg);
    } catch (error) {
      snackBarErr(ctx, 'Error verifying provider: $error');
    }
  }

  searchProvider(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredServiceProviders = serviceproviders
        .where(
          (user) =>
              user.email!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              user.name!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              user.taskerNumber!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredServiceProviders.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  Future<void> refreshProviders() async {
    await fnc!.getAllServiceProviders(fnc!.currentPage);
    setVariables(fnc!);
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredServiceProviders = serviceproviders;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
