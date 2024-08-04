// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/companyBooking/company_booking_header.dart';
import 'package:leafguard/widgets/companyBooking/company_booking_table.dart';

class CompanyBookingIndex extends StatefulWidget {
  const CompanyBookingIndex({super.key});

  @override
  State<CompanyBookingIndex> createState() => _CompanyBookingIndexState();
}

class _CompanyBookingIndexState extends State<CompanyBookingIndex> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.bgWhiteMixin,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        children: [
          const CompanyBookingHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const CompanyBookingTable(),
        ],
      ),
    );
  }
}
