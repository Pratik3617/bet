import 'package:flutter/material.dart';

class GameSelector with ChangeNotifier {
  String activeMatrix = 'A';
  Map<String, bool> checkBoxValues = {
    'A': false,
    'B': false,
    'C': false,
    'D': false,
    'E': false,
    'F': false,
    'G': false,
    'H': false,
    'I': false,
    'J': false,
    'K': false,
    'L': false,
    'M': false,
    'N': false,
    'O': false,
    'P': false,
    'Q': false,
    'R': false,
    'S': false,
    'T': false,
  };

  List<String> checkbox = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T"
  ];

  List<String> times = [
    "09:30:00 AM",
    "09:45:00 AM",
    "10:00:00 AM",
    "10:15:00 AM",
    "10:30:00 AM",
    "10:45:00 AM",
    "11:00:00 AM",
    "11:15:00 AM",
    "11:30:00 AM",
    "11:45:00 AM",
    "12:00:00 PM",
    "12:15:00 PM",
    "12:30:00 PM",
    "12:45:00 PM",
    "13:00:00 PM",
    "13:15:00 PM",
    "13:30:00 PM",
    "13:45:00 PM",
    "14:00:00 PM",
    "14:15:00 PM",
    "14:30:00 PM",
    "14:45:00 PM",
    "15:00:00 PM",
    "15:15:00 PM",
    "15:30:00 PM",
    "15:45:00 PM",
    "16:00:00 PM",
    "16:15:00 PM",
    "16:30:00 PM",
    "16:45:00 PM",
    "17:00:00 PM",
    "17:15:00 PM",
    "17:30:00 PM",
    "17:45:00 PM",
    "18:00:00 PM",
    "18:15:00 PM",
    "18:30:00 PM",
    "18:45:00 PM",
    "19:00:00 PM",
    "19:15:00 PM",
    "19:30:00 PM",
    "19:45:00 PM",
    "20:00:00 PM",
    "20:15:00 PM",
    "20:30:00 PM",
    "20:45:00 PM",
    "21:00:00 PM",
    "21:15:00 PM",
    "21:30:00 PM",
    "21:45:00 PM",
    "22:00:00 PM",
  ];
  bool atIsChecked = false;
  bool ajIsChecked = false, ktIsChecked = false;
  bool allIsChecked = false, evenIsChecked = false, oddIsChecked = false;
  bool fpIsChecked = false;
  int selectedAlphabet = 0;

  List<List<TextEditingController>> controllers = List.generate(
      10, (i) => List.generate(10, (j) => TextEditingController()));

  List<List<TextEditingController>> get newControllers {
    return controllers;
  }

  bool ShowTimeSheet = false;

  void loadTimeSheet() {
    // Simulate loading data, you can replace this with your actual data loading logic
    ShowTimeSheet = !ShowTimeSheet;
    notifyListeners();
  }

  List<List<List<int?>>> matrixList = List.generate(
      20, (index) => List.generate(10, (i) => List.generate(10, (j) => 0)));

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
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        String? textValue = controllers[i][j].text;
        matrixList[selectedAlphabet][i][j] =
            textValue != null ? int.tryParse(textValue) : null;
      }
    }
    // Set all other checkboxes to false
    checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
    // Set the selected checkbox to true
    if (value != null) {
      checkBoxValues[key] = value;

      selectedAlphabet = checkbox.indexOf(key);

      for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
          controllers[i][j].text =
              matrixList[selectedAlphabet][i][j].toString();
        }
      }
    }

    notifyListeners();
  }
}
