// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, use_build_context_synchronously
// Projects Imports

import 'package:intl/intl.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/screens/administrator/edit_admin.dart';
import 'package:leafguard/services/administrator/adminFactory.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/administrator/admin_preview.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class AdministratorTable extends StatefulWidget {
  const AdministratorTable({super.key});

  @override
  State<AdministratorTable> createState() => _AdministratorTableState();
}

class _AdministratorTableState extends State<AdministratorTable> {
  List<Administrator> administrators = [];
  List<Administrator> _filteredAdministrators = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  AdministratorFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no administrator records';
  var searchResultInvalid = 'There is no such administrator';

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
      fnc = Provider.of<AdministratorFactory>(context);
      await fnc!
          .getAllAdmins(fnc!.currentPage)
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
    if (_filteredAdministrators.isEmpty) {
      _filteredAdministrators = administrators;
      // administrators =
      //     Provider.of<AdministratorFactory>(context, listen: false).admins;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchAdmin,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredAdministrators.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshAdmins(context),
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
                                          label: Text('Created On'),
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
                                        _filteredAdministrators.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredAdministrators[element]
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredAdministrators[element]
                                                          .email !=
                                                      null
                                                  ? Text(
                                                      _filteredAdministrators[
                                                              element]
                                                          .email
                                                          .toString()
                                                          .toUpperCase(),
                                                    )
                                                  : Text(
                                                      'No Email'.toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              _filteredAdministrators[element]
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
                                                    _filteredAdministrators[
                                                            element]
                                                        .createdAt!),
                                              ),
                                            ),
                                            DataCell(Row(
                                              children: [
                                                IconButton(
                                                  tooltip: 'View',
                                                  onPressed: () {
                                                    showModalSideSheet(
                                                      context: context,
                                                      width: 550,
                                                      ignoreAppBar: true,
                                                      body:
                                                          PreviewAdministrator(
                                                        user:
                                                            _filteredAdministrators[
                                                                element],
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                if (getProperty!.permissions!
                                                    .where((permission) =>
                                                        permission.module ==
                                                        'Admins')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'create')))) ...{
                                                  const VerticalDivider(),
                                                  IconButton(
                                                    tooltip: 'Update',
                                                    onPressed: () {
                                                      updateAdmin(
                                                          _filteredAdministrators[
                                                              element]);
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                },
                                                if (getProperty!.permissions!
                                                    .where((permission) =>
                                                        permission.module ==
                                                        'Admins')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'delete')))) ...{
                                                  const VerticalDivider(),
                                                  IconButton(
                                                    tooltip: 'Delete',
                                                    onPressed: () {
                                                      delete(
                                                          _filteredAdministrators[
                                                              element],
                                                          context);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                    ),
                                                  ),
                                                },
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

  Widget get _searchAdmin {
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
              searchAdministrator(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(AdministratorFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    administrators = fnc.admins;
    setState(() {
      _filteredAdministrators = administrators;
    });
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshAdmins(BuildContext context) async {
    await fnc!.getAllAdmins(fnc!.currentPage).then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from administrator list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteAdmin(element.id, ctx);
        for (int i = 0; i < _filteredAdministrators.length; i++) {
          if (_filteredAdministrators[i].id == element.id) {
            setState(() {
              _filteredAdministrators.remove(_filteredAdministrators[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteAdmin(id, ctx) async {
    final response =
        await Provider.of<AdministratorFactory>(context, listen: false)
            .deleteAdmin(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchAdministrator(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredAdministrators = administrators
        .where(
          (administrator) =>
              administrator.email!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              administrator.name!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredAdministrators.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredAdministrators = administrators;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateAdmin(admin) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditAdministrator(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: admin,
        ),
      ),
    );
  }
}
