// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final select = Provider.of<GameSelector>(context, listen: false);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    select.toggleSelectedToday();
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
                  child: Text(select.selectedToday ? " NEXT DAY " : " TODAY ",
                      style: TextStyle(
                          fontFamily: "SansSerif",
                          letterSpacing: 2.0,
                          fontSize: 18.0)),
                ),
              ),
            ],
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
                      for (int i = 0; i < 20; i++) {
                        for (int j = 0; j < 10; j++) {
                          for (int k = 0; k < 10; k++) {
                            if (select.matrixList[i][j][k] != "" &&
                                select.matrixList[i][j][k] != "0") {
                              print(
                                  "${select.checkbox[i]}-$j$k - ${select.matrixList[i][j][k]}");
                            }
                          }
                        }
                      }
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
