import 'package:flutter/material.dart';

class Input_Box extends StatelessWidget {
  Input_Box({super.key, required this.text, required this.color, required this.controller});
  final String text;
  final Color color;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78.0,
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 50.0,
                height: 32.0,
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "SanSerif",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: color,
                    contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
