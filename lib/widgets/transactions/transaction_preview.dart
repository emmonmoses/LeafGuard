// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures
// Project imports:

import 'package:intl/intl.dart';
import 'package:leafguard/models/transactions/transaction.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/variables_service.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';

// Package Imports

class PreviewTransaction extends StatefulWidget {
  final Transaction transaction;

  const PreviewTransaction({
    super.key,
    required this.transaction,
  });

  @override
  State<PreviewTransaction> createState() => _PreviewTransactionState();
}

class _PreviewTransactionState extends State<PreviewTransaction> {
  VariableService getProperty = VariableService();

  String? bookingDate, loginTime, logoutDate, logoutTime;

  DateTime? bookingDateTime;

  setVariables(ctx, prop) {
    getProperty.width = MediaQuery.of(ctx).size.width;
    getProperty.file = '${ApiEndPoint.getCategoryImage}/$prop';
  }

  formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    return DateFormat("dd-MM-yyyy hh:mm:ss a'").format(dateTime);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setVariables(
      context,
      widget.transaction.tasker != null
          ? widget.transaction.tasker!.avatar
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
                              "transaction ref: ${widget.transaction.transactionRef}"
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
                // jobStatus(task),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.transaction.customer != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Customer (${widget.transaction.customer!.customerNumber}) Information",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  widget.transaction.customer!.name!,
                                ),
                                Text(
                                  widget.transaction.customer!.email!,
                                ),
                                Text(
                                  '${widget.transaction.customer!.phone!.code!} ${widget.transaction.customer!.phone!.number!}',
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Customer Information',
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
                    widget.transaction.tasker != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Provider (${widget.transaction.tasker!.taskerNumber}) Information",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${widget.transaction.tasker!.name!} (${widget.transaction.tasker!.experience!.name!})',
                                ),
                                Text(
                                  widget.transaction.tasker!.email!,
                                ),
                                Text(
                                  'ID - ${widget.transaction.tasker!.phone!.number}',
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
                          widget.transaction.category!.name != null
                              ? Text(
                                  'Category: ${widget.transaction.category!.name}',
                                )
                              : Text(
                                  'Category Deleted',
                                  style: TextStyle(color: AppTheme.red),
                                ),
                          widget.transaction.service != null
                              ? Text(
                                  'Service: ${widget.transaction.service!.name!.toUpperCase()}',
                                )
                              : Text(
                                  'Service: Service was deleted',
                                  style: TextStyle(color: AppTheme.red),
                                ),
                          Text(
                            'Booking Ref: ${widget.transaction.bookingRef}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Transaction Ref: ${widget.transaction.transactionRef}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Created On - ${formatDate(widget.transaction.transactionDate!.toString())}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                Padding(
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
                          Text(
                            'Hourly Price: Etb ${widget.transaction.price}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Hours Worked: ${widget.transaction.totalHoursWorked}'
                                .toUpperCase(),
                          ),
                          Text(
                            'BasePrice: Etb ${widget.transaction.basePrice}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Tax: Etb ${widget.transaction.tax!.amount}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Discount: Etb ${widget.transaction.discount!.amount}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Service Charge: Etb ${widget.transaction.adminCommission!.amount}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Agent Commission: Etb ${widget.transaction.agentCommission!.amount}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Provider Commission: Etb ${widget.transaction.taskerCommission!.amount}'
                                .toUpperCase(),
                          ),
                          Text(
                            'Total: Etb ${widget.transaction.total}'
                                .toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
