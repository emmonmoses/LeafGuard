// ignore_for_file: file_names

// Flutter imports:

import 'package:flutter/material.dart';
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/discount/discount_create.dart';
import 'package:leafguard/models/discount/discount_search.dart';
import 'package:leafguard/models/discount/discount_update.dart';

// Project imports:

import 'package:leafguard/services/discount/discountService.dart';

class DiscountFactory with ChangeNotifier {
  List<Discount> discounts = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get couponList {
    return [...discounts];
  }

  getDiscountId(id) {
    return discounts.firstWhere((res) => res.id == id);
  }

  Future getDiscountById(couponId) async {
    DiscountService req = DiscountService();
    Discount couponSearch = await req.getDiscountById(couponId);

    notifyListeners();
    return couponSearch;
  }

  Future<List<Discount>?> getAllDiscounts(page) async {
    DiscountService req = DiscountService();
    DiscountSearch? couponSearch = await req.getDiscounts(page);
    if (couponSearch!.data != null) {
      discounts = couponSearch.data!;
      isNextable = couponSearch.page! < couponSearch.pages!;
      isPrevious = (couponSearch.page! > 1);
      totalPages = couponSearch.pages!;
      notifyListeners();
      return couponSearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllDiscounts(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllDiscounts(--currentPage);
      notifyListeners();
    }
  }

  Future<DiscountCreate> createDiscount(
    name,
    code,
    discount,
    description,
    rate,
    valid,
    expiry,
    status,
  ) async {
    final coupon = DiscountCreate(
      name: name,
      code: code,
      discount_type: discount,
      description: description,
      rate: rate,
      valid_from: valid,
      expiry_date: expiry,
      status: status,
    );

    DiscountService requests = DiscountService();
    await requests.createDiscount(coupon);
    return coupon;
  }

  Future<DiscountUpdate?> updateDiscount(updatedDiscount) async {
    DiscountService requests = DiscountService();
    DiscountUpdate? coupon = await requests.updateDiscount(updatedDiscount);

    notifyListeners();
    return coupon;
  }

  Future deleteDiscount(couponId) async {
    DiscountService requests = DiscountService();
    final result = await requests.deleteDiscount(couponId);

    notifyListeners();
    return result;
  }
}
