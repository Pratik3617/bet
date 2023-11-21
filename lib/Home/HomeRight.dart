import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ResultDisplayBlock.dart';

class HomeRight extends StatelessWidget {
  const HomeRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children : [
          Container(
              width: 210.0,
              height: 40.0,
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.green,
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
                    Text("Results", style: TextStyle(
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

          Container(
            width: 210.0,
            height: 38.0,
            margin: const EdgeInsets.fromLTRB(4.0, 2.0, 0.0, 0.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 210.0,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius : BorderRadius.circular(2.0)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("07 : 15 PM", style: TextStyle(
                            fontFamily: "SansSerif",
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),

          Result_Display_Box(text1: "A", text2: "11", text3: "K", text4:"11"),
          Result_Display_Box(text1: "B", text2: "11", text3: "L", text4:"11"),
          Result_Display_Box(text1: "C", text2: "11", text3: "M", text4:"11"),
          Result_Display_Box(text1: "D", text2: "11", text3: "N", text4:"11"),
          Result_Display_Box(text1: "E", text2: "11", text3: "O", text4:"11"),
          Result_Display_Box(text1: "F", text2: "11", text3: "P", text4:"11"),
          Result_Display_Box(text1: "G", text2: "11", text3: "Q", text4:"11"),
          Result_Display_Box(text1: "H", text2: "11", text3: "R", text4:"11"),
          Result_Display_Box(text1: "I", text2: "11", text3: "S", text4:"11"),
          Result_Display_Box(text1: "J", text2: "11", text3: "T", text4:"11"),

        ]
    );
  }
}