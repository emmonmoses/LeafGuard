// ignore_for_file: file_names

// Flutter imports:

import 'package:flutter/material.dart';
import 'package:leafguard/models/tax/tax.dart';
import 'package:leafguard/models/tax/tax_create.dart';
import 'package:leafguard/models/tax/tax_search.dart';
import 'package:leafguard/models/tax/tax_update.dart';

// Project imports:

import 'package:leafguard/services/tax/taxService.dart';

class TaxFactory with ChangeNotifier {
  List<Tax> taxes = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get taxList {
    return [...taxes];
  }

  getTaxId(id) {
    return taxes.firstWhere((res) => res.id == id);
  }

  Future getTaxById(taxId) async {
    TaxService req = TaxService();
    Tax taxSearch = await req.getTaxById(taxId);

    notifyListeners();
    return taxSearch;
  }

  Future<List<Tax>?> getAllTaxes(page) async {
    TaxService req = TaxService();
    TaxSearch? taxSearch = await req.getTaxes(page);

    if (taxSearch!.data != null) {
      taxes = taxSearch.data!;
      isNextable = taxSearch.page! < taxSearch.pages!;
      isPrevious = (taxSearch.page! > 1);
      totalPages = taxSearch.pages!;
      notifyListeners();
      return taxSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllTaxes(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllTaxes(--currentPage);
      notifyListeners();
    }
  }

  Future<TaxCreate> createTax(
    name,
    amount,
    description,
    status,
  ) async {
    final tax = TaxCreate(
      name: name,
      rate: amount,
      description: description,
      status: status,
    );

    TaxService requests = TaxService();
    await requests.createTax(tax);
    return tax;
  }

  Future<TaxUpdate?> updateTax(updatedTax) async {
    TaxService requests = TaxService();
    TaxUpdate? tax = await requests.updateTax(updatedTax);

    notifyListeners();
    return tax;
  }

  Future deleteTax(taxId) async {
    TaxService requests = TaxService();
    final result = await requests.deleteTax(taxId);

    notifyListeners();
    return result;
  }
}
