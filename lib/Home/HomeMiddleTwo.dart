import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PointsBlock.dart';

class HomeMiddleTwo extends StatefulWidget {
  final List<List<TextEditingController>> controllers;
  const HomeMiddleTwo({super.key, required this.controllers});

  @override
  _updatePoints createState() => _updatePoints();
}

class _updatePoints extends State<HomeMiddleTwo> {

  int sum = 0;

  @override
  void initState() {
    super.initState();
    // Attach listeners to all controllers
    for (var row in widget.controllers) {
      for (var controller in row) {
        controller.addListener(_updateSum);
      }
    }
    // Initial sum calculation
    _updateSum();
  }

  _updateSum() {
    int newSum = 0;
    for (var row in widget.controllers) {
      for (var controller in row) {
        newSum += int.tryParse(controller.text) ?? 0;
      }
    }
    setState(() {
      sum = newSum * 2;
    });
  }

  @override
  void dispose() {
    // Remove listeners to avoid memory leaks
    for (var row in widget.controllers) {
      for (var controller in row) {
        controller.removeListener(_updateSum);
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children : [
          Container(
              width: 150.0,
              height: 40.0,
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  border: Border.all(
                      color: Colors.white,
                      width: 2.0
                  ),
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Points", style: TextStyle(
                        fontFamily: "SansSerif",
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                    )
                  ],
                ),
              )
          ),
          const PointsBlock(text1: " A TO J", text2: " K TO T", color:Colors.white, textColor: Colors.black),
          PointsBlock(text1: "$sum", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
          PointsBlock(text1: "0", text2: "0", textColor: Colors.black),
        ]
    );
  }
}