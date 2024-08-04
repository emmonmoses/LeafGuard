// Flutter imports:
// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/foundation.dart';
import 'package:leafguard/models/transactions/transaction.dart';
import 'package:leafguard/models/transactions/transaction_search.dart';
import 'package:leafguard/services/transaction/transactionService.dart';

class TransactionFactory with ChangeNotifier {
  List<Transaction>? transactions = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get transactionList {
    return [...transactions!];
  }

  getTransactionId(id) {
    return transactions!.firstWhere((res) => res.id == id);
  }

  Future<List<Transaction>?> getTransactions(page) async {
    TransactionService req = TransactionService();
    TransactionSearch? transactionSearch = await req.getTransactions(page);

    if (transactionSearch!.data != null) {
      transactions = transactionSearch.data;
      isNextable = transactionSearch.page! < transactionSearch.pages!;
      isPrevious = (transactionSearch.page! > 1);
      totalPages = transactionSearch.pages!;
      notifyListeners();

      return transactionSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<List<Transaction>?> getTransactionsByCreator(page, createdBy) async {
    TransactionService req = TransactionService();
    TransactionSearch? transactionSearch =
        await req.getTransactionsByCreator(page, createdBy);
    notifyListeners();

    transactions = transactionSearch?.data;
    isNextable = transactionSearch!.page! < transactionSearch.pages!;
    isPrevious = (transactionSearch.page! > 1);
    totalPages = transactionSearch.pages!;
    return transactionSearch.data;
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getTransactions(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getTransactions(--currentPage);
      notifyListeners();
    }
  }
}
