// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, use_build_context_synchronously
// Projects Imports

import 'package:intl/intl.dart';
import 'package:leafguard/models/company/company.dart';
import 'package:leafguard/screens/company/edit_company.dart';
import 'package:leafguard/services/company/companyFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/company/company_preview.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class CompanyTable extends StatefulWidget {
  const CompanyTable({super.key});

  @override
  State<CompanyTable> createState() => _CompanyTableState();
}

class _CompanyTableState extends State<CompanyTable> {
  List<Company> companies = [];
  List<Company> _filteredCompanies = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  CompanyFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no company records';
  var searchResultInvalid = 'There is no such company';

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
      fnc = Provider.of<CompanyFactory>(context);
      await fnc!
          .getAllCompanies(fnc!.currentPage)
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
    if (_filteredCompanies.isEmpty) {
      _filteredCompanies = companies;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchCompany,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredCompanies.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshCompanies(context),
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
                                          label: Text('Code'),
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
                                        _filteredCompanies.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredCompanies[element]
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredCompanies[element]
                                                          .email !=
                                                      null
                                                  ? Text(
                                                      _filteredCompanies[
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
                                              _filteredCompanies[element]
                                                          .code !=
                                                      null
                                                  ? Text(
                                                      _filteredCompanies[
                                                              element]
                                                          .code
                                                          .toString()
                                                          .toUpperCase(),
                                                    )
                                                  : Text(
                                                      'No Code'.toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              _filteredCompanies[element]
                                                          .status !=
                                                      true
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
                                                    DateTime.parse(
                                                        _filteredCompanies[
                                                                element]
                                                            .createdOn!)),
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
                                                      body: PreviewCompany(
                                                        company:
                                                            _filteredCompanies[
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
                                                        'Company')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'create')))) ...{
                                                  // const VerticalDivider(),
                                                  IconButton(
                                                    tooltip: 'Update',
                                                    onPressed: () {
                                                      updateCompany(
                                                          _filteredCompanies[
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
                                                        'Company')
                                                    .any((p) => p.actions!.any(
                                                        (action) => action.name!
                                                            .contains(
                                                                'delete')))) ...{
                                                  // const VerticalDivider(),
                                                  IconButton(
                                                    tooltip: 'Delete',
                                                    onPressed: () {
                                                      delete(
                                                          _filteredCompanies[
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

  Widget get _searchCompany {
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
              searchCompany(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(CompanyFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    companies = fnc.companies;
    setState(() {
      _filteredCompanies = companies;
    });
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshCompanies(BuildContext context) async {
    await fnc!
        .getAllCompanies(fnc!.currentPage)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from Company list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteCompany(element.id, ctx);
        for (int i = 0; i < _filteredCompanies.length; i++) {
          if (_filteredCompanies[i].id == element.id) {
            setState(() {
              _filteredCompanies.remove(_filteredCompanies[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteCompany(id, ctx) async {
    final response = await Provider.of<CompanyFactory>(context, listen: false)
        .deleteCompany(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchCompany(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredCompanies = companies
        .where(
          (company) =>
              company.email!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              company.name!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredCompanies.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredCompanies = companies;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateCompany(company) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EditCompany(),
        transitionDuration: const Duration(seconds: 0),
        settings: RouteSettings(
          arguments: company,
        ),
      ),
    );
  }
}
