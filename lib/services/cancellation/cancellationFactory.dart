// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/models/cancellation/cancellation.dart';
import 'package:leafguard/models/cancellation/cancellation_create.dart';
import 'package:leafguard/models/cancellation/cancellation_search.dart';
import 'package:leafguard/models/cancellation/cancellation_update.dart';

// Project imports:
import 'package:leafguard/services/cancellation/cancellationService.dart';

class CancellationFactory with ChangeNotifier {
  List<CancellationRules> cancellations = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get cancellationList {
    return [...cancellations];
  }

  getCancellationId(id) {
    return cancellations.firstWhere((res) => res.id == id);
  }

  Future getCancellationById(cancellationId) async {
    CancellationService req = CancellationService();
    CancellationRules experienceSearch =
        await req.getCancellationRulesById(cancellationId);

    notifyListeners();
    return experienceSearch;
  }

  Future<List<CancellationRules>?> getAllCancellations(page) async {
    CancellationService req = CancellationService();
    CancellationRulesSearch? experienceSearch =
        await req.getCancellations(page);

    if (experienceSearch!.data != null) {
      cancellations = experienceSearch.data!;
      isNextable = experienceSearch.page! < experienceSearch.pages!;
      isPrevious = (experienceSearch.page! > 1);
      totalPages = experienceSearch.pages!;
      notifyListeners();
      return experienceSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllCancellations(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllCancellations(--currentPage);
      notifyListeners();
    }
  }

  Future<CancellationRuleCreate> createCancellation(
    name,
    type,
    status,
  ) async {
    final cancellation = CancellationRuleCreate(
      cancellation_reason: name,
      cancellation_user_type: type,
      cancellation_status: status,
    );
    CancellationService requests = CancellationService();
    await requests.createCancellationRules(cancellation);

    notifyListeners();
    return cancellation;
  }

  Future<CancellationRuleUpdate?> updateCancellation(
      updatedCancellation) async {
    CancellationService requests = CancellationService();
    CancellationRuleUpdate? cancellation =
        await requests.updateCancellationRules(updatedCancellation);

    notifyListeners();
    return cancellation;
  }

  Future deleteCancellation(cancellationId) async {
    CancellationService requests = CancellationService();
    final result = await requests.deleteCancellationRules(cancellationId);

    notifyListeners();
    return result;
  }
}
