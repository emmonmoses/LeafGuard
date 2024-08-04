// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/models/witness/witness_create.dart';
import 'package:leafguard/models/witness/witness_search.dart';
import 'package:leafguard/models/witness/witness.dart';
import 'package:leafguard/models/witness/witness_update.dart';
import 'package:leafguard/models/witness/witnesses.dart';
import 'package:leafguard/models/witness/witnessresponse.dart';
import 'package:leafguard/services/witness/witnessService.dart';

class WitnessFactory with ChangeNotifier {
  List<Witnesses> witnesses = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;
  // String taskerId = "6507fb3932e98efc9327465a";

  get witnessList {
    return [...witnesses];
  }

  getWitnessId(id) {
    return witnesses.firstWhere((res) => res.id == id);
  }

  Future getWitnessById(witnessId) async {
    WitnessService req = WitnessService();
    WitnessSearch witnessSearch = await req.getWitnessById(witnessId);
    notifyListeners();
    return witnessSearch;
  }

  Future<List<Witnesses>?> getAllWitnesses(page) async {
    WitnessService req = WitnessService();
    WitnessSearch? witnessSearch = await req.getWitnesses(page);

    if (witnessSearch!.data != null) {
      witnesses = witnessSearch.data!;
      isNextable = witnessSearch.page! < witnessSearch.pages!;
      isPrevious = (witnessSearch.page! > 1);
      totalPages = witnessSearch.pages!;
      notifyListeners();

      return witnessSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<List<WitnessResponse>?> getWitnessByTaskerId(taskerId) async {
    WitnessService req = WitnessService();
    List<WitnessResponse>? witnessSearch =
        await req.getWitnessByTaskerId(taskerId);
    notifyListeners();
    return witnessSearch;
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllWitnesses(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllWitnesses(--currentPage);
      notifyListeners();
    }
  }

  Future<WitnessCreate> createWitness(
    taskerId,
    List<Witness> witnesses,
  ) async {
    final witness = WitnessCreate(
      taskerId: taskerId,
      taskerWitnesses: witnesses,
    );

    WitnessService requests = WitnessService();
    await requests.createWitness(witness);

    notifyListeners();
    return witness;
  }

  Future<WitnessUpdate?> updateWitness(updatedWitness) async {
    WitnessService requests = WitnessService();
    WitnessUpdate? witness = await requests.updateWitness(updatedWitness);

    notifyListeners();
    return witness;
  }

  Future deleteAllWitness(witnessId) async {
    WitnessService requests = WitnessService();
    final result = await requests.deleteAllWitness(witnessId);

    notifyListeners();
    return result;
  }

  Future deleteSpecificWitness(witnessId) async {
    WitnessService requests = WitnessService();
    final result = await requests.deleteSpecificWitness(witnessId);

    notifyListeners();
    return result;
  }
}
