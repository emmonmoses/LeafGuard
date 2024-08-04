// ignore_for_file: file_names

// Flutter imports:
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/bookings/booking.dart';
import 'package:leafguard/models/bookings/booking_search.dart';
import 'package:leafguard/models/cancellation/cancel_Action.dart';
import 'package:leafguard/models/cancellation/cancel_action_object.dart';

// Project imports:
import 'package:leafguard/services/bookings/bookingService.dart';

class BookingFactory with ChangeNotifier {
  List<Booking>? bookings = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;
  String? adminKey = "storedAdmin";
  String? adminNumber;

  get bookingList {
    return [...bookings!];
  }

  getBookingId(id) {
    return bookings!.firstWhere((res) => res.id == id);
  }

  Future getBookingById(companyId) async {
    BookingService req = BookingService();
    BookingSearch userSearch = await req.getBookingById(companyId);
    notifyListeners();
    return userSearch;
  }

  Future<dynamic> uploadImage() async {
    BookingService requests = BookingService();
    var image = await requests.uploadImage();

    notifyListeners();
    return image;
  }

  Future<String> getTaskerLogo(taskerLogo) async {
    BookingService req = BookingService();
    Uint8List logo = await req.getTaskerLogo(taskerLogo);
    notifyListeners();
    return base64Encode(logo);
  }

  Future<List<Booking>?> getAllBookings(page) async {
    BookingService req = BookingService();
    BookingSearch? userSearch = await req.getBookings(page);

    if (userSearch!.data != null) {
      bookings = userSearch.data;
      isNextable = userSearch.page! < userSearch.pages!;
      isPrevious = (userSearch.page! > 1);
      totalPages = userSearch.pages!;
      notifyListeners();
      return userSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllBookings(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllBookings(--currentPage);
      notifyListeners();
    }
  }

  Future deleteBooking(taskId) async {
    BookingService requests = BookingService();
    final result = await requests.deleteBooking(taskId);

    notifyListeners();
    return result;
  }

  Future<String?> cancelBooking(personType, cancelReason, bookingId) async {
    adminNumber = await sharedPref.read(adminKey);

    final action = CancelAction(
      person: adminNumber,
      personType: personType,
      cancelReason: cancelReason,
    );

    final model = CancelActionObject(cancelAction: action);

    BookingService requests = BookingService();
    var result = await requests.cancelBooking(model, bookingId);

    notifyListeners();
    return result;
  }
}
