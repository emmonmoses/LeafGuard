// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures
// Project imports:
import 'package:intl/intl.dart';
import 'package:leafguard/models/bookings/booking.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/variables_service.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';

// Package Imports

class PreviewBooking extends StatelessWidget {
  final Booking booking;
  VariableService getProperty = VariableService();

  PreviewBooking({
    super.key,
    required this.booking,
  });

  String? bookingDate, loginTime, logoutDate, logoutTime;
  DateTime? bookingDateTime;

  setVariables(ctx, prop) {
    getProperty.width = MediaQuery.of(ctx).size.width;
    getProperty.file = '${ApiEndPoint.getProviderImage}/$prop';
  }

  formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    return DateFormat("dd - MMM - yyyy").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    setVariables(
      context,
      booking.service!.isNotEmpty
          ? booking.service![0].tasker!.avatar
          : ApiEndPoint.appLogo,
    );

    return getProperty.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: -40,
                        width: getProperty.width,
                        child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background-6.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 200,
                        width: getProperty.width! + 20,
                        child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background-5.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 200,
                        width: getProperty.width! + 20,
                        child: FadeAnimation(
                          1.3,
                          Container(
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 15.0),
                            child: Text(
                              "booking ref: ${booking.bookingRef}"
                                  .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: AppTheme.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                jobStatus(booking),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    booking.customer != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Customer Information",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  booking.customer!.name!,
                                ),
                                Text(
                                  '${booking.customer!.phone!.code!} ${booking.customer!.phone!.number!}',
                                ),
                                Text(
                                  booking.customer!.email!,
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Customer Information",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Customer was deleted',
                                  style: TextStyle(color: AppTheme.red),
                                ),
                                const Text(''),
                                const Text(''),
                              ],
                            ),
                          ),
                    booking.service!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Provider Information",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${booking.service![0].tasker!.name!} (${booking.service![0].tasker!.experience!.name!})',
                                ),
                                Text(
                                  booking.service![0].tasker!.email!,
                                ),
                                Text(
                                  'ID - ${booking.service![0].tasker!.taskerNumber!}',
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              children: [
                                const Text(
                                  "Provider Information",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Provider was deleted',
                                  style: TextStyle(color: AppTheme.red),
                                ),
                                const Text(''),
                                const Text(''),
                              ],
                            ),
                          ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Booking Information",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          booking.category!.name != null
                              ? Text(
                                  'Category: ${booking.category!.name}',
                                )
                              : Text(
                                  'Category Deleted',
                                  style: TextStyle(color: AppTheme.red),
                                ),
                          booking.service!.isNotEmpty
                              ? Text(
                                  'Service: ${booking.service![0].name}',
                                )
                              : Text(
                                  'Service: Service was deleted',
                                  style: TextStyle(color: AppTheme.red),
                                ),
                          Text(
                            'Booking Ref: ${booking.bookingRef}',
                          ),
                          booking.agentJobCompleteDate != null
                              ? Text(
                                  'Booked on - ${formatDate(booking.agentJobCompleteDate!.toString())}')
                              : const Text(''),
                          Text(
                              'Start On - ${formatDate(booking.customerPrefferredJobStartDate!.toString())}'),
                          // ),
                          Text(
                            booking.description!.length > 80
                                ? booking.description!.substring(0, 80)
                                : booking.description!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                booking.jobStatus == 5
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Invoice",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                booking.service!.isNotEmpty
                                    ? Text(
                                        'Hourly Price: ETB ${booking.service![0].price}'
                                            .toUpperCase(),
                                      )
                                    : Row(
                                        children: [
                                          const Text(
                                            'Hourly Price: ',
                                          ),
                                          Text(
                                            'No Service',
                                            style:
                                                TextStyle(color: AppTheme.red),
                                          ),
                                        ],
                                      ),
                                Text(
                                  'Hours Worked: ${booking.invoice!.totalHoursWorked}'
                                      .toUpperCase(),
                                ),
                                Text(
                                  'Tax: ETB ${booking.invoice!.taxTotal}'
                                      .toUpperCase(),
                                ),
                                Text(
                                  'Discount: ETB ${booking.invoice!.discountTotal}'
                                      .toUpperCase(),
                                ),
                                Text(
                                  'Service Charge: ETB ${booking.invoice!.totalAdminCommission}'
                                      .toUpperCase(),
                                ),
                                Text(
                                  'Agent Commission: ETB ${booking.invoice!.totalAgentCommission}'
                                      .toUpperCase(),
                                ),
                                Text(
                                  'Provider Commission: ETB ${booking.invoice!.totalTaskerCommission}'
                                      .toUpperCase(),
                                ),
                                Text(
                                  'Total Price: ETB ${booking.invoice!.totalPrice}'
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Invoice",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'The booking has not been completed hence no INVOICE to show'),
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
  }

  Widget jobStatus(Booking booking) {
    if (booking.jobStatus == 0)
      return const Column(
        children: [
          Icon(
            Icons.pending_actions,
            size: 40.0,
          ),
          Text(
            "Pending",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );

    if (booking.jobStatus == 1)
      return const Column(
        children: [
          Icon(
            Icons.reviews,
            size: 25.0,
          ),
          Text(
            "Accepted",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );

    if (booking.jobStatus == 2)
      return Column(
        children: [
          Icon(
            Icons.cancel_rounded,
            color: AppTheme.red,
            size: 25.0,
          ),
          const Text(
            "Cancelled",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );

    if (booking.jobStatus == 3)
      return const Column(
        children: [
          Icon(
            Icons.pending,
            size: 25.0,
          ),
          Text(
            "Started",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );

    if (booking.jobStatus == 4)
      return const Column(
        children: [
          Icon(
            Icons.pause_circle,
            size: 25.0,
          ),
          Text(
            "Paused",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    if (booking.jobStatus == 5)
      return Column(
        children: [
          Icon(
            Icons.done_all,
            color: AppTheme.green,
            size: 25.0,
          ),
          const Text(
            "Completed",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );

    return const Icon(
      Icons.done,
      color: Colors.green,
      size: 25.0,
    );
  }
}
