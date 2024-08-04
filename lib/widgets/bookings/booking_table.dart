// ignore_for_file: curly_braces_in_flow_control_structures, avoid_returning_null_for_void, unused_local_variable, use_build_context_synchronously
// Projects Imports

import 'package:intl/intl.dart';
import 'package:leafguard/models/bookings/booking.dart';
import 'package:leafguard/models/cancellation/cancellation.dart';
import 'package:leafguard/screens/booking/home.dart';
import 'package:leafguard/services/cancellation/cancellationFactory.dart';
import 'package:leafguard/services/bookings/bookingFactory.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/sliding_modal.dart';
import 'package:leafguard/widgets/general/paginator.dart';

// Flutter Iports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/bookings/booking_preview.dart';
import 'package:provider/provider.dart';

class BookingTable extends StatefulWidget {
  const BookingTable({super.key});

  @override
  State<BookingTable> createState() => _BookingTableState();
}

class _BookingTableState extends State<BookingTable> {
  List<Booking> bookings = [];
  List<Booking> _filteredBookings = [];
  TextEditingController searchController = TextEditingController();
  List<CancellationRules> cancelReasons = [];
  int page = 1, pages = 1;
  BookingFactory? fnc;
  VariableService? getProperty = VariableService();
  var searchResult = 'There are no booking records';
  var searchResultInvalid = 'There is no such booking';

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
      await Provider.of<CancellationFactory>(context, listen: false)
          .getAllCancellations(page);
      getUserCancellationReason();

      fnc = Provider.of<BookingFactory>(context, listen: false);
      await fnc!
          .getAllBookings(fnc!.currentPage)
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
    if (_filteredBookings.isEmpty) {
      _filteredBookings = bookings;
    }

    return Container(
      child: getProperty!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchUser,
                Visibility(
                  visible: getProperty!.isVisible,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: _filteredBookings.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: RefreshIndicator(
                              onRefresh: () => refreshTasks(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('BookigRef#'),
                                        ),
                                        DataColumn(
                                          label: Text('Category'),
                                        ),
                                        DataColumn(
                                          label: Text('Amount(\$)'),
                                        ),
                                        DataColumn(
                                          label: Text('Status'),
                                        ),
                                        DataColumn(
                                          label: Text('BookingDate'),
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
                                        _filteredBookings.length,
                                        (element) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                _filteredBookings[element]
                                                    .bookingRef!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                _filteredBookings[element]
                                                    .category!
                                                    .name!
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            DataCell(
                                              _filteredBookings[element]
                                                          .invoice !=
                                                      null
                                                  ? Text(
                                                      'ETB.${_filteredBookings[element].invoice!.totalPrice}'
                                                          .toString()
                                                          .toUpperCase(),
                                                    )
                                                  : const Text(
                                                      '',
                                                    ),
                                            ),
                                            DataCell(statusIcon(
                                                _filteredBookings[element])),
                                            DataCell(
                                              Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                    _filteredBookings[element]
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
                                                        body: PreviewBooking(
                                                            booking:
                                                                _filteredBookings[
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
                                                          'Bookings')
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
                                                            _filteredBookings[
                                                                element],
                                                            context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete_forever,
                                                      ),
                                                    ),
                                                  },
                                                  if (getProperty!.permissions!
                                                      .where((permission) =>
                                                          permission.module ==
                                                          'Bookings')
                                                      .any((p) => p.actions!.any(
                                                          (action) => action
                                                              .name!
                                                              .contains(
                                                                  'create')))) ...{
                                                    const VerticalDivider(),
                                                    IconButton(
                                                      tooltip: 'Cancel',
                                                      onPressed: () {
                                                        _openTaskerModalSheet(
                                                            context,
                                                            _filteredBookings[
                                                                    element]
                                                                .id,
                                                            _filteredBookings[
                                                                    element]
                                                                .jobStatus);
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
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
                hintText: 'Search by bookingRef', border: InputBorder.none),
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

  void setVariables(BookingFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    bookings = fnc.bookings!;
    setState(() {
      _filteredBookings = bookings;
    });
  }

  goNext() {
    fnc!.goNext().then((value) => setState(() => setVariables(fnc!)));
  }

  goPrevious() {
    fnc!.goPrevious().then((value) => setState(() => setVariables(fnc!)));
  }

  refreshTasks(BuildContext context) async {
    await fnc!.getAllBookings(fnc!.currentPage).then((r) => {
          setVariables(fnc!),
        });
  }

  submitCancelReason(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context, 'Cancel Reason', 'Select Your Cancel Reason');
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete booking  ${element.bookingRef} from the bookings list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteProvider(element.id, ctx);
        for (int i = 0; i < _filteredBookings.length; i++) {
          if (_filteredBookings[i].id == element.id) {
            setState(() {
              _filteredBookings.remove(_filteredBookings[i]);
            });
          }
        }
      });
    } else
      setState(() => null);
  }

  cancel(element, String cancelReason, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'CancelConfirmation',
        'Are you sure you wish to cancel booking  ${element.bookingId}');
    if (action == DialogAction.yes) {
      setState(() {
        cancelProvider(cancelReason, element.id, ctx);
      });
    } else
      setState(() => null);
  }

