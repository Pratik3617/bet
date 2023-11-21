import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:esc_pos_utils/network_printer.dart]';

class AccountsBottom extends StatefulWidget{
  @override
  _Bottom createState() => _Bottom();
}

class _Bottom extends State<AccountsBottom>{

  List<String> listHeading = [""," Play Points "," Earn Points "," End Points "," Profit "," Agent Bonus "," Net Points "];

  List<List<String>> account = [
    ["","12345","56345","1345","2748.6","0","7845.2"],
    ["","12345","56345","1345","2748.6","0","7845.2"],
    ["","12345","56345","1345","2748.6","0","7845.2"],
    ["","12345","56345","1345","2748.6","0","7845.2"],
    ["","12345","56345","1345","2748.6","0","7845.2"],
  ];

  // void printTable(List<List<String>> table) async {
  //   final profile = CapabilityProfile.load();
  //
  //   final printer = NetworkPrinter(PaperSize.mm80, profile);
  //
  //   final paper = Paper();
  //   paper.text('Table Printing Example',
  //       styles: PosStyles(
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //         align: PosAlign.center,
  //       ));
  //   table.forEach((row) {
  //     paper.row();
  //     row.forEach((cell) {
  //       paper.text(cell,
  //           styles: PosStyles(
  //             width: PosTextSize.size1,
  //             align: PosAlign.left,
  //           ));
  //     });
  //   });
  //
  //   printer.text(paper.text());
  //   printer.cut();
  //   printer.disconnect();
  // }


  @override
  Widget build(BuildContext context){
    return Flex(
        direction: Axis.vertical,
      children: [
          Container(
          width: 1000.0,
          height: 450.0,
          child: Column(
            children: [
              // Sticky first row
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: 1000.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      7,
                          (index) {
                        double width = index == 0 ? 50.0 : 150.0;
                        return Container(
                          margin: EdgeInsets.only(top: 20.0),
                          color: Colors.white,
                          width: width,
                          height: 30.0,
                          child: Text(
                            listHeading[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                        );
                      }
                  ),
                ),
              ),
              // Scrollable content
              Container(
                width: 1000.0,
                height: 300.0,
                // height: 500.0,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: account.length,
                    itemBuilder: (context, row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            7,
                                (col) {
                              double width = col == 0 ? 50.0 : 150.0;
                              return Container(
                                width: width,
                                color: Colors.white,
                                height: 30.0,
                                margin: EdgeInsets.only(top: 2.0),
                                padding: EdgeInsets.only(top: 2.0),
                                child: Text(
                                  account[row][col],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            }
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        ElevatedButton(onPressed: () { },
          child: Text("Print",style: TextStyle(
              fontFamily: "SansSerif",
              fontSize: 20.0
          ),),
        )
      ],
    );
  }
}