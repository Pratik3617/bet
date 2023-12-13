// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final select = Provider.of<GameSelector>(context, listen: false);
    final GlobalKey _key = GlobalKey();

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: !(select.selectedToday ?? false),
                child: SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      select.todayClicked();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "SansSerif",
                            color: Colors.white),
                      ),
                    ),
                    child: Text(" TODAY ",
                        style: TextStyle(
                            fontFamily: "SansSerif",
                            letterSpacing: 2.0,
                            fontSize: 18.0)),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: select.selectedToday ?? false,
            child: SizedBox(
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  select.nextDayClicked();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.yellow, width: 2.0),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "SansSerif",
                        color: Colors.white),
                  ),
                ),
                child: Text(" NEXT DAY ",
                    style: TextStyle(
                        fontFamily: "SansSerif",
                        letterSpacing: 2.0,
                        fontSize: 18.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Update Results",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: "SansSerif")),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Cancel & Reprint",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: "SansSerif")),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Reset All",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: "SansSerif")),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      final select =
                          Provider.of<GameSelector>(context, listen: false);
                      for (int i = 0; i < 10; i++) {
                        for (int j = 0; j < 10; j++) {
                          String? textValue = select.controllers[i][j].text;
                          if (select.activeMatrix.length == 1) {
                            select.matrixList[select.checkbox
                                    .indexOf(select.activeMatrix)][i][j] =
                                textValue != "" ? textValue : "";
                          } else if (select.activeMatrix == "AT") {
                            for (int k = 0; k < 20; k++) {
                              select.matrixList[k][i][j] =
                                  textValue != "" ? textValue : "";
                            }
                          } else if (select.activeMatrix == "AJ") {
                            for (int k = 0; k < 10; k++) {
                              select.matrixList[k][i][j] =
                                  textValue != "" ? textValue : "";
                            }
                          } else if (select.activeMatrix == "KT") {
                            for (int k = 10; k < 20; k++) {
                              select.matrixList[k][i][j] =
                                  textValue != "" ? textValue : "";
                            }
                          }
                        }
                      }
                      String txnId =
                          "TXN${DateTime.now().millisecondsSinceEpoch}";
                      String selectedCharacters = "";
                      String selectedTimes = "";
                      int totalPoints = 0;
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(now);
                      String nextDayDate = DateFormat('dd/MM/yyyy')
                          .format(now.add(Duration(days: 1)));
                      select.timesValues.forEach((key, value) {
                        if (value.selected == true) {
                          selectedTimes +=
                              "${select.showNextDayTimes ? nextDayDate : formattedDate} $key \n";
                        }
                      });

                      for (int i = 0; i < 20; i++) {
                        for (int j = 0; j < 10; j++) {
                          for (int k = 0; k < 10; k++) {
                            if (select.matrixList[i][j][k] != "" &&
                                select.matrixList[i][j][k] != "0") {
                              selectedCharacters +=
                                  "${select.checkbox[i]}-$j$k - ${int.parse(select.matrixList[i][j][k] ?? "0") * 2}     ";
                              totalPoints +=
                                  int.parse(select.matrixList[i][j][k] ?? "0");
                            }
                          }
                        }
                      }
                      Dialog printDialog = Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        backgroundColor: Colors.white,
                        child: Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8),
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          clipBehavior: Clip.hardEdge,
                          padding: EdgeInsets.only(bottom: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RepaintBoundary(
                                  key: _key,
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "N.1 GAMING",
                                          style: TextStyle(
                                            fontFamily: 'YoungSerif',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.black,
                                            letterSpacing: 2.0,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "FOR AMUSEMENT ONLY",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "ID : ${txnId}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Slip DT : ${DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.now())}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Game Date : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          selectedTimes,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          selectedCharacters,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Total Quantity : $totalPoints Total Points : $totalPoints",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          side: MaterialStateProperty.all<
                                              BorderSide>(
                                            BorderSide(
                                                color: Colors.yellow,
                                                width: 2.0),
                                          ),
                                          textStyle: MaterialStateProperty.all<
                                              TextStyle>(
                                            TextStyle(
                                                fontFamily: "SansSerif",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        child: Text("Close",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontFamily: "SansSerif")),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.0,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          // Convert the widget to an image
                                          final boundary = _key.currentContext!
                                                  .findRenderObject()
                                              as RenderRepaintBoundary;
                                          final image = await boundary.toImage(
                                              pixelRatio: 3.0);
                                          final byteData =
                                              await image.toByteData(
                                                  format:
                                                      ui.ImageByteFormat.png);

                                          // Get the image data as Uint8List
                                          final pngBytes =
                                              byteData!.buffer.asUint8List();

                                          // Create a file name (optional)
                                          final fileName = 'widget_image.png';

                                          // Create a download link for the image
                                          final anchor = html.AnchorElement(
                                              href:
                                                  'data:image/png;base64,${base64.encode(pngBytes)}')
                                            ..setAttribute('download', fileName)
                                            ..click();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          side: MaterialStateProperty.all<
                                              BorderSide>(
                                            BorderSide(
                                                color: Colors.yellow,
                                                width: 2.0),
                                          ),
                                          textStyle: MaterialStateProperty.all<
                                              TextStyle>(
                                            TextStyle(
                                                fontFamily: "SansSerif",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        child: Text("Print",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontFamily: "SansSerif")),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => printDialog);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Play",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "SansSerif",
                            fontSize: 18.0)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Grand Total: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SansSerif",
                          fontSize: 18.0)),
                  SizedBox(
                    width: 70.0,
                    height: 35.0,
                    child: TextField(
                      keyboardType:
                          TextInputType.number, // Set keyboard type to numeric
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only digits
                      ],
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontFamily: "SanSerif"),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      width: 70.0,
                      height: 35.0,
                      child: TextField(
                        keyboardType: TextInputType
                            .number, // Set keyboard type to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontFamily: "SanSerif"),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Net Total: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SansSerif",
                          fontSize: 18.0)),
                  SizedBox(
                    width: 70.0,
                    height: 35.0,
                    child: TextField(
                      keyboardType:
                          TextInputType.number, // Set keyboard type to numeric
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only digits
                      ],
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontFamily: "SanSerif"),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      width: 70.0,
                      height: 35.0,
                      child: TextField(
                        keyboardType: TextInputType
                            .number, // Set keyboard type to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontFamily: "SanSerif"),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Center(
              child: Text("N.1 GAMING",
                  style: TextStyle(
                    fontFamily: 'YoungSerif',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Color(0xFFF3FDE8),
                    letterSpacing: 2.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
