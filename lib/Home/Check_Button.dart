import 'package:flutter/material.dart';

class Check_Button extends StatelessWidget {
  const Check_Button({super.key, required this.text, required this.width,
    required this.height, required this.onChange,
    required this.isChecked
  });
  final String text;
  final double width;
  final double height;
  final ValueChanged<bool?> onChange;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.yellow,
                width: 2.0
            ),
            borderRadius : BorderRadius.circular(2.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              checkColor: Colors.black,
              value: isChecked,
              onChanged: onChange,
              fillColor: MaterialStateProperty.all<Color>(Colors.white)
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: "SansSerif",
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            )
          ],
        )
    );
  }
}
