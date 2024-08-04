// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:leafguard/models/company/company_booking.dart';
import 'package:leafguard/models/company/company_booking_search.dart';
import 'package:leafguard/services/company_booking/companyBookingService.dart';

class CompanyBookingFactory with ChangeNotifier {
  List<CompanyBooking> companyBooking = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  Future<List<CompanyBooking>?> getAllCompanies(page) async {
    CompanyBookingService req = CompanyBookingService();
    CompanyBookingSearch? companySearch = await req.getCompanyBookings(page);

    if (companySearch!.data != null) {
      companyBooking = companySearch.data!;
      isNextable = companySearch.page! < companySearch.pages!;
      isPrevious = (companySearch.page! > 1);
      totalPages = companySearch.pages!;
      notifyListeners();
      return companySearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllCompanies(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllCompanies(--currentPage);
      notifyListeners();
    }
  }
}
