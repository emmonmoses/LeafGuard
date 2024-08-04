// ignore_for_file: file_names

// Flutter imports:
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:leafguard/models/customerBalance/customer.dart';
import 'package:leafguard/models/customerBalance/customer_balance_create.dart';
import 'package:leafguard/models/customerBalance/customer_balance_search.dart';
import 'package:leafguard/models/customerBalance/customer_balance_update.dart';
import 'package:leafguard/models/providerBalance/provider.dart';
import 'package:leafguard/models/providerBalance/provider_balance_create.dart';
import 'package:leafguard/models/providerBalance/provider_balance_search.dart';
import 'package:leafguard/models/providerBalance/provider_balance_update.dart';
import 'package:leafguard/services/balance/balanceService.dart';

class BalanceFactory with ChangeNotifier {
  List<ProviderBalance> providersbalance = [];
  List<CustomerBalance> customersbalance = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  // providers endpoints
  get providerBalanceList {
    return [...providersbalance];
  }

  getTaskerBalanceId(id) {
    return providersbalance.firstWhere((res) => res.id == id);
  }

  Future getTaskerBalanceByBalanceId(balanceId) async {
    BalanceService req = BalanceService();
    ProviderBalance balanceSearch =
        await req.getTaskerBalanceByBalanceId(balanceId);
    notifyListeners();
    return balanceSearch;
  }

  Future getBalanceByTaskerNo(taskerNo) async {
    BalanceService req = BalanceService();
    ProviderBalance balanceSearch = await req.getBalanceByTaskerNo(taskerNo);
    notifyListeners();
    return balanceSearch;
  }

  Future<List<ProviderBalance>?> getTaskerBalances(page) async {
    BalanceService req = BalanceService();
    ProviderBalanceSearch? balanceSearch = await req.getTaskerBalances(page);
    if (balanceSearch!.data != null) {
      providersbalance = balanceSearch.data!;
      isNextable = balanceSearch.page! < balanceSearch.pages!;
      isPrevious = (balanceSearch.page! > 1);
      totalPages = balanceSearch.pages!;
      notifyListeners();
      return balanceSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getTaskerBalances(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getTaskerBalances(--currentPage);
      notifyListeners();
    }
  }

  Future<ProviderBalanceCreate> createBalanceTasker(
    provider,
    balance,
  ) async {
    final providerBalance = ProviderBalanceCreate(
      taskerId: provider,
      taskerBalance: balance,
    );
    BalanceService requests = BalanceService();
    await requests.createBalanceTasker(providerBalance);

    notifyListeners();
    return providerBalance;
  }

  Future<ProviderBalanceUpdate?> rechargeBalanceTasker(updatedBooking) async {
    BalanceService requests = BalanceService();
    ProviderBalanceUpdate? balance =
        await requests.rechargeBalanceTasker(updatedBooking);

    notifyListeners();
    return balance;
  }

  Future deleteBalanceTasker(balanceId) async {
    BalanceService requests = BalanceService();
    final result = await requests.deleteBalanceTasker(balanceId);

    notifyListeners();
    return result;
  }

  // customer endpoints
  get customerBalanceList {
    return [...customersbalance];
  }

  getCustomerBalanceId(id) {
    return customersbalance.firstWhere((res) => res.id == id);
  }

  Future getCustomerBalanceByBalanceId(balanceId) async {
    BalanceService req = BalanceService();
    CustomerBalance balanceSearch =
        await req.getCustomerBalanceByBalanceId(balanceId);
    notifyListeners();
    return balanceSearch;
  }

  Future getBalanceByCustomerNo(customerNo) async {
    BalanceService req = BalanceService();
    CustomerBalance balanceSearch =
        await req.getBalanceByCustomerNo(customerNo);
    notifyListeners();
    return balanceSearch;
  }

  Future<List<CustomerBalance>?> getCustomerBalances(page) async {
    BalanceService req = BalanceService();
    CustomerBalanceSearch balanceSearch = await req.getCustomerBalances(page);
    notifyListeners();

    customersbalance = balanceSearch.data!;
    isNextable = balanceSearch.page! < balanceSearch.pages!;
    isPrevious = (balanceSearch.page! > 1);
    totalPages = balanceSearch.pages!;
    return balanceSearch.data;
  }

  Future<void> goNextCustomer() async {
    if (isNextable) {
      await getCustomerBalances(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPreviousCustomer() async {
    if (isPrevious) {
      await getCustomerBalances(--currentPage);
      notifyListeners();
    }
  }

  Future<CustomerBalanceCreate> createBalanceCustomer(
    customer,
    balance,
  ) async {
    final customerBalance = CustomerBalanceCreate(
      customerId: customer,
      customerBalance: balance,
    );
    BalanceService requests = BalanceService();
    await requests.createBalanceCustomer(customerBalance);

    notifyListeners();
    return customerBalance;
  }

  Future<CustomerBalanceUpdate?> rechargeBalanceCustomer(updatedBooking) async {
    BalanceService requests = BalanceService();
    CustomerBalanceUpdate? balance =
        await requests.rechargeBalanceCustomer(updatedBooking);

    notifyListeners();
    return balance;
  }

  Future deleteBalanceCustomer(balanceId) async {
    BalanceService requests = BalanceService();
    final result = await requests.deleteBalanceCustomer(balanceId);

    notifyListeners();
    return result;
  }
}
