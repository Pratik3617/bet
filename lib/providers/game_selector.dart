// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeState {
  bool active;
  bool selected;

  TimeState({required this.active, required this.selected});
}

class GameSelector with ChangeNotifier {
  late Timer _timer5;
  GameSelector() {
    _timer5 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setTimeCheckBoxesState();
    });
  }

  setTimeCheckBoxesState() async {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    DateTime tomorrowTime =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0, 0, 0);

    for (var time in times) {
      if (isTimePassed(time, showNextDayTimes ? tomorrowTime : now)) {
        timesValues[time]!.active = false;
        timesValues[time]!.selected = false;
      } else {
        timesValues[time]!.active = true;
      }
    }
    notifyListeners();
  }

  String activeMatrix = 'A';
  String prevActiveMatrix = 'A';

  bool? selectedToday;
  bool showNextDayTimes = false;
  bool showTimes = false;
  bool allTimesSelected = false;

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

  Map<String, TimeState> timesValues = {
    "09:30 AM": TimeState(active: true, selected: false),
    "09:45 AM": TimeState(active: true, selected: false),
    "10:00 AM": TimeState(active: true, selected: false),
    "10:15 AM": TimeState(active: true, selected: false),
    "10:30 AM": TimeState(active: true, selected: false),
    "10:45 AM": TimeState(active: true, selected: false),
    "11:00 AM": TimeState(active: true, selected: false),
    "11:15 AM": TimeState(active: true, selected: false),
    "11:30 AM": TimeState(active: true, selected: false),
    "11:45 AM": TimeState(active: true, selected: false),
    "12:00 PM": TimeState(active: true, selected: false),
    "12:15 PM": TimeState(active: true, selected: false),
    "12:30 PM": TimeState(active: true, selected: false),
    "12:45 PM": TimeState(active: true, selected: false),
    "01:00 PM": TimeState(active: true, selected: false),
    "01:15 PM": TimeState(active: true, selected: false),
    "01:30 PM": TimeState(active: true, selected: false),
    "01:45 PM": TimeState(active: true, selected: false),
    "02:00 PM": TimeState(active: true, selected: false),
    "02:15 PM": TimeState(active: true, selected: false),
    "02:30 PM": TimeState(active: true, selected: false),
    "02:45 PM": TimeState(active: true, selected: false),
    "03:00 PM": TimeState(active: true, selected: false),
    "03:15 PM": TimeState(active: true, selected: false),
    "03:30 PM": TimeState(active: true, selected: false),
    "03:45 PM": TimeState(active: true, selected: false),
    "04:00 PM": TimeState(active: true, selected: false),
    "04:15 PM": TimeState(active: true, selected: false),
    "04:30 PM": TimeState(active: true, selected: false),
    "04:45 PM": TimeState(active: true, selected: false),
    "05:00 PM": TimeState(active: true, selected: false),
    "05:15 PM": TimeState(active: true, selected: false),
    "05:30 PM": TimeState(active: true, selected: false),
    "05:45 PM": TimeState(active: true, selected: false),
    "06:00 PM": TimeState(active: true, selected: false),
    "06:15 PM": TimeState(active: true, selected: false),
    "06:30 PM": TimeState(active: true, selected: false),
    "06:45 PM": TimeState(active: true, selected: false),
    "07:00 PM": TimeState(active: true, selected: false),
    "07:15 PM": TimeState(active: true, selected: false),
    "07:30 PM": TimeState(active: true, selected: false),
    "07:45 PM": TimeState(active: true, selected: false),
    "08:00 PM": TimeState(active: true, selected: false),
    "08:15 PM": TimeState(active: true, selected: false),
    "08:30 PM": TimeState(active: true, selected: false),
    "08:45 PM": TimeState(active: true, selected: false),
    "09:00 PM": TimeState(active: true, selected: false),
    "09:15 PM": TimeState(active: true, selected: false),
    "09:30 PM": TimeState(active: true, selected: false),
    "09:45 PM": TimeState(active: true, selected: false),
    "10:00 PM": TimeState(active: true, selected: false)
  };

  List<String> times = [
    "09:30 AM",
    "09:45 AM",
    "10:00 AM",
    "10:15 AM",
    "10:30 AM",
    "10:45 AM",
    "11:00 AM",
    "11:15 AM",
    "11:30 AM",
    "11:45 AM",
    "12:00 PM",
    "12:15 PM",
    "12:30 PM",
    "12:45 PM",
    "01:00 PM",
    "01:15 PM",
    "01:30 PM",
    "01:45 PM",
    "02:00 PM",
    "02:15 PM",
    "02:30 PM",
    "02:45 PM",
    "03:00 PM",
    "03:15 PM",
    "03:30 PM",
    "03:45 PM",
    "04:00 PM",
    "04:15 PM",
    "04:30 PM",
    "04:45 PM",
    "05:00 PM",
    "05:15 PM",
    "05:30 PM",
    "05:45 PM",
    "06:00 PM",
    "06:15 PM",
    "06:30 PM",
    "06:45 PM",
    "07:00 PM",
    "07:15 PM",
    "07:30 PM",
    "07:45 PM",
    "08:00 PM",
    "08:15 PM",
    "08:30 PM",
    "08:45 PM",
    "09:00 PM",
    "09:15 PM",
    "09:30 PM",
    "09:45 PM",
    "10:00 PM",
  ];

  bool isTimePassed(String inputTime, DateTime now) {
    // Parse the provided time string into DateTime object
    DateTime providedTime = DateFormat('hh:mm a').parse(inputTime);

    // Create a DateTime for today with the provided time
    DateTime todayWithProvidedTime = DateTime(
        now.year, now.month, now.day, providedTime.hour, providedTime.minute);

    // Compare if the calculated time has passed
    if (now.isAfter(todayWithProvidedTime)) {
      return true; // Time has passed for today
    } else {
      return false; // Time has not passed yet for today
    }
  }

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

  void todayClicked() {
    showTimes = true;
    selectedToday = true;
    notifyListeners();
  }

  void nextDayClicked() {
    showTimes = true;
    showNextDayTimes = true;
    notifyListeners();
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
      // handleMultipleCheckboxChange(value!, getSelectionType());
      // checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      // activeMatrix = prevActiveMatrix;
      // setCheckBoxes();
      // atIsChecked = value;
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
      // handleMultipleCheckboxChange(value!, getSelectionType());
      // checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      // activeMatrix = prevActiveMatrix;
      // setCheckBoxes();
      // ajIsChecked = value;
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
      // handleMultipleCheckboxChange(value!, getSelectionType());
      // checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      // activeMatrix = prevActiveMatrix;
      // setCheckBoxes();
      // ktIsChecked = value;
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
    notifyListeners();
  }
}

enum SelectionType { SINGLE, ATOT, ATOJ, KTOT }
