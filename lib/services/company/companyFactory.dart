// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:leafguard/models/company/company.dart';
import 'package:leafguard/models/company/company_create.dart';
import 'package:leafguard/models/company/company_search.dart';
import 'package:leafguard/models/company/company_update.dart';
import 'package:leafguard/services/company/companyService.dart';

class CompanyFactory with ChangeNotifier {
  List<Company> companies = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get categoryList {
    return [...companies];
  }

  getCategoryId(id) {
    return companies.firstWhere((res) => res.id == id);
  }

  Future<dynamic> uploadImage(
      {required attachmentStream,
      required attachmentSize,
      required attachmentName}) async {
    CompanyService requests = CompanyService();
    var image = await requests.uploadCompanyLogo(
        attachmentName: attachmentName,
        attachmentSize: attachmentSize,
        attachmentStream: attachmentStream);

    notifyListeners();
    return image;
  }

  Future<Company?> getCompanyById(comId) async {
    CompanyService req = CompanyService();
    Company? company = await req.getCompanyById(comId);
    notifyListeners();
    return company;
  }

  Future<List<Company>?> getAllCompanies(page) async {
    CompanyService req = CompanyService();
    CompanySearch? companySearch = await req.getCompanies(page);

    if (companySearch!.data != null) {
      companies = companySearch.data!;
      isNextable = companySearch.page! < companySearch.pages!;
      isPrevious = (companySearch.page! > 1);
      totalPages = companySearch.pages!;
      notifyListeners();
      return companySearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllCompanies(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllCompanies(--currentPage);
      notifyListeners();
    }
  }

  Future<dynamic> createCompany(CompanyCreate model) async {
    CompanyService requests = CompanyService();
    var result = await requests.createCompany(model);

    notifyListeners();
    return result;
  }

  Future<dynamic> updateCompany(UpdateCompany model) async {
    CompanyService requests = CompanyService();
    var result = await requests.updateCompany(model);

    notifyListeners();
    return result;
  }

  Future deleteCompany(companyId) async {
    CompanyService requests = CompanyService();
    final result = await requests.deleteCompany(companyId);

    notifyListeners();
    return result;
  }
}
