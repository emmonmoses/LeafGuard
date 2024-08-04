// ignore_for_file: must_be_immutable
// Project imports:
import 'package:intl/intl.dart';
import 'package:leafguard/models/company/company_booking.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package Imports

class PreviewCompanyBookings extends StatelessWidget {
  final CompanyBooking companyBookings;
  VariableService getProperty = VariableService();

  PreviewCompanyBookings({super.key, required this.companyBookings});

  setVariables(ctx, prop) {
    getProperty.width = MediaQuery.of(ctx).size.width;
  }

  formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    return DateFormat("dd - MMM - yyyy").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  width: getProperty.width ?? MediaQuery.of(context).size.width,
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
                  width: getProperty.width ?? MediaQuery.of(context).size.width,
                  child: FadeAnimation(
                    1.3,
                    Container(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Company Booking details".toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppTheme.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: CircleAvatar(
              radius: AppTheme.avatarSize,
              backgroundImage: NetworkImage(
                '${ApiEndPoint.getCompanyImage}/${companyBookings.company!.avatar}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: companyBookings.reference != null
                ? Text(
                    companyBookings.reference!.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.black,
                        ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Biodata'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('Company Name:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${companyBookings.company!.name}'
                                          .toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('Tin Number:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${companyBookings.company!.tinnumber}'
                                          .toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('Email Address:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${companyBookings.company!.email}'
                                          .toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Address'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  companyBookings.company!.address != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'City:',
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                    '${companyBookings.company!.address!.city}'
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Country:',
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    '${companyBookings.company!.address!.country}'
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      : Text(
                                          'There is no address associated with  ${companyBookings.company!.email}'
                                              .toUpperCase(),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'Telephone'.toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: companyBookings.company!.phone !=
                                            null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text('Country Code:'),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      companyBookings
                                                          .company!.phone!.code
                                                          .toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text('Phone Number:'),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      companyBookings.company!
                                                          .phone!.number
                                                          .toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Text(
                                            'There is no phonenumber associated with  ${companyBookings.company!.email}'
                                                .toUpperCase(),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: AppTheme.dividerThickness,
                              color: AppTheme.main,
                              height: 20,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Customer Biodata'.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const Text('Customer Name:'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              '${companyBookings.customer!.name}'
                                                  .toUpperCase(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const Text('CustomerId:'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              '${companyBookings.customerNumber}'
                                                  .toUpperCase(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const Text('Email Address:'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              '${companyBookings.customer!.email}'
                                                  .toUpperCase(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          companyBookings.customer!.status != 1
                                              ? Row(
                                                  children: [
                                                    Tooltip(
                                                      message: 'In Active',
                                                      child: Icon(
                                                        Icons.verified_sharp,
                                                        color: AppTheme.red,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8.0,
                                                      ),
                                                      child: Text('In Active'
                                                          .toUpperCase()),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Tooltip(
                                                      message: 'Active',
                                                      child: Icon(
                                                        Icons.verified_sharp,
                                                        color: AppTheme.green,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8.0,
                                                      ),
                                                      child: Text('Active'
                                                          .toUpperCase()),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              thickness: AppTheme.dividerThickness,
                              color: AppTheme.main,
                              height: 20,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Booking Information",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    companyBookings.service != null
                                        ? Text(
                                            'Category: ${companyBookings.service!}',
                                          )
                                        : Text(
                                            'Category Deleted',
                                            style:
                                                TextStyle(color: AppTheme.red),
                                          ),
                                    Text(
                                      'Booking Ref: ${companyBookings.reference}',
                                    ),
                                    Text(
                                        'Booked on - ${formatDate(companyBookings.createdOn!.toString())}'),
                                    Text(
                                      companyBookings.description!.length > 80
                                          ? companyBookings.description!
                                              .substring(0, 80)
                                          : companyBookings.description!,
                                    ),
                                    Text(
                                      'Number of Providers: ${companyBookings.reference}',
                                    ),
                                    Text(
                                      'Work Duration: ${companyBookings.reference}',
                                    ),
                                    Text(
                                      'Total Amount: ${companyBookings.reference}',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          companyBookings.invoice!.paid != true
                                              ? Row(
                                                  children: [
                                                    Tooltip(
                                                      message: 'Unpaid',
                                                      child: Icon(
                                                        Icons.verified_sharp,
                                                        color: AppTheme.red,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8.0,
                                                      ),
                                                      child: Text('Unpaid'
                                                          .toUpperCase()),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Tooltip(
                                                      message: 'Paid',
                                                      child: Icon(
                                                        Icons.verified_sharp,
                                                        color: AppTheme.green,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8.0,
                                                      ),
                                                      child: Text(
                                                          'Paid'.toUpperCase()),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
