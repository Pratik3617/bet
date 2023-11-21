import 'package:flutter/material.dart';

class AccountsTop extends StatefulWidget{
  @override
  _Top createState() => _Top();
}

class _Top extends State<AccountsTop>{

  DateTime _dateTime1 = DateTime.now();
  DateTime _dateTime2 = DateTime.now();

  void _showDatePicker1() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) => {
      setState(() {
        _dateTime1 = value!;
      })
    });
  }

  void _showDatePicker2() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) => {
      setState(() {
        _dateTime2 = value!;
      })
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Flex(
                      direction: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 180.0,
                        child: Text(_dateTime1.toString().substring(0,10),style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(onPressed: _showDatePicker1,
                          icon: Icon(
                              Icons.calendar_month_outlined,
                            color: Colors.white,
                          )
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 180.0,
                        child: Text(_dateTime2.toString().substring(0,10),style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(onPressed: _showDatePicker2,
                          icon: Icon(
                              Icons.calendar_month_outlined,
                            color: Colors.white,
                          )
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: ElevatedButton(onPressed: (){},
                      child: Text("OK", style: TextStyle(
                          color: Colors.white
                      ),),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purple)
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text("Accounts as on: 14/10/2023 7:35 PM",
                  style: TextStyle(
                      fontFamily: "SansSerif",
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text("From : ${_dateTime1.toString().substring(0,10)} To : ${_dateTime2.toString().substring(0,10)}",
                  style: TextStyle(
                      fontFamily: "SansSerif",
                      color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}