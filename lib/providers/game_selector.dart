import 'package:flutter/material.dart';

class GameSelector with ChangeNotifier {
  String activeMatrix = 'A';
  Map<String, bool> checkBoxValues = {
    'A': false, 'B': false, 'C': false, 'D': false, 'E': false, 'F': false, 'G': false, 'H': false, 'I': false, 'J': false,
    'K': false, 'L': false, 'M': false, 'N': false, 'O': false, 'P': false, 'Q': false, 'R': false, 'S': false, 'T': false,
  };

  List<String> checkbox = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T"];
  bool atIsChecked = false;
  bool ajIsChecked = false,ktIsChecked = false;
  bool allIsChecked = false,evenIsChecked = false,oddIsChecked = false;
  bool fpIsChecked = false;

  List<List<TextEditingController>> controllers = List.generate(10, (i) => List.generate(10, (j) => TextEditingController()));

  List<List<TextEditingController>> get newControllers {
    return controllers;
  }

  void toggleAT(bool? value) {
    atIsChecked = value!;
    notifyListeners();
  }

  void toggleAJ(bool? value) {
    ajIsChecked = value!;
    notifyListeners();
  }

  void toggleKT(bool? value) {
    ktIsChecked = value!;
    notifyListeners();
  }

  void toggleAll(bool? value) {
    allIsChecked = value!;
    notifyListeners();
  }

  void toggleEven(bool? value) {
    evenIsChecked = value!;
    notifyListeners();
  }

  void toggleOdd(bool? value) {
    oddIsChecked = value!;
    notifyListeners();
  }

  void toggleFP(bool? value) {
    fpIsChecked = value!;
    notifyListeners();
  }

  void handleCheckboxChange(String key, bool? value) {
      // Set all other checkboxes to false
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      // Set the selected checkbox to true
      if (value != null) {
        checkBoxValues[key] = value;
      }
      notifyListeners();
  }
}