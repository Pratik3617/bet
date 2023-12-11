// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class GameSelector with ChangeNotifier {
  String activeMatrix = 'A';
  String prevActiveMatrix = 'A';

  Map<String, bool> checkBoxValues = {
    'A': true,
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

  List<List<List<String?>>> matrixList = List.generate(
      20, (index) => List.generate(10, (i) => List.generate(10, (j) => "")));

  setCheckBoxes() {
    if (prevActiveMatrix.length == 1) {
      checkBoxValues[prevActiveMatrix] = true;
    } else if (prevActiveMatrix == "AT") {
      atIsChecked = true;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = true);
    } else if (prevActiveMatrix == "AJ") {
      ajIsChecked = true;
      checkBoxValues.forEach((k, v) {
        if (k == "A" ||
            k == "B" ||
            k == "C" ||
            k == "D" ||
            k == "E" ||
            k == "F" ||
            k == "G" ||
            k == "H" ||
            k == "I" ||
            k == "J") {
          checkBoxValues[k] = true;
        }
      });
    } else if (prevActiveMatrix == "KT") {
      ktIsChecked = true;
      checkBoxValues.forEach((k, v) {
        if (k == "K" ||
            k == "L" ||
            k == "M" ||
            k == "N" ||
            k == "O" ||
            k == "P" ||
            k == "Q" ||
            k == "R" ||
            k == "S" ||
            k == "T") {
          checkBoxValues[k] = true;
        }
      });
    }
  }

  SelectionType getSelectionType() {
    if (prevActiveMatrix.length == 1) {
      return SelectionType.SINGLE;
    } else if (prevActiveMatrix == "AT") {
      return SelectionType.ATOT;
    } else if (prevActiveMatrix == "AJ") {
      return SelectionType.ATOJ;
    } else if (prevActiveMatrix == "KT") {
      return SelectionType.KTOT;
    }
    return SelectionType.SINGLE;
  }

  void toggleAT(bool? value) {
    if (value == true) {
      prevActiveMatrix = activeMatrix;
      activeMatrix = "AT";
      atIsChecked = value!;
      ajIsChecked = !value;
      ktIsChecked = !value;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = true);
      handleMultipleCheckboxChange(value, SelectionType.ATOT);
    } else {
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      activeMatrix = prevActiveMatrix;
      setCheckBoxes();
      atIsChecked = value!;
      handleMultipleCheckboxChange(value, getSelectionType());
    }
    notifyListeners();
  }

  void toggleAJ(bool? value) {
    if (value == true) {
      prevActiveMatrix = activeMatrix;
      activeMatrix = "AJ";
      atIsChecked = !value!;
      ajIsChecked = value;
      ktIsChecked = !value;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      checkBoxValues.forEach((k, v) {
        if (k == "A" ||
            k == "B" ||
            k == "C" ||
            k == "D" ||
            k == "E" ||
            k == "F" ||
            k == "G" ||
            k == "H" ||
            k == "I" ||
            k == "J") {
          checkBoxValues[k] = true;
        }
      });
      handleMultipleCheckboxChange(value, SelectionType.ATOJ);
    } else {
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      activeMatrix = prevActiveMatrix;
      setCheckBoxes();
      ajIsChecked = value!;
      handleMultipleCheckboxChange(value, getSelectionType());
    }
    notifyListeners();
  }

  void toggleKT(bool? value) {
    if (value == true) {
      prevActiveMatrix = activeMatrix;
      activeMatrix = "KT";
      atIsChecked = !value!;
      ajIsChecked = !value;
      ktIsChecked = value;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      checkBoxValues.forEach((k, v) {
        if (k == "K" ||
            k == "L" ||
            k == "M" ||
            k == "N" ||
            k == "O" ||
            k == "P" ||
            k == "Q" ||
            k == "R" ||
            k == "S" ||
            k == "T") {
          checkBoxValues[k] = true;
        }
      });
      handleMultipleCheckboxChange(value, SelectionType.KTOT);
    } else {
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      activeMatrix = prevActiveMatrix;
      setCheckBoxes();
      ktIsChecked = value!;
      handleMultipleCheckboxChange(value, getSelectionType());
    }
    notifyListeners();
  }

  void toggleAll(bool? value) {
    if (value == true) {
      allIsChecked = value!;
      evenIsChecked = !value;
      oddIsChecked = !value;
    } else {
      allIsChecked = value!;
    }
    notifyListeners();
  }

  void toggleEven(bool? value) {
    if (value == true) {
      allIsChecked = !value!;
      evenIsChecked = value;
      oddIsChecked = !value;
    } else {
      evenIsChecked = value!;
    }
    notifyListeners();
  }

  void toggleOdd(bool? value) {
    if (value == true) {
      allIsChecked = !value!;
      evenIsChecked = !value;
      oddIsChecked = value;
    } else {
      oddIsChecked = value!;
    }
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
        matrixList[selectedAlphabet][i][j] = textValue != "" ? textValue : "";
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

  void handleMultipleCheckboxChange(bool value, SelectionType type) {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        String? textValue = controllers[i][j].text;
        if (prevActiveMatrix.length == 1) {
          matrixList[checkbox.indexOf(prevActiveMatrix)][i][j] =
              textValue != "" ? textValue : "";
        } else if (prevActiveMatrix == "AT") {
          for (int k = 0; k < 20; k++) {
            matrixList[k][i][j] = textValue != "" ? textValue : "";
          }
        } else if (prevActiveMatrix == "AJ") {
          for (int k = 0; k < 10; k++) {
            matrixList[k][i][j] = textValue != "" ? textValue : "";
          }
        } else if (prevActiveMatrix == "KT") {
          for (int k = 10; k < 20; k++) {
            matrixList[k][i][j] = textValue != "" ? textValue : "";
          }
        }
      }
    }
    // if (value) {
    switch (type) {
      case SelectionType.SINGLE:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              controllers[i][j].text =
                  matrixList[checkbox.indexOf(prevActiveMatrix)][i][j]
                      .toString();
            }
          }
        }
        break;
      case SelectionType.ATOT:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              for (int k = 0; k < 20; k++) {
                controllers[i][j].text = matrixList[k][i][j].toString();
              }
            }
          }
        }
        break;
      case SelectionType.ATOJ:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              for (int k = 0; k < 10; k++) {
                controllers[i][j].text = matrixList[k][i][j].toString();
              }
            }
          }
        }
        break;
      case SelectionType.KTOT:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              for (int k = 10; k < 20; k++) {
                controllers[i][j].text = matrixList[k][i][j].toString();
              }
            }
          }
        }
        break;
    }
    // } else {
    //   if (activeMatrix.length == 1) {
    //     selectedAlphabet = checkbox.indexOf(activeMatrix);
    //     for (int i = 0; i < 10; i++) {
    //       for (int j = 0; j < 10; j++) {
    //         controllers[i][j].text =
    //             matrixList[selectedAlphabet][i][j].toString();
    //       }
    //     }
    //   } else if (activeMatrix == "AT") {
    //   } else if (activeMatrix == "AJ") {
    //   } else if (activeMatrix == "KT") {}
    // }
    notifyListeners();
  }
}

enum SelectionType { SINGLE, ATOT, ATOJ, KTOT }
