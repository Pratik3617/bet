import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Transaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, List<List<String>>> transactionData = {
      'T00030392031': [
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
      ],
      'T00030392032': [
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
      ],
      'T00030392033': [
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
      ],
    };

    List<DataRow> rows = [];

    transactionData.forEach((transactionId, rowList) {
      for (int i = 0; i < rowList.length; i++) {
        List<DataCell> cells = [];

        // Add the transaction ID cell only in the first row of the group
        if (i == 0) {
          cells.add(DataCell(Text(transactionId)));
        } else {
          // Add an empty cell for the transaction ID in subsequent rows
          cells.add(DataCell(Text('')));
        }

        // Add the other cells for the row
        cells.addAll(rowList[i].map((data) => DataCell(Text(data))));

        // Ensure that each row has the correct number of cells
        while (cells.length < 7) {
          cells.add(DataCell(Text('')));
        }

        // Add the DataRow to the list
        rows.add(DataRow(cells: cells));
      }
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.blueGrey,
        actions: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "N.1 GAMING",
                style: TextStyle(
                  fontFamily: 'YoungSerif',
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  color: Color(0xFFF3FDE8),
                  letterSpacing: 2.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 2),
              color: Colors.white,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 100, 30),
                      child: Text("Click on TSN for Details", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                      child: Text("Slips Cancelled: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                      child: Text("0", style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                  columnSpacing: 70.0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Transaction ID', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('TSN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('GAME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Game Date Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Slip Date Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Points', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Cancel', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: rows,
                ),
                )
              ],
            ),
            )
          ),
      ),
    );
  }
}
