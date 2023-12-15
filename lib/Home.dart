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
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';

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
  int GrandTotal = 0;
  late Timer _timer;
  late Timer _timer2;
  Duration _remainingTime = Duration();
  DateTime _currentTime = DateTime.now();
  String transId = "";
  int endpoints = 0;
  
  @override
  void initState() {
    super.initState();
    _startTimer();
    _startTimerFor15Min();
  }

  //next game timings
  List<String> times = [
    "09:30:00 AM", "09:45:00 AM", "10:00:00 AM", "10:15:00 AM", "10:30:00 AM", "10:45:00 AM",
    "11:00:00 AM", "11:15:00 AM", "11:30:00 AM", "11:45:00 AM", "12:00:00 PM", "12:15:00 PM", "12:30:00 PM",
    "12:45:00 PM", "01:00:00 PM", "01:15:00 PM", "01:30:00 PM", "01:45:00 PM", "02:00:00 PM", "02:15:00 PM",
    "02:30:00 PM", "02:45:00 PM", "03:00:00 PM", "03:15:00 PM", "03:30:00 PM", "03:45:00 PM", "04:00:00 PM",
    "04:15:00 PM", "04:30:00 PM", "04:45:00 PM", "05:00:00 PM", "05:15:00 PM", "05:30:00 PM", "05:45:00 PM",
    "06:00:00 PM", "06:15:00 PM", "06:30:00 PM", "06:45:00 PM", "07:00:00 PM", "07:15:00 PM", "07:30:00 PM",
    "07:45:00 PM", "08:00:00 PM", "08:15:00 PM", "08:30:00 PM", "08:45:00 PM", "09:00:00 PM", "09:15:00 PM",
    "09:30:00 PM", "09:45:00 PM", "10:00:00 PM"
  ];

  int _currentIndex = 0;

  void _startTimer() {
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        int hours = _currentTime.hour;
        int min = _currentTime.minute;

        while (_currentIndex < times.length - 1) {
          int h = int.parse(times[_currentIndex].substring(0,2));
          int m = int.parse(times[_currentIndex].substring(3,5));
          if(times[_currentIndex].substring(9,11)!="AM"){
            if(times[_currentIndex].substring(0,2)!="12"){
              h= h + 12;
            }
          }
          if(h==hours){
            if(m>min){
              break;
            }
          }else if(h>hours){
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


  void _startTimerFor15Min() {
    final now = DateTime.now();

    if ((now.hour >= 22 && now.minute >= 00) || (now.hour <=9  && now.minute <= 30)) {
      // If the current time is 08:30 pm or later, calculate time until 9:30 am next day
      final tomorrowStartTime = DateTime(now.year, now.month, now.day + 1, 9, 30);
      _remainingTime = tomorrowStartTime.difference(now);
    } else {
      // Calculate time until the next 15-minute mark
      final next15Min = DateTime(now.year, now.month, now.day, now.hour, now.minute)
          .add(Duration(minutes: 15 - (now.minute % 15)));

      _remainingTime = next15Min.difference(now);
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime -= const Duration(seconds: 1);
        } else {
          // Recalculate for the next 15-minute mark or 9:30 am next day
          final now = DateTime.now();

          if ((now.hour >= 22 && now.minute >= 00) || (now.hour <= 9  && now.minute <= 30)) {
            // If the current time is 08:30 pm or later, calculate time until 9:30 am next day
            final tomorrowStartTime = DateTime(now.year, now.month, now.day + 1, 9, 30);
            _remainingTime = tomorrowStartTime.difference(now);
          } else {
            // Calculate time until the next 15-minute mark
            final next15Min = DateTime(now.year, now.month, now.day, now.hour, now.minute)
                .add(Duration(minutes: 15 - (now.minute % 15)));

            _remainingTime = next15Min.difference(now);
          }
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

  void updateData(String id, int total) {
    setState(() {
      transId = id;
      endpoints = total;
    });
  }

  void _showModal(BuildContext context) {
  // Show modal with information for the clicked TSN
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          width: 300.0,
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'You have won 2000Rs',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}


  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _editingController = TextEditingController(text: "");
    DateTime now1 = DateTime.now();
    String formattedDate = "${now1.day}-${now1.month}-${now1.year}";
    String formattedTime = "${now1.hour}:${now1.minute}:${now1.second}";

    String _formatDuration(Duration duration) {
      String twoDigits(int n) {
        if (n >= 10) return "$n";
        return "0$n";
      }
      return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
    }

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
                              child: Text(
                                'Time Left : ${_formatDuration(_remainingTime)}',
                                style: const TextStyle(
                                    fontFamily: "SansSerif",
                                    color: Colors.black,
                                    letterSpacing: 2,
                                    fontSize: 15
                                )
                            )
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
                                  controller: TextEditingController(text: "${transId}"),
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
                                  controller: TextEditingController(text: "${endpoints}"),
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
                                Consumer<GameSelector>(
                                    builder: (context, value, child) {
                                  return BarcodeKeyboardListener(
                                    bufferDuration: Duration(milliseconds: 200),
                                    onBarcodeScanned: (barcode) {
                                      value.barcodeController.text = barcode;
                                    },
                                    child: Head_Input(
                                      label: "Barcode",
                                      controller: value.barcodeController,
                                    ),
                                  );
                                }),
                                Button_G(text: "REDEEM", onPressed: () {
                                  _showModal(context);
                                }),
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
                        onGrandTotalChange: (newValue){
                          GrandTotal = newValue;
                        }
                      );
                    }),
                    HomeRight(),
                  ],
                ),
              ),
              Consumer<UserProvider>(
                  builder:
                      (context, userProvider, child){
                      return HomeBottom(GrandTotal: GrandTotal, onDataChanged: updateData, user: userProvider.user?.username.toUpperCase() ?? '');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
