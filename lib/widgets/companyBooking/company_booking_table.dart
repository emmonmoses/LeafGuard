// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, use_build_context_synchronously
// Projects Imports

import 'package:intl/intl.dart';
import 'package:leafguard/models/company/company_booking.dart';
import 'package:leafguard/services/company_booking/companyBookingFactory.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/companyBooking/company_booking_preview.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';

class CompanyBookingTable extends StatefulWidget {
  const CompanyBookingTable({super.key});

  @override
  State<CompanyBookingTable> createState() => _CompanyBookingTableState();
}

class _CompanyBookingTableState extends State<CompanyBookingTable> {
  List<CompanyBooking> companyBookings = [];
  List<CompanyBooking> _filteredCompanyBookings = [];
  TextEditingController searchController = TextEditingController();

  int page = 1, pages = 1;
  CompanyBookingFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no company booking found';
  var searchResultInvalid = 'There is no such company booking';

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
      fnc = Provider.of<CompanyBookingFactory>(context, listen: false);
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
    if (_filteredCompanyBookings.isEmpty) {
      _filteredCompanyBookings = companyBookings;
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
                _searchCompanyBookings,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredCompanyBookings.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshCompanyBookings(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('Company'),
                                        ),
                                        DataColumn(
                                          label: Text('Reference'),
                                        ),
                                        DataColumn(
                                          label: Text('Customer'),
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
                                          ),
                                        ),
                                      ],
                                      // rows: const [],
                                      rows: List.generate(
                                        _filteredCompanyBookings.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredCompanyBookings[
                                                        element]
                                                    .company!
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredCompanyBookings[element]
                                                          .reference !=
                                                      null
                                                  ? Text(
                                                      _filteredCompanyBookings[
                                                              element]
                                                          .reference
                                                          .toString()
                                                          .toUpperCase(),
                                                    )
                                                  : Text(
                                                      'No Reference'
                                                          .toUpperCase(),
                                                    ),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredCompanyBookings[
                                                        element]
                                                    .customerNumber!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredCompanyBookings[element]
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
                                                    DateTime.parse(
                                                        _filteredCompanyBookings[
                                                                element]
                                                            .createdOn!)),
                                              ),
                                            ),
                                            DataCell(Row(
                                              children: [
                                                const VerticalDivider(),
                                                IconButton(
                                                  tooltip: 'View',
                                                  onPressed: () {
                                                    showModalSideSheet(
                                                      context: context,
                                                      width: 550,
                                                      ignoreAppBar: true,
                                                      body:
                                                          PreviewCompanyBookings(
                                                        companyBookings:
                                                            _filteredCompanyBookings[
                                                                element],
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.black,
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

  Widget get _searchCompanyBookings {
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
                hintText: 'Search by reference or customerNumber',
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
              searchCompanyBookings(searchController.text);
            });
          },
        ),
      ),
    );
  }

  void setVariables(CompanyBookingFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    companyBookings = fnc.companyBooking;
    setState(() {
      _filteredCompanyBookings = companyBookings;
    });
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshCompanyBookings(BuildContext context) async {
    await fnc!
        .getAllCompanies(fnc!.currentPage)
        .then((r) => {setVariables(fnc!)});
  }

  searchCompanyBookings(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredCompanyBookings = companyBookings
        .where(
          (companyBooking) =>
              companyBooking.reference!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText) ||
              companyBooking.customerNumber!
                  .toLowerCase()
                  .contains(getProperty!.search.searchText),
        )
        .toList();

    if (_filteredCompanyBookings.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredCompanyBookings = companyBookings;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }
}
