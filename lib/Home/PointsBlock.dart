import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PointsBlock extends StatelessWidget {
  const PointsBlock({super.key, required this.text1, required this.text2, this.color=Colors.amberAccent, this.textColor=Colors.white});
  final String text1;
  final String text2;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context){
    return Container(
      width: 150.0,
      height: 38.0,
      margin: const EdgeInsets.fromLTRB(4.0, 2.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 73.0,
              height: 38.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius : BorderRadius.circular(2.0),
                border: Border.all(
                    color: Colors.white,
                    width: 1.0
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: textColor
                    ),
                  )
                ],
              )
          ),
          Container(
              width: 73.0,
              height: 38.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                      color: Colors.white,
                      width: 1.0
                  ),
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text2,
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: textColor
                  ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}