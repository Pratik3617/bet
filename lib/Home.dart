// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bet/Home/Check_Button.dart';
import 'package:bet/Home/CustomButton.dart';
import 'package:bet/Home/Input_Box.dart';
import 'package:bet/Result.dart';
import 'package:bet/TransactionList/Transaction.dart';
import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'Home/ButtonG.dart';
import 'Home/Head_Input.dart';
import 'Home/HomeLeft.dart';
import 'Home/HomeBottom.dart';
import 'Home/HomeMiddleOne.dart';
import 'Home/HomeMiddleTwo.dart';
import 'Home/HomeRight.dart';
import 'package:bet/providers/LoginProvider.dart';
import './API/ShowResultAPI.dart';
import 'package:bet/providers/ShowResult.dart';
import 'package:intl/intl.dart';

final TextStyle customTextStyle = TextStyle(
  fontFamily: 'SansSerif',
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<Home> {
  late Timer _timer;
  late Timer _timer2;
  late Timer _timer3;
  late Timer _timer4;
  late Timer _timer5;
  late Duration _timeRemaining = Duration();
  Duration _remainingTime = Duration();
  DateTime _currentTime = DateTime.now();
  // DateTime _targetTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 30,);

  @override
  void initState() {
    super.initState();
    // _setTimeCheckBoxState();
    _startTimer();
    _startTimer2();
    // _updateTimer();
    _timeRemaining = _calculateTimeUntil9AM();
    _timer4 = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _timeRemaining = _calculateTimeUntil9AM();
      });
    });
  }

  Duration _calculateTimeUntil9AM() {
    final now = DateTime.now();
    DateTime target;
    if (now.hour >= 22) {
      // If it's past 10 PM, target the next day's 9 AM
      target = DateTime(now.year, now.month, now.day + 1, 9);
    } else {
      // Otherwise, target today's 9 AM (will show 0 if it's past 9 AM but before 10 PM)
      target = DateTime(now.year, now.month, now.day, 9);
    }
    return target.difference(now);
  }

  //next game timings
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
  int _currentIndex = 0;

  void _startTimer2() {
    _timer3 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        int hours = _currentTime.hour;
        int min = _currentTime.minute;

        while (_currentIndex < times.length - 1) {
          int h = int.parse(times[_currentIndex].substring(0, 2));
          int m = int.parse(times[_currentIndex].substring(3, 5));
          if (h == hours) {
            if (m > min) {
              break;
            }
          } else if (h > hours) {
            break;
          }
          _currentIndex++;
        }
        if (_currentTime.hour >= 22) {
          _currentIndex = 0;
        }
      });
    });
  }

  // void _updateTimer() {
  //   _timer2 = Timer.periodic(const Duration(minutes: 15), (timer) {
  //     setState(() {
  //       _currentTime = DateTime.now();
  //       if (_targetTime.isBefore(_currentTime)) {
  //         _targetTime = _targetTime.add(const Duration(minutes: 15));
  //       }
  //     });
  //   });
  // }

  // showing dynamic 15 minutes timer
  void _startTimer() {
    final now = DateTime.now();
    final next15Min =
        DateTime(now.year, now.month, now.day, now.hour, now.minute)
            .add(Duration(minutes: 15 - (now.minute % 15)));

    _remainingTime = next15Min.difference(now);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime -= const Duration(seconds: 1);
        } else {
          // Recalculate for the next 15-minute mark
          final now = DateTime.now();
          final next15Min =
              DateTime(now.year, now.month, now.day, now.hour, now.minute)
                  .add(Duration(minutes: 15 - (now.minute % 15)));

          _remainingTime = next15Min.difference(now);
        }
      });
    });
  }

  //api task
  List<dynamic> convertTimeFormat(List<dynamic> localDataList) {
    for (int i = 0; i < localDataList.length; i++) {
      String originalTime = localDataList[i][0].toString();

      DateTime parsedTime = DateFormat('HH:mm:ss').parse(originalTime);

      String formattedTime = DateFormat('hh:mm a').format(parsedTime);

      localDataList[i][0] = formattedTime;
    }

    return localDataList;
  }

  Future<void> _TodayResult() async {
    try {
      DateTime today = DateTime.now();
      DateTime currentDate = DateTime(today.year, today.month, today.day);
      final response = await fetchDataForDate(currentDate);
      if (response.containsKey('error')) {
        context.read<ShowResultProvider>().updateResult([]);
      } else {
        List<dynamic> localDataList = response['result'];
        List<dynamic> updatedDataList = convertTimeFormat(localDataList);

        context.read<ShowResultProvider>().updateResult(updatedDataList);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(),
        ),
      );
    } catch (e) {
      print('Error during fetching todays data: $e');
    }
  }

  // void _setTimeCheckBoxState() {
  //   final function = Provider.of<GameSelector>(context, listen: false)
  //       .setTimeCheckBoxesState();
  //   _timer5 = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     function();
  //   });
  // }

  @override
  void dispose() {
    _timer.cancel();
    _timer2.cancel();
    _timer3.cancel();
    _timer4.cancel();
    _timer5.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract hours, minutes, and seconds from the duration
    final hours = _remainingTime.inHours;
    final minutes = (_remainingTime.inMinutes % 60);
    final seconds = (_remainingTime.inSeconds % 60);

    String hoursStr =
        _timeRemaining.inHours.remainder(24).toString().padLeft(2, '0');
    String minutesStr =
        _timeRemaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    String secondsStr =
        _timeRemaining.inSeconds.remainder(60).toString().padLeft(2, '0');

    TextEditingController _editingController = TextEditingController(text: "");
    DateTime now1 = DateTime.now();
    String formattedDate = "${now1.day}-${now1.month}-${now1.year}";
    String formattedTime = "${now1.hour}:${now1.minute}:${now1.second}";
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 5, // Adjust the elevation to control the shadow intensity
          shadowColor: const Color.fromARGB(
              255, 236, 230, 230), // Set the shadow color to white
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: SizedBox.shrink(),
          toolbarHeight: 200.0,
          backgroundColor: Colors.blueGrey,
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<GameSelector>(
                      builder: (context, value, child) {
                        return value.showTimes
                            ? Container(
                                constraints:
                                    BoxConstraints(maxWidth: size.width * 0.81),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Check_Button(
                                            width: 250.0,
                                            height: 28.0,
                                            isChecked: value.allTimesSelected,
                                            fontSize: 16,
                                            decoration: BoxDecoration(
                                                color: Colors.orange.shade100),
                                            text: "Check to select all games",
                                            onChange: (bool? v) {
                                              DateTime now = DateTime.now();
                                              DateTime tomorrow = DateTime(
                                                  now.year,
                                                  now.month,
                                                  now.day + 1);
                                              DateTime tomorrowTime = DateTime(
                                                  tomorrow.year,
                                                  tomorrow.month,
                                                  tomorrow.day,
                                                  0,
                                                  0,
                                                  0);
                                              value.allTimesSelected = v!;
                                              if (v == true) {
                                                for (var element
                                                    in value.times) {
                                                  if (!value.isTimePassed(
                                                      element,
                                                      value.showNextDayTimes
                                                          ? tomorrowTime
                                                          : now)) {
                                                    value.timesValues[element]!
                                                        .selected = v;
                                                  }
                                                }
                                              } else {
                                                for (var element
                                                    in value.times) {
                                                  value.timesValues[element]!
                                                      .selected = v;
                                                }
                                              }
                                            }),
                                        CustomButton(
                                            width: 380.0,
                                            height: 28.0,
                                            text:
                                                "Click here to clear all selection",
                                            decoration: BoxDecoration(
                                                color: Colors.yellow),
                                            onClick: () {
                                              value.allTimesSelected = false;
                                              for (var element in value.times) {
                                                value.timesValues[element]!
                                                    .selected = false;
                                              }
                                              value.notifyListeners();
                                            }),
                                        CustomButton(
                                            width: 100.0,
                                            height: 28.0,
                                            decoration: BoxDecoration(
                                                color: Colors.red),
                                            text: "Close",
                                            onClick: () {
                                              value.showTimes = false;
                                              value.notifyListeners();
                                            })
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        for (var i = 0;
                                            i < value.times.length;
                                            i++) ...[
                                          Check_Button(
                                              width: 117,
                                              height: 30.0,
                                              fontSize: 16,
                                              isChecked: value
                                                          .timesValues[
                                                              value.times[i]]
                                                          ?.active ==
                                                      false
                                                  ? false
                                                  : (value
                                                          .timesValues[
                                                              value.times[i]]
                                                          ?.selected ??
                                                      false),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue.shade100),
                                              text: value.times[i],
                                              onChange: (bool? v) {
                                                DateTime now = DateTime.now();
                                                DateTime tomorrow = DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day + 1);
                                                DateTime tomorrowTime =
                                                    DateTime(
                                                        tomorrow.year,
                                                        tomorrow.month,
                                                        tomorrow.day,
                                                        0,
                                                        0,
                                                        0);
                                                if (!value.isTimePassed(
                                                    value.times[i],
                                                    value.showNextDayTimes
                                                        ? tomorrowTime
                                                        : now)) {
                                                  value
                                                      .timesValues[
                                                          value.times[i]]!
                                                      .selected = v!;
                                                  value.notifyListeners();
                                                }
                                              }),
                                        ]
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Consumer<UserProvider>(
                                        builder:
                                            (context, userProvider, child) {
                                          return Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 2.0),
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                width: 250.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow[600],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Terminal Name - ${userProvider.user?.username.toUpperCase() ?? ''}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "SansSerif",
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Text("Terminal Id - A09909",
                                              style: customTextStyle),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3.0,
                                                      horizontal: 5.0),
                                              margin: const EdgeInsets.fromLTRB(
                                                  0.0, 5.0, 0.0, 0.0),
                                              width: 250.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.yellow,
                                                    width: 2.0,
                                                  )),
                                              child: Center(
                                                child: Text(
                                                    'Next Game  ${times[_currentIndex]}',
                                                    style: const TextStyle(
                                                        fontFamily: "SansSerif",
                                                        color: Colors.black,
                                                        fontSize: 15)),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 350),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "N.1 GAMING",
                                        style: TextStyle(
                                          fontFamily: 'YoungSerif',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.0,
                                          color: Color(0xFFF3FDE8),
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 2.0),
                          width: 250.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text("$formattedDate  $formattedTime",
                                style: customTextStyle),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Credits - 9012.33", style: customTextStyle),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.refresh_outlined,
                                size: 25.0,
                                color: Colors.lightGreenAccent,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 5.0),
                            width: 250.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 2.0,
                                )),
                            child: Center(
                              child: DateTime.now().hour >= 22 ||
                                      DateTime.now().hour <= 9
                                  ? Text(
                                      'Time Left : $hoursStr:${minutesStr.toString().padLeft(2, '0')}:${secondsStr.toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                          fontFamily: "SansSerif",
                                          color: Colors.black,
                                          letterSpacing: 2,
                                          fontSize: 15))
                                  : Text(
                                      'Time Left : $hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                          fontFamily: "SansSerif",
                                          color: Colors.black,
                                          letterSpacing: 2)),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
          color: Colors.blueGrey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
                            child: Button_G(
                                text: "ACCOUNT",
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/accounts');
                                }),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Button_G(
                                text: "TRANS. LIST",
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("/transaction");
                                }),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Button_G(
                              text: "RESULT",
                              onPressed: _TodayResult,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Button_G(
                                text: "CHANGE PASSWORD", onPressed: () {}),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text(
                                  "Last Transaction Id : ",
                                  style: TextStyle(
                                    fontFamily: "SansSerif",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Head_Input(
                                  label: "Transaction Id",
                                  controller: "",
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text(
                                  "End Points : ",
                                  style: TextStyle(
                                    fontFamily: "SansSerif",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Head_Input(
                                  label: "End Points",
                                  controller: "",
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Barcode : ",
                                  style: TextStyle(
                                    fontFamily: "SansSerif",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Head_Input(
                                  label: "Barcode",
                                  controller: _editingController.text,
                                ),
                                Button_G(text: "REDEEM", onPressed: () {}),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeLeft(),
                    Consumer<GameSelector>(
                      builder: (context, value, child) {
                        return HomeMiddleOne(
                          matrixControllers: value.controllers,
                          context: context,
                        );
                      },
                    ),
                    Consumer<GameSelector>(builder: (context, value, child) {
                      return HomeMiddleTwo(
                        controllers: value.controllers,
                        context: context,
                      );
                    }),
                    HomeRight(),
                  ],
                ),
              ),
              HomeBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
