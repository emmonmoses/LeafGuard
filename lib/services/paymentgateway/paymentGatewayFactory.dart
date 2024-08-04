// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway_create.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway_search.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway_update.dart';

// Project imports:
import 'package:leafguard/services/paymentgateway/paymentGatewayService.dart';

class PaymentFactory with ChangeNotifier {
  List<PaymentGateway> paymentgateways = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get paymentgatewayList {
    return [...paymentgateways];
  }

  getPaymentGatewayId(id) {
    return paymentgateways.firstWhere((res) => res.id == id);
  }

  Future getPaymentGatewayById(paymentGatewayId) async {
    PaymentGatewayService req = PaymentGatewayService();
    PaymentGateway paymentGatewaySearch =
        await req.getPaymentGatewayById(paymentGatewayId);

    notifyListeners();
    return paymentGatewaySearch;
  }

  Future<List<PaymentGateway>?> getAllPaymentGateways(page) async {
    PaymentGatewayService req = PaymentGatewayService();
    PaymentGatewaySearch? paymentGatewaySearch =
        await req.getPaymentGateways(page);

    if (paymentGatewaySearch!.data != null) {
      paymentgateways = paymentGatewaySearch.data!;
      isNextable = paymentGatewaySearch.page! < paymentGatewaySearch.pages!;
      isPrevious = (paymentGatewaySearch.page! > 1);
      totalPages = paymentGatewaySearch.pages!;
      notifyListeners();
      return paymentGatewaySearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllPaymentGateways(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllPaymentGateways(--currentPage);
      notifyListeners();
    }
  }

  Future<PaymentGatewayCreate> createPaymentGateway(
    name,
    alias,
    settings,
    status,
  ) async {
    final paymentgateway = PaymentGatewayCreate(
      payment_gateway: name,
      gateway_alias: alias,
      gateway_settings: settings,
      status: status,
    );
    PaymentGatewayService requests = PaymentGatewayService();
    await requests.createPaymentGateway(paymentgateway);

    notifyListeners();
    return paymentgateway;
  }

  Future<PaymentGatewayUpdate?> updatePaymentGateway(
      updatePaymentGateway) async {
    PaymentGatewayService requests = PaymentGatewayService();
    PaymentGatewayUpdate? paymentgateway =
        await requests.updatePaymentGateway(updatePaymentGateway);

    notifyListeners();
    return paymentgateway;
  }

  Future deletePaymentGateway(paymentGatewayId) async {
    PaymentGatewayService requests = PaymentGatewayService();
    final result = await requests.deletePaymentGateway(paymentGatewayId);

    notifyListeners();
    return result;
  }
}
