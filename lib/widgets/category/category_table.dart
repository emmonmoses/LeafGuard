// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, use_build_context_synchronously
// Projects Imports

import 'package:intl/intl.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/category/category_preview.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class CategoryTable extends StatefulWidget {
  const CategoryTable({super.key});

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  List<Category> categories = [];
  List<Category> _filteredCategories = [];
  TextEditingController searchController = TextEditingController();

  int page = 1;
  int pages = 1;
  CategoryFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no category records';
  var searchResultInvalid = 'There is no such category record';

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
      fnc = Provider.of<CategoryFactory>(context, listen: false);
      await fnc!
          .getAllCategories(fnc!.currentPage)
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
    if (_filteredCategories.isEmpty) {
      _filteredCategories = categories;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchCategory,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredCategories.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshCategories(context),
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
                                          label: Text('Category'),
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
                                        _filteredCategories.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredCategories[element]
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredCategories[element]
                                                          .maincategory !=
                                                      null
                                                  ? Text(
                                                      _filteredCategories[
                                                                      element]
                                                                  .maincategory!
                                                                  .name!
                                                                  .length >
                                                              40
                                                          ? _filteredCategories[
                                                                  element]
                                                              .maincategory!
                                                              .name!
                                                              .substring(0, 40)
                                                          : _filteredCategories[
                                                                  element]
                                                              .maincategory!
                                                              .name!,
                                                    )
                                                  : Text(
                                                      'No Category'
                                                          .toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              _filteredCategories[element]
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
                                                    _filteredCategories[element]
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
                                                        width: 550,
                                                        ignoreAppBar: true,
                                                        body: PreviewCategory(
                                                            category:
                                                                _filteredCategories[
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
                                                          'Categories')
                                                      .any((p) => p.actions!.any(
                                                          (action) => action
                                                              .name!
                                                              .contains(
                                                                  'create')))) ...{
                                                    const VerticalDivider(),
                                                    IconButton(
                                                      tooltip: 'Update',
                                                      onPressed: () {
                                                        RouteService.updateCategory(
                                                            context,
                                                            _filteredCategories[
                                                                    element]
                                                                .id);
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
                                                          'Categories')
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
                                                            _filteredCategories[
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

  Widget get _searchCategory {
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
              searchCategory(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(CategoryFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    categories = fnc.categories;
    _filteredCategories = categories;
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshCategories(BuildContext context) async {
    await fnc!
        .getAllCategories(fnc!.currentPage)
        .then((r) => {setVariables(fnc!)});
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from category list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteCategory(element.id, ctx);
        for (int i = 0; i < _filteredCategories.length; i++) {
          if (_filteredCategories[i].id == element.id) {
            setState(() {
              _filteredCategories.remove(_filteredCategories[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  deleteCategory(id, ctx) async {
    final response = await Provider.of<CategoryFactory>(context, listen: false)
        .deleteCategory(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  searchCategory(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredCategories = categories
        .where((category) => category.name!
            .toLowerCase()
            .contains(getProperty!.search.searchText))
        .toList();

    if (_filteredCategories.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredCategories = categories;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
