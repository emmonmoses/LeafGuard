// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/models/administrator/admin_search.dart';
import 'package:leafguard/models/administrator/subadmin_create.dart';
import 'package:leafguard/services/subadministrator/subadminService.dart';

class SubAdministratorFactory with ChangeNotifier {
  List<Administrator> subadmins = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get administratorList {
    return [...subadmins];
  }

  getSubAdminId(id) {
    return subadmins.firstWhere((res) => res.id == id);
  }

  Future getSubAdminById(companyId) async {
    SubAdministratorService req = SubAdministratorService();
    AdministratorSearch adminSearch = await req.getSubAdminById(companyId);
    notifyListeners();
    return adminSearch;
  }

  Future<List<Administrator>?> getAllAdmins(page) async {
    SubAdministratorService req = SubAdministratorService();
    AdministratorSearch? adminSearch = await req.getSubAdmins(page);

    if (adminSearch!.data != null) {
      subadmins = adminSearch.data!;
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

  Future<SubAdministratorCreate> createSubAdmin(
    name,
    email,
    username,
    password,
    status,
    priviledges,
  ) async {
    final admin = SubAdministratorCreate(
      name: name,
      email: email,
      username: username,
      password: password,
      status: status,
      permissions: priviledges,
    );
    SubAdministratorService requests = SubAdministratorService();
    await requests.createSubAdmin(admin);

    notifyListeners();
    return admin;
  }

  Future<Administrator?> updateAdmin(updatedAdmin) async {
    SubAdministratorService requests = SubAdministratorService();
    Administrator? admin = await requests.updateSubAdmin(updatedAdmin);

    notifyListeners();
    return admin;
  }

  Future deleteAdmin(adminId) async {
    SubAdministratorService requests = SubAdministratorService();
    final result = await requests.deleteSubAdmin(adminId);

    notifyListeners();
    return result;
  }

  Future deleteRole(roleId) async {
    SubAdministratorService requests = SubAdministratorService();
    final result = await requests.deleteRole(roleId);

    notifyListeners();
    return result;
  }
}
