// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/customer/customer.dart';
import 'package:leafguard/models/customer/customer_create.dart';
import 'package:leafguard/models/customer/customer_search.dart';
import 'package:leafguard/services/customer/customerService.dart';

class CustomerFactory with ChangeNotifier {
  List<Customer> customers = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get customerList {
    return [...customers];
  }

  getCustomerId(id) {
    return customers.firstWhere((res) => res.id == id);
  }

  Future getCustomerById(customerId) async {
    CustomerService req = CustomerService();
    Customer userSearch = await req.getCustomerById(customerId);
    notifyListeners();
    return userSearch;
  }

  Future<List<Customer>?> getAllCustomers(page) async {
    CustomerService req = CustomerService();
    CustomerSearch? userSearch = await req.getCustomers(page);

    if (userSearch!.data != null) {
      customers = userSearch.data!;
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
      await getAllCustomers(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllCustomers(--currentPage);
      notifyListeners();
    }
  }

  Future<CustomerCreate> createCustomer(status, name, email, username, password,
      address, phone, profile, dateOfBirth, documentType, document) async {
    final user = CustomerCreate(
        status: status,
        name: name,
        email: email,
        username: username,
        password: password,
        address: address,
        phone: phone,
        avatar: profile,
        dateOfBirth: dateOfBirth,
        documentType: documentType,
        document: document);
    CustomerService requests = CustomerService();
    await requests.createCustomer(user);

    notifyListeners();
    return user;
  }

  Future<Customer?> updateCustomer(updatedCustomer) async {
    CustomerService requests = CustomerService();
    Customer? user = await requests.updateCustomer(updatedCustomer);

    notifyListeners();
    return user;
  }

  Future deleteCustomer(customerId) async {
    CustomerService requests = CustomerService();
    final result = await requests.deleteCustomer(customerId);

    notifyListeners();
    return result;
  }
}
