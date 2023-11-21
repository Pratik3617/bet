import 'package:flutter/material.dart';

class Head_Input extends StatelessWidget {
  const Head_Input({super.key, required this.label, required this.controller});
  final String label;
  final String controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 27.0,

      child: TextField(
        controller: TextEditingController(text: controller),
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontFamily: "SanSerif"
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),

          labelStyle: TextStyle(
              color: Colors.white,
              fontFamily: "SansSerif"// Floating label text color when focused
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          labelText: label,
        ),
      ),
    );
  }
}