  deleteProvider(id, ctx) async {
    final response = await Provider.of<BookingFactory>(context, listen: false)
        .deleteBooking(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }

  cancelProvider(String canceReason, String id, ctx) async {
    final response = await Provider.of<BookingFactory>(context, listen: false)
        .cancelBooking("admin", canceReason, id);
    if (response == "Booking Cancelled") {
      snackBarNotification(ctx, ToasterService.successMsg);
      fnc = Provider.of<BookingFactory>(context, listen: false);
      fnc!
          .getAllBookings(getProperty!.search.page)
          .then((r) => {setVariables(fnc!)});
      Navigator.pushReplacement(
        ctx,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const BookingHome(),
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    }

    return response;
  }

  searchProvider(String val) {
    getProperty!.search.searchText = val.toLowerCase();
    _filteredBookings = bookings
        .where((user) => user.bookingRef!
            .toLowerCase()
            .contains(getProperty!.search.searchText))
        .toList();

    if (_filteredBookings.isEmpty) {
      getProperty!.isInvisible = true;
      getProperty!.isVisible = false;
    }
  }

  clearSearch() {
    searchController.clear();
    getProperty!.search.searchText = '';
    setState(() {
      _filteredBookings = bookings;
      getProperty!.isInvisible = false;
      getProperty!.isVisible = true;
    });
  }

  getUserCancellationReason() {
    var reasons = Provider.of<CancellationFactory>(context, listen: false)
        .cancellationList;

    cancelReasons.addAll(reasons);
  }

  Widget cancelReason(String? id, ctx) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Reason for Cancellation'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0.1,
                blurRadius: 5,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: cancelReasons.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        cancelProvider(
                            cancelReasons[index].reason as String, id!, ctx);
                      },
                      child: Card(
                        color: Colors.greenAccent,
                        elevation: 8.0,
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: ListTile(
                          leading: const Icon(
                            Icons.list,
                            color: Colors.white,
                          ),
                          title: Text(
                            '${cancelReasons[index].reason}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailing: const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openTaskerModalSheet(BuildContext context, String? id, int? status) {
    if (status == 0) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return cancelReason(id, context);
        },
      );
    } else {
      snackBarErr(context, ToasterService.invalidCancellation);
    }
  }

  Widget statusIcon(Booking booking) {
    if (booking.jobStatus == 0)
      return const Tooltip(
        message: "Pending",
        child: Icon(
          Icons.pending_actions,
          color: Colors.yellow,
          size: 25.0,
        ),
      );

    if (booking.jobStatus == 1)
      return const Tooltip(
        message: "Accepted",
        child: Icon(
          Icons.reviews,
          color: Colors.yellow,
          size: 25.0,
        ),
      );

    if (booking.jobStatus == 2)
      return const Tooltip(
        message: "Cancelled",
        child: Icon(
          Icons.cancel_rounded,
          color: Colors.red,
          size: 25.0,
        ),
      );

    if (booking.jobStatus == 3)
      return const Tooltip(
        message: "In Progress",
        child: Icon(
          Icons.pending,
          color: Colors.amber,
          size: 25.0,
        ),
      );

    if (booking.jobStatus == 4)
      return const Tooltip(
        message: "Completed",
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 25.0,
        ),
      );

    return const Tooltip(
      message: "Completed",
      child: Icon(
        Icons.done,
        color: Colors.green,
        size: 25.0,
      ),
    );
  }
}
