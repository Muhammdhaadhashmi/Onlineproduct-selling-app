import 'package:flutter/material.dart';
import 'package:onicame/model/tabelmodel.dart';
import 'package:onicame/utils/colors.dart';

class HomeRankScreen extends StatefulWidget {
  const HomeRankScreen({Key? key}) : super(key: key);

  @override
  _HomeRankScreenState createState() => _HomeRankScreenState();
}

class _HomeRankScreenState extends State<HomeRankScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: kMaxWidth,
          ),
          child: Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      color: kPrimaryClr,
                      child: Center(
                        child: Text(
                          'Ranks',
                          style: TextStyle(
                            fontSize: _size.width >= 570 ? 20 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      color: kPrimaryClr,
                      child: Center(
                        child: Text(
                          'Rank Points',
                          style: TextStyle(
                            fontSize: _size.width >= 570 ? 20 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      color: kPrimaryClr,
                      child: Center(
                        child: Text(
                          'Awards Rs',
                          style: TextStyle(
                            fontSize: _size.width >= 570 ? 20 : 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (var i = 0; i < rnkpoint.length; i++) ...[
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                          child: Text(rnkpoint[i].title,
                              style: TextStyle(
                                  fontSize: _size.width >= 570 ? 18 : 14.0))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(rnkpoint[i].rankpoints,
                              style: TextStyle(
                                  fontSize: _size.width >= 570 ? 18 : 14.0))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(rnkpoint[i].award,
                              style: TextStyle(
                                  fontSize: _size.width >= 570 ? 18 : 14.0))),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
//  rodata("Distributor", "2500", "7000"),
//             rodata("Silver", "10000", "200000"),
//             rodata("Gold", "25000", "40000"),
//             rodata("Platinum", "50000", "70000"),
//             rodata("Diamond", "100000", "Trip + 70000"),
//             rodata("Crown", "250000", "250000"),
//             rodata("Double Crown", "500000", "500000"),
//             rodata("Star", "1000000", "10,00,000"),
//             rodata("Double Star", "2500000", "25,00,000"),
//             rodata("Super Star", "5000000", "50,00,000"),
//             rodata("Royal", "10000000", "1,00,00,000"),
//             rodata("Royal Achiever", "40000000", "4,00,00,000"),