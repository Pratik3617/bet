import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'PointsBlock.dart';

class HomeMiddleTwo extends StatefulWidget {
  final List<List<TextEditingController>> controllers;
  final BuildContext context;
  const HomeMiddleTwo({
    super.key,
    required this.controllers,
    required this.context,
  });

  @override
  _updatePoints createState() => _updatePoints(context: context);
}

class _updatePoints extends State<HomeMiddleTwo> {
  final BuildContext context;
  int sum = 0;
  List<int> sumList = List<int>.filled(20, 0);
  _updatePoints({required this.context});

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
    List<int> newSum = List<int>.filled(20, 0);
    final matrixList =
        Provider.of<GameSelector>(context, listen: false).matrixList;

    final checkBoxValues =
        Provider.of<GameSelector>(context, listen: false).checkBoxValues;

    final checkbox = Provider.of<GameSelector>(context, listen: false).checkbox;

    final selectedAlphabet =
        Provider.of<GameSelector>(context, listen: false).selectedAlphabet;
    for (int i = 0; i < 20; i++) {
      if (checkBoxValues[checkbox[i]] == true) {
        newSum[i] = 0;
        for (int j = 0; j < 10; j++) {
          for (int k = 0; k < 10; k++) {
            newSum[i] += int.tryParse(widget.controllers[j][k].text) ?? 0;
          }
        }
      } else {
        for (int j = 0; j < 10; j++) {
          for (int k = 0; k < 10; k++) {
            newSum[i] += int.tryParse(matrixList[i][j][k] ?? "0") ?? 0;
          }
        }
      }
    }

    setState(() {
      for (int i = 0; i < 20; i++) {
        sumList[i] = newSum[i] * 2;
      }
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
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          width: 150.0,
          height: 40.0,
          margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
          decoration: BoxDecoration(
              color: Colors.yellow[600],
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(2.0)),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Points",
                  style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          )),
      const PointsBlock(
          text1: " A TO J",
          text2: " K TO T",
          color: Colors.white,
          textColor: Colors.black),
      for (int i = 0; i < 10; i++)
        PointsBlock(
            text1: "${sumList[i]}",
            text2: "${sumList[i + 10]}",
            textColor: Colors.black),
    ]);
  }
}
