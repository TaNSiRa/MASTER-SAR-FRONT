// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02INSIDEINSTRUMENTGETDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../page1.dart';
import 'P02INSIDEINSTRUMENTVAR.dart';

late BuildContext P02INSIDEINSTRUMENTMAINcontext;

class P02INSIDEINSTRUMENTMAIN extends StatefulWidget {
  P02INSIDEINSTRUMENTMAIN({
    super.key,
    this.data,
  });
  List<P02INSIDEINSTRUMENTGETDATAclass>? data;

  @override
  State<P02INSIDEINSTRUMENTMAIN> createState() =>
      _P02INSIDEINSTRUMENTMAINState();
}

class _P02INSIDEINSTRUMENTMAINState extends State<P02INSIDEINSTRUMENTMAIN> {
  @override
  void initState() {
    super.initState();
    // context
    //     .read<P02INSIDEINSTRUMENTGETDATA_Bloc>()
    //     .add(P02INSIDEINSTRUMENTGETDATA_GET());
  }

  List<bool> selectedTickets = List.generate(18 * 4, (index) => false);
  List<bool> selectedTickets2 = List.generate(18 * 4, (index2) => false);
  bool isSelecting = false;
  List<int> UseBox = [];

  @override
  Widget build(BuildContext context) {
    P02INSIDEINSTRUMENTMAINcontext = context;
    List<P02INSIDEINSTRUMENTGETDATAclass> _datain = widget.data ?? [];
    if (selectpage == "Salt Spray Tester : SST No.1") {
      UseBox = P02INSIDEINSTRUMENTVAR.disabledIndexesSST1;
    } else if (selectpage == "Salt Spray Tester : SST No.2") {
      UseBox = P02INSIDEINSTRUMENTVAR.disabledIndexesSST2;
    } else if (selectpage == "Salt Spray Tester : SST No.3") {
      UseBox = P02INSIDEINSTRUMENTVAR.disabledIndexesSST3;
    } else if (selectpage == "Salt Spray Tester : SST No.4") {
      UseBox = P02INSIDEINSTRUMENTVAR.disabledIndexesSST4;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(1.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.blueGrey[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectpage,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // กำหนดขนาดขอบโค้ง
                            child: SizedBox(
                              width: 1030,
                              height: 600,
                              child: Image.asset(
                                "assets/images/InsideSST.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 240,
                            top: 150,
                            child: SizedBox(
                              width: 170,
                              height: 370,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 2.07,
                                ),
                                itemCount: 18 * 4,
                                itemBuilder: (context, index) {
                                  bool isRedDisabled = UseBox.contains(
                                      index + 1); // เช็คว่ามีในลิสต์ไหม
                                  bool isBlackDisabled = [
                                    1,
                                    5,
                                    9,
                                    36,
                                    40,
                                    44,
                                    48,
                                    52,
                                    61,
                                    65,
                                    69
                                  ].contains(index + 1); // เช็ค index ที่กำหนด
                                  return Container(
                                    margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: isBlackDisabled
                                          ? Colors
                                              .black // สีดำถ้าเป็น index ที่กำหนด
                                          : (isRedDisabled
                                              ? Colors
                                                  .red // สีแดงถ้ามีใน UseBox
                                              : (index <
                                                          selectedTickets
                                                              .length &&
                                                      selectedTickets[index]
                                                  ? Colors.yellow
                                                  : Colors.green
                                                      .withOpacity(0.5))),
                                      border: Border.all(
                                          color: Colors.green, width: 1),
                                    ),
                                    child: InkWell(
                                      onTap: (isRedDisabled || isBlackDisabled)
                                          ? null
                                          : () {
                                              if (index <
                                                  selectedTickets.length) {
                                                setState(() {
                                                  selectedTickets[index] =
                                                      !selectedTickets[index];
                                                });
                                              }
                                              print(index + 1);
                                            },
                                      child: Center(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            right: 195,
                            top: 150,
                            child: SizedBox(
                              width: 170,
                              height: 370,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 2.07,
                                ),
                                itemCount: 18 * 4,
                                itemBuilder: (context, index2) {
                                  bool isRedDisabled = UseBox.contains(
                                      index2 + 73); // เช็คว่ามีในลิสต์ไหม
                                  bool isBlackDisabled = [
                                    76,
                                    80,
                                    84,
                                    105,
                                    109,
                                    113,
                                    117,
                                    121,
                                    136,
                                    140,
                                    144
                                  ].contains(
                                      index2 + 73); // เช็ค index ที่กำหนด

                                  return Container(
                                    margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: isBlackDisabled
                                          ? Colors
                                              .black // สีดำถ้าเป็น index ที่กำหนด
                                          : (isRedDisabled
                                              ? Colors
                                                  .red // สีแดงถ้ามีใน UseBox
                                              : (selectedTickets2[index2]
                                                  ? Colors.yellow
                                                  : Colors.green
                                                      .withOpacity(0.5))),
                                      border: Border.all(
                                          color: Colors.green, width: 1),
                                    ),
                                    child: InkWell(
                                      onTap: (isRedDisabled || isBlackDisabled)
                                          ? null // ปิดการกดถ้าเป็น index ที่ถูกปิด
                                          : () {
                                              setState(() {
                                                selectedTickets2[index2] =
                                                    !selectedTickets2[index2];
                                              });
                                              print(index2 + 73);
                                            },
                                      child: Center(
                                        child: Text(
                                          '${index2 + 73}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: () {
                MainBodyContext.read<ChangePage_Bloc>().ChangePage_nodrower(
                    'SALT SPRAY MONITORING SYSTEM', Page1());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Back to main page',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 30,
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.5),
                        border: Border.all(color: Colors.green, width: 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('='),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Available for use'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 30,
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.green, width: 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('='),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Not available for use'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 30,
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.green, width: 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('='),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Do not use'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // int _getTicketIndexFromPosition(Offset position) {
  //   final double cellWidth = MediaQuery.of(context).size.width / 4;
  //   final double cellHeight = MediaQuery.of(context).size.height / (18 * 4);

  //   int columnIndex = (position.dx / cellWidth).floor();
  //   int rowIndex = (position.dy / cellHeight).floor();
  //   int index = rowIndex * 4 + columnIndex;

  //   return index;
  // }
}
