import 'dart:async';

import 'package:edental/providers/dentistService.dart';
import 'package:edental/providers/recommendationService.dart';
import 'package:flutter/material.dart';
import 'package:edental/models/dentist.dart';

import '../models/user.dart';

class DentistProvider extends ChangeNotifier {
  List<Dentist> _dentist = [];
  List<DropdownMenuItem> dropdownItems = [];
  late final User _user;
  List<Dentist> get dentists => [..._dentist];
  List<Dentist> recommendedDentists = [];
  final DentistService dentistService = DentistService();
  RecommendationService recommendationService = RecommendationService();
  int? _selectedDentistId;
  DentistProvider(User? user) {
    if (user != null) {
      _user = user;
      recommendationService = RecommendationService(
          username: _user.username, password: _user.password);
    }
  }

  Future<List<Dentist>> getDentistsAsync() async =>
      _dentist.isEmpty ? dentistService.getAll() : Future.value(dentists);
  List<Dentist> getDentists() {
    dentistService.getAll().then((val) {
      _dentist = val;
    }).onError((error, stackTrace) {
      _dentist = [];
    });
    return dentists;
  }

  List<DropdownMenuItem> getDentistsDropdown() {
    if (_dentist.isNotEmpty) {
      dropdownItems = dentists
          .map((dentist) => DropdownMenuItem(
              value: dentist,
              child: Padding(
                padding: const EdgeInsets.only(right: 87.0),
                child: Text(
                  dentist.fullName,
                  textAlign: TextAlign.start,
                ),
              )))
          .toList();
      return dropdownItems;
    }
    return [];
  }

  Future<List<Dentist>> getRecommendedDentistAsync({int id = 1}) async {
    if (_selectedDentistId != id) {
      recommendedDentists = await recommendationService.getMultipleById(
        id,
      );
      _selectedDentistId = id;
      return recommendedDentists;
    }
    return Future.value(recommendedDentists);
  }

  Future<List<Dentist>> getOtherDentistAsync({int id = 1}) async {
    if (dentists.isEmpty) {
      _dentist = await getDentistsAsync();
      notifyListeners();
    }
    return dentists
        .where((element) => !recommendedDentists.contains(element))
        .toList();
  }
}
