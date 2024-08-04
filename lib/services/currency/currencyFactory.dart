// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/currency/currency.dart';
import 'package:leafguard/models/currency/currency_create.dart';
import 'package:leafguard/models/currency/currency_search.dart';
import 'package:leafguard/models/currency/currency_update.dart';
import 'package:leafguard/services/currency/currencyService.dart';

class CurrencyFactory with ChangeNotifier {
  List<Currency> currencies = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get currencyList {
    return [...currencies];
  }

  getCurrencyId(id) {
    return currencies.firstWhere((res) => res.id == id);
  }

  Future getCurrencyById(currencyId) async {
    CurrencyService req = CurrencyService();
    Currency experienceSearch = await req.getCurrencyById(currencyId);

    notifyListeners();
    return experienceSearch;
  }

  Future<List<Currency>?> getAllCurrencies(page) async {
    CurrencyService req = CurrencyService();
    CurrencySearch? experienceSearch = await req.getCurrencies(page);
    if (experienceSearch!.data != null) {
      currencies = experienceSearch.data!;
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
      await getAllCurrencies(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllCurrencies(--currentPage);
      notifyListeners();
    }
  }

  Future<CurrencyCreate> createCurrency(
    name,
    code,
    symbol,
    value,
    status,
  ) async {
    final currency = CurrencyCreate(
      currency_name: name,
      currency_code: code,
      currency_symbol: symbol,
      currency_value: value,
      currency_status: status,
    );
    CurrencyService requests = CurrencyService();
    await requests.createCurrency(currency);
    return currency;
  }

  Future<CurrencyUpdate?> updateCurrency(updatedCurrency) async {
    CurrencyService requests = CurrencyService();
    CurrencyUpdate? currency = await requests.updateCurrency(updatedCurrency);

    notifyListeners();
    return currency;
  }

  Future deleteCurrency(currencyId) async {
    CurrencyService requests = CurrencyService();
    final result = await requests.deleteCurrency(currencyId);

    notifyListeners();
    return result;
  }
}
