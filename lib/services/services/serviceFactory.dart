// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/service/service.dart';
import 'package:leafguard/models/service/service_create.dart';
import 'package:leafguard/models/service/service_search.dart';
import 'package:leafguard/models/service/service_update.dart';
import 'package:leafguard/services/services/serviceProvider.dart';

class ServiceFactory with ChangeNotifier {
  List<Service> services = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get serviceList {
    return [...services];
  }

  getServiceId(id) {
    return services.firstWhere((res) => res.id == id);
  }

  Future getServiceById(serviceId) async {
    ServiceProvider req = ServiceProvider();
    ServiceSearch serviceSearch = await req.getServiceById(serviceId);
    notifyListeners();
    return serviceSearch;
  }

  Future<List<Service>?> getAllServices(page) async {
    ServiceProvider req = ServiceProvider();
    ServiceSearch? serviceSearch = await req.getServices(page);

    if (serviceSearch!.data != null) {
      services = serviceSearch.data!;
      isNextable = serviceSearch.page! < serviceSearch.pages!;
      isPrevious = (serviceSearch.page! > 1);
      totalPages = serviceSearch.pages!;
      notifyListeners();

      return serviceSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllServices(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllServices(--currentPage);
      notifyListeners();
    }
  }

  Future<ServiceCreate> createService(
      taskerId, categoryIds, description, createdBy) async {
    final subcategory = ServiceCreate(
        taskerId: taskerId,
        categoryId: categoryIds,
        description: description,
        createdBy: createdBy);

    ServiceProvider requests = ServiceProvider();
    await requests.createService(subcategory);

    notifyListeners();
    return subcategory;
  }

  Future<ServiceUpdate?> updateService(updatedService) async {
    ServiceProvider requests = ServiceProvider();
    ServiceUpdate? category = await requests.updateService(updatedService);

    notifyListeners();
    return category;
  }

  Future deleteService(serviceId) async {
    ServiceProvider requests = ServiceProvider();
    final result = await requests.deleteService(serviceId);

    notifyListeners();
    return result;
  }
}
