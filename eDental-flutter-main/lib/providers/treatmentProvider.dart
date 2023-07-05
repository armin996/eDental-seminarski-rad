import 'package:edental/providers/treatmentService.dart';
import 'package:flutter/material.dart';

import '../models/treatment.dart';

class TreatmentProvider extends ChangeNotifier {
  List<Treatment> _treatments = [];
  List<Treatment> get treatments => [..._treatments];
  TreatmentService _service = TreatmentService();
  TreatmentProvider(userName, password) {
    _service = TreatmentService(username: userName, password: password);
  }
  Future<List<Treatment>> getTreatments() async {
    if (_treatments.isEmpty) {
      final result = await _service.getAll();
      _treatments = result;
      notifyListeners();
    }
    return treatments;
  }

  List<DropdownMenuItem> getDropdown() => treatments
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e.name,
            ),
          ))
      .toList();
}
