// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/experience/experience.dart';
import 'package:leafguard/models/experience/experience_create.dart';
import 'package:leafguard/models/experience/experience_search.dart';
import 'package:leafguard/models/experience/experience_update.dart';
import 'package:leafguard/services/experience/experienceService.dart';

class ExperienceFactory with ChangeNotifier {
  List<Experience> experiences = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get experienceList {
    return [...experiences];
  }

  getExperienceId(id) {
    return experiences.firstWhere((res) => res.id == id);
  }

  Future getExperienceById(experienceId) async {
    ExperienceService req = ExperienceService();
    Experience experienceSearch = await req.getExperienceById(experienceId);

    notifyListeners();
    return experienceSearch;
  }

  Future<List<Experience>?> getAllExperiences(page) async {
    ExperienceService req = ExperienceService();
    ExperienceSearch? experienceSearch = await req.getExperiences(page);

    if (experienceSearch!.data != null) {
      experiences = experienceSearch.data!;
      isNextable = experienceSearch.page! < experienceSearch.pages!;
      isPrevious = (experienceSearch.page! > 1);
      totalPages = experienceSearch.pages!;
      notifyListeners();
      return experienceSearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllExperiences(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllExperiences(--currentPage);
      notifyListeners();
    }
  }

  Future<ExperienceCreate> createExperience(
    name,
    status,
  ) async {
    final experience = ExperienceCreate(
      experience_tag: name,
      experience_status: status,
    );
    ExperienceService requests = ExperienceService();
    await requests.createExperience(experience);
    return experience;
  }

  Future<ExperienceUpdate?> updateExperience(updatedExperience) async {
    ExperienceService requests = ExperienceService();
    ExperienceUpdate? experience =
        await requests.updateExperience(updatedExperience);

    notifyListeners();
    return experience;
  }

  Future deleteExperience(experienceId) async {
    ExperienceService requests = ExperienceService();
    final result = await requests.deleteExperience(experienceId);

    notifyListeners();
    return result;
  }
}
