// ignore_for_file: file_names

// Flutter imports:
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/models/agents/agent_search.dart';
import 'package:leafguard/models/bookings/booking.dart';
import 'package:leafguard/models/bookings/booking_search.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/models/provider/provider_search.dart';
import 'package:leafguard/models/transactions/transaction.dart';
import 'package:leafguard/models/transactions/transaction_search.dart';
import 'package:leafguard/services/report/reportService.dart';

class ReportFactory with ChangeNotifier {
  List<Agent> agents = [];
  List<ServiceProvider> serviceproviders = [];
  List<Booking> bookings = [];
  List<Transaction> transactions = [];

  bool isNextable = false;
  bool isPrevious = false;
  int pageSize = 100;
  // int currentPage = 1,
  int status = 0;
  int totalPages = 0;

  String agentNumber = '', taskerId = '', customerId = '', categoryId = '';

  int currentPageAgent = 1,
      currentPageTasker = 1,
      currentPageBooking = 1,
      currentPageTrans = 1,
      currentPageATrans = 1,
      currentPageTTrans = 1;

  Future<List<Agent>?> getAgents(page) async {
    ReportService req = ReportService();
    AgentSearch? agentSearch = await req.getAgents(page);
    notifyListeners();

    if (agentSearch!.data != null) {
      agents = agentSearch.data!;
      isNextable = agentSearch.page! < agentSearch.pages!;
      isPrevious = (agentSearch.page! > 1);
      totalPages = agentSearch.pages!;
      return agentSearch.data;
    } else {
      return null;
    }
  }

  Future<List<ServiceProvider>?> getServiceProviders(page) async {
    ReportService req = ReportService();
    ProviderSearch? userSearch = await req.getServiceProviders(page);
    notifyListeners();

    if (userSearch!.data != null) {
      serviceproviders = userSearch.data!;
      isNextable = userSearch.page! < userSearch.pages!;
      isPrevious = (userSearch.page! > 1);
      totalPages = userSearch.pages!;
      return userSearch.data;
    } else {
      return null;
    }
  }

  ////BOOKINGS
  Future<List<Booking>?> getBookings(page) async {
    ReportService req = ReportService();
    BookingSearch? jobSearch = await req.getBookings(page);
    notifyListeners();

    if (jobSearch!.data != null) {
      bookings = jobSearch.data!;
      isNextable = jobSearch.page! < jobSearch.pages!;
      isPrevious = (jobSearch.page! > 1);
      totalPages = jobSearch.pages!;
      return jobSearch.data;
    } else {
      return null;
    }
  }

  Future<List<Booking>?> getBookingsByJobStatus(status, page) async {
    ReportService req = ReportService();
    BookingSearch? jobSearch = await req.getBookingsByJobStatus(status, page);
    notifyListeners();

    bookings = jobSearch!.data!;
    isNextable = jobSearch.page! < jobSearch.pages!;
    isPrevious = (jobSearch.page! > 1);
    totalPages = jobSearch.pages!;
    return jobSearch.data;
  }

  Future<List<Booking>?> getBookingsByCreator(createdBy, page) async {
    ReportService req = ReportService();
    BookingSearch? jobSearch = await req.getBookingsByCreator(
      createdBy,
      page,
    );
    notifyListeners();

    bookings = jobSearch!.data!;
    isNextable = jobSearch.page! < jobSearch.pages!;
    isPrevious = (jobSearch.page! > 1);
    totalPages = jobSearch.pages!;
    return jobSearch.data;
  }

  Future<List<Booking>?> getBookingsByCreatorAndJobStatus(
      createdBy, status, page) async {
    ReportService req = ReportService();
    BookingSearch? jobSearch =
        await req.getBookingsByCreatorAndJobStatus(createdBy, status, page);
    notifyListeners();

    bookings = jobSearch!.data!;
    isNextable = jobSearch.page! < jobSearch.pages!;
    isPrevious = (jobSearch.page! > 1);
    totalPages = jobSearch.pages!;
    return jobSearch.data;
  }

