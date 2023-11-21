import 'package:flutter/material.dart';

class ResultLeft extends StatefulWidget{
  @override
  _Left createState() => _Left();
}

class _Left extends State<ResultLeft>{

  void goBack() {
    Navigator.pop(context);
  }

  DateTime _dateTime = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
    ).then((value) => {
      setState(() {
        _dateTime = value!;
      })
    });
  }


  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("N.1 GAMING", style: TextStyle(
          fontFamily: 'YoungSerif',
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
          color: Color(0xFFF3FDE8),
          letterSpacing: 2.0,
        ),),

        Container(
          padding: EdgeInsets.only(bottom: 5.0),
          margin: EdgeInsets.symmetric(vertical: 70.0, horizontal: 0.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 2.0
              )
            )
          ),
          child: SizedBox(
            width: 180.0,
            child: Text(_dateTime.toString().substring(0,10),style: TextStyle(
                color: Colors.white,
              fontSize: 20.0
            ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: MaterialButton(
            onPressed: _showDatePicker,
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Choose Date', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                fontFamily: 'SansSerif'
              ),),
            ),
          ),
        ),

        Container(
          width: 100.0,
          height: 40.0,
          margin: EdgeInsets.only(top: 300),
          child: ElevatedButton(
            onPressed: goBack,
            child: Text("Back", style: TextStyle(
              color: Colors.indigo,
              fontSize: 20.0,
              fontFamily: "SansSerif",
            ),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3FDE8)),
              ),
            ),
          ),

      ],
    );
  }
}