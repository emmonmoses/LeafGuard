// ignore_for_file: file_names, unnecessary_null_comparison

// Flutter imports:

import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/billing/billing.dart';
import 'package:leafguard/models/billing/billing_create.dart';
import 'package:leafguard/models/billing/billing_search.dart';
import 'package:leafguard/models/billing/billing_update.dart';
import 'package:leafguard/services/billing/billingService.dart';

class BillingFactory with ChangeNotifier {
  List<Billing> billings = [];
  List<Billing> filteredBillingCycle = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get billingList {
    return [...billings];
  }

  getBillingId(id) {
    return billings.firstWhere((res) => res.id == id);
  }

  Future getBillingById(billingId) async {
    BillingService req = BillingService();
    Billing billingSearch = await req.getBillingById(billingId);

    notifyListeners();
    return billingSearch;
  }

  Future<List<Billing>?> getAllBillings(page) async {
    BillingService req = BillingService();
    BillingSearch? billingSearch = await req.getBillings(page);

    if (billingSearch.data != null) {
      billings = billingSearch.data!;
      isNextable = billingSearch.page! < billingSearch.pages!;
      isPrevious = (billingSearch.page! > 1);
      totalPages = billingSearch.pages!;
      notifyListeners();
      return billingSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllBillings(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllBillings(--currentPage);
      notifyListeners();
    }
  }

  Future<BillingCreate> createBilling(
    name,
    valid,
    expiry,
    status,
  ) async {
    final billing = BillingCreate(
      billing_period: name,
      valid_from: valid,
      valid_to: expiry,
      status: status,
    );

    BillingService requests = BillingService();
    await requests.createBilling(billing);
    return billing;
  }

  Future<BillingUpdate?> updateBilling(updatedBilling) async {
    BillingService requests = BillingService();
    BillingUpdate? billing = await requests.updateBilling(updatedBilling);

    notifyListeners();
    return billing;
  }

  Future deleteBilling(billingId) async {
    BillingService requests = BillingService();
    final result = await requests.deleteBilling(billingId);

    notifyListeners();
    return result;
  }

  Future<List<Billing>?> filterBillingPeriod(billId, page) async {
    BillingService req = BillingService();
    BillingSearch billSearch = await req.filterBillingPeriod(billId, page);
    notifyListeners();

    filteredBillingCycle = billSearch.data!;
    isNextable = billSearch.page! < billSearch.pages!;
    isPrevious = (billSearch.page! > 1);
    totalPages = billSearch.pages!;
    return billSearch.data;
  }
}
