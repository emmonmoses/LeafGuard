// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/models/administrator/admin_create.dart';
import 'package:leafguard/models/administrator/admin_search.dart';
import 'package:leafguard/services/administrator/adminService.dart';

class AdministratorFactory with ChangeNotifier {
  List<Administrator> admins = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get administratorList {
    return [...admins];
  }

  getAdminId(id) {
    return admins.firstWhere((res) => res.id == id);
  }

  Future getAdminById(companyId) async {
    AdministratorService req = AdministratorService();
    Administrator adminSearch = await req.getAdminById(companyId);
    notifyListeners();
    return adminSearch;
  }

  Future<List<Administrator>?> getAllAdmins(page) async {
    AdministratorService req = AdministratorService();
    AdministratorSearch? adminSearch = await req.getAdmins(page);

    if (adminSearch!.data != null) {
      admins = adminSearch.data!;
      isNextable = adminSearch.page! < adminSearch.pages!;
      isPrevious = (adminSearch.page! > 1);
      totalPages = adminSearch.pages!;
      notifyListeners();
      return adminSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllAdmins(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllAdmins(--currentPage);
      notifyListeners();
    }
  }

  Future<AdministratorCreate> createAdmin(
    name,
    email,
    username,
    password,
    status,
  ) async {
    final admin = AdministratorCreate(
      name: name,
      email: email,
      username: username,
      password: password,
      status: status,
    );
    AdministratorService requests = AdministratorService();
    await requests.createAdmin(admin);

    notifyListeners();
    return admin;
  }

  Future<Administrator?> updateAdmin(updatedAdmin) async {
    AdministratorService requests = AdministratorService();
    Administrator? admin = await requests.updateAdmin(updatedAdmin);

    notifyListeners();
    return admin;
  }

  Future deleteAdmin(adminId) async {
    AdministratorService requests = AdministratorService();
    final result = await requests.deleteAdmin(adminId);

    notifyListeners();
    return result;
  }
}
