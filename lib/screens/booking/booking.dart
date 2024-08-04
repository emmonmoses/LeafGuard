// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/bookings/booking_header.dart';
import 'package:leafguard/widgets/bookings/booking_table.dart';

class BookingIndex extends StatefulWidget {
  const BookingIndex({super.key});

  @override
  State<BookingIndex> createState() => _BookingIndexState();
}

class _BookingIndexState extends State<BookingIndex> {
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
          const BookingHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const BookingTable(),
        ],
      ),
    );
  }
}
