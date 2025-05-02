// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, use_build_context_synchronously, deprecated_member_use
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/BlocEvent/03-01-P03DATATABLEGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/ComInputTextTan.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';
import '../page2.dart';
import 'P03DATATABLEVAR.dart';
import 'package:dropdown_search/dropdown_search.dart';

late BuildContext P03DATATABLEMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P03DATATABLEMAIN extends StatefulWidget {
  P03DATATABLEMAIN({
    super.key,
    this.data,
  });
  List<P03DATATABLEGETDATAclass>? data;

  @override
  State<P03DATATABLEMAIN> createState() => _P03DATATABLEMAINState();
}

class _P03DATATABLEMAINState extends State<P03DATATABLEMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P03DATATABLEGETDATA_Bloc>().add(P03DATATABLEGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P03DATATABLEMAINcontext = context;
    List<P03DATATABLEGETDATAclass> _datain = widget.data ?? [];
    selectpage = '';
    selectstatus = '';
    selectslot.text = '';
    List<P03DATATABLEGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      _datain.where(
        (data) =>
            data.REQUESTNO.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.REPORTNO.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.SECTION.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.REQUESTER.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.CUSTOMERNAME.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME1.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO1.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME2.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO2.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME3.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO3.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME4.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO4.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME5.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO5.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME6.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO6.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME7.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO7.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME8.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO8.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME9.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO9.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNAME10.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.PARTNO10.toLowerCase().contains(P03DATATABLEVAR.SEARCH),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  'SALT SPRAY STATUS',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ComInputTextTan(
                        sPlaceholder: "Search...",
                        isSideIcon: true,
                        height: 40,
                        width: 400,
                        isContr: P03DATATABLEVAR.iscontrol,
                        fnContr: (input) {
                          P03DATATABLEVAR.iscontrol = input;
                        },
                        sValue: P03DATATABLEVAR.SEARCH,
                        returnfunc: (String s) {
                          setState(() {
                            P03DATATABLEVAR.SEARCH = s;
                          });
                        },
                      ),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            P03DATATABLEVAR.isHoveredClear = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            P03DATATABLEVAR.isHoveredClear = false;
                          });
                        },
                        child: InkWell(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          onTap: () {
                            setState(() {
                              P03DATATABLEVAR.isHoveredClear = false;
                              P03DATATABLEVAR.iscontrol = true;
                              P03DATATABLEVAR.SEARCH = '';
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: P03DATATABLEVAR.isHoveredClear
                                    ? Colors.yellowAccent.shade700
                                    : Colors.redAccent.shade700,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: const [
                                      Colors.white,
                                      Colors.red,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ).createShader(bounds),
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: P03DATATABLEVAR.isHoveredClear ? 15 : 17,
                                      end: P03DATATABLEVAR.isHoveredClear ? 17 : 15,
                                    ),
                                    duration: Duration(milliseconds: 200),
                                    builder: (context, size, child) {
                                      return TweenAnimationBuilder<Color?>(
                                        tween: ColorTween(
                                          begin: P03DATATABLEVAR.isHoveredClear
                                              ? Colors.redAccent.shade700
                                              : Colors.yellowAccent.shade700,
                                          end: P03DATATABLEVAR.isHoveredClear
                                              ? Colors.yellowAccent.shade700
                                              : Colors.redAccent.shade700,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        builder: (context, color, child) {
                                          return Text(
                                            'CLEAR',
                                            style: TextStyle(
                                              fontSize: size,
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<P03DATATABLEGETDATA_Bloc>().add(P03DATATABLEGETDATA_GET());
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Icon(
                                Icons.refresh_rounded,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Refresh',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await fetchCustomerAndIncharge();
                                showAddDialog(P03DATATABLEMAINcontext);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Add Job',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Scrollbar(
                      controller: _controllerIN01,
                      thumbVisibility: true,
                      interactive: true,
                      thickness: 10,
                      radius: Radius.circular(20),
                      child: SingleChildScrollView(
                        controller: _controllerIN01,
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Table(
                              border: TableBorder.all(),
                              columnWidths: {
                                0: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth0),
                                1: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth1),
                                2: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth2),
                                3: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth3),
                                4: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth4),
                                5: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth5),
                                6: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth6),
                                7: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth7),
                                8: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth8),
                                9: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth9),
                                10: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth10),
                                11: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth11),
                                12: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth12),
                                13: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth13),
                                14: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth14),
                                15: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth15),
                                16: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth16),
                                17: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth17),
                                18: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth18),
                                19: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth19),
                                20: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth20),
                                21: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth21),
                                22: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth22),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(child: buildHeaderCell('Request No.')),
                                    TableCell(child: buildHeaderCell('Report No.')),
                                    TableCell(child: buildHeaderCell('Section Request')),
                                    TableCell(child: buildHeaderCell('Requester')),
                                    TableCell(child: buildHeaderCell('Received Date\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Customer Name')),
                                    TableCell(child: buildHeaderCell('Part Name')),
                                    TableCell(child: buildHeaderCell('Part No.')),
                                    TableCell(child: buildHeaderCell('Amount of\nsample\n(Pcs)')),
                                    TableCell(child: buildHeaderCell('Take\nphoto\n(Pcs)')),
                                    TableCell(
                                        child: buildHeaderCell('Start Date\n(วันที่นำงานเข้า)\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Time (Hrs.)')),
                                    TableCell(
                                        child: buildHeaderCell('Finish Date\n(วันเอางานออก)\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Temp Report Date\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Due Date\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Instrument')),
                                    TableCell(child: buildHeaderCell('Method')),
                                    TableCell(child: buildHeaderCell('Person incharge')),
                                    TableCell(child: buildHeaderCell('Approved Date')),
                                    TableCell(child: buildHeaderCell('Approved By')),
                                    TableCell(child: buildHeaderCell('Status')),
                                    TableCell(child: buildHeaderCell('Edit')),
                                    TableCell(child: buildHeaderCell('Remark')),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth0),
                                    1: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth1),
                                    2: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth2),
                                    3: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth3),
                                    4: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth4),
                                    5: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth5),
                                    6: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth6),
                                    7: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth7),
                                    8: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth8),
                                    9: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth9),
                                    10: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth10),
                                    11: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth11),
                                    12: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth12),
                                    13: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth13),
                                    14: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth14),
                                    15: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth15),
                                    16: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth16),
                                    17: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth17),
                                    18: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth18),
                                    19: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth19),
                                    20: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth20),
                                    21: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth21),
                                    22: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth22),
                                  },
                                  children: _datasearch.map((item) {
                                    // int dataCount = _datasearch.indexOf(item) + 1;
                                    return TableRow(
                                      children: [
                                        TableCell(
                                            child: buildDataCell(
                                                item.REQUESTNO, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.REPORTNO, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.SECTION, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.REQUESTER, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.RECEIVEDDATE, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.CUSTOMERNAME, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell('Part Name', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Part No', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                '${item.AMOUNTSAMPLE}', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                '${item.TAKEPHOTO}', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.STARTDATE, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Time', countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell('Finish Date', countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell('Temp Date', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Due Date', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.INSTRUMENT, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.METHOD, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.INCHARGE, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.APPROVEDDATE, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.APPROVEDBY, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.STATUS, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Edit', countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.REMARK, countRowMultiplier(item), item)),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeaderCell(String title) {
  return Container(
    height: 50,
    color: Colors.blueGrey,
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget buildDataCell(String data, int maxRowCount, dynamic item) {
  List<dynamic> fieldValues = [];

  if (data == 'Part Name') {
    fieldValues = [
      item.PARTNAME1,
      item.PARTNAME2,
      item.PARTNAME3,
      item.PARTNAME4,
      item.PARTNAME5,
      item.PARTNAME6,
      item.PARTNAME7,
      item.PARTNAME8,
      item.PARTNAME9,
      item.PARTNAME10,
    ];
  } else if (data == 'Part No') {
    fieldValues = [
      item.PARTNO1,
      item.PARTNO2,
      item.PARTNO3,
      item.PARTNO4,
      item.PARTNO5,
      item.PARTNO6,
      item.PARTNO7,
      item.PARTNO8,
      item.PARTNO9,
      item.PARTNO10,
    ];
  } else if (data == 'Time') {
    fieldValues = [
      item.TIME1,
      item.TIME2,
      item.TIME3,
      item.TIME4,
      item.TIME5,
      item.TIME6,
      item.TIME7,
      item.TIME8,
      item.TIME9,
      item.TIME10,
    ];
  } else if (data == 'Finish Date') {
    fieldValues = [
      item.FINISHDATE1,
      item.FINISHDATE2,
      item.FINISHDATE3,
      item.FINISHDATE4,
      item.FINISHDATE5,
      item.FINISHDATE6,
      item.FINISHDATE7,
      item.FINISHDATE8,
      item.FINISHDATE9,
      item.FINISHDATE10,
    ];
  } else if (data == 'Temp Date') {
    fieldValues = [
      item.TEMPDATE1,
      item.TEMPDATE2,
      item.TEMPDATE3,
      item.TEMPDATE4,
      item.TEMPDATE5,
      item.TEMPDATE6,
      item.TEMPDATE7,
      item.TEMPDATE8,
      item.TEMPDATE9,
      item.TEMPDATE10,
    ];
  } else if (data == 'Due Date') {
    fieldValues = [
      item.DUEDATE1,
      item.DUEDATE2,
      item.DUEDATE3,
      item.DUEDATE4,
      item.DUEDATE5,
      item.DUEDATE6,
      item.DUEDATE7,
      item.DUEDATE8,
      item.DUEDATE9,
      item.DUEDATE10,
    ];
  }

  if (data == 'Time') {
    fieldValues = fieldValues.where((v) => v != null && v != 0).toList();
  } else {
    fieldValues = fieldValues.where((v) => v != null && v.toString().trim().isNotEmpty).toList();
  }

  if (fieldValues.isNotEmpty) {
    double heightPerCell = 30.0 * maxRowCount / fieldValues.length;

    return Column(
      children: fieldValues.map((value) {
        return Container(
          height: heightPerCell,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 0.5),
            ),
          ),
          child: Center(
            child: Text(
              value.toString(),
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }

  if (data == 'Edit') {
    return SizedBox(
      height: 30.0 * maxRowCount,
      child: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            textStyle: const TextStyle(fontSize: 10, color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          icon: const Icon(Icons.edit, size: 14, color: Colors.white),
          label: const Text(
            'Edit',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            await fetchCustomerAndIncharge();
            P03DATATABLEMAINcontext.read<P03DATATABLEGETDATA_Bloc>().add(P03DATATABLEGETDATA_GET());
            showEditDialog(P03DATATABLEMAINcontext, item);
          },
        ),
      ),
    );
  }

  // ถ้าไม่มีข้อมูล แสดง cell เปล่าที่มีความสูงเท่ากับ maxRowCount
  return SizedBox(
    height: 30.0 * maxRowCount,
    child: Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        decoration: (data == 'RECEIVED' || data == 'RESERVED' || data == 'CANCEL' || data == 'COMPLETED')
            ? BoxDecoration(
                color: _getStatusColor(data),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              )
            : const BoxDecoration(),
        child: Text(
          data,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: (data == 'RECEIVED' || data == 'RESERVED' || data == 'CANCEL' || data == 'COMPLETED')
                ? Colors.white
                : Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

int countRowMultiplier(item) {
  // TIME1 - TIME10
  List<dynamic> timeFields = [
    item.TIME1,
    item.TIME2,
    item.TIME3,
    item.TIME4,
    item.TIME5,
    item.TIME6,
    item.TIME7,
    item.TIME8,
    item.TIME9,
    item.TIME10,
  ];
  int timeCount = timeFields.where((time) => time != null && time != 0).length;

  // PARTNAME1 - PARTNAME10
  List<dynamic> partNameFields = [
    item.PARTNAME1,
    item.PARTNAME2,
    item.PARTNAME3,
    item.PARTNAME4,
    item.PARTNAME5,
    item.PARTNAME6,
    item.PARTNAME7,
    item.PARTNAME8,
    item.PARTNAME9,
    item.PARTNAME10,
  ];
  int partNameCount = partNameFields.where((Name) => Name != null && Name != '').length;

  // PARTNO1 - PARTNO10
  List<dynamic> partNoFields = [
    item.PARTNO1,
    item.PARTNO2,
    item.PARTNO3,
    item.PARTNO4,
    item.PARTNO5,
    item.PARTNO6,
    item.PARTNO7,
    item.PARTNO8,
    item.PARTNO9,
    item.PARTNO10,
  ];
  int partNoCount = partNoFields.where((No) => No != null && No != '').length;

  // คืนค่ามากที่สุด
  return [timeCount, partNameCount, partNoCount].reduce((a, b) => a > b ? a : b);
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'RECEIVED':
      return Colors.blue;
    case 'RESERVED':
      return Colors.orange;
    case 'CANCEL':
      return Colors.red;
    case 'COMPLETED':
      return Colors.green;
    default:
      return Colors.grey.shade200;
  }
}

void showEditDialog(BuildContext context, P03DATATABLEGETDATAclass item) {
  // print(item.REQUESTNO);
  final FocusNode RequestNoFocusNode = FocusNode();
  final FocusNode ReportNoFocusNode = FocusNode();
  final FocusNode SectionRequestFocusNode = FocusNode();
  final FocusNode RequesterFocusNode = FocusNode();
  final FocusNode ReceivedDateFocusNode = FocusNode();
  final FocusNode CustomerNameFocusNode = FocusNode();
  final FocusNode PartName1FocusNode = FocusNode();
  final FocusNode PartNo1FocusNode = FocusNode();
  final FocusNode PartName2FocusNode = FocusNode();
  final FocusNode PartNo2FocusNode = FocusNode();
  final FocusNode PartName3FocusNode = FocusNode();
  final FocusNode PartNo3FocusNode = FocusNode();
  final FocusNode PartName4FocusNode = FocusNode();
  final FocusNode PartNo4FocusNode = FocusNode();
  final FocusNode PartName5FocusNode = FocusNode();
  final FocusNode PartNo5FocusNode = FocusNode();
  final FocusNode PartName6FocusNode = FocusNode();
  final FocusNode PartNo6FocusNode = FocusNode();
  final FocusNode PartName7FocusNode = FocusNode();
  final FocusNode PartNo7FocusNode = FocusNode();
  final FocusNode PartName8FocusNode = FocusNode();
  final FocusNode PartNo8FocusNode = FocusNode();
  final FocusNode PartName9FocusNode = FocusNode();
  final FocusNode PartNo9FocusNode = FocusNode();
  final FocusNode PartName10FocusNode = FocusNode();
  final FocusNode PartNo10FocusNode = FocusNode();
  final FocusNode AmountOfSampleFocusNode = FocusNode();
  final FocusNode TakePhotoFocusNode = FocusNode();
  final FocusNode StartDateFocusNode = FocusNode();
  final FocusNode Time1FocusNode = FocusNode();
  final FocusNode Time2FocusNode = FocusNode();
  final FocusNode Time3FocusNode = FocusNode();
  final FocusNode Time4FocusNode = FocusNode();
  final FocusNode Time5FocusNode = FocusNode();
  final FocusNode Time6FocusNode = FocusNode();
  final FocusNode Time7FocusNode = FocusNode();
  final FocusNode Time8FocusNode = FocusNode();
  final FocusNode Time9FocusNode = FocusNode();
  final FocusNode Time10FocusNode = FocusNode();
  final FocusNode FinishDate1FocusNode = FocusNode();
  final FocusNode FinishDate2FocusNode = FocusNode();
  final FocusNode FinishDate3FocusNode = FocusNode();
  final FocusNode FinishDate4FocusNode = FocusNode();
  final FocusNode FinishDate5FocusNode = FocusNode();
  final FocusNode FinishDate6FocusNode = FocusNode();
  final FocusNode FinishDate7FocusNode = FocusNode();
  final FocusNode FinishDate8FocusNode = FocusNode();
  final FocusNode FinishDate9FocusNode = FocusNode();
  final FocusNode FinishDate10FocusNode = FocusNode();
  final FocusNode TempDate1FocusNode = FocusNode();
  final FocusNode TempDate2FocusNode = FocusNode();
  final FocusNode TempDate3FocusNode = FocusNode();
  final FocusNode TempDate4FocusNode = FocusNode();
  final FocusNode TempDate5FocusNode = FocusNode();
  final FocusNode TempDate6FocusNode = FocusNode();
  final FocusNode TempDate7FocusNode = FocusNode();
  final FocusNode TempDate8FocusNode = FocusNode();
  final FocusNode TempDate9FocusNode = FocusNode();
  final FocusNode TempDate10FocusNode = FocusNode();
  final FocusNode DueDate1FocusNode = FocusNode();
  final FocusNode DueDate2FocusNode = FocusNode();
  final FocusNode DueDate3FocusNode = FocusNode();
  final FocusNode DueDate4FocusNode = FocusNode();
  final FocusNode DueDate5FocusNode = FocusNode();
  final FocusNode DueDate6FocusNode = FocusNode();
  final FocusNode DueDate7FocusNode = FocusNode();
  final FocusNode DueDate8FocusNode = FocusNode();
  final FocusNode DueDate9FocusNode = FocusNode();
  final FocusNode DueDate10FocusNode = FocusNode();
  final FocusNode InstrumentFocusNode = FocusNode();
  final FocusNode MethodFocusNode = FocusNode();
  final FocusNode InchargeFocusNode = FocusNode();
  final FocusNode ApprovedDateFocusNode = FocusNode();
  final FocusNode ApprovedByFocusNode = FocusNode();
  final FocusNode StatusFocusNode = FocusNode();
  final FocusNode RemarkFocusNode = FocusNode();

  TextEditingController RequestNoController = TextEditingController(text: item.REQUESTNO);
  TextEditingController ReportNoController = TextEditingController(text: item.REPORTNO);
  TextEditingController SectionRequestController = TextEditingController(text: item.SECTION);
  TextEditingController RequesterController = TextEditingController(text: item.REQUESTER);
  TextEditingController ReceivedDateController = TextEditingController(text: item.RECEIVEDDATE);
  TextEditingController CustomerNameController = TextEditingController(text: item.CUSTOMERNAME);
  TextEditingController PartName1Controller = TextEditingController(text: item.PARTNAME1);
  TextEditingController PartNo1Controller = TextEditingController(text: item.PARTNO1);
  TextEditingController PartName2Controller = TextEditingController(text: item.PARTNAME2);
  TextEditingController PartNo2Controller = TextEditingController(text: item.PARTNO2);
  TextEditingController PartName3Controller = TextEditingController(text: item.PARTNAME3);
  TextEditingController PartNo3Controller = TextEditingController(text: item.PARTNO3);
  TextEditingController PartName4Controller = TextEditingController(text: item.PARTNAME4);
  TextEditingController PartNo4Controller = TextEditingController(text: item.PARTNO4);
  TextEditingController PartName5Controller = TextEditingController(text: item.PARTNAME5);
  TextEditingController PartNo5Controller = TextEditingController(text: item.PARTNO5);
  TextEditingController PartName6Controller = TextEditingController(text: item.PARTNAME6);
  TextEditingController PartNo6Controller = TextEditingController(text: item.PARTNO6);
  TextEditingController PartName7Controller = TextEditingController(text: item.PARTNAME7);
  TextEditingController PartNo7Controller = TextEditingController(text: item.PARTNO7);
  TextEditingController PartName8Controller = TextEditingController(text: item.PARTNAME8);
  TextEditingController PartNo8Controller = TextEditingController(text: item.PARTNO8);
  TextEditingController PartName9Controller = TextEditingController(text: item.PARTNAME9);
  TextEditingController PartNo9Controller = TextEditingController(text: item.PARTNO9);
  TextEditingController PartName10Controller = TextEditingController(text: item.PARTNAME10);
  TextEditingController PartNo10Controller = TextEditingController(text: item.PARTNO10);
  TextEditingController AmountOfSampleController = TextEditingController(text: '${item.AMOUNTSAMPLE}');
  TextEditingController TakePhotoController = TextEditingController(text: '${item.TAKEPHOTO}');
  TextEditingController StartDateController = TextEditingController(text: item.STARTDATE);
  TextEditingController Time1Controller = TextEditingController(text: '${item.TIME1}');
  TextEditingController Time2Controller = TextEditingController(text: '${item.TIME2}');
  TextEditingController Time3Controller = TextEditingController(text: '${item.TIME3}');
  TextEditingController Time4Controller = TextEditingController(text: '${item.TIME4}');
  TextEditingController Time5Controller = TextEditingController(text: '${item.TIME5}');
  TextEditingController Time6Controller = TextEditingController(text: '${item.TIME6}');
  TextEditingController Time7Controller = TextEditingController(text: '${item.TIME7}');
  TextEditingController Time8Controller = TextEditingController(text: '${item.TIME8}');
  TextEditingController Time9Controller = TextEditingController(text: '${item.TIME9}');
  TextEditingController Time10Controller = TextEditingController(text: '${item.TIME10}');
  TextEditingController FinishDate1Controller = TextEditingController(text: item.FINISHDATE1);
  TextEditingController FinishDate2Controller = TextEditingController(text: item.FINISHDATE2);
  TextEditingController FinishDate3Controller = TextEditingController(text: item.FINISHDATE3);
  TextEditingController FinishDate4Controller = TextEditingController(text: item.FINISHDATE4);
  TextEditingController FinishDate5Controller = TextEditingController(text: item.FINISHDATE5);
  TextEditingController FinishDate6Controller = TextEditingController(text: item.FINISHDATE6);
  TextEditingController FinishDate7Controller = TextEditingController(text: item.FINISHDATE7);
  TextEditingController FinishDate8Controller = TextEditingController(text: item.FINISHDATE8);
  TextEditingController FinishDate9Controller = TextEditingController(text: item.FINISHDATE9);
  TextEditingController FinishDate10Controller = TextEditingController(text: item.FINISHDATE10);
  TextEditingController TempDate1Controller = TextEditingController(text: item.TEMPDATE1);
  TextEditingController TempDate2Controller = TextEditingController(text: item.TEMPDATE2);
  TextEditingController TempDate3Controller = TextEditingController(text: item.TEMPDATE3);
  TextEditingController TempDate4Controller = TextEditingController(text: item.TEMPDATE4);
  TextEditingController TempDate5Controller = TextEditingController(text: item.TEMPDATE5);
  TextEditingController TempDate6Controller = TextEditingController(text: item.TEMPDATE6);
  TextEditingController TempDate7Controller = TextEditingController(text: item.TEMPDATE7);
  TextEditingController TempDate8Controller = TextEditingController(text: item.TEMPDATE8);
  TextEditingController TempDate9Controller = TextEditingController(text: item.TEMPDATE9);
  TextEditingController TempDate10Controller = TextEditingController(text: item.TEMPDATE10);
  TextEditingController DueDate1Controller = TextEditingController(text: item.DUEDATE1);
  TextEditingController DueDate2Controller = TextEditingController(text: item.DUEDATE2);
  TextEditingController DueDate3Controller = TextEditingController(text: item.DUEDATE3);
  TextEditingController DueDate4Controller = TextEditingController(text: item.DUEDATE4);
  TextEditingController DueDate5Controller = TextEditingController(text: item.DUEDATE5);
  TextEditingController DueDate6Controller = TextEditingController(text: item.DUEDATE6);
  TextEditingController DueDate7Controller = TextEditingController(text: item.DUEDATE7);
  TextEditingController DueDate8Controller = TextEditingController(text: item.DUEDATE8);
  TextEditingController DueDate9Controller = TextEditingController(text: item.DUEDATE9);
  TextEditingController DueDate10Controller = TextEditingController(text: item.DUEDATE10);
  TextEditingController InstrumentController = TextEditingController(text: item.INSTRUMENT);
  TextEditingController MethodController = TextEditingController(text: item.METHOD);
  TextEditingController InchargeController = TextEditingController(text: item.INCHARGE);
  TextEditingController ApprovedDateController = TextEditingController(text: item.APPROVEDDATE);
  TextEditingController ApprovedByController = TextEditingController(text: item.APPROVEDBY);
  TextEditingController StatusController = TextEditingController(text: item.STATUS);
  TextEditingController RemarkController = TextEditingController(text: item.REMARK);

  List<TextEditingController> partNameControllers = [
    PartName1Controller,
    PartName2Controller,
    PartName3Controller,
    PartName4Controller,
    PartName5Controller,
    PartName6Controller,
    PartName7Controller,
    PartName8Controller,
    PartName9Controller,
    PartName10Controller,
  ];
  List<FocusNode> partNameFocusNodes = [
    PartName1FocusNode,
    PartName2FocusNode,
    PartName3FocusNode,
    PartName4FocusNode,
    PartName5FocusNode,
    PartName6FocusNode,
    PartName7FocusNode,
    PartName8FocusNode,
    PartName9FocusNode,
    PartName10FocusNode,
  ];
  List<TextEditingController> partNoControllers = [
    PartNo1Controller,
    PartNo2Controller,
    PartNo3Controller,
    PartNo4Controller,
    PartNo5Controller,
    PartNo6Controller,
    PartNo7Controller,
    PartNo8Controller,
    PartNo9Controller,
    PartNo10Controller,
  ];
  List<FocusNode> partNoFocusNodes = [
    PartNo1FocusNode,
    PartNo2FocusNode,
    PartNo3FocusNode,
    PartNo4FocusNode,
    PartNo5FocusNode,
    PartNo6FocusNode,
    PartNo7FocusNode,
    PartNo8FocusNode,
    PartNo9FocusNode,
    PartNo10FocusNode,
  ];
  List<TextEditingController> timeControllers = [
    Time1Controller,
    Time2Controller,
    Time3Controller,
    Time4Controller,
    Time5Controller,
    Time6Controller,
    Time7Controller,
    Time8Controller,
    Time9Controller,
    Time10Controller,
  ];
  List<FocusNode> timeFocusNodes = [
    Time1FocusNode,
    Time2FocusNode,
    Time3FocusNode,
    Time4FocusNode,
    Time5FocusNode,
    Time6FocusNode,
    Time7FocusNode,
    Time8FocusNode,
    Time9FocusNode,
    Time10FocusNode,
  ];
  List<TextEditingController> finishDateControllers = [
    FinishDate1Controller,
    FinishDate2Controller,
    FinishDate3Controller,
    FinishDate4Controller,
    FinishDate5Controller,
    FinishDate6Controller,
    FinishDate7Controller,
    FinishDate8Controller,
    FinishDate9Controller,
    FinishDate10Controller,
  ];
  List<FocusNode> finishDateFocusNodes = [
    FinishDate1FocusNode,
    FinishDate2FocusNode,
    FinishDate3FocusNode,
    FinishDate4FocusNode,
    FinishDate5FocusNode,
    FinishDate6FocusNode,
    FinishDate7FocusNode,
    FinishDate8FocusNode,
    FinishDate9FocusNode,
    FinishDate10FocusNode,
  ];
  List<TextEditingController> tempDateControllers = [
    TempDate1Controller,
    TempDate2Controller,
    TempDate3Controller,
    TempDate4Controller,
    TempDate5Controller,
    TempDate6Controller,
    TempDate7Controller,
    TempDate8Controller,
    TempDate9Controller,
    TempDate10Controller,
  ];
  List<FocusNode> tempDateFocusNodes = [
    TempDate1FocusNode,
    TempDate2FocusNode,
    TempDate3FocusNode,
    TempDate4FocusNode,
    TempDate5FocusNode,
    TempDate6FocusNode,
    TempDate7FocusNode,
    TempDate8FocusNode,
    TempDate9FocusNode,
    TempDate10FocusNode,
  ];
  List<TextEditingController> dueDateControllers = [
    DueDate1Controller,
    DueDate2Controller,
    DueDate3Controller,
    DueDate4Controller,
    DueDate5Controller,
    DueDate6Controller,
    DueDate7Controller,
    DueDate8Controller,
    DueDate9Controller,
    DueDate10Controller,
  ];
  List<FocusNode> dueDateFocusNodes = [
    DueDate1FocusNode,
    DueDate2FocusNode,
    DueDate3FocusNode,
    DueDate4FocusNode,
    DueDate5FocusNode,
    DueDate6FocusNode,
    DueDate7FocusNode,
    DueDate8FocusNode,
    DueDate9FocusNode,
    DueDate10FocusNode,
  ];
  List<int> itemTimes = [
    item.TIME1,
    item.TIME2,
    item.TIME3,
    item.TIME4,
    item.TIME5,
    item.TIME6,
    item.TIME7,
    item.TIME8,
    item.TIME9,
    item.TIME10,
  ];
  List<String> partNames = [
    item.PARTNAME1,
    item.PARTNAME2,
    item.PARTNAME3,
    item.PARTNAME4,
    item.PARTNAME5,
    item.PARTNAME6,
    item.PARTNAME7,
    item.PARTNAME8,
    item.PARTNAME9,
    item.PARTNAME10,
  ];
  List<String> partNos = [
    item.PARTNO1,
    item.PARTNO2,
    item.PARTNO3,
    item.PARTNO4,
    item.PARTNO5,
    item.PARTNO6,
    item.PARTNO7,
    item.PARTNO8,
    item.PARTNO9,
    item.PARTNO10,
  ];

  void updateMultipleDatesAll() {
    updateMultipleDates({
      ReceivedDateController: (val) => item.RECEIVEDDATE = val,
      StartDateController: (val) => item.STARTDATE = val,
      FinishDate1Controller: (val) => item.FINISHDATE1 = val,
      FinishDate2Controller: (val) => item.FINISHDATE2 = val,
      FinishDate3Controller: (val) => item.FINISHDATE3 = val,
      FinishDate4Controller: (val) => item.FINISHDATE4 = val,
      FinishDate5Controller: (val) => item.FINISHDATE5 = val,
      FinishDate6Controller: (val) => item.FINISHDATE6 = val,
      FinishDate7Controller: (val) => item.FINISHDATE7 = val,
      FinishDate8Controller: (val) => item.FINISHDATE8 = val,
      FinishDate9Controller: (val) => item.FINISHDATE9 = val,
      FinishDate10Controller: (val) => item.FINISHDATE10 = val,
      TempDate1Controller: (val) => item.TEMPDATE1 = val,
      TempDate2Controller: (val) => item.TEMPDATE2 = val,
      TempDate3Controller: (val) => item.TEMPDATE3 = val,
      TempDate4Controller: (val) => item.TEMPDATE4 = val,
      TempDate5Controller: (val) => item.TEMPDATE5 = val,
      TempDate6Controller: (val) => item.TEMPDATE6 = val,
      TempDate7Controller: (val) => item.TEMPDATE7 = val,
      TempDate8Controller: (val) => item.TEMPDATE8 = val,
      TempDate9Controller: (val) => item.TEMPDATE9 = val,
      TempDate10Controller: (val) => item.TEMPDATE10 = val,
      DueDate1Controller: (val) => item.DUEDATE1 = val,
      DueDate2Controller: (val) => item.DUEDATE2 = val,
      DueDate3Controller: (val) => item.DUEDATE3 = val,
      DueDate4Controller: (val) => item.DUEDATE4 = val,
      DueDate5Controller: (val) => item.DUEDATE5 = val,
      DueDate6Controller: (val) => item.DUEDATE6 = val,
      DueDate7Controller: (val) => item.DUEDATE7 = val,
      DueDate8Controller: (val) => item.DUEDATE8 = val,
      DueDate9Controller: (val) => item.DUEDATE9 = val,
      DueDate10Controller: (val) => item.DUEDATE10 = val,
      ApprovedDateController: (val) => item.APPROVEDDATE = val,
    });
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: 400,
          height: 600,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            spacing: 10,
            children: [
              Text(
                'แก้ไขข้อมูล ${item.REQUESTNO}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      buildCustomFieldforEditData(
                        controller: RequestNoController,
                        focusNode: RequestNoFocusNode,
                        labelText: "Request No.",
                        icon: Icons.assignment,
                      ),
                      buildCustomFieldforEditData(
                        controller: ReportNoController,
                        focusNode: ReportNoFocusNode,
                        labelText: "Report No.",
                        icon: Icons.assignment,
                      ),
                      buildCustomField(
                        controller: SectionRequestController,
                        focusNode: SectionRequestFocusNode,
                        labelText: "Section Request",
                        icon: Icons.account_tree,
                        dropdownItems: ['QC HP', 'QC BP', 'MKT ES1'],
                        onChanged: (value) {
                          item.SECTION = value;
                        },
                      ),
                      buildCustomField(
                        controller: RequesterController,
                        focusNode: RequesterFocusNode,
                        labelText: "Requester",
                        icon: Icons.person,
                        onChanged: (value) {
                          item.REQUESTER = value;
                        },
                      ),
                      buildCustomField(
                        controller: ReceivedDateController,
                        focusNode: ReceivedDateFocusNode,
                        labelText: "Received Date",
                        icon: Icons.calendar_month_rounded,
                        onChanged: (value) {
                          EditTextController(
                            controller: ReceivedDateController,
                            value: value,
                          );
                        },
                      ),
                      buildCustomField(
                        controller: CustomerNameController,
                        focusNode: CustomerNameFocusNode,
                        labelText: "Customer Name",
                        icon: Icons.people,
                        dropdownItems: P03DATATABLEVAR.dropdownCustomer,
                        onChanged: (value) {
                          item.CUSTOMERNAME = value;
                        },
                      ),
                      for (int i = 0; i < 10; i++)
                        if (partNameControllers[i].text != '')
                          buildCustomField(
                            controller: partNameControllers[i],
                            focusNode: partNameFocusNodes[i],
                            labelText: "Part Name ${i + 1}",
                            icon: Icons.settings,
                            onChanged: (value) {
                              EditTextController(
                                controller: partNameControllers[i],
                                value: value,
                              );
                              partNames[i] = value;
                              item.PARTNAME1 = partNames[0];
                              item.PARTNAME2 = partNames[1];
                              item.PARTNAME3 = partNames[2];
                              item.PARTNAME4 = partNames[3];
                              item.PARTNAME5 = partNames[4];
                              item.PARTNAME6 = partNames[5];
                              item.PARTNAME7 = partNames[6];
                              item.PARTNAME8 = partNames[7];
                              item.PARTNAME9 = partNames[8];
                              item.PARTNAME10 = partNames[9];
                            },
                          ),
                      for (int i = 0; i < 10; i++)
                        if (partNoControllers[i].text != '')
                          buildCustomField(
                            controller: partNoControllers[i],
                            focusNode: partNoFocusNodes[i],
                            labelText: "Part No ${i + 1}",
                            icon: Icons.settings,
                            onChanged: (value) {
                              EditTextController(
                                controller: partNoControllers[i],
                                value: value,
                              );
                              partNos[i] = value;
                              item.PARTNO1 = partNos[0];
                              item.PARTNO2 = partNos[1];
                              item.PARTNO3 = partNos[2];
                              item.PARTNO4 = partNos[3];
                              item.PARTNO5 = partNos[4];
                              item.PARTNO6 = partNos[5];
                              item.PARTNO7 = partNos[6];
                              item.PARTNO8 = partNos[7];
                              item.PARTNO9 = partNos[8];
                              item.PARTNO10 = partNos[9];
                            },
                          ),
                      buildCustomField(
                        controller: AmountOfSampleController,
                        focusNode: AmountOfSampleFocusNode,
                        labelText: "Amount of Sample (Pcs)",
                        icon: Icons.science,
                        onChanged: (value) {
                          item.AMOUNTSAMPLE = value.isNotEmpty ? int.parse(value) : 0;
                        },
                      ),
                      buildCustomField(
                        controller: TakePhotoController,
                        focusNode: TakePhotoFocusNode,
                        labelText: "Take photo (Pcs)",
                        icon: Icons.photo_camera,
                        onChanged: (value) {
                          item.TAKEPHOTO = value.isNotEmpty ? int.parse(value) : 0;
                        },
                      ),
                      buildCustomField(
                        controller: StartDateController,
                        focusNode: StartDateFocusNode,
                        labelText: "Start Date",
                        icon: Icons.calendar_month_rounded,
                        onChanged: (value) async {
                          EditTextController(
                            controller: StartDateController,
                            value: value,
                          );
                          // print(StartDateController.text);
                          // print(StartDateController.value);
                          for (int i = 0; i < 10; i++) {
                            calculateFinishDate(
                              startDateController: StartDateController,
                              timeController: timeControllers[i],
                              finishDateController: finishDateControllers[i],
                            );
                            // print('Finish ${finishDateControllers[i]}');
                            DateTime? FinishDateToDateTime =
                                convertStringToDateTime(finishDateControllers[i].text);
                            if (FinishDateToDateTime != '' && FinishDateToDateTime != null) {
                              String CalTemp = await calculateRepDue(
                                startDate: DateTime(FinishDateToDateTime.year, FinishDateToDateTime.month,
                                    FinishDateToDateTime.day),
                                addDays: P03DATATABLEVAR.TempAddDays,
                              );
                              tempDateControllers[i].text = CalTemp;
                              // print('temp ${tempDateControllers[i].text}');
                              String CalDue = await calculateRepDue(
                                startDate: DateTime(FinishDateToDateTime.year, FinishDateToDateTime.month,
                                    FinishDateToDateTime.day),
                                addDays: P03DATATABLEVAR.DueAddDays,
                              );
                              dueDateControllers[i].text = CalDue;
                              // print('temp ${tempDateControllers[i].text}');
                            }
                          }
                        },
                      ),
                      for (int i = 0; i < 10; i++)
                        if (timeControllers[i].text != '0')
                          Column(
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: buildCustomField(
                                      controller: timeControllers[i],
                                      focusNode: timeFocusNodes[i],
                                      labelText: "Time ${i + 1} (Hrs.)",
                                      icon: Icons.timer_sharp,
                                      onChanged: (value) async {
                                        EditTextController(
                                          controller: timeControllers[i],
                                          value: value,
                                        );
                                        calculateFinishDate(
                                          startDateController: StartDateController,
                                          timeController: timeControllers[i],
                                          finishDateController: finishDateControllers[i],
                                        );
                                        await calculateAndSetTempDate(
                                          finishDateController: finishDateControllers[i],
                                          DateController: tempDateControllers[i],
                                          addDays: P03DATATABLEVAR.TempAddDays,
                                        );
                                        await calculateAndSetTempDate(
                                          finishDateController: finishDateControllers[i],
                                          DateController: dueDateControllers[i],
                                          addDays: P03DATATABLEVAR.DueAddDays,
                                        );
                                        itemTimes[i] = value.isNotEmpty ? int.parse(value) : 0;
                                        item.TIME1 = itemTimes[0];
                                        item.TIME2 = itemTimes[1];
                                        item.TIME3 = itemTimes[2];
                                        item.TIME4 = itemTimes[3];
                                        item.TIME5 = itemTimes[4];
                                        item.TIME6 = itemTimes[5];
                                        item.TIME7 = itemTimes[6];
                                        item.TIME8 = itemTimes[7];
                                        item.TIME9 = itemTimes[8];
                                        item.TIME10 = itemTimes[9];
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: buildCustomField(
                                      controller: finishDateControllers[i],
                                      focusNode: finishDateFocusNodes[i],
                                      labelText: "Finish Date ${i + 1}",
                                      icon: Icons.calendar_month_rounded,
                                      onChanged: (value) {
                                        EditTextController(
                                          controller: finishDateControllers[i],
                                          value: value,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildCustomField(
                                      controller: tempDateControllers[i],
                                      focusNode: tempDateFocusNodes[i],
                                      labelText: "Temp Date ${i + 1}",
                                      icon: Icons.calendar_month_rounded,
                                      onChanged: (value) {
                                        EditTextController(
                                          controller: tempDateControllers[i],
                                          value: value,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: buildCustomField(
                                      controller: dueDateControllers[i],
                                      focusNode: dueDateFocusNodes[i],
                                      labelText: "Due Date ${i + 1}",
                                      icon: Icons.calendar_month_rounded,
                                      onChanged: (value) {
                                        EditTextController(
                                          controller: dueDateControllers[i],
                                          value: value,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      buildCustomField(
                        controller: InstrumentController,
                        focusNode: InstrumentFocusNode,
                        labelText: "Instrument",
                        icon: Icons.analytics_outlined,
                        dropdownItems: ['SST No.1', 'SST No.2', 'SST No.3', 'SST No.4'],
                        onChanged: (value) {
                          item.INSTRUMENT = value;
                        },
                      ),
                      buildCustomField(
                        controller: MethodController,
                        focusNode: MethodFocusNode,
                        labelText: "Method",
                        icon: Icons.precision_manufacturing,
                        dropdownItems: ['ASTM-B117', 'ISO-9227', 'Other'],
                        onChanged: (value) {
                          item.METHOD = value;
                        },
                      ),
                      buildCustomField(
                        controller: InchargeController,
                        focusNode: InchargeFocusNode,
                        labelText: "Incharge",
                        icon: Icons.person,
                        dropdownItems: P03DATATABLEVAR.dropdownIncharge,
                        onChanged: (value) {
                          item.INCHARGE = value;
                        },
                      ),
                      buildCustomField(
                        controller: ApprovedDateController,
                        focusNode: ApprovedDateFocusNode,
                        labelText: "Approved Date",
                        icon: Icons.calendar_month_rounded,
                        onChanged: (value) {
                          EditTextController(
                            controller: ApprovedDateController,
                            value: value,
                          );
                        },
                      ),
                      buildCustomField(
                        controller: ApprovedByController,
                        focusNode: ApprovedByFocusNode,
                        labelText: "Approved By",
                        icon: Icons.assignment,
                        dropdownItems: P03DATATABLEVAR.dropdownApprover,
                        onChanged: (value) {
                          item.APPROVEDBY = value;
                        },
                      ),
                      buildCustomFieldforEditData(
                        controller: StatusController,
                        focusNode: StatusFocusNode,
                        labelText: "Status",
                        icon: Icons.info,
                        dropdownItems: ['RECEIVED', 'RESERVED'],
                        onChanged: (value) {
                          P03DATATABLEVAR.STATUS = value;
                        },
                      ),
                      buildCustomField(
                        controller: RemarkController,
                        focusNode: RemarkFocusNode,
                        labelText: "Remark",
                        icon: Icons.comment,
                        onChanged: (value) {
                          item.REMARK = value;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                await showEditConfirmationDialog(
                                  context: context,
                                  onConfirm: () async {
                                    updateMultipleDatesAll();
                                    P03DATATABLEVAR.SendEditDataToAPI = jsonEncode(item.toJson());
                                    // print(P03DATATABLEVAR.SendEditDataToAPI);
                                    EditDataToAPI();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.amber,
                                shadowColor: Colors.amberAccent,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.amber, width: 2),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: const [
                                  Text(
                                    'ยืนยันการแก้ไข',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.edit_note_rounded,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                await showCancelConfirmationDialog(
                                  context: context,
                                  onConfirm: () async {
                                    item.STATUS = 'CANCEL';
                                    updateMultipleDatesAll();
                                    P03DATATABLEVAR.SendEditDataToAPI = jsonEncode(item.toJson());
                                    // print(P03DATATABLEVAR.SendEditDataToAPI);
                                    EditDataToAPI();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                shadowColor: Colors.redAccent,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.red, width: 2),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: const [
                                  Text(
                                    'ยกเลิกงาน',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.red,
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
            ],
          ),
        ),
      );
    },
  );
}

void showAddDialog(BuildContext context) {
  // print(item.REQUESTNO);
  final FocusNode RequestNoFocusNode = FocusNode();
  final FocusNode ReportNoFocusNode = FocusNode();
  final FocusNode SectionRequestFocusNode = FocusNode();
  final FocusNode RequesterFocusNode = FocusNode();
  final FocusNode ReceivedDateFocusNode = FocusNode();
  final FocusNode CustomerNameFocusNode = FocusNode();
  final FocusNode PartName1FocusNode = FocusNode();
  final FocusNode PartNo1FocusNode = FocusNode();
  final FocusNode PartName2FocusNode = FocusNode();
  final FocusNode PartNo2FocusNode = FocusNode();
  final FocusNode PartName3FocusNode = FocusNode();
  final FocusNode PartNo3FocusNode = FocusNode();
  final FocusNode PartName4FocusNode = FocusNode();
  final FocusNode PartNo4FocusNode = FocusNode();
  final FocusNode PartName5FocusNode = FocusNode();
  final FocusNode PartNo5FocusNode = FocusNode();
  final FocusNode PartName6FocusNode = FocusNode();
  final FocusNode PartNo6FocusNode = FocusNode();
  final FocusNode PartName7FocusNode = FocusNode();
  final FocusNode PartNo7FocusNode = FocusNode();
  final FocusNode PartName8FocusNode = FocusNode();
  final FocusNode PartNo8FocusNode = FocusNode();
  final FocusNode PartName9FocusNode = FocusNode();
  final FocusNode PartNo9FocusNode = FocusNode();
  final FocusNode PartName10FocusNode = FocusNode();
  final FocusNode PartNo10FocusNode = FocusNode();
  final FocusNode AmountOfSampleFocusNode = FocusNode();
  final FocusNode TakePhotoFocusNode = FocusNode();
  final FocusNode StartDateFocusNode = FocusNode();
  final FocusNode Time1FocusNode = FocusNode();
  final FocusNode Time2FocusNode = FocusNode();
  final FocusNode Time3FocusNode = FocusNode();
  final FocusNode Time4FocusNode = FocusNode();
  final FocusNode Time5FocusNode = FocusNode();
  final FocusNode Time6FocusNode = FocusNode();
  final FocusNode Time7FocusNode = FocusNode();
  final FocusNode Time8FocusNode = FocusNode();
  final FocusNode Time9FocusNode = FocusNode();
  final FocusNode Time10FocusNode = FocusNode();
  final FocusNode FinishDate1FocusNode = FocusNode();
  final FocusNode FinishDate2FocusNode = FocusNode();
  final FocusNode FinishDate3FocusNode = FocusNode();
  final FocusNode FinishDate4FocusNode = FocusNode();
  final FocusNode FinishDate5FocusNode = FocusNode();
  final FocusNode FinishDate6FocusNode = FocusNode();
  final FocusNode FinishDate7FocusNode = FocusNode();
  final FocusNode FinishDate8FocusNode = FocusNode();
  final FocusNode FinishDate9FocusNode = FocusNode();
  final FocusNode FinishDate10FocusNode = FocusNode();
  final FocusNode TempDate1FocusNode = FocusNode();
  final FocusNode TempDate2FocusNode = FocusNode();
  final FocusNode TempDate3FocusNode = FocusNode();
  final FocusNode TempDate4FocusNode = FocusNode();
  final FocusNode TempDate5FocusNode = FocusNode();
  final FocusNode TempDate6FocusNode = FocusNode();
  final FocusNode TempDate7FocusNode = FocusNode();
  final FocusNode TempDate8FocusNode = FocusNode();
  final FocusNode TempDate9FocusNode = FocusNode();
  final FocusNode TempDate10FocusNode = FocusNode();
  final FocusNode DueDate1FocusNode = FocusNode();
  final FocusNode DueDate2FocusNode = FocusNode();
  final FocusNode DueDate3FocusNode = FocusNode();
  final FocusNode DueDate4FocusNode = FocusNode();
  final FocusNode DueDate5FocusNode = FocusNode();
  final FocusNode DueDate6FocusNode = FocusNode();
  final FocusNode DueDate7FocusNode = FocusNode();
  final FocusNode DueDate8FocusNode = FocusNode();
  final FocusNode DueDate9FocusNode = FocusNode();
  final FocusNode DueDate10FocusNode = FocusNode();
  final FocusNode InstrumentFocusNode = FocusNode();
  final FocusNode MethodFocusNode = FocusNode();
  final FocusNode InchargeFocusNode = FocusNode();
  final FocusNode ApprovedDateFocusNode = FocusNode();
  final FocusNode ApprovedByFocusNode = FocusNode();
  final FocusNode StatusFocusNode = FocusNode();
  final FocusNode CheckBoxFocusNode = FocusNode();
  // final FocusNode RemarkFocusNode = FocusNode();

  TextEditingController RequestNoController = TextEditingController();
  TextEditingController ReportNoController = TextEditingController();
  TextEditingController SectionRequestController = TextEditingController();
  TextEditingController RequesterController = TextEditingController();
  TextEditingController ReceivedDateController = TextEditingController();
  TextEditingController CustomerNameController = TextEditingController();
  TextEditingController PartName1Controller = TextEditingController();
  TextEditingController PartNo1Controller = TextEditingController();
  TextEditingController PartName2Controller = TextEditingController();
  TextEditingController PartNo2Controller = TextEditingController();
  TextEditingController PartName3Controller = TextEditingController();
  TextEditingController PartNo3Controller = TextEditingController();
  TextEditingController PartName4Controller = TextEditingController();
  TextEditingController PartNo4Controller = TextEditingController();
  TextEditingController PartName5Controller = TextEditingController();
  TextEditingController PartNo5Controller = TextEditingController();
  TextEditingController PartName6Controller = TextEditingController();
  TextEditingController PartNo6Controller = TextEditingController();
  TextEditingController PartName7Controller = TextEditingController();
  TextEditingController PartNo7Controller = TextEditingController();
  TextEditingController PartName8Controller = TextEditingController();
  TextEditingController PartNo8Controller = TextEditingController();
  TextEditingController PartName9Controller = TextEditingController();
  TextEditingController PartNo9Controller = TextEditingController();
  TextEditingController PartName10Controller = TextEditingController();
  TextEditingController PartNo10Controller = TextEditingController();
  TextEditingController AmountOfSampleController = TextEditingController();
  TextEditingController TakePhotoController = TextEditingController();
  TextEditingController StartDateController = TextEditingController();
  TextEditingController Time1Controller = TextEditingController();
  TextEditingController Time2Controller = TextEditingController();
  TextEditingController Time3Controller = TextEditingController();
  TextEditingController Time4Controller = TextEditingController();
  TextEditingController Time5Controller = TextEditingController();
  TextEditingController Time6Controller = TextEditingController();
  TextEditingController Time7Controller = TextEditingController();
  TextEditingController Time8Controller = TextEditingController();
  TextEditingController Time9Controller = TextEditingController();
  TextEditingController Time10Controller = TextEditingController();
  TextEditingController FinishDate1Controller = TextEditingController();
  TextEditingController FinishDate2Controller = TextEditingController();
  TextEditingController FinishDate3Controller = TextEditingController();
  TextEditingController FinishDate4Controller = TextEditingController();
  TextEditingController FinishDate5Controller = TextEditingController();
  TextEditingController FinishDate6Controller = TextEditingController();
  TextEditingController FinishDate7Controller = TextEditingController();
  TextEditingController FinishDate8Controller = TextEditingController();
  TextEditingController FinishDate9Controller = TextEditingController();
  TextEditingController FinishDate10Controller = TextEditingController();
  TextEditingController TempDate1Controller = TextEditingController();
  TextEditingController TempDate2Controller = TextEditingController();
  TextEditingController TempDate3Controller = TextEditingController();
  TextEditingController TempDate4Controller = TextEditingController();
  TextEditingController TempDate5Controller = TextEditingController();
  TextEditingController TempDate6Controller = TextEditingController();
  TextEditingController TempDate7Controller = TextEditingController();
  TextEditingController TempDate8Controller = TextEditingController();
  TextEditingController TempDate9Controller = TextEditingController();
  TextEditingController TempDate10Controller = TextEditingController();
  TextEditingController DueDate1Controller = TextEditingController();
  TextEditingController DueDate2Controller = TextEditingController();
  TextEditingController DueDate3Controller = TextEditingController();
  TextEditingController DueDate4Controller = TextEditingController();
  TextEditingController DueDate5Controller = TextEditingController();
  TextEditingController DueDate6Controller = TextEditingController();
  TextEditingController DueDate7Controller = TextEditingController();
  TextEditingController DueDate8Controller = TextEditingController();
  TextEditingController DueDate9Controller = TextEditingController();
  TextEditingController DueDate10Controller = TextEditingController();
  TextEditingController InstrumentController = TextEditingController();
  TextEditingController MethodController = TextEditingController();
  TextEditingController InchargeController = TextEditingController();
  TextEditingController ApprovedDateController = TextEditingController();
  TextEditingController ApprovedByController = TextEditingController();
  TextEditingController StatusController = TextEditingController();
  // TextEditingController CheckBoxController = TextEditingController(text: selectslot);
  // TextEditingController RemarkController = TextEditingController();

  List<TextEditingController> partNameControllers = [
    PartName1Controller,
    PartName2Controller,
    PartName3Controller,
    PartName4Controller,
    PartName5Controller,
    PartName6Controller,
    PartName7Controller,
    PartName8Controller,
    PartName9Controller,
    PartName10Controller,
  ];
  List<FocusNode> partNameFocusNodes = [
    PartName1FocusNode,
    PartName2FocusNode,
    PartName3FocusNode,
    PartName4FocusNode,
    PartName5FocusNode,
    PartName6FocusNode,
    PartName7FocusNode,
    PartName8FocusNode,
    PartName9FocusNode,
    PartName10FocusNode,
  ];
  List<String> partNameVAR = [
    P03DATATABLEVAR.PARTNAME1,
    P03DATATABLEVAR.PARTNAME2,
    P03DATATABLEVAR.PARTNAME3,
    P03DATATABLEVAR.PARTNAME4,
    P03DATATABLEVAR.PARTNAME5,
    P03DATATABLEVAR.PARTNAME6,
    P03DATATABLEVAR.PARTNAME7,
    P03DATATABLEVAR.PARTNAME8,
    P03DATATABLEVAR.PARTNAME9,
    P03DATATABLEVAR.PARTNAME10,
  ];
  List<TextEditingController> partNoControllers = [
    PartNo1Controller,
    PartNo2Controller,
    PartNo3Controller,
    PartNo4Controller,
    PartNo5Controller,
    PartNo6Controller,
    PartNo7Controller,
    PartNo8Controller,
    PartNo9Controller,
    PartNo10Controller,
  ];
  List<FocusNode> partNoFocusNodes = [
    PartNo1FocusNode,
    PartNo2FocusNode,
    PartNo3FocusNode,
    PartNo4FocusNode,
    PartNo5FocusNode,
    PartNo6FocusNode,
    PartNo7FocusNode,
    PartNo8FocusNode,
    PartNo9FocusNode,
    PartNo10FocusNode,
  ];
  List<String> partNoVAR = [
    P03DATATABLEVAR.PARTNO1,
    P03DATATABLEVAR.PARTNO2,
    P03DATATABLEVAR.PARTNO3,
    P03DATATABLEVAR.PARTNO4,
    P03DATATABLEVAR.PARTNO5,
    P03DATATABLEVAR.PARTNO6,
    P03DATATABLEVAR.PARTNO7,
    P03DATATABLEVAR.PARTNO8,
    P03DATATABLEVAR.PARTNO9,
    P03DATATABLEVAR.PARTNO10,
  ];
  List<TextEditingController> timeControllers = [
    Time1Controller,
    Time2Controller,
    Time3Controller,
    Time4Controller,
    Time5Controller,
    Time6Controller,
    Time7Controller,
    Time8Controller,
    Time9Controller,
    Time10Controller,
  ];
  List<FocusNode> timeFocusNodes = [
    Time1FocusNode,
    Time2FocusNode,
    Time3FocusNode,
    Time4FocusNode,
    Time5FocusNode,
    Time6FocusNode,
    Time7FocusNode,
    Time8FocusNode,
    Time9FocusNode,
    Time10FocusNode,
  ];
  List<TextEditingController> finishDateControllers = [
    FinishDate1Controller,
    FinishDate2Controller,
    FinishDate3Controller,
    FinishDate4Controller,
    FinishDate5Controller,
    FinishDate6Controller,
    FinishDate7Controller,
    FinishDate8Controller,
    FinishDate9Controller,
    FinishDate10Controller,
  ];
  List<FocusNode> finishDateFocusNodes = [
    FinishDate1FocusNode,
    FinishDate2FocusNode,
    FinishDate3FocusNode,
    FinishDate4FocusNode,
    FinishDate5FocusNode,
    FinishDate6FocusNode,
    FinishDate7FocusNode,
    FinishDate8FocusNode,
    FinishDate9FocusNode,
    FinishDate10FocusNode,
  ];
  List<TextEditingController> tempDateControllers = [
    TempDate1Controller,
    TempDate2Controller,
    TempDate3Controller,
    TempDate4Controller,
    TempDate5Controller,
    TempDate6Controller,
    TempDate7Controller,
    TempDate8Controller,
    TempDate9Controller,
    TempDate10Controller,
  ];
  List<FocusNode> tempDateFocusNodes = [
    TempDate1FocusNode,
    TempDate2FocusNode,
    TempDate3FocusNode,
    TempDate4FocusNode,
    TempDate5FocusNode,
    TempDate6FocusNode,
    TempDate7FocusNode,
    TempDate8FocusNode,
    TempDate9FocusNode,
    TempDate10FocusNode,
  ];
  List<TextEditingController> dueDateControllers = [
    DueDate1Controller,
    DueDate2Controller,
    DueDate3Controller,
    DueDate4Controller,
    DueDate5Controller,
    DueDate6Controller,
    DueDate7Controller,
    DueDate8Controller,
    DueDate9Controller,
    DueDate10Controller,
  ];
  List<FocusNode> dueDateFocusNodes = [
    DueDate1FocusNode,
    DueDate2FocusNode,
    DueDate3FocusNode,
    DueDate4FocusNode,
    DueDate5FocusNode,
    DueDate6FocusNode,
    DueDate7FocusNode,
    DueDate8FocusNode,
    DueDate9FocusNode,
    DueDate10FocusNode,
  ];

  int _visiblePartNameCount = 0;
  int _visiblePartNoCount = 0;
  int _visibleTimeCount = 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              width: 400,
              height: 600,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                spacing: 10,
                children: [
                  Text(
                    'เพิ่มงานใหม่',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          buildCustomField(
                            controller: RequestNoController,
                            focusNode: RequestNoFocusNode,
                            labelText: "Request No.",
                            icon: Icons.assignment,
                            onChanged: (value) {
                              P03DATATABLEVAR.REQUESTNO = value;
                            },
                          ),
                          buildCustomField(
                            controller: ReportNoController,
                            focusNode: ReportNoFocusNode,
                            labelText: "Report No.",
                            icon: Icons.assignment,
                            onChanged: (value) {
                              P03DATATABLEVAR.REPORTNO = value;
                            },
                          ),
                          buildCustomField(
                            controller: SectionRequestController,
                            focusNode: SectionRequestFocusNode,
                            labelText: "Section Request",
                            icon: Icons.account_tree,
                            dropdownItems: ['QC HP', 'QC BP', 'MKT ES1'],
                            onChanged: (value) {
                              P03DATATABLEVAR.SECTION = value;
                            },
                          ),
                          buildCustomField(
                            controller: RequesterController,
                            focusNode: RequesterFocusNode,
                            labelText: "Requester",
                            icon: Icons.person,
                            onChanged: (value) {
                              P03DATATABLEVAR.REQUESTER = value;
                            },
                          ),
                          buildCustomField(
                            controller: ReceivedDateController,
                            focusNode: ReceivedDateFocusNode,
                            labelText: "Received Date",
                            icon: Icons.calendar_month_rounded,
                            onChanged: (value) {
                              P03DATATABLEVAR.RECEIVEDDATE = convertStringToDateTime(value).toString();
                            },
                          ),
                          buildCustomField(
                            controller: CustomerNameController,
                            focusNode: CustomerNameFocusNode,
                            labelText: "Customer Name",
                            icon: Icons.people,
                            dropdownItems: P03DATATABLEVAR.dropdownCustomer,
                            onChanged: (value) {
                              P03DATATABLEVAR.CUSTOMERNAME = value;
                            },
                          ),
                          for (int i = 0; i < _visiblePartNameCount + 1 && i < 10; i++)
                            buildCustomField(
                              controller: partNameControllers[i],
                              focusNode: partNameFocusNodes[i],
                              labelText: "Part Name ${i + 1}",
                              icon: Icons.settings,
                              onChanged: (value) {
                                partNameVAR[i] = value;
                                P03DATATABLEVAR.PARTNAME1 = partNameVAR[0];
                                P03DATATABLEVAR.PARTNAME2 = partNameVAR[1];
                                P03DATATABLEVAR.PARTNAME3 = partNameVAR[2];
                                P03DATATABLEVAR.PARTNAME4 = partNameVAR[3];
                                P03DATATABLEVAR.PARTNAME5 = partNameVAR[4];
                                P03DATATABLEVAR.PARTNAME6 = partNameVAR[5];
                                P03DATATABLEVAR.PARTNAME7 = partNameVAR[6];
                                P03DATATABLEVAR.PARTNAME8 = partNameVAR[7];
                                P03DATATABLEVAR.PARTNAME9 = partNameVAR[8];
                                P03DATATABLEVAR.PARTNAME10 = partNameVAR[9];
                              },
                            ),
                          if (_visiblePartNameCount < 9)
                            buildAddPartNameButton(
                              visibleCount: _visiblePartNameCount,
                              onPressed: () {
                                setState(() {
                                  _visiblePartNameCount++;
                                });
                              },
                            ),
                          for (int i = 0; i < _visiblePartNoCount + 1 && i < 10; i++)
                            buildCustomField(
                              controller: partNoControllers[i],
                              focusNode: partNoFocusNodes[i],
                              labelText: "Part No ${i + 1}",
                              icon: Icons.settings,
                              onChanged: (value) {
                                partNoVAR[i] = value;
                                P03DATATABLEVAR.PARTNO1 = partNoVAR[0];
                                P03DATATABLEVAR.PARTNO2 = partNoVAR[1];
                                P03DATATABLEVAR.PARTNO3 = partNoVAR[2];
                                P03DATATABLEVAR.PARTNO4 = partNoVAR[3];
                                P03DATATABLEVAR.PARTNO5 = partNoVAR[4];
                                P03DATATABLEVAR.PARTNO6 = partNoVAR[5];
                                P03DATATABLEVAR.PARTNO7 = partNoVAR[6];
                                P03DATATABLEVAR.PARTNO8 = partNoVAR[7];
                                P03DATATABLEVAR.PARTNO9 = partNoVAR[8];
                                P03DATATABLEVAR.PARTNO10 = partNoVAR[9];
                              },
                            ),
                          if (_visiblePartNoCount < 9)
                            buildAddPartNameButton(
                              visibleCount: _visiblePartNoCount,
                              onPressed: () {
                                setState(() {
                                  _visiblePartNoCount++;
                                });
                              },
                            ),
                          buildCustomField(
                            controller: AmountOfSampleController,
                            focusNode: AmountOfSampleFocusNode,
                            labelText: "Amount of Sample (Pcs)",
                            icon: Icons.science,
                            onChanged: (value) {
                              P03DATATABLEVAR.AMOUNTSAMPLE = int.parse(value);
                            },
                          ),
                          buildCustomField(
                            controller: TakePhotoController,
                            focusNode: TakePhotoFocusNode,
                            labelText: "Take photo (Pcs)",
                            icon: Icons.photo_camera,
                            onChanged: (value) {
                              P03DATATABLEVAR.TAKEPHOTO = int.parse(value);
                            },
                          ),
                          buildCustomField(
                            controller: StartDateController,
                            focusNode: StartDateFocusNode,
                            labelText: "Start Date",
                            icon: Icons.calendar_month_rounded,
                            onChanged: (value) async {
                              P03DATATABLEVAR.STARTDATE = convertStringToDateTime(value).toString();
                              for (int i = 0; i < 10; i++) {
                                calculateFinishDate(
                                  startDateController: StartDateController,
                                  timeController: timeControllers[i],
                                  finishDateController: finishDateControllers[i],
                                );
                                DateTime? FinishDateToDateTime =
                                    convertStringToDateTime(finishDateControllers[i].text);
                                if (FinishDateToDateTime != '' && FinishDateToDateTime != null) {
                                  String CalTemp = await calculateRepDue(
                                    startDate: DateTime(FinishDateToDateTime.year, FinishDateToDateTime.month,
                                        FinishDateToDateTime.day),
                                    addDays: P03DATATABLEVAR.TempAddDays,
                                  );
                                  tempDateControllers[i].text = CalTemp;
                                  String CalDue = await calculateRepDue(
                                    startDate: DateTime(FinishDateToDateTime.year, FinishDateToDateTime.month,
                                        FinishDateToDateTime.day),
                                    addDays: P03DATATABLEVAR.DueAddDays,
                                  );
                                  dueDateControllers[i].text = CalDue;
                                }
                              }
                              P03DATATABLEVAR.FINISHDATE1 =
                                  convertStringToDateTime(finishDateControllers[0].text).toString();
                              P03DATATABLEVAR.FINISHDATE2 =
                                  convertStringToDateTime(finishDateControllers[1].text).toString();

                              P03DATATABLEVAR.FINISHDATE3 =
                                  convertStringToDateTime(finishDateControllers[2].text).toString();
                              P03DATATABLEVAR.FINISHDATE4 =
                                  convertStringToDateTime(finishDateControllers[3].text).toString();
                              P03DATATABLEVAR.FINISHDATE5 =
                                  convertStringToDateTime(finishDateControllers[4].text).toString();
                              P03DATATABLEVAR.FINISHDATE6 =
                                  convertStringToDateTime(finishDateControllers[5].text).toString();
                              P03DATATABLEVAR.FINISHDATE7 =
                                  convertStringToDateTime(finishDateControllers[6].text).toString();
                              P03DATATABLEVAR.FINISHDATE8 =
                                  convertStringToDateTime(finishDateControllers[7].text).toString();
                              P03DATATABLEVAR.FINISHDATE9 =
                                  convertStringToDateTime(finishDateControllers[8].text).toString();
                              P03DATATABLEVAR.FINISHDATE10 =
                                  convertStringToDateTime(finishDateControllers[9].text).toString();
                              P03DATATABLEVAR.TEMPDATE1 =
                                  convertStringToDateTime(tempDateControllers[0].text).toString();
                              P03DATATABLEVAR.TEMPDATE2 =
                                  convertStringToDateTime(tempDateControllers[1].text).toString();
                              P03DATATABLEVAR.TEMPDATE3 =
                                  convertStringToDateTime(tempDateControllers[2].text).toString();
                              P03DATATABLEVAR.TEMPDATE4 =
                                  convertStringToDateTime(tempDateControllers[3].text).toString();
                              P03DATATABLEVAR.TEMPDATE5 =
                                  convertStringToDateTime(tempDateControllers[4].text).toString();
                              P03DATATABLEVAR.TEMPDATE6 =
                                  convertStringToDateTime(tempDateControllers[5].text).toString();
                              P03DATATABLEVAR.TEMPDATE7 =
                                  convertStringToDateTime(tempDateControllers[6].text).toString();
                              P03DATATABLEVAR.TEMPDATE8 =
                                  convertStringToDateTime(tempDateControllers[7].text).toString();
                              P03DATATABLEVAR.TEMPDATE9 =
                                  convertStringToDateTime(tempDateControllers[8].text).toString();
                              P03DATATABLEVAR.TEMPDATE10 =
                                  convertStringToDateTime(tempDateControllers[9].text).toString();
                              P03DATATABLEVAR.DUEDATE1 =
                                  convertStringToDateTime(dueDateControllers[0].text).toString();
                              P03DATATABLEVAR.DUEDATE2 =
                                  convertStringToDateTime(dueDateControllers[1].text).toString();
                              P03DATATABLEVAR.DUEDATE3 =
                                  convertStringToDateTime(dueDateControllers[2].text).toString();
                              P03DATATABLEVAR.DUEDATE4 =
                                  convertStringToDateTime(dueDateControllers[3].text).toString();
                              P03DATATABLEVAR.DUEDATE5 =
                                  convertStringToDateTime(dueDateControllers[4].text).toString();
                              P03DATATABLEVAR.DUEDATE6 =
                                  convertStringToDateTime(dueDateControllers[5].text).toString();
                              P03DATATABLEVAR.DUEDATE7 =
                                  convertStringToDateTime(dueDateControllers[6].text).toString();
                              P03DATATABLEVAR.DUEDATE8 =
                                  convertStringToDateTime(dueDateControllers[7].text).toString();
                              P03DATATABLEVAR.DUEDATE9 =
                                  convertStringToDateTime(dueDateControllers[8].text).toString();
                              P03DATATABLEVAR.DUEDATE10 =
                                  convertStringToDateTime(dueDateControllers[9].text).toString();
                              setState(() {});
                            },
                          ),
                          if (StartDateController.text != '') ...[
                            for (int i = 0; i < _visibleTimeCount + 1 && i < 10; i++)
                              Column(
                                spacing: 10,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildCustomField(
                                          controller: timeControllers[i],
                                          focusNode: timeFocusNodes[i],
                                          labelText: "Time ${i + 1} (Hrs.)",
                                          icon: Icons.timer_sharp,
                                          onChanged: (value) async {
                                            EditTextController(
                                              controller: timeControllers[i],
                                              value: value,
                                            );
                                            P03DATATABLEVAR.TIME1 =
                                                int.tryParse(timeControllers[0].text) ?? 0;
                                            P03DATATABLEVAR.TIME2 =
                                                int.tryParse(timeControllers[1].text) ?? 0;
                                            P03DATATABLEVAR.TIME3 =
                                                int.tryParse(timeControllers[2].text) ?? 0;
                                            P03DATATABLEVAR.TIME4 =
                                                int.tryParse(timeControllers[3].text) ?? 0;
                                            P03DATATABLEVAR.TIME5 =
                                                int.tryParse(timeControllers[4].text) ?? 0;
                                            P03DATATABLEVAR.TIME6 =
                                                int.tryParse(timeControllers[5].text) ?? 0;
                                            P03DATATABLEVAR.TIME7 =
                                                int.tryParse(timeControllers[6].text) ?? 0;
                                            P03DATATABLEVAR.TIME8 =
                                                int.tryParse(timeControllers[7].text) ?? 0;
                                            P03DATATABLEVAR.TIME9 =
                                                int.tryParse(timeControllers[8].text) ?? 0;
                                            P03DATATABLEVAR.TIME10 =
                                                int.tryParse(timeControllers[9].text) ?? 0;
                                            calculateFinishDate(
                                              startDateController: StartDateController,
                                              timeController: timeControllers[i],
                                              finishDateController: finishDateControllers[i],
                                            );
                                            P03DATATABLEVAR.FINISHDATE1 =
                                                convertStringToDateTime(finishDateControllers[0].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE2 =
                                                convertStringToDateTime(finishDateControllers[1].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE3 =
                                                convertStringToDateTime(finishDateControllers[2].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE4 =
                                                convertStringToDateTime(finishDateControllers[3].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE5 =
                                                convertStringToDateTime(finishDateControllers[4].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE6 =
                                                convertStringToDateTime(finishDateControllers[5].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE7 =
                                                convertStringToDateTime(finishDateControllers[6].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE8 =
                                                convertStringToDateTime(finishDateControllers[7].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE9 =
                                                convertStringToDateTime(finishDateControllers[8].text)
                                                    .toString();
                                            P03DATATABLEVAR.FINISHDATE10 =
                                                convertStringToDateTime(finishDateControllers[9].text)
                                                    .toString();
                                            await calculateAndSetTempDate(
                                              finishDateController: finishDateControllers[i],
                                              DateController: tempDateControllers[i],
                                              addDays: P03DATATABLEVAR.TempAddDays,
                                            );
                                            P03DATATABLEVAR.TEMPDATE1 =
                                                convertStringToDateTime(tempDateControllers[0].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE2 =
                                                convertStringToDateTime(tempDateControllers[1].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE3 =
                                                convertStringToDateTime(tempDateControllers[2].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE4 =
                                                convertStringToDateTime(tempDateControllers[3].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE5 =
                                                convertStringToDateTime(tempDateControllers[4].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE6 =
                                                convertStringToDateTime(tempDateControllers[5].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE7 =
                                                convertStringToDateTime(tempDateControllers[6].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE8 =
                                                convertStringToDateTime(tempDateControllers[7].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE9 =
                                                convertStringToDateTime(tempDateControllers[8].text)
                                                    .toString();
                                            P03DATATABLEVAR.TEMPDATE10 =
                                                convertStringToDateTime(tempDateControllers[9].text)
                                                    .toString();
                                            await calculateAndSetTempDate(
                                              finishDateController: finishDateControllers[i],
                                              DateController: dueDateControllers[i],
                                              addDays: P03DATATABLEVAR.DueAddDays,
                                            );
                                            P03DATATABLEVAR.DUEDATE1 =
                                                convertStringToDateTime(dueDateControllers[0].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE2 =
                                                convertStringToDateTime(dueDateControllers[1].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE3 =
                                                convertStringToDateTime(dueDateControllers[2].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE4 =
                                                convertStringToDateTime(dueDateControllers[3].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE5 =
                                                convertStringToDateTime(dueDateControllers[4].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE6 =
                                                convertStringToDateTime(dueDateControllers[5].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE7 =
                                                convertStringToDateTime(dueDateControllers[6].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE8 =
                                                convertStringToDateTime(dueDateControllers[7].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE9 =
                                                convertStringToDateTime(dueDateControllers[8].text)
                                                    .toString();
                                            P03DATATABLEVAR.DUEDATE10 =
                                                convertStringToDateTime(dueDateControllers[9].text)
                                                    .toString();
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: buildCustomField(
                                          controller: finishDateControllers[i],
                                          focusNode: finishDateFocusNodes[i],
                                          labelText: "Finish Date ${i + 1}",
                                          icon: Icons.calendar_month_rounded,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildCustomField(
                                          controller: tempDateControllers[i],
                                          focusNode: tempDateFocusNodes[i],
                                          labelText: "Temp Date ${i + 1}",
                                          icon: Icons.calendar_month_rounded,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: buildCustomField(
                                          controller: dueDateControllers[i],
                                          focusNode: dueDateFocusNodes[i],
                                          labelText: "Due Date ${i + 1}",
                                          icon: Icons.calendar_month_rounded,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (_visibleTimeCount < 9)
                              buildAddPartNameButton(
                                visibleCount: _visibleTimeCount,
                                onPressed: () {
                                  setState(() {
                                    _visibleTimeCount++;
                                  });
                                },
                              ),
                          ],
                          buildCustomField(
                            controller: InstrumentController,
                            focusNode: InstrumentFocusNode,
                            labelText: "Instrument",
                            icon: Icons.analytics_outlined,
                            dropdownItems: ['SST No.1', 'SST No.2', 'SST No.3', 'SST No.4'],
                            onChanged: (value) {
                              P03DATATABLEVAR.INSTRUMENT = value;
                              setState(() {});
                            },
                          ),
                          buildCustomField(
                            controller: MethodController,
                            focusNode: MethodFocusNode,
                            labelText: "Method",
                            icon: Icons.precision_manufacturing,
                            dropdownItems: ['ASTM-B117', 'ISO-9227', 'Other'],
                            onChanged: (value) {
                              P03DATATABLEVAR.METHOD = value;
                            },
                          ),
                          buildCustomField(
                            controller: InchargeController,
                            focusNode: InchargeFocusNode,
                            labelText: "Incharge",
                            icon: Icons.person,
                            dropdownItems: P03DATATABLEVAR.dropdownIncharge,
                            onChanged: (value) {
                              P03DATATABLEVAR.INCHARGE = value;
                            },
                          ),
                          buildCustomField(
                            controller: ApprovedDateController,
                            focusNode: ApprovedDateFocusNode,
                            labelText: "Approved Date",
                            icon: Icons.calendar_month_rounded,
                            onChanged: (value) {
                              P03DATATABLEVAR.APPROVEDDATE = convertStringToDateTime(value).toString();
                            },
                          ),
                          buildCustomField(
                            controller: ApprovedByController,
                            focusNode: ApprovedByFocusNode,
                            labelText: "Approved By",
                            icon: Icons.assignment,
                            dropdownItems: P03DATATABLEVAR.dropdownApprover,
                            onChanged: (value) {
                              P03DATATABLEVAR.APPROVEDBY = value;
                            },
                          ),
                          if (InstrumentController.text != '')
                            buildCustomField(
                              controller: StatusController,
                              focusNode: StatusFocusNode,
                              labelText: "Status",
                              icon: Icons.info,
                              dropdownItems: ['RECEIVED', 'RESERVED'],
                              onChanged: (value) {
                                P03DATATABLEVAR.STATUS = value;
                                selectpage = 'Salt Spray Tester : ${P03DATATABLEVAR.INSTRUMENT}';
                                selectstatus = value;
                                showChooseSlot(context);
                                setState(() {});
                                // print(selectpage);
                                // print(selectstatus);
                              },
                            ),
                          if (StatusController.text != '')
                            buildCustomFieldforEditData(
                              controller: selectslot,
                              focusNode: CheckBoxFocusNode,
                              labelText: "Select Slot",
                              icon: Icons.add_box_rounded,
                              onChanged: (value) {
                                P03DATATABLEVAR.CHECKBOX = value;
                              },
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                await showAddConfirmationDialog(
                                  context: context,
                                  onConfirm: () async {
                                    P03DATATABLEVAR.SendAddDataToAPI = jsonEncode(toJsonAddDate());
                                    // print(P03DATATABLEVAR.SendAddDataToAPI);
                                    AddDataToAPI();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.green,
                                shadowColor: Colors.greenAccent,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.green, width: 2),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: const [
                                  Text(
                                    'ยืนยันการเพิ่มงาน',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.note_add_rounded,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget buildCustomField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String labelText,
  required IconData icon,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  List<String>? dropdownItems,
}) {
  // ถ้าเป็น Section Request ให้แสดง Dropdown
  if ((labelText == "Section Request" ||
          labelText == "Customer Name" ||
          labelText == "Instrument" ||
          labelText == "Method" ||
          labelText == "Incharge" ||
          labelText == "Approved By" ||
          labelText == "Status") &&
      dropdownItems != null) {
    return DropdownSearch<String>(
      items: dropdownItems,
      selectedItem: controller.text.isNotEmpty ? controller.text : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          labelText: labelText,
          labelStyle: buildTextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        fit: FlexFit.loose,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14),
        );
      },
      onChanged: (value) {
        if (value != null) {
          controller.text = value;
          if (onChanged != null) onChanged(value);
        }
      },
    );
  }

  if (labelText == "Received Date" || labelText == "Approved Date") {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: P03DATATABLEMAINcontext,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            String formattedDate =
                "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year.toString().substring(2)}";
            controller.text = formattedDate;
            onChanged?.call(formattedDate);
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blue),
              labelText: labelText,
              labelStyle: buildTextStyle(),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }

  if (labelText == "Start Date") {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: P03DATATABLEMAINcontext,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: P03DATATABLEMAINcontext,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
            );

            if (pickedTime != null) {
              final DateTime fullDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );

              String formattedDateTime = "${fullDateTime.day.toString().padLeft(2, '0')}-"
                  "${fullDateTime.month.toString().padLeft(2, '0')}-"
                  "${fullDateTime.year.toString().substring(2)} "
                  "${fullDateTime.hour.toString().padLeft(2, '0')}:"
                  "${fullDateTime.minute.toString().padLeft(2, '0')}";

              controller.text = formattedDateTime;
              onChanged?.call(formattedDateTime);
            }
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blue),
              labelText: labelText,
              labelStyle: buildTextStyle(),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }

  if (labelText == "Finish Date 1" ||
      labelText == "Finish Date 2" ||
      labelText == "Finish Date 3" ||
      labelText == "Finish Date 4" ||
      labelText == "Finish Date 5" ||
      labelText == "Finish Date 6" ||
      labelText == "Finish Date 7" ||
      labelText == "Finish Date 8" ||
      labelText == "Finish Date 9" ||
      labelText == "Finish Date 10" ||
      labelText == "Temp Date 1" ||
      labelText == "Temp Date 2" ||
      labelText == "Temp Date 3" ||
      labelText == "Temp Date 4" ||
      labelText == "Temp Date 5" ||
      labelText == "Temp Date 6" ||
      labelText == "Temp Date 7" ||
      labelText == "Temp Date 8" ||
      labelText == "Temp Date 9" ||
      labelText == "Temp Date 10" ||
      labelText == "Due Date 1" ||
      labelText == "Due Date 2" ||
      labelText == "Due Date 3" ||
      labelText == "Due Date 4" ||
      labelText == "Due Date 5" ||
      labelText == "Due Date 6" ||
      labelText == "Due Date 7" ||
      labelText == "Due Date 8" ||
      labelText == "Due Date 9" ||
      labelText == "Due Date 10") {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: labelText,
        labelStyle: buildTextStyleGrey(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.grey[300],
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: const TextStyle(color: Colors.black54),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
  if (labelText == "Time 1 (Hrs.)" ||
      labelText == "Time 2 (Hrs.)" ||
      labelText == "Time 3 (Hrs.)" ||
      labelText == "Time 4 (Hrs.)" ||
      labelText == "Time 5 (Hrs.)" ||
      labelText == "Time 6 (Hrs.)" ||
      labelText == "Time 7 (Hrs.)" ||
      labelText == "Time 8 (Hrs.)" ||
      labelText == "Time 9 (Hrs.)" ||
      labelText == "Time 10 (Hrs.)" ||
      labelText == "Amount of Sample (Pcs)" ||
      labelText == "Take photo (Pcs)") {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number, // แสดงคีย์บอร์ดตัวเลข
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // รับเฉพาะตัวเลขเท่านั้น
      ],
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: labelText,
        labelStyle: buildTextStyle(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  return TextField(
    controller: controller,
    focusNode: focusNode,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blue),
      labelText: labelText,
      labelStyle: buildTextStyle(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    onChanged: onChanged,
    onSubmitted: onSubmitted,
  );
}

Widget buildCustomFieldforEditData({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String labelText,
  required IconData icon,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  List<String>? dropdownItems,
}) {
  if ((labelText == "Status") && dropdownItems != null) {
    return DropdownSearch<String>(
      items: dropdownItems,
      enabled: false,
      selectedItem: controller.text.isNotEmpty ? controller.text : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          labelText: labelText,
          labelStyle: buildTextStyleGrey(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.grey[300],
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        fit: FlexFit.loose,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14),
        );
      },
      onChanged: (value) {
        if (value != null) {
          controller.text = value;
          if (onChanged != null) onChanged(value);
        }
      },
    );
  }

  return TextField(
    controller: controller,
    focusNode: focusNode,
    readOnly: true,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.grey),
      labelText: labelText,
      labelStyle: buildTextStyleGrey(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      filled: true,
      fillColor: Colors.grey[300],
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    style: const TextStyle(color: Colors.black54),
    onChanged: onChanged,
    onSubmitted: onSubmitted,
  );
}

void calculateFinishDate({
  required TextEditingController startDateController,
  required TextEditingController timeController,
  required TextEditingController finishDateController,
}) {
  try {
    // print(timeController);
    // print(timeController.text);
    if (timeController.text == '') {
      finishDateController.text = "";
      return;
    }
    DateTime startDate = convertStringToDateTime(startDateController.text)!;
    int addedHours = int.parse(timeController.text);

    DateTime finishDate = startDate.add(Duration(hours: addedHours));
    finishDateController.text = formatDate(finishDate.toString());
    if (finishDateController.text == startDateController.text || addedHours == 0 || addedHours == '') {
      finishDateController.text = "";
    }
  } catch (e) {
    debugPrint("Error in calculateFinishDate: $e");
    finishDateController.text = "";
  }
}

TextStyle buildTextStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

TextStyle buildTextStyleGrey() {
  return TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

void EditTextController({
  required TextEditingController controller,
  required String value,
}) {
  final oldValue = controller.value;
  controller.value = TextEditingValue(
    text: value,
    selection: oldValue.selection,
  );
}

Future<void> fetchCustomerAndIncharge() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final responseCustomer = await Dio().post(
      "$ToServer/02SALTSPRAY/SearchCustomer",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
        },
      ),
    );

    if (responseCustomer.statusCode == 200 && responseCustomer.data is List) {
      List data = responseCustomer.data;
      P03DATATABLEVAR.dropdownCustomer =
          data.map((item) => item['Customer_Name'].toString()).where((name) => name.isNotEmpty).toList();
    } else {
      print("SearchCustomer failed");
      showErrorPopup(P03DATATABLEMAINcontext, responseCustomer.toString());
      Navigator.pop(P03DATATABLEMAINcontext);
    }

    final responseIncharge = await Dio().post(
      "$ToServer/02SALTSPRAY/SearchIncharge",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
        },
      ),
    );

    if (responseIncharge.statusCode == 200 && responseIncharge.data is List) {
      List data = responseIncharge.data;
      P03DATATABLEVAR.dropdownIncharge = data
          .where((item) => item['Permission'] == 1)
          .map((item) => item['Incharge'].toString())
          .where((name) => name.isNotEmpty)
          .toList();
      P03DATATABLEVAR.dropdownApprover = data
          .where((item) => item['Permission'] == 2)
          .map((item) => item['Incharge'].toString())
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      print("SearchIncharge failed");
      showErrorPopup(P03DATATABLEMAINcontext, responseCustomer.toString());
    }

    final responseHolidays = await Dio().post(
      "$ToServer/02SALTSPRAY/Holidays",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
        },
      ),
    );

    if (responseHolidays.statusCode == 200 && responseHolidays.data is List) {
      List data = responseHolidays.data;
      P03DATATABLEVAR.holidays =
          data.map((item) => item['HolidayDate'].toString()).where((name) => name.isNotEmpty).toList();
      // print(P03DATATABLEVAR.holidays);
    } else {
      print("SearchCustomer failed");
      showErrorPopup(P03DATATABLEMAINcontext, responseHolidays.toString());
      Navigator.pop(P03DATATABLEMAINcontext);
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P03DATATABLEMAINcontext, e.toString());
  } finally {
    Navigator.pop(P03DATATABLEMAINcontext);
  }
}

Future<void> EditDataToAPI() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/EditData",
      data: {
        'dataRow': P03DATATABLEVAR.SendEditDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
        },
      ),
    );

    if (response.statusCode == 200) {
      P03DATATABLEMAINcontext.read<P03DATATABLEGETDATA_Bloc>().add(P03DATATABLEGETDATA_GET());
      // Navigator.pop(P03DATATABLEMAINcontext);
      Navigator.pop(P03DATATABLEMAINcontext);
    } else {
      Navigator.pop(P03DATATABLEMAINcontext);
      showErrorPopup(P03DATATABLEMAINcontext, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P03DATATABLEMAINcontext, e.toString());
  } finally {
    Navigator.pop(P03DATATABLEMAINcontext);
  }
}

Future<void> AddDataToAPI() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/AddData",
      data: {
        'dataRow': P03DATATABLEVAR.SendAddDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
        },
      ),
    );

    if (response.statusCode == 200) {
      P03DATATABLEMAINcontext.read<P03DATATABLEGETDATA_Bloc>().add(P03DATATABLEGETDATA_GET());
      // Navigator.pop(P03DATATABLEMAINcontext);
      Navigator.pop(P03DATATABLEMAINcontext);
    } else {
      Navigator.pop(P03DATATABLEMAINcontext);
      showErrorPopup(P03DATATABLEMAINcontext, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P03DATATABLEMAINcontext, e.toString());
  } finally {
    Navigator.pop(P03DATATABLEMAINcontext);
  }
}

Future<void> showEditConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: const [
            Icon(Icons.edit_note_rounded, color: Colors.amber),
            SizedBox(width: 8),
            Text('ยืนยันการแก้ไข?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะแก้ไขข้อมูลหรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ยกเลิก', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

Future<void> showCancelConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: const [
            Icon(Icons.cancel, color: Colors.red),
            SizedBox(width: 8),
            Text('ยืนยันการยกเลิกงาน?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะยกเลิกงานนี้หรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ยกเลิก', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

Future<void> showAddConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: const [
            Icon(Icons.note_add_rounded, color: Colors.green),
            SizedBox(width: 8),
            Text('ยืนยันการเพิ่มงาน?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะเพิ่มงานนี้หรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ยกเลิก', style: TextStyle(color: Colors.green)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

void updateMultipleDates(Map<TextEditingController, void Function(String)> updates) {
  updates.forEach((controller, setValue) {
    DateTime? date = convertStringToDateTime(controller.text);
    if (date != null) {
      setValue(date.toString());
    } else {
      print("Invalid date: ${controller.text}");
    }
  });
}

Future<String> calculateRepDue({
  required DateTime? startDate,
  required int addDays,
}) async {
  if (startDate == null) return '';
  List<String> holidays = P03DATATABLEVAR.holidays;
  // เริ่มต้นวันที่ใหม่โดยเซ็ตเวลาเป็น 00:00:00
  DateTime currentDate = DateTime(startDate.year, startDate.month, startDate.day);
  int addedDays = 0;
  // print('currentDate $currentDate');
  // แปลง holidays ให้เป็น Set ของ yyyy-MM-dd
  final Set<String> holidaySet =
      holidays.map((h) => DateFormat('yyyy-MM-dd').format(DateTime.parse(h))).toSet();
  // print('holidaySet $holidaySet');
  while (addedDays < addDays) {
    final currentDateStr = DateFormat('yyyy-MM-dd').format(currentDate);
    // print('currentDateStr $currentDateStr');
    if (!holidaySet.contains(currentDateStr)) {
      addedDays++;
    }

    if (addedDays < addDays) {
      currentDate = currentDate.add(Duration(days: 1));
    }
  }

  // ข้ามวันหยุดถ้าวันที่ได้ตรงกับวันหยุด
  while (holidaySet.contains(DateFormat('yyyy-MM-dd').format(currentDate))) {
    currentDate = currentDate.add(Duration(days: 1));
  }

  return DateFormat('dd-MM-yy').format(currentDate);
}

Future<void> calculateAndSetTempDate({
  required TextEditingController finishDateController,
  required TextEditingController DateController,
  required int addDays,
}) async {
  if (finishDateController.text == '') {
    DateController.text = "";
    return;
  }
  DateTime? finishDate = convertStringToDateTime(finishDateController.text);

  if (finishDate != null) {
    String result = await calculateRepDue(
      startDate: DateTime(finishDate.year, finishDate.month, finishDate.day),
      addDays: addDays,
    );

    DateController.text = result;
  }
}

Widget buildAddPartNameButton({
  required int visibleCount,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: visibleCount < 9 ? onPressed : null,
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(10),
    ),
    child: const Icon(
      Icons.add,
      color: Colors.blue,
      size: 30,
    ),
  );
}

void showChooseSlot(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 800,
          width: 1700,
          color: Colors.white,
          child: Page2(),
        ),
      );
    },
  );
}
