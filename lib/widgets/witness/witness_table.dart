// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, use_build_context_synchronously
// Projects Imports

import 'package:leafguard/models/witness/witness.dart';
import 'package:leafguard/screens/witness/edit_witness.dart';
import 'package:leafguard/services/witness/witnessFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class WitnessTable extends StatefulWidget {
  const WitnessTable({Key? key}) : super(key: key);

  @override
  State<WitnessTable> createState() => _WitnessTableState();
}

class _WitnessTableState extends State<WitnessTable> {
  List<Witness> witnesses = [];
  List<Witness> _filteredWitnesses = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  WitnessFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no witness records';
  var searchResultInvalid = 'There is no such witness';

  @override
  void didChangeDependencies() async {
    if (getProperty!.isInit) {
      setState(() {
        getProperty!.isLoading = true;
      });
      fnc = Provider.of<WitnessFactory>(context, listen: false);
      await fnc!
          .getAllWitnesses(fnc!.currentPage)
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
    if (_filteredWitnesses.isEmpty) {
      _filteredWitnesses = witnesses;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchWitness,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredWitnesses.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshWitnesses(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('NationalID'),
                                        ),
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Phone'),
                                        ),
                                        DataColumn(
                                          label: Row(
                                            children: [
                                              Text(''),
                                            ],
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                        _filteredWitnesses.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(_filteredWitnesses[element]
                                                  .nationalId!
                                                  .toUpperCase()),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredWitnesses[element]
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredWitnesses[element]
                                                    .phone!
                                                    .toString(),
                                              ),
                                            ),
                                            DataCell(Row(
                                              children: [
                                                IconButton(
                                                  tooltip: 'Update',
                                                  onPressed: () {
                                                    updateWitness(
                                                        context,
                                                        fnc,
                                                        _filteredWitnesses[
                                                            element]);
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const VerticalDivider(),
                                                IconButton(
                                                  tooltip: 'Delete',
                                                  onPressed: () {
                                                    // delete(
                                                    //     _filteredWitnesses[
                                                    //         element],
                                                    //     context);
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

  Widget get _searchWitness {
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
              // searchWitness(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(WitnessFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    witnesses = fnc.witnesses
        .map((witnessesObj) => witnessesObj.witnesses!)
        .expand((witnessList) => witnessList)
        .toList();
    _filteredWitnesses = List.from(witnesses);
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshWitnesses(BuildContext context) async {
    await fnc!
        .getAllWitnesses(fnc!.currentPage)
        .then((r) => {setVariables(fnc!)});
  }

  void delete(Witness element, BuildContext ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
      context,
      'DeleteConfirmation',
      'Are you sure you wish to delete ${element.name!.toUpperCase()} from witness list',
    );

    if (action == DialogAction.yes) {
      setState(() {
        deleteTax(element.nationalId!, ctx);
        _filteredWitnesses
            .removeWhere((witness) => witness.nationalId == element.nationalId);
      });
    } else {
      setState(() => null);
    }
  }

  Future<void> deleteTax(String id, BuildContext ctx) async {
    final response = await Provider.of<WitnessFactory>(context, listen: false)
        .deleteSpecificWitness(id);

    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  // void searchWitness(String val) {
  //   getProperty!.search.searchText = val.toLowerCase();
  //   _filteredWitnesses = witnesses
  //       .where(
  //         (witness) => witness.witnesses!.any(
  //           (w) => w.nationalId!
  //               .toLowerCase()
  //               .contains(getProperty!.search.searchText),
  //         ),
  //       )
  //       .toList();

  //   if (_filteredWitnesses.isEmpty) {
  //     getProperty!.isInvisible = true;
  //     getProperty!.isVisible = false;
  //   }
  // }

  void clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredWitnesses = List.from(witnesses);
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  updateWitness(context, provider, witness) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => EditWitness(
          provider: provider,
          witness: witness,
        ),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }
}
