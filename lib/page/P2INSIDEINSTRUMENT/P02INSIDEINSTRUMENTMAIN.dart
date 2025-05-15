// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02INSIDEINSTRUMENTGETDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../P3DATATABLE/P03DATATABLEVAR.dart';
import '../page1.dart';

late BuildContext P02INSIDEINSTRUMENTMAINcontext;

class P02INSIDEINSTRUMENTMAIN extends StatefulWidget {
  P02INSIDEINSTRUMENTMAIN({
    super.key,
    this.data,
  });
  List<P02INSIDEINSTRUMENTGETDATAclass>? data;

  @override
  State<P02INSIDEINSTRUMENTMAIN> createState() => _P02INSIDEINSTRUMENTMAINState();
}

class _P02INSIDEINSTRUMENTMAINState extends State<P02INSIDEINSTRUMENTMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P02INSIDEINSTRUMENTGETDATA_Bloc>().add(P02INSIDEINSTRUMENTGETDATA_GET());
  }

  List<bool> selectedTickets = List.generate(18 * 4, (index) => false);
  List<bool> selectedTickets2 = List.generate(18 * 4, (index2) => false);
  bool isSelecting = false;
  List<int> UseBoxRECEIVED = [];
  List<int> UseBoxRESERVED = [];
  List<int> selectedTicketIndexes = [];

  @override
  Widget build(BuildContext context) {
    P02INSIDEINSTRUMENTMAINcontext = context;
    List<P02INSIDEINSTRUMENTGETDATAclass> _datain = widget.data ?? [];
    List<P02INSIDEINSTRUMENTGETDATAclass> AllSSTCheckBox = _datain.toList();
    List<Map<String, String>> selectedDataRECEIVED = [];
    List<Map<String, String>> selectedDataRESERVED = [];
    List<Map<String, String>> SST1DataRECEIVED = [];
    List<Map<String, String>> SST2DataRECEIVED = [];
    List<Map<String, String>> SST3DataRECEIVED = [];
    List<Map<String, String>> SST4DataRECEIVED = [];
    List<Map<String, String>> SST1DataRESERVED = [];
    List<Map<String, String>> SST2DataRESERVED = [];
    List<Map<String, String>> SST3DataRESERVED = [];
    List<Map<String, String>> SST4DataRESERVED = [];
    List<int> allCheckboxSST1RECEIVED = [];
    List<int> allCheckboxSST2RECEIVED = [];
    List<int> allCheckboxSST3RECEIVED = [];
    List<int> allCheckboxSST4RECEIVED = [];
    List<int> allCheckboxSST1RESERVED = [];
    List<int> allCheckboxSST2RESERVED = [];
    List<int> allCheckboxSST3RESERVED = [];
    List<int> allCheckboxSST4RESERVED = [];

    for (var data in AllSSTCheckBox) {
      if (data.INSTRUMENT == 'SST No.1') {
        if (data.STATUS == 'RECEIVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST1DataRECEIVED.add(transformedData);
        } else if (data.STATUS == 'RESERVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST1DataRESERVED.add(transformedData);
        }
      } else if (data.INSTRUMENT == 'SST No.2') {
        if (data.STATUS == 'RECEIVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST2DataRECEIVED.add(transformedData);
        } else if (data.STATUS == 'RESERVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST2DataRESERVED.add(transformedData);
        }
      } else if (data.INSTRUMENT == 'SST No.3') {
        if (data.STATUS == 'RECEIVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST3DataRECEIVED.add(transformedData);
        } else if (data.STATUS == 'RESERVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST3DataRESERVED.add(transformedData);
        }
      } else if (data.INSTRUMENT == 'SST No.4' && data.STATUS == 'RECEIVED') {
        if (data.STATUS == 'RECEIVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST4DataRECEIVED.add(transformedData);
        } else if (data.STATUS == 'RESERVED') {
          Map<String, String> transformedData = {
            'REQUESTNO': data.REQUESTNO,
            'CHECKBOX': data.CHECKBOX,
            'METHOD': data.METHOD,
          };
          SST4DataRESERVED.add(transformedData);
        }
      }
    }

    for (var item in SST1DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST1DataRESERVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1RESERVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST2DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST2DataRESERVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2RESERVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST3DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST3DataRESERVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3RESERVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST4DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST4DataRESERVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4RESERVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    allCheckboxSST1RECEIVED.sort();
    allCheckboxSST2RECEIVED.sort();
    allCheckboxSST3RECEIVED.sort();
    allCheckboxSST4RECEIVED.sort();
    allCheckboxSST1RESERVED.sort();
    allCheckboxSST2RESERVED.sort();
    allCheckboxSST3RESERVED.sort();
    allCheckboxSST4RESERVED.sort();

    // String? lastMethodSST1 = '';
    // String? lastMethodSST2 = '';
    // String? lastMethodSST3 = '';
    // String? lastMethodSST4 = '';

    // if (SST1DataRECEIVED.isNotEmpty) {
    //   lastMethodSST1 = SST1DataRECEIVED.last['METHOD'];
    // }
    // if (SST2DataRECEIVED.isNotEmpty) {
    //   lastMethodSST2 = SST2DataRECEIVED.last['METHOD'];
    // }
    // if (SST3DataRECEIVED.isNotEmpty) {
    //   lastMethodSST3 = SST3DataRECEIVED.last['METHOD'];
    // }
    // if (SST4DataRECEIVED.isNotEmpty) {
    //   lastMethodSST4 = SST4DataRECEIVED.last['METHOD'];
    // }

    if (selectpage == "Salt Spray Tester : SST No.1") {
      UseBoxRECEIVED = allCheckboxSST1RECEIVED;
      UseBoxRESERVED = allCheckboxSST1RESERVED;
      selectedDataRECEIVED = SST1DataRECEIVED;
      selectedDataRESERVED = SST1DataRESERVED;
    } else if (selectpage == "Salt Spray Tester : SST No.2") {
      UseBoxRECEIVED = allCheckboxSST2RECEIVED;
      UseBoxRESERVED = allCheckboxSST2RESERVED;
      selectedDataRECEIVED = SST2DataRECEIVED;
      selectedDataRESERVED = SST2DataRESERVED;
    } else if (selectpage == "Salt Spray Tester : SST No.3") {
      UseBoxRECEIVED = allCheckboxSST3RECEIVED;
      UseBoxRESERVED = allCheckboxSST3RESERVED;
      selectedDataRECEIVED = SST3DataRECEIVED;
      selectedDataRESERVED = SST3DataRESERVED;
    } else if (selectpage == "Salt Spray Tester : SST No.4") {
      UseBoxRECEIVED = allCheckboxSST4RECEIVED;
      UseBoxRESERVED = allCheckboxSST4RESERVED;
      selectedDataRECEIVED = SST4DataRECEIVED;
      selectedDataRESERVED = SST4DataRESERVED;
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
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectpage,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (selectstatus != 'RECEIVED' && selectstatus != 'RESERVED')
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 225,
                              height: 600,
                              color: Colors.green[200],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  const Center(
                                    child: Text(
                                      'RECEIVED JOB',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // ข้อมูล selectedDataRECEIVED อยู่ใน Expanded + SingleChildScrollView
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // ให้ข้อความชิดซ้าย
                                        children: selectedDataRECEIVED.map((data) {
                                          final reqNo = data['REQUESTNO'] ?? '';
                                          final checkbox = data['CHECKBOX'] ?? '';
                                          return Padding(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                                            child: Text(
                                              "$reqNo = $checkbox",
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Center(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
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
                                top: 10,
                                right: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
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
                                        Text('=   Available for use', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
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
                                        Text('=   RECIEVED JOB', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 30,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[200],
                                            border: Border.all(color: Colors.green, width: 1),
                                          ),
                                        ),
                                        Text('=   RESERVED JOB', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
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
                                        Text('=   Do not use', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 240,
                                top: 150,
                                child: SizedBox(
                                  width: 170,
                                  height: 370,
                                  child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 2.07,
                                    ),
                                    itemCount: 18 * 4,
                                    itemBuilder: (context, index) {
                                      bool isRedDisabled = UseBoxRECEIVED.contains(index + 1);
                                      bool isBlueDisabled =
                                          UseBoxRESERVED.contains(index + 1); // เช็คว่ามีในลิสต์ไหม
                                      bool isBlackDisabled = [1, 5, 9, 36, 40, 44, 48, 52, 61, 65, 69]
                                          .contains(index + 1); // เช็ค index ที่กำหนด
                                      return Container(
                                        margin: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          color: isBlackDisabled
                                              ? Colors.black // สีดำถ้าเป็น index ที่กำหนด
                                              : (isRedDisabled
                                                  ? Colors.red // สีแดงถ้ามีใน UseBoxRECEIVED
                                                  : isBlueDisabled
                                                      ? Colors.blue[200]
                                                      : (index < selectedTickets.length &&
                                                              selectedTickets[index]
                                                          ? Colors.yellow
                                                          : Colors.green.withOpacity(0.5))),
                                          border: Border.all(color: Colors.green, width: 1),
                                        ),
                                        child: InkWell(
                                          onTap: (isRedDisabled || isBlackDisabled || isBlueDisabled)
                                              ? null
                                              : () {
                                                  if (index < selectedTickets.length) {
                                                    setState(() {
                                                      selectedTickets[index] = !selectedTickets[index];
                                                      int realIndex = index + 1;

                                                      if (selectedTickets[index]) {
                                                        // เพิ่มเข้า list ถ้าเลือก
                                                        if (!selectedTicketIndexes.contains(realIndex)) {
                                                          selectedTicketIndexes.add(realIndex);
                                                        }
                                                      } else {
                                                        // ลบออกถ้ายกเลิกเลือก
                                                        selectedTicketIndexes.remove(realIndex);
                                                      }
                                                      // print(selectedTicketIndexes);
                                                    });
                                                  }
                                                  // print(index + 1);
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
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 2.07,
                                    ),
                                    itemCount: 18 * 4,
                                    itemBuilder: (context, index2) {
                                      bool isRedDisabled =
                                          UseBoxRECEIVED.contains(index2 + 73); // เช็คว่ามีในลิสต์ไหม
                                      bool isBlueDisabled = UseBoxRESERVED.contains(index2 + 73);
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
                                      ].contains(index2 + 73); // เช็ค index ที่กำหนด

                                      return Container(
                                        margin: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          color: isBlackDisabled
                                              ? Colors.black // สีดำถ้าเป็น index ที่กำหนด
                                              : (isRedDisabled
                                                  ? Colors.red // สีแดงถ้ามีใน UseBoxRECEIVED
                                                  : isBlueDisabled
                                                      ? Colors.blue[200]
                                                      : (selectedTickets2[index2]
                                                          ? Colors.yellow
                                                          : Colors.green.withOpacity(0.5))),
                                          border: Border.all(color: Colors.green, width: 1),
                                        ),
                                        child: InkWell(
                                          onTap: (isRedDisabled || isBlackDisabled || isBlueDisabled)
                                              ? null // ปิดการกดถ้าเป็น index ที่ถูกปิด
                                              : () {
                                                  setState(() {
                                                    selectedTickets2[index2] = !selectedTickets2[index2];
                                                    int realIndex = index2 + 73;

                                                    if (selectedTickets2[index2]) {
                                                      // เพิ่มเข้า list ถ้าเลือก
                                                      if (!selectedTicketIndexes.contains(realIndex)) {
                                                        selectedTicketIndexes.add(realIndex);
                                                      }
                                                    } else {
                                                      // ลบออกถ้ายกเลิกเลือก
                                                      selectedTicketIndexes.remove(realIndex);
                                                    }
                                                    // print(selectedTicketIndexes);
                                                  });
                                                  // print(index2 + 73);
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
                        if (selectstatus != 'RECEIVED' && selectstatus != 'RESERVED')
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 225,
                              height: 600,
                              color: Colors.yellow[100],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  const Center(
                                    child: Text(
                                      'RESERVED JOB',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // ข้อมูล selectedDataRECEIVED อยู่ใน Expanded + SingleChildScrollView
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // ให้ข้อความชิดซ้าย
                                        children: selectedDataRESERVED.map((data) {
                                          final reqNo = data['REQUESTNO'] ?? '';
                                          final checkbox = data['CHECKBOX'] ?? '';
                                          return Padding(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                                            child: Text(
                                              "$reqNo = $checkbox",
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selectstatus != 'RECEIVED' && selectstatus != 'RESERVED')
            Positioned(
              top: 16,
              left: 16,
              child: ElevatedButton(
                onPressed: () {
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('SALT SPRAY MONITORING SYSTEM', Page1());
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
                    spacing: 4,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      Text(
                        'Back to main page',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (selectstatus == 'RECEIVED' || selectstatus == 'RESERVED')
            Positioned(
              bottom: 16,
              right: 86,
              child: ElevatedButton(
                onPressed: () {
                  selectslot.text = selectedTicketIndexes.join(',');
                  // print(selectslot.text);
                  P03DATATABLEVAR.CHECKBOX = selectslot.text;
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          if (selectstatus == 'RECEIVED' || selectstatus == 'RESERVED')
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
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
