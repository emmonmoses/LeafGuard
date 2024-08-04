// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/category_main/category_main.dart';
import 'package:leafguard/models/category_main/category_main_create.dart';
import 'package:leafguard/models/category_main/category_main_search.dart';
import 'package:leafguard/models/category_main/category_main_update.dart';
import 'package:leafguard/services/categorymain/categoryMainService.dart';

class MainCategoryFactory with ChangeNotifier {
  List<MainCategory> categories = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get categoryList {
    return [...categories];
  }

  getMainCategoryId(id) {
    // var response = categories.firstWhere((res) => res.id == id);
    return categories.firstWhere((res) => res.id == id);
  }

  Future getMainCategoryById(catId) async {
    MainCategoryService req = MainCategoryService();
    MainCategory categorySearch = await req.getMainCategoryById(catId);
    notifyListeners();
    return categorySearch;
  }

  Future<List<MainCategory>?> getAllMainCategories(page) async {
    MainCategoryService req = MainCategoryService();
    MainCategorySearch? categorySearch = await req.getMainCategories(page);
    if (categorySearch!.data != null) {
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
      await getAllMainCategories(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllMainCategories(--currentPage);
      notifyListeners();
    }
  }

  Future<MainCategoryCreate> createMainCategory(
    name,
    image,
    description,
  ) async {
    final category = MainCategoryCreate(
      name: name,
      image: image,
      description: description,
    );

    MainCategoryService requests = MainCategoryService();
    await requests.createMainCategory(category);

    notifyListeners();
    return category;
  }

  Future<MainCategoryUpdate?> updateMainCategory(updatedCategory) async {
    MainCategoryService requests = MainCategoryService();
    MainCategoryUpdate? category =
        await requests.updateMainCategory(updatedCategory);

    notifyListeners();
    return category;
  }

  Future deleteMainCategory(categoryId) async {
    MainCategoryService requests = MainCategoryService();
    final result = await requests.deleteMainCategory(categoryId);

    notifyListeners();
    return result;
  }
}
