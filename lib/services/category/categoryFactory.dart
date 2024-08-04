// ignore_for_file: file_names, unnecessary_null_comparison

// Flutter imports:
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/category/category_create.dart';
import 'package:leafguard/models/category/category_search.dart';
import 'package:leafguard/services/category/categoryService.dart';

class CategoryFactory with ChangeNotifier {
  List<Category> categories = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get categoryList {
    return [...categories];
  }

  getCategoryId(id) {
    // var response = categories.firstWhere((res) => res.id == id);

    return categories.firstWhere((res) => res.id == id);
  }

  Future<String> getCategoryLogo(categoryLogo) async {
    CategoryService req = CategoryService();
    Uint8List logo = await req.getCategoryLogo(categoryLogo);
    notifyListeners();
    return base64Encode(logo);
  }

  Future<dynamic> uploadImage() async {
    CategoryService requests = CategoryService();
    var image = await requests.uploadImage();

    notifyListeners();
    return image;
  }

  Future getCategoryById(catId) async {
    CategoryService req = CategoryService();
    Category categorySearch = await req.getCategoryById(catId);
    notifyListeners();
    return categorySearch;
  }

  Future<List<Category>?> getAllCategories(page) async {
    CategoryService req = CategoryService();
    CategorySearch? categorySearch = await req.getCategories(page);

    if (categorySearch!.data != null) {
      categories = categorySearch.data!;
      notifyListeners();
      isNextable = categorySearch.page! < categorySearch.pages!;
      isPrevious = (categorySearch.page! > 1);
      totalPages = categorySearch.pages!;
      return categorySearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<List<Category>?> getAllCategoriesWithMorePageSize(page) async {
    CategoryService req = CategoryService();
    CategorySearch? categorySearch =
        await req.getCategoriesWithMorePageSize(page);

    if (categorySearch.data != null) {
      categories = categorySearch.data!;
      isNextable = categorySearch.page! < categorySearch.pages!;
      isPrevious = (categorySearch.page! > 1);
      totalPages = categorySearch.pages!;
      notifyListeners();
      return categorySearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllCategories(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllCategories(--currentPage);
      notifyListeners();
    }
  }

  Future<CategoryCreate> createCategory({
    name,
    maincategory,
    description,
    image,
    status,
    adminCommission,
    // agentCommission,
    discount,
    price,
    tax,
  }) async {
    final category = CategoryCreate(
      name: name,
      maincategoryId: maincategory,
      description: description,
      avatar: image,
      status: status,
      adminCommission: adminCommission,
      // agentCommission: agentCommission,
      discount: discount,
      price: price,
      tax: tax,
    );

    CategoryService requests = CategoryService();
    await requests.createCategory(category);

    notifyListeners();
    return category;
  }

  Future<Category?> updateCategory(updatedCategory) async {
    CategoryService requests = CategoryService();
    Category? category = await requests.updateCategory(updatedCategory);

    notifyListeners();
    return category;
  }

  Future deleteCategory(categoryId) async {
    CategoryService requests = CategoryService();
    final result = await requests.deleteCategory(categoryId);

    notifyListeners();
    return result;
  }

  Future<List<Category>?> getCategoriesByMainCategoryId(catId, page) async {
    CategoryService req = CategoryService();
    CategorySearch categorySearch =
        await req.getCategoriesByMainCategoryId(catId, page);
    notifyListeners();

    categories = categorySearch.data!;
    isNextable = categorySearch.page! < categorySearch.pages!;
    isPrevious = (categorySearch.page! > 1);
    totalPages = categorySearch.pages!;
    return categorySearch.data;
  }
}