  Future<List<Booking>?> getBookingsByCustomer(customerId, page) async {
    ReportService req = ReportService();
    BookingSearch? jobSearch =
        await req.getBookingsByCustomer(customerId, page);
    notifyListeners();

    bookings = jobSearch!.data!;
    isNextable = jobSearch.page! < jobSearch.pages!;
    isPrevious = (jobSearch.page! > 1);
    totalPages = jobSearch.pages!;
    return jobSearch.data;
  }

  Future<List<Booking>?> getBookingsByCategory(categoryId, page) async {
    ReportService req = ReportService();
    BookingSearch? jobSearch =
        await req.getBookingsByCategory(categoryId, page);
    notifyListeners();

    bookings = jobSearch!.data!;
    isNextable = jobSearch.page! < jobSearch.pages!;
    isPrevious = (jobSearch.page! > 1);
    totalPages = jobSearch.pages!;
    return jobSearch.data;
  }

  ////TRANSACTIONS
  Future<List<Transaction>?> getTransactions(page) async {
    ReportService req = ReportService();
    TransactionSearch? transactionSearch = await req.getTransactions(page);
    notifyListeners();

    if (transactionSearch!.data != null) {
      transactions = transactionSearch.data!;
      isNextable = transactionSearch.page! < transactionSearch.pages!;
      isPrevious = (transactionSearch.page! > 1);
      totalPages = transactionSearch.pages!;
      return transactionSearch.data;
    } else {
      return null;
    }
  }

  Future<List<Transaction>?> getTransactionsByCreator(createdBy, page) async {
    ReportService req = ReportService();
    TransactionSearch? jobSearch = await req.getTransactionsByCreator(
      createdBy,
      page,
    );
    notifyListeners();

    transactions = jobSearch!.data!;
    isNextable = jobSearch.page! < jobSearch.pages!;
    isPrevious = (jobSearch.page! > 1);
    totalPages = jobSearch.pages!;
    return jobSearch.data;
  }

  Future<List<Transaction>?> getTransactionsByCustomerId(
      customerId, page) async {
    ReportService req = ReportService();
    TransactionSearch? jobSearch =
        await req.getTransactionsByCustomerId(customerId, page);
    notifyListeners();

    transactions = jobSearch!.data!;
    isNextable = jobSearch.page! < jobSearch.pages!;
    isPrevious = (jobSearch.page! > 1);
    totalPages = jobSearch.pages!;
    return jobSearch.data;
  }

  Future<void> goNextAgent() async {
    if (isNextable) {
      await getAgents(++currentPageAgent);
      notifyListeners();
    }
  }

  Future<void> goPreviousAgent() async {
    if (isPrevious) {
      await getAgents(--currentPageAgent);
      notifyListeners();
    }
  }

  Future<void> goNextTaskers() async {
    if (isNextable) {
      await getServiceProviders(++currentPageTasker);
      notifyListeners();
    }
  }

  Future<void> goPreviousTaskers() async {
    if (isPrevious) {
      await getServiceProviders(--currentPageTasker);
      notifyListeners();
    }
  }

  Future<void> goNextBooking() async {
    if (isNextable) {
      await getBookings(++currentPageBooking);
      notifyListeners();
    }
  }

  Future<void> goPreviousBooking() async {
    if (isPrevious) {
      await getBookings(--currentPageBooking);
      notifyListeners();
    }
  }

  Future<void> goNextTransaction() async {
    if (isNextable) {
      await getTransactions(++currentPageTrans);
      notifyListeners();
    }
  }

  Future<void> goPreviousTransaction() async {
    if (isPrevious) {
      await getTransactions(--currentPageTrans);
      notifyListeners();
    }
  }

  Future<void> goNextAgentTransaction() async {
    if (isNextable) {
      await getTransactionsByCreator(agentNumber, ++currentPageATrans);
      notifyListeners();
    }
  }

  Future<void> goPreviousAgentTransaction() async {
    if (isPrevious) {
      await getTransactionsByCreator(agentNumber, --currentPageATrans);
      notifyListeners();
    }
  }

  Future<void> goNextTaskerTransaction() async {
    if (isNextable) {
      await getTransactionsByCreator(taskerId, ++currentPageTTrans);
      notifyListeners();
    }
  }

  Future<void> goPreviousTaskerTransaction() async {
    if (isPrevious) {
      await getTransactionsByCreator(taskerId, --currentPageTTrans);
      notifyListeners();
    }
  }
}
