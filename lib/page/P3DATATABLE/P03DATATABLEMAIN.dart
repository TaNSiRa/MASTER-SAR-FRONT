// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, use_build_context_synchronously, deprecated_member_use, avoid_print, unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../bloc/BlocEvent/03-01-P03DATATABLEGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputTextTan.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/ForUseAllPage.dart';
import 'P03DATATABLEVAR.dart';

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
    selectpage = '';
    selectstatus = '';
    selectslot.text = '';
    PageName = 'SALY SPRAY STATUS';
  }

  @override
  Widget build(BuildContext context) {
    P03DATATABLEMAINcontext = context;
    List<P03DATATABLEGETDATAclass> _datain = widget.data ?? [];

    // print(PageName);
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
            data.PARTNO10.toLowerCase().contains(P03DATATABLEVAR.SEARCH) ||
            data.INSTRUMENT.toLowerCase().contains(P03DATATABLEVAR.SEARCH),
      ),
    );

    List<P03DATATABLEGETDATAclass> filteredData = _datasearch.where((data) {
      if (P03DATATABLEVAR.DropdownInstrument == 'All Instrument' ||
          P03DATATABLEVAR.DropdownInstrument == '') {
        return true;
      } else {
        return data.INSTRUMENT == P03DATATABLEVAR.DropdownInstrument;
      }
    }).toList();

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
                            ),
                          ],
                        ),
                      ),
                      AdvanceDropDown(
                        hint: "Instrument",
                        height: 40,
                        width: 105,
                        listdropdown: const [
                          MapEntry("All Instrument", "All Instrument"),
                          MapEntry("SST No.1", "SST No.1"),
                          MapEntry("SST No.2", "SST No.2"),
                          MapEntry("SST No.3", "SST No.3"),
                          MapEntry("SST No.4", "SST No.4"),
                        ],
                        onChangeinside: (d, k) {
                          setState(() {
                            P03DATATABLEVAR.DropdownInstrument = d;
                          });
                        },
                        value: P03DATATABLEVAR.DropdownInstrument,
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  P03DATATABLEVAR.CustomerIsPM = false;
                                });
                                await _fetchCustomerAndIncharge();
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
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                exportToExcel(filteredData);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Icon(
                                Icons.download,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Export Excel',
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
                                23: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth23),
                                24: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth24),
                                25: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth25),
                                26: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth26),
                                27: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth27),
                                28: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth28),
                                29: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth29),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(child: buildHeaderCell('Type (SP/SV)')),
                                    TableCell(child: buildHeaderCell('Request No.')),
                                    TableCell(child: buildHeaderCell('Report No.')),
                                    TableCell(child: buildHeaderCell('Stop')),
                                    TableCell(child: buildHeaderCell('Bar Status')),
                                    TableCell(child: buildHeaderCell('Section Request')),
                                    TableCell(child: buildHeaderCell('Requester')),
                                    TableCell(child: buildHeaderCell('Sampling Date\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Received Date\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Customer Name')),
                                    TableCell(child: buildHeaderCell('Part Name')),
                                    TableCell(child: buildHeaderCell('Part No.')),
                                    TableCell(child: buildHeaderCell('Lot No.')),
                                    TableCell(child: buildHeaderCell('Amount')),
                                    TableCell(child: buildHeaderCell('Material')),
                                    TableCell(child: buildHeaderCell('Process')),
                                    // TableCell(child: buildHeaderCell('Amount of\nsample\n(Pcs)')),
                                    TableCell(child: buildHeaderCell('Take\nphoto\n(Pcs)')),
                                    TableCell(
                                        child: buildHeaderCell('Start Date\n(วันที่นำงานเข้า)\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Time (Hrs.)')),
                                    TableCell(
                                        child: buildHeaderCell('Finish Date\n(วันเอางานออก)\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Temp Report\n(dd-MM-yy)')),
                                    TableCell(child: buildHeaderCell('Due Report\n(dd-MM-yy)')),
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
                                    23: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth23),
                                    24: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth24),
                                    25: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth25),
                                    26: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth26),
                                    27: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth27),
                                    28: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth28),
                                    29: FixedColumnWidth(P03DATATABLEVAR.FixedColumnWidth29),
                                  },
                                  children: filteredData.map((item) {
                                    return TableRow(
                                      children: [
                                        TableCell(
                                            child: buildDataCell(item.TYPE, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.REQUESTNO, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.REPORTNO, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Stop', countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell('Bar Status', countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.SECTION, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.REQUESTER, countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell(
                                                item.SAMPLINGDATE, countRowMultiplier(item), item)),
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
                                            child: buildDataCell('Lot No', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Amount', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Material', countRowMultiplier(item), item)),
                                        TableCell(
                                            child: buildDataCell('Process', countRowMultiplier(item), item)),
                                        // TableCell(
                                        //     child: buildDataCell(
                                        //         '${item.AMOUNTSAMPLE}', countRowMultiplier(item), item)),
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
                                            child: buildDataCell(
                                                item.TEMPDATE0, countRowMultiplier(item), item)),
                                        TableCell(
                                            child:
                                                buildDataCell(item.DUEDATE0, countRowMultiplier(item), item)),
                                        // TableCell(
                                        //     child:
                                        //         buildDataCell('Temp Report', countRowMultiplier(item), item)),
                                        // TableCell(
                                        //     child:
                                        //         buildDataCell('Due Report', countRowMultiplier(item), item)),
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
  } else if (data == 'Lot No') {
    fieldValues = [
      item.LOTNO1,
      item.LOTNO2,
      item.LOTNO3,
      item.LOTNO4,
      item.LOTNO5,
      item.LOTNO6,
      item.LOTNO7,
      item.LOTNO8,
      item.LOTNO9,
      item.LOTNO10,
    ];
  } else if (data == 'Amount') {
    fieldValues = [
      item.AMOUNT1,
      item.AMOUNT2,
      item.AMOUNT3,
      item.AMOUNT4,
      item.AMOUNT5,
      item.AMOUNT6,
      item.AMOUNT7,
      item.AMOUNT8,
      item.AMOUNT9,
      item.AMOUNT10,
    ];
  } else if (data == 'Material') {
    fieldValues = [
      item.MATERIAL1,
      item.MATERIAL2,
      item.MATERIAL3,
      item.MATERIAL4,
      item.MATERIAL5,
      item.MATERIAL6,
      item.MATERIAL7,
      item.MATERIAL8,
      item.MATERIAL9,
      item.MATERIAL10,
    ];
  } else if (data == 'Process') {
    fieldValues = [
      item.PROCESS1,
      item.PROCESS2,
      item.PROCESS3,
      item.PROCESS4,
      item.PROCESS5,
      item.PROCESS6,
      item.PROCESS7,
      item.PROCESS8,
      item.PROCESS9,
      item.PROCESS10,
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
  }
  // else if (data == 'Temp Report') {
  //   fieldValues = [
  //     item.TEMPDATE1,
  //     item.TEMPDATE2,
  //     item.TEMPDATE3,
  //     item.TEMPDATE4,
  //     item.TEMPDATE5,
  //     item.TEMPDATE6,
  //     item.TEMPDATE7,
  //     item.TEMPDATE8,
  //     item.TEMPDATE9,
  //     item.TEMPDATE10,
  //   ];
  // } else if (data == 'Due Report') {
  //   fieldValues = [
  //     item.DUEDATE1,
  //     item.DUEDATE2,
  //     item.DUEDATE3,
  //     item.DUEDATE4,
  //     item.DUEDATE5,
  //     item.DUEDATE6,
  //     item.DUEDATE7,
  //     item.DUEDATE8,
  //     item.DUEDATE9,
  //     item.DUEDATE10,
  //   ];
  // }

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
            await _fetchCustomerAndIncharge();
            P03DATATABLEMAINcontext.read<P03DATATABLEGETDATA_Bloc>().add(P03DATATABLEGETDATA_GET());
            showEditDialog(P03DATATABLEMAINcontext, item);
          },
        ),
      ),
    );
  }

  if (data == 'Stop') {
    final dateFormat = DateFormat('dd-MM-yy HH:mm');

    List<DateTime> finishDates = [
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
    ]
        .where((v) => v != null && v.toString().trim().isNotEmpty)
        .map((v) {
          try {
            return dateFormat.parse(v.toString());
          } catch (e) {
            return null;
          }
        })
        .where((v) => v != null)
        .cast<DateTime>()
        .toList();

    int total = finishDates.length;
    int passed = finishDates.where((d) => DateTime.now().isAfter(d)).length;
    // print(DateTime.now());

    return SizedBox(
      height: 30.0 * maxRowCount,
      child: Center(
        child: Text(
          '$passed / $total',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  if (data == 'Bar Status') {
    final dateFormat = DateFormat('dd-MM-yy HH:mm');

    List<DateTime> finishDates = [
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
    ]
        .where((v) => v != null && v.toString().trim().isNotEmpty)
        .map((v) {
          try {
            return dateFormat.parse(v.toString());
          } catch (e) {
            return null;
          }
        })
        .where((v) => v != null)
        .cast<DateTime>()
        .toList();

    int total = finishDates.length;
    int passed = finishDates.where((d) => DateTime.now().isAfter(d)).length;

    double progress = total == 0 ? 0 : passed / total;
    double percent = progress * 100;

    return SizedBox(
      height: 30.0 * maxRowCount,
      child: Center(
        child: LinearPercentIndicator(
          lineHeight: 15.0,
          percent: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.orange[100]!,
          progressColor: Colors.green,
          animation: true,
          animationDuration: 1000,
          barRadius: const Radius.circular(10),
          center: Text(
            "${percent.toStringAsFixed(1)}%",
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return SizedBox(
    height: 30.0 * maxRowCount,
    child: Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        decoration: (data == 'RECEIVED' ||
                data == 'START' ||
                data == 'WAIT TRANSFER' ||
                data == 'TRANSFER' ||
                data == 'CANCEL' ||
                data == 'PM' ||
                data == 'FINISH')
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
          data == 'Part Name' ||
                  data == 'Part No' ||
                  data == 'Lot No' ||
                  data == 'Amount' ||
                  data == 'Material' ||
                  data == 'Process'
              ? ''
              : data,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: (data == 'RECEIVED' ||
                    data == 'START' ||
                    data == 'WAIT TRANSFER' ||
                    data == 'TRANSFER' ||
                    data == 'CANCEL' ||
                    data == 'PM' ||
                    data == 'FINISH')
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

  return [timeCount, partNameCount, partNoCount].reduce((a, b) => a > b ? a : b);
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'RECEIVED':
      return Colors.blue;
    case 'START':
      return Colors.pink;
    case 'WAIT TRANSFER':
      return Colors.orange;
    case 'CANCEL' || 'PM':
      return Colors.red;
    case 'FINISH' || 'TRANSFER':
      return Colors.green;
    default:
      return Colors.grey.shade200;
  }
}

void showEditDialog(BuildContext context, P03DATATABLEGETDATAclass item) {
  // print(item.REQUESTNO);
  final FocusNode TypeFocusNode = FocusNode();
  final FocusNode RequestNoFocusNode = FocusNode();
  final FocusNode ReportNoFocusNode = FocusNode();
  final FocusNode SectionRequestFocusNode = FocusNode();
  final FocusNode RequesterFocusNode = FocusNode();
  final FocusNode SamplingDateFocusNode = FocusNode();
  final FocusNode ReceivedDateFocusNode = FocusNode();
  final FocusNode CustomerNameFocusNode = FocusNode();
  final FocusNode PartName1FocusNode = FocusNode();
  final FocusNode PartNo1FocusNode = FocusNode();
  final FocusNode LotNo1FocusNode = FocusNode();
  final FocusNode Amount1FocusNode = FocusNode();
  final FocusNode Material1FocusNode = FocusNode();
  final FocusNode Process1FocusNode = FocusNode();
  final FocusNode PartName2FocusNode = FocusNode();
  final FocusNode PartNo2FocusNode = FocusNode();
  final FocusNode LotNo2FocusNode = FocusNode();
  final FocusNode Amount2FocusNode = FocusNode();
  final FocusNode Material2FocusNode = FocusNode();
  final FocusNode Process2FocusNode = FocusNode();
  final FocusNode PartName3FocusNode = FocusNode();
  final FocusNode PartNo3FocusNode = FocusNode();
  final FocusNode LotNo3FocusNode = FocusNode();
  final FocusNode Amount3FocusNode = FocusNode();
  final FocusNode Material3FocusNode = FocusNode();
  final FocusNode Process3FocusNode = FocusNode();
  final FocusNode PartName4FocusNode = FocusNode();
  final FocusNode PartNo4FocusNode = FocusNode();
  final FocusNode LotNo4FocusNode = FocusNode();
  final FocusNode Amount4FocusNode = FocusNode();
  final FocusNode Material4FocusNode = FocusNode();
  final FocusNode Process4FocusNode = FocusNode();
  final FocusNode PartName5FocusNode = FocusNode();
  final FocusNode PartNo5FocusNode = FocusNode();
  final FocusNode LotNo5FocusNode = FocusNode();
  final FocusNode Amount5FocusNode = FocusNode();
  final FocusNode Material5FocusNode = FocusNode();
  final FocusNode Process5FocusNode = FocusNode();
  final FocusNode PartName6FocusNode = FocusNode();
  final FocusNode PartNo6FocusNode = FocusNode();
  final FocusNode LotNo6FocusNode = FocusNode();
  final FocusNode Amount6FocusNode = FocusNode();
  final FocusNode Material6FocusNode = FocusNode();
  final FocusNode Process6FocusNode = FocusNode();
  final FocusNode PartName7FocusNode = FocusNode();
  final FocusNode PartNo7FocusNode = FocusNode();
  final FocusNode LotNo7FocusNode = FocusNode();
  final FocusNode Amount7FocusNode = FocusNode();
  final FocusNode Material7FocusNode = FocusNode();
  final FocusNode Process7FocusNode = FocusNode();
  final FocusNode PartName8FocusNode = FocusNode();
  final FocusNode PartNo8FocusNode = FocusNode();
  final FocusNode LotNo8FocusNode = FocusNode();
  final FocusNode Amount8FocusNode = FocusNode();
  final FocusNode Material8FocusNode = FocusNode();
  final FocusNode Process8FocusNode = FocusNode();
  final FocusNode PartName9FocusNode = FocusNode();
  final FocusNode PartNo9FocusNode = FocusNode();
  final FocusNode LotNo9FocusNode = FocusNode();
  final FocusNode Amount9FocusNode = FocusNode();
  final FocusNode Material9FocusNode = FocusNode();
  final FocusNode Process9FocusNode = FocusNode();
  final FocusNode PartName10FocusNode = FocusNode();
  final FocusNode PartNo10FocusNode = FocusNode();
  final FocusNode LotNo10FocusNode = FocusNode();
  final FocusNode Amount10FocusNode = FocusNode();
  final FocusNode Material10FocusNode = FocusNode();
  final FocusNode Process10FocusNode = FocusNode();
  // final FocusNode AmountOfSampleFocusNode = FocusNode();
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
  final FocusNode TempDate0FocusNode = FocusNode();
  // final FocusNode TempDate1FocusNode = FocusNode();
  // final FocusNode TempDate2FocusNode = FocusNode();
  // final FocusNode TempDate3FocusNode = FocusNode();
  // final FocusNode TempDate4FocusNode = FocusNode();
  // final FocusNode TempDate5FocusNode = FocusNode();
  // final FocusNode TempDate6FocusNode = FocusNode();
  // final FocusNode TempDate7FocusNode = FocusNode();
  // final FocusNode TempDate8FocusNode = FocusNode();
  // final FocusNode TempDate9FocusNode = FocusNode();
  // final FocusNode TempDate10FocusNode = FocusNode();
  final FocusNode DueDate0FocusNode = FocusNode();
  // final FocusNode DueDate1FocusNode = FocusNode();
  // final FocusNode DueDate2FocusNode = FocusNode();
  // final FocusNode DueDate3FocusNode = FocusNode();
  // final FocusNode DueDate4FocusNode = FocusNode();
  // final FocusNode DueDate5FocusNode = FocusNode();
  // final FocusNode DueDate6FocusNode = FocusNode();
  // final FocusNode DueDate7FocusNode = FocusNode();
  // final FocusNode DueDate8FocusNode = FocusNode();
  // final FocusNode DueDate9FocusNode = FocusNode();
  // final FocusNode DueDate10FocusNode = FocusNode();
  final FocusNode InstrumentFocusNode = FocusNode();
  final FocusNode MethodFocusNode = FocusNode();
  final FocusNode InchargeFocusNode = FocusNode();
  final FocusNode ApprovedDateFocusNode = FocusNode();
  final FocusNode ApprovedByFocusNode = FocusNode();
  final FocusNode StatusFocusNode = FocusNode();
  final FocusNode RemarkFocusNode = FocusNode();

  TextEditingController TypeController = TextEditingController(text: item.TYPE);
  TextEditingController RequestNoController = TextEditingController(text: item.REQUESTNO);
  TextEditingController ReportNoController = TextEditingController(text: item.REPORTNO);
  TextEditingController SectionRequestController = TextEditingController(text: item.SECTION);
  TextEditingController RequesterController = TextEditingController(text: item.REQUESTER);
  TextEditingController SamplingDateController = TextEditingController(text: item.SAMPLINGDATE);
  TextEditingController ReceivedDateController = TextEditingController(text: item.RECEIVEDDATE);
  TextEditingController CustomerNameController = TextEditingController(text: item.CUSTOMERNAME);
  TextEditingController PartName1Controller = TextEditingController(text: item.PARTNAME1);
  TextEditingController PartNo1Controller = TextEditingController(text: item.PARTNO1);
  TextEditingController LotNo1Controller = TextEditingController(text: item.LOTNO1);
  TextEditingController Amount1Controller = TextEditingController(text: item.AMOUNT1);
  TextEditingController Material1Controller = TextEditingController(text: item.MATERIAL1);
  TextEditingController Process1Controller = TextEditingController(text: item.PROCESS1);
  TextEditingController PartName2Controller = TextEditingController(text: item.PARTNAME2);
  TextEditingController PartNo2Controller = TextEditingController(text: item.PARTNO2);
  TextEditingController LotNo2Controller = TextEditingController(text: item.LOTNO2);
  TextEditingController Amount2Controller = TextEditingController(text: item.AMOUNT2);
  TextEditingController Material2Controller = TextEditingController(text: item.MATERIAL2);
  TextEditingController Process2Controller = TextEditingController(text: item.PROCESS2);
  TextEditingController PartName3Controller = TextEditingController(text: item.PARTNAME3);
  TextEditingController PartNo3Controller = TextEditingController(text: item.PARTNO3);
  TextEditingController LotNo3Controller = TextEditingController(text: item.LOTNO3);
  TextEditingController Amount3Controller = TextEditingController(text: item.AMOUNT3);
  TextEditingController Material3Controller = TextEditingController(text: item.MATERIAL3);
  TextEditingController Process3Controller = TextEditingController(text: item.PROCESS3);
  TextEditingController PartName4Controller = TextEditingController(text: item.PARTNAME4);
  TextEditingController PartNo4Controller = TextEditingController(text: item.PARTNO4);
  TextEditingController LotNo4Controller = TextEditingController(text: item.LOTNO4);
  TextEditingController Amount4Controller = TextEditingController(text: item.AMOUNT4);
  TextEditingController Material4Controller = TextEditingController(text: item.MATERIAL4);
  TextEditingController Process4Controller = TextEditingController(text: item.PROCESS4);
  TextEditingController PartName5Controller = TextEditingController(text: item.PARTNAME5);
  TextEditingController PartNo5Controller = TextEditingController(text: item.PARTNO5);
  TextEditingController LotNo5Controller = TextEditingController(text: item.LOTNO5);
  TextEditingController Amount5Controller = TextEditingController(text: item.AMOUNT5);
  TextEditingController Material5Controller = TextEditingController(text: item.MATERIAL5);
  TextEditingController Process5Controller = TextEditingController(text: item.PROCESS5);
  TextEditingController PartName6Controller = TextEditingController(text: item.PARTNAME6);
  TextEditingController PartNo6Controller = TextEditingController(text: item.PARTNO6);
  TextEditingController LotNo6Controller = TextEditingController(text: item.LOTNO6);
  TextEditingController Amount6Controller = TextEditingController(text: item.AMOUNT6);
  TextEditingController Material6Controller = TextEditingController(text: item.MATERIAL6);
  TextEditingController Process6Controller = TextEditingController(text: item.PROCESS6);
  TextEditingController PartName7Controller = TextEditingController(text: item.PARTNAME7);
  TextEditingController PartNo7Controller = TextEditingController(text: item.PARTNO7);
  TextEditingController LotNo7Controller = TextEditingController(text: item.LOTNO7);
  TextEditingController Amount7Controller = TextEditingController(text: item.AMOUNT7);
  TextEditingController Material7Controller = TextEditingController(text: item.MATERIAL7);
  TextEditingController Process7Controller = TextEditingController(text: item.PROCESS7);
  TextEditingController PartName8Controller = TextEditingController(text: item.PARTNAME8);
  TextEditingController PartNo8Controller = TextEditingController(text: item.PARTNO8);
  TextEditingController LotNo8Controller = TextEditingController(text: item.LOTNO8);
  TextEditingController Amount8Controller = TextEditingController(text: item.AMOUNT8);
  TextEditingController Material8Controller = TextEditingController(text: item.MATERIAL8);
  TextEditingController Process8Controller = TextEditingController(text: item.PROCESS8);
  TextEditingController PartName9Controller = TextEditingController(text: item.PARTNAME9);
  TextEditingController PartNo9Controller = TextEditingController(text: item.PARTNO9);
  TextEditingController LotNo9Controller = TextEditingController(text: item.LOTNO9);
  TextEditingController Amount9Controller = TextEditingController(text: item.AMOUNT9);
  TextEditingController Material9Controller = TextEditingController(text: item.MATERIAL9);
  TextEditingController Process9Controller = TextEditingController(text: item.PROCESS9);
  TextEditingController PartName10Controller = TextEditingController(text: item.PARTNAME10);
  TextEditingController PartNo10Controller = TextEditingController(text: item.PARTNO10);
  TextEditingController LotNo10Controller = TextEditingController(text: item.LOTNO10);
  TextEditingController Amount10Controller = TextEditingController(text: item.AMOUNT10);
  TextEditingController Material10Controller = TextEditingController(text: item.MATERIAL10);
  TextEditingController Process10Controller = TextEditingController(text: item.PROCESS10);
  // TextEditingController AmountOfSampleController = TextEditingController(text: '${item.AMOUNTSAMPLE}');
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
  TextEditingController TempDate0Controller = TextEditingController(text: item.TEMPDATE0);
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
  TextEditingController DueDate0Controller = TextEditingController(text: item.DUEDATE0);
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
  List<TextEditingController> lotNoControllers = [
    LotNo1Controller,
    LotNo2Controller,
    LotNo3Controller,
    LotNo4Controller,
    LotNo5Controller,
    LotNo6Controller,
    LotNo7Controller,
    LotNo8Controller,
    LotNo9Controller,
    LotNo10Controller,
  ];
  List<FocusNode> lotNoFocusNodes = [
    LotNo1FocusNode,
    LotNo2FocusNode,
    LotNo3FocusNode,
    LotNo4FocusNode,
    LotNo5FocusNode,
    LotNo6FocusNode,
    LotNo7FocusNode,
    LotNo8FocusNode,
    LotNo9FocusNode,
    LotNo10FocusNode,
  ];
  List<TextEditingController> amountControllers = [
    Amount1Controller,
    Amount2Controller,
    Amount3Controller,
    Amount4Controller,
    Amount5Controller,
    Amount6Controller,
    Amount7Controller,
    Amount8Controller,
    Amount9Controller,
    Amount10Controller,
  ];
  List<FocusNode> amountFocusNodes = [
    Amount1FocusNode,
    Amount2FocusNode,
    Amount3FocusNode,
    Amount4FocusNode,
    Amount5FocusNode,
    Amount6FocusNode,
    Amount7FocusNode,
    Amount8FocusNode,
    Amount9FocusNode,
    Amount10FocusNode,
  ];
  List<TextEditingController> materialControllers = [
    Material1Controller,
    Material2Controller,
    Material3Controller,
    Material4Controller,
    Material5Controller,
    Material6Controller,
    Material7Controller,
    Material8Controller,
    Material9Controller,
    Material10Controller,
  ];
  List<FocusNode> materialFocusNodes = [
    Material1FocusNode,
    Material2FocusNode,
    Material3FocusNode,
    Material4FocusNode,
    Material5FocusNode,
    Material6FocusNode,
    Material7FocusNode,
    Material8FocusNode,
    Material9FocusNode,
    Material10FocusNode,
  ];
  List<TextEditingController> processControllers = [
    Process1Controller,
    Process2Controller,
    Process3Controller,
    Process4Controller,
    Process5Controller,
    Process6Controller,
    Process7Controller,
    Process8Controller,
    Process9Controller,
    Process10Controller,
  ];
  List<FocusNode> processFocusNodes = [
    Process1FocusNode,
    Process2FocusNode,
    Process3FocusNode,
    Process4FocusNode,
    Process5FocusNode,
    Process6FocusNode,
    Process7FocusNode,
    Process8FocusNode,
    Process9FocusNode,
    Process10FocusNode,
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
  // List<FocusNode> tempDateFocusNodes = [
  //   TempDate1FocusNode,
  //   TempDate2FocusNode,
  //   TempDate3FocusNode,
  //   TempDate4FocusNode,
  //   TempDate5FocusNode,
  //   TempDate6FocusNode,
  //   TempDate7FocusNode,
  //   TempDate8FocusNode,
  //   TempDate9FocusNode,
  //   TempDate10FocusNode,
  // ];
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
  // List<FocusNode> dueDateFocusNodes = [
  //   DueDate1FocusNode,
  //   DueDate2FocusNode,
  //   DueDate3FocusNode,
  //   DueDate4FocusNode,
  //   DueDate5FocusNode,
  //   DueDate6FocusNode,
  //   DueDate7FocusNode,
  //   DueDate8FocusNode,
  //   DueDate9FocusNode,
  //   DueDate10FocusNode,
  // ];
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
  List<String> lotNos = [
    item.LOTNO1,
    item.LOTNO2,
    item.LOTNO3,
    item.LOTNO4,
    item.LOTNO5,
    item.LOTNO6,
    item.LOTNO7,
    item.LOTNO8,
    item.LOTNO9,
    item.LOTNO10,
  ];
  List<String> amounts = [
    item.AMOUNT1,
    item.AMOUNT2,
    item.AMOUNT3,
    item.AMOUNT4,
    item.AMOUNT5,
    item.AMOUNT6,
    item.AMOUNT7,
    item.AMOUNT8,
    item.AMOUNT9,
    item.AMOUNT10,
  ];
  List<String> materials = [
    item.MATERIAL1,
    item.MATERIAL2,
    item.MATERIAL3,
    item.MATERIAL4,
    item.MATERIAL5,
    item.MATERIAL6,
    item.MATERIAL7,
    item.MATERIAL8,
    item.MATERIAL9,
    item.MATERIAL10,
  ];
  List<String> processs = [
    item.PROCESS1,
    item.PROCESS2,
    item.PROCESS3,
    item.PROCESS4,
    item.PROCESS5,
    item.PROCESS6,
    item.PROCESS7,
    item.PROCESS8,
    item.PROCESS9,
    item.PROCESS10,
  ];

  void updateMultipleDatesAll() {
    updateMultipleDates({
      SamplingDateController: (val) => item.SAMPLINGDATE = val,
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
      TempDate0Controller: (val) => item.TEMPDATE0 = val,
      DueDate0Controller: (val) => item.DUEDATE0 = val,
      ApprovedDateController: (val) => item.APPROVEDDATE = val,
    });
  }

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                width: 600,
                height: 600,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Text(
                            'แก้ไขข้อมูล ${item.REQUESTNO}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
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
                              context: P03DATATABLEMAINcontext,
                              controller: TypeController,
                              focusNode: TypeFocusNode,
                              labelText: "Type",
                              icon: Icons.assignment,
                              dropdownItems: ['Service lab', 'Special request'],
                              onChanged: (value) {
                                item.TYPE = value;
                              },
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
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
                              controller: RequesterController,
                              focusNode: RequesterFocusNode,
                              labelText: "Requester",
                              icon: Icons.person,
                              onChanged: (value) {
                                item.REQUESTER = value;
                              },
                            ),
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
                              controller: SamplingDateController,
                              focusNode: SamplingDateFocusNode,
                              labelText: "Sampling Date",
                              icon: Icons.calendar_month_rounded,
                              onChanged: (value) {
                                EditTextController(
                                  controller: SamplingDateController,
                                  value: value,
                                );
                              },
                            ),
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
                              controller: CustomerNameController,
                              focusNode: CustomerNameFocusNode,
                              labelText: "Customer Name",
                              icon: Icons.people,
                              dropdownItems: P03DATATABLEVAR.dropdownCustomer,
                              onChanged: (value) {
                                item.CUSTOMERNAME = value;
                              },
                            ),
                            for (int i = 0; i < 10; i++) ...[
                              if (partNameControllers[i].text != '')
                                buildCustomField(
                                  context: P03DATATABLEMAINcontext,
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
                              if (partNoControllers[i].text != '')
                                buildCustomField(
                                  context: P03DATATABLEMAINcontext,
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
                              if (lotNoControllers[i].text != '')
                                buildCustomField(
                                  context: P03DATATABLEMAINcontext,
                                  controller: lotNoControllers[i],
                                  focusNode: lotNoFocusNodes[i],
                                  labelText: "Lot No ${i + 1}",
                                  icon: Icons.settings,
                                  onChanged: (value) {
                                    EditTextController(
                                      controller: lotNoControllers[i],
                                      value: value,
                                    );
                                    lotNos[i] = value;
                                    item.LOTNO1 = lotNos[0];
                                    item.LOTNO2 = lotNos[1];
                                    item.LOTNO3 = lotNos[2];
                                    item.LOTNO4 = lotNos[3];
                                    item.LOTNO5 = lotNos[4];
                                    item.LOTNO6 = lotNos[5];
                                    item.LOTNO7 = lotNos[6];
                                    item.LOTNO8 = lotNos[7];
                                    item.LOTNO9 = lotNos[8];
                                    item.LOTNO10 = lotNos[9];
                                  },
                                ),
                              if (amountControllers[i].text != '')
                                buildCustomField(
                                  context: P03DATATABLEMAINcontext,
                                  controller: amountControllers[i],
                                  focusNode: amountFocusNodes[i],
                                  labelText: "Amount ${i + 1}",
                                  icon: Icons.settings,
                                  onChanged: (value) {
                                    EditTextController(
                                      controller: amountControllers[i],
                                      value: value,
                                    );
                                    amounts[i] = value;
                                    item.AMOUNT1 = amounts[0];
                                    item.AMOUNT2 = amounts[1];
                                    item.AMOUNT3 = amounts[2];
                                    item.AMOUNT4 = amounts[3];
                                    item.AMOUNT5 = amounts[4];
                                    item.AMOUNT6 = amounts[5];
                                    item.AMOUNT7 = amounts[6];
                                    item.AMOUNT8 = amounts[7];
                                    item.AMOUNT9 = amounts[8];
                                    item.AMOUNT10 = amounts[9];
                                  },
                                ),
                              if (materialControllers[i].text != '')
                                buildCustomField(
                                  context: P03DATATABLEMAINcontext,
                                  controller: materialControllers[i],
                                  focusNode: materialFocusNodes[i],
                                  labelText: "Material ${i + 1}",
                                  icon: Icons.settings,
                                  onChanged: (value) {
                                    EditTextController(
                                      controller: materialControllers[i],
                                      value: value,
                                    );
                                    materials[i] = value;
                                    item.MATERIAL1 = materials[0];
                                    item.MATERIAL2 = materials[1];
                                    item.MATERIAL3 = materials[2];
                                    item.MATERIAL4 = materials[3];
                                    item.MATERIAL5 = materials[4];
                                    item.MATERIAL6 = materials[5];
                                    item.MATERIAL7 = materials[6];
                                    item.MATERIAL8 = materials[7];
                                    item.MATERIAL9 = materials[8];
                                    item.MATERIAL10 = materials[9];
                                  },
                                ),
                              if (processControllers[i].text != '')
                                buildCustomField(
                                  context: P03DATATABLEMAINcontext,
                                  controller: processControllers[i],
                                  focusNode: processFocusNodes[i],
                                  labelText: "Process ${i + 1}",
                                  icon: Icons.settings,
                                  onChanged: (value) {
                                    EditTextController(
                                      controller: processControllers[i],
                                      value: value,
                                    );
                                    processs[i] = value;
                                    item.PROCESS1 = processs[0];
                                    item.PROCESS2 = processs[1];
                                    item.PROCESS3 = processs[2];
                                    item.PROCESS4 = processs[3];
                                    item.PROCESS5 = processs[4];
                                    item.PROCESS6 = processs[5];
                                    item.PROCESS7 = processs[6];
                                    item.PROCESS8 = processs[7];
                                    item.PROCESS9 = processs[8];
                                    item.PROCESS10 = processs[9];
                                  },
                                ),
                            ],
                            // buildCustomField(
                            //   context: P03DATATABLEMAINcontext,
                            //   controller: AmountOfSampleController,
                            //   focusNode: AmountOfSampleFocusNode,
                            //   labelText: "Amount of Sample (Pcs)",
                            //   icon: Icons.science,
                            //   onChanged: (value) {
                            //     item.AMOUNTSAMPLE = value.isNotEmpty ? int.parse(value) : 0;
                            //   },
                            // ),
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
                              controller: TakePhotoController,
                              focusNode: TakePhotoFocusNode,
                              labelText: "Take photo (Pcs)",
                              icon: Icons.photo_camera,
                              onChanged: (value) {
                                item.TAKEPHOTO = value.isNotEmpty ? int.parse(value) : 0;
                              },
                            ),
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
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
                                  await calculateFinishDate(
                                    startDateController: StartDateController,
                                    timeController: timeControllers[i],
                                    finishDateController: finishDateControllers[i],
                                  );
                                  // print('Finish ${finishDateControllers[i]}');
                                  DateTime? FinishDateToDateTime =
                                      convertStringToDateTime(finishDateControllers[i].text);
                                  if (FinishDateToDateTime != '' && FinishDateToDateTime != null) {
                                    String CalTemp = await calculateRepDue(
                                      startDate: DateTime(FinishDateToDateTime.year,
                                          FinishDateToDateTime.month, FinishDateToDateTime.day),
                                      addDays: P03DATATABLEVAR.TempAddDays,
                                    );
                                    tempDateControllers[i].text = CalTemp;
                                    // print('temp ${tempDateControllers[i].text}');
                                    String CalDue = await calculateRepDue(
                                      startDate: DateTime(FinishDateToDateTime.year,
                                          FinishDateToDateTime.month, FinishDateToDateTime.day),
                                      addDays: P03DATATABLEVAR.DueAddDays,
                                    );
                                    dueDateControllers[i].text = CalDue;
                                    // print('temp ${tempDateControllers[i].text}');
                                  }
                                }
                                setState(() {});
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
                                            context: P03DATATABLEMAINcontext,
                                            controller: timeControllers[i],
                                            focusNode: timeFocusNodes[i],
                                            labelText: "Time ${i + 1} (Hrs.)",
                                            icon: Icons.timer_sharp,
                                            onChanged: (value) async {
                                              EditTextController(
                                                controller: timeControllers[i],
                                                value: value,
                                              );
                                              await calculateFinishDate(
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
                                              for (int i = finishDateControllers.length - 1; i >= 0; i--) {
                                                if (finishDateControllers[i].text.isNotEmpty) {
                                                  await calculateAndSetTempDate(
                                                    finishDateController: finishDateControllers[i],
                                                    DateController: TempDate0Controller,
                                                    addDays: P03DATATABLEVAR.TempAddDays,
                                                  );
                                                  await calculateAndSetTempDate(
                                                    finishDateController: finishDateControllers[i],
                                                    DateController: DueDate0Controller,
                                                    addDays: P03DATATABLEVAR.DueAddDays,
                                                  );
                                                  break;
                                                }
                                              }
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
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: buildCustomField(
                                            context: P03DATATABLEMAINcontext,
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
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: buildCustomField(
                                    //         context: P03DATATABLEMAINcontext,
                                    //         controller: tempDateControllers[i],
                                    //         focusNode: tempDateFocusNodes[i],
                                    //         labelText: "Temp Report ${i + 1}",
                                    //         icon: Icons.calendar_month_rounded,
                                    //         onChanged: (value) {
                                    //           EditTextController(
                                    //             controller: tempDateControllers[i],
                                    //             value: value,
                                    //           );
                                    //         },
                                    //       ),
                                    //     ),
                                    //     const SizedBox(width: 10),
                                    //     Expanded(
                                    //       child: buildCustomField(
                                    //         context: P03DATATABLEMAINcontext,
                                    //         controller: dueDateControllers[i],
                                    //         focusNode: dueDateFocusNodes[i],
                                    //         labelText: "Due Report ${i + 1}",
                                    //         icon: Icons.calendar_month_rounded,
                                    //         onChanged: (value) {
                                    //           EditTextController(
                                    //             controller: dueDateControllers[i],
                                    //             value: value,
                                    //           );
                                    //         },
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                            Row(
                              children: [
                                Expanded(
                                  child: buildCustomField(
                                    context: P03DATATABLEMAINcontext,
                                    controller: TempDate0Controller,
                                    focusNode: TempDate0FocusNode,
                                    labelText: "Temp Report",
                                    icon: Icons.calendar_month_rounded,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: buildCustomField(
                                    context: P03DATATABLEMAINcontext,
                                    controller: DueDate0Controller,
                                    focusNode: DueDate0FocusNode,
                                    labelText: "Due Report",
                                    icon: Icons.calendar_month_rounded,
                                  ),
                                ),
                              ],
                            ),
                            buildCustomFieldforEditData(
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
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
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
                                if (item.STATUS == 'RECEIVED' && USERDATA.UserLV >= 5)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await showStartConfirmationDialog(
                                          context: context,
                                          onConfirm: () async {
                                            updateMultipleDatesAll();
                                            P03DATATABLEVAR.SendEditDataToAPI = jsonEncode(item.toJson());
                                            // print(P03DATATABLEVAR.SendEditDataToAPI);
                                            _StatJobToAPI();
                                            // initSocketConnection();
                                            // sendDataToServer('EditJob');
                                            // await EditDataToAPI();
                                            // await initSocketConnection();
                                            // await sendDataToServer('EditJob');
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.pink,
                                        shadowColor: Colors.pinkAccent,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          side: BorderSide(color: Colors.pink, width: 2),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: 5,
                                        children: const [
                                          Text(
                                            'START JOB',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.start_rounded,
                                            color: Colors.pink,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (item.STATUS == 'RECEIVED')
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
                                            _EditDataToAPI();
                                            // initSocketConnection();
                                            // sendDataToServer('EditJob');
                                            // await EditDataToAPI();
                                            // await initSocketConnection();
                                            // await sendDataToServer('EditJob');
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
                                if (item.STATUS == 'START' && USERDATA.UserLV >= 5)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await showCancelConfirmationDialog(
                                          context: context,
                                          onConfirm: () async {
                                            updateMultipleDatesAll();
                                            P03DATATABLEVAR.SendEditDataToAPI = jsonEncode(item.toJson());
                                            // print(P03DATATABLEVAR.SendEditDataToAPI);
                                            _CancelJobToAPI();
                                            // initSocketConnection();
                                            // sendDataToServer('CancelJob');
                                            // await EditDataToAPI();
                                            // await initSocketConnection();
                                            // await sendDataToServer('CancelJob');
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
                                if (item.STATUS == 'START' && USERDATA.UserLV >= 5)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await showFinishConfirmationDialog(
                                          context: context,
                                          onConfirm: () async {
                                            updateMultipleDatesAll();
                                            P03DATATABLEVAR.SendEditDataToAPI = jsonEncode(item.toJson());
                                            // print(P03DATATABLEVAR.SendEditDataToAPI);
                                            _FinishJobToAPI();
                                            // initSocketConnection();
                                            // sendDataToServer('FinishJob');
                                            // await EditDataToAPI();
                                            // await initSocketConnection();
                                            // await sendDataToServer('CancelJob');
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
                                            'Finish Job',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.done_outline_rounded,
                                            color: Colors.green,
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
      });
}

void showAddDialog(BuildContext context) {
  // print(item.REQUESTNO);
  final FocusNode TypeFocusNode = FocusNode();
  final FocusNode RequestNoFocusNode = FocusNode();
  final FocusNode ReportNoFocusNode = FocusNode();
  final FocusNode SectionRequestFocusNode = FocusNode();
  final FocusNode RequesterFocusNode = FocusNode();
  final FocusNode SamplingDateFocusNode = FocusNode();
  final FocusNode ReceivedDateFocusNode = FocusNode();
  final FocusNode CustomerNameFocusNode = FocusNode();
  final FocusNode PartName1FocusNode = FocusNode();
  final FocusNode PartNo1FocusNode = FocusNode();
  final FocusNode LotNo1FocusNode = FocusNode();
  final FocusNode Amount1FocusNode = FocusNode();
  final FocusNode Material1FocusNode = FocusNode();
  final FocusNode Process1FocusNode = FocusNode();
  final FocusNode PartName2FocusNode = FocusNode();
  final FocusNode PartNo2FocusNode = FocusNode();
  final FocusNode LotNo2FocusNode = FocusNode();
  final FocusNode Amount2FocusNode = FocusNode();
  final FocusNode Material2FocusNode = FocusNode();
  final FocusNode Process2FocusNode = FocusNode();
  final FocusNode PartName3FocusNode = FocusNode();
  final FocusNode PartNo3FocusNode = FocusNode();
  final FocusNode LotNo3FocusNode = FocusNode();
  final FocusNode Amount3FocusNode = FocusNode();
  final FocusNode Material3FocusNode = FocusNode();
  final FocusNode Process3FocusNode = FocusNode();
  final FocusNode PartName4FocusNode = FocusNode();
  final FocusNode PartNo4FocusNode = FocusNode();
  final FocusNode LotNo4FocusNode = FocusNode();
  final FocusNode Amount4FocusNode = FocusNode();
  final FocusNode Material4FocusNode = FocusNode();
  final FocusNode Process4FocusNode = FocusNode();
  final FocusNode PartName5FocusNode = FocusNode();
  final FocusNode PartNo5FocusNode = FocusNode();
  final FocusNode LotNo5FocusNode = FocusNode();
  final FocusNode Amount5FocusNode = FocusNode();
  final FocusNode Material5FocusNode = FocusNode();
  final FocusNode Process5FocusNode = FocusNode();
  final FocusNode PartName6FocusNode = FocusNode();
  final FocusNode PartNo6FocusNode = FocusNode();
  final FocusNode LotNo6FocusNode = FocusNode();
  final FocusNode Amount6FocusNode = FocusNode();
  final FocusNode Material6FocusNode = FocusNode();
  final FocusNode Process6FocusNode = FocusNode();
  final FocusNode PartName7FocusNode = FocusNode();
  final FocusNode PartNo7FocusNode = FocusNode();
  final FocusNode LotNo7FocusNode = FocusNode();
  final FocusNode Amount7FocusNode = FocusNode();
  final FocusNode Material7FocusNode = FocusNode();
  final FocusNode Process7FocusNode = FocusNode();
  final FocusNode PartName8FocusNode = FocusNode();
  final FocusNode PartNo8FocusNode = FocusNode();
  final FocusNode LotNo8FocusNode = FocusNode();
  final FocusNode Amount8FocusNode = FocusNode();
  final FocusNode Material8FocusNode = FocusNode();
  final FocusNode Process8FocusNode = FocusNode();
  final FocusNode PartName9FocusNode = FocusNode();
  final FocusNode PartNo9FocusNode = FocusNode();
  final FocusNode LotNo9FocusNode = FocusNode();
  final FocusNode Amount9FocusNode = FocusNode();
  final FocusNode Material9FocusNode = FocusNode();
  final FocusNode Process9FocusNode = FocusNode();
  final FocusNode PartName10FocusNode = FocusNode();
  final FocusNode PartNo10FocusNode = FocusNode();
  final FocusNode LotNo10FocusNode = FocusNode();
  final FocusNode Amount10FocusNode = FocusNode();
  final FocusNode Material10FocusNode = FocusNode();
  final FocusNode Process10FocusNode = FocusNode();
  // final FocusNode AmountOfSampleFocusNode = FocusNode();
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
  final FocusNode TempDate0FocusNode = FocusNode();
  // final FocusNode TempDate1FocusNode = FocusNode();
  // final FocusNode TempDate2FocusNode = FocusNode();
  // final FocusNode TempDate3FocusNode = FocusNode();
  // final FocusNode TempDate4FocusNode = FocusNode();
  // final FocusNode TempDate5FocusNode = FocusNode();
  // final FocusNode TempDate6FocusNode = FocusNode();
  // final FocusNode TempDate7FocusNode = FocusNode();
  // final FocusNode TempDate8FocusNode = FocusNode();
  // final FocusNode TempDate9FocusNode = FocusNode();
  // final FocusNode TempDate10FocusNode = FocusNode();
  final FocusNode DueDate0FocusNode = FocusNode();
  // final FocusNode DueDate1FocusNode = FocusNode();
  // final FocusNode DueDate2FocusNode = FocusNode();
  // final FocusNode DueDate3FocusNode = FocusNode();
  // final FocusNode DueDate4FocusNode = FocusNode();
  // final FocusNode DueDate5FocusNode = FocusNode();
  // final FocusNode DueDate6FocusNode = FocusNode();
  // final FocusNode DueDate7FocusNode = FocusNode();
  // final FocusNode DueDate8FocusNode = FocusNode();
  // final FocusNode DueDate9FocusNode = FocusNode();
  // final FocusNode DueDate10FocusNode = FocusNode();
  final FocusNode InstrumentFocusNode = FocusNode();
  final FocusNode MethodFocusNode = FocusNode();
  final FocusNode InchargeFocusNode = FocusNode();
  // final FocusNode ApprovedDateFocusNode = FocusNode();
  // final FocusNode ApprovedByFocusNode = FocusNode();
  final FocusNode StatusFocusNode = FocusNode();
  final FocusNode CheckBoxFocusNode = FocusNode();
  // final FocusNode RemarkFocusNode = FocusNode();

  TextEditingController TypeController = TextEditingController();
  TextEditingController RequestNoController = TextEditingController();
  TextEditingController ReportNoController = TextEditingController();
  TextEditingController SectionRequestController = TextEditingController();
  TextEditingController RequesterController = TextEditingController();
  TextEditingController SamplingDateController = TextEditingController();
  TextEditingController ReceivedDateController = TextEditingController();
  TextEditingController CustomerNameController = TextEditingController();
  TextEditingController PartName1Controller = TextEditingController();
  TextEditingController PartNo1Controller = TextEditingController();
  TextEditingController LotNo1Controller = TextEditingController();
  TextEditingController Amount1Controller = TextEditingController();
  TextEditingController Material1Controller = TextEditingController();
  TextEditingController Process1Controller = TextEditingController();
  TextEditingController PartName2Controller = TextEditingController();
  TextEditingController PartNo2Controller = TextEditingController();
  TextEditingController LotNo2Controller = TextEditingController();
  TextEditingController Amount2Controller = TextEditingController();
  TextEditingController Material2Controller = TextEditingController();
  TextEditingController Process2Controller = TextEditingController();
  TextEditingController PartName3Controller = TextEditingController();
  TextEditingController PartNo3Controller = TextEditingController();
  TextEditingController LotNo3Controller = TextEditingController();
  TextEditingController Amount3Controller = TextEditingController();
  TextEditingController Material3Controller = TextEditingController();
  TextEditingController Process3Controller = TextEditingController();
  TextEditingController PartName4Controller = TextEditingController();
  TextEditingController PartNo4Controller = TextEditingController();
  TextEditingController LotNo4Controller = TextEditingController();
  TextEditingController Amount4Controller = TextEditingController();
  TextEditingController Material4Controller = TextEditingController();
  TextEditingController Process4Controller = TextEditingController();
  TextEditingController PartName5Controller = TextEditingController();
  TextEditingController PartNo5Controller = TextEditingController();
  TextEditingController LotNo5Controller = TextEditingController();
  TextEditingController Amount5Controller = TextEditingController();
  TextEditingController Material5Controller = TextEditingController();
  TextEditingController Process5Controller = TextEditingController();
  TextEditingController PartName6Controller = TextEditingController();
  TextEditingController PartNo6Controller = TextEditingController();
  TextEditingController LotNo6Controller = TextEditingController();
  TextEditingController Amount6Controller = TextEditingController();
  TextEditingController Material6Controller = TextEditingController();
  TextEditingController Process6Controller = TextEditingController();
  TextEditingController PartName7Controller = TextEditingController();
  TextEditingController PartNo7Controller = TextEditingController();
  TextEditingController LotNo7Controller = TextEditingController();
  TextEditingController Amount7Controller = TextEditingController();
  TextEditingController Material7Controller = TextEditingController();
  TextEditingController Process7Controller = TextEditingController();
  TextEditingController PartName8Controller = TextEditingController();
  TextEditingController PartNo8Controller = TextEditingController();
  TextEditingController LotNo8Controller = TextEditingController();
  TextEditingController Amount8Controller = TextEditingController();
  TextEditingController Material8Controller = TextEditingController();
  TextEditingController Process8Controller = TextEditingController();
  TextEditingController PartName9Controller = TextEditingController();
  TextEditingController PartNo9Controller = TextEditingController();
  TextEditingController LotNo9Controller = TextEditingController();
  TextEditingController Amount9Controller = TextEditingController();
  TextEditingController Material9Controller = TextEditingController();
  TextEditingController Process9Controller = TextEditingController();
  TextEditingController PartName10Controller = TextEditingController();
  TextEditingController PartNo10Controller = TextEditingController();
  TextEditingController LotNo10Controller = TextEditingController();
  TextEditingController Amount10Controller = TextEditingController();
  TextEditingController Material10Controller = TextEditingController();
  TextEditingController Process10Controller = TextEditingController();
  // TextEditingController AmountOfSampleController = TextEditingController();
  TextEditingController TakePhotoController = TextEditingController();
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
  TextEditingController TempDate0Controller = TextEditingController();
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
  TextEditingController DueDate0Controller = TextEditingController();
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
  // TextEditingController ApprovedDateController = TextEditingController();
  // TextEditingController ApprovedByController = TextEditingController();
  TextEditingController StatusController = TextEditingController(text: 'RECEIVED');
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
  List<TextEditingController> lotNoControllers = [
    LotNo1Controller,
    LotNo2Controller,
    LotNo3Controller,
    LotNo4Controller,
    LotNo5Controller,
    LotNo6Controller,
    LotNo7Controller,
    LotNo8Controller,
    LotNo9Controller,
    LotNo10Controller,
  ];
  List<FocusNode> lotNoFocusNodes = [
    LotNo1FocusNode,
    LotNo2FocusNode,
    LotNo3FocusNode,
    LotNo4FocusNode,
    LotNo5FocusNode,
    LotNo6FocusNode,
    LotNo7FocusNode,
    LotNo8FocusNode,
    LotNo9FocusNode,
    LotNo10FocusNode,
  ];
  List<String> lotNoVAR = [
    P03DATATABLEVAR.LOTNO1,
    P03DATATABLEVAR.LOTNO2,
    P03DATATABLEVAR.LOTNO3,
    P03DATATABLEVAR.LOTNO4,
    P03DATATABLEVAR.LOTNO5,
    P03DATATABLEVAR.LOTNO6,
    P03DATATABLEVAR.LOTNO7,
    P03DATATABLEVAR.LOTNO8,
    P03DATATABLEVAR.LOTNO9,
    P03DATATABLEVAR.LOTNO10,
  ];
  List<TextEditingController> amountControllers = [
    Amount1Controller,
    Amount2Controller,
    Amount3Controller,
    Amount4Controller,
    Amount5Controller,
    Amount6Controller,
    Amount7Controller,
    Amount8Controller,
    Amount9Controller,
    Amount10Controller,
  ];
  List<FocusNode> amountFocusNodes = [
    Amount1FocusNode,
    Amount2FocusNode,
    Amount3FocusNode,
    Amount4FocusNode,
    Amount5FocusNode,
    Amount6FocusNode,
    Amount7FocusNode,
    Amount8FocusNode,
    Amount9FocusNode,
    Amount10FocusNode,
  ];
  List<String> amountVAR = [
    P03DATATABLEVAR.AMOUNT1,
    P03DATATABLEVAR.AMOUNT2,
    P03DATATABLEVAR.AMOUNT3,
    P03DATATABLEVAR.AMOUNT4,
    P03DATATABLEVAR.AMOUNT5,
    P03DATATABLEVAR.AMOUNT6,
    P03DATATABLEVAR.AMOUNT7,
    P03DATATABLEVAR.AMOUNT8,
    P03DATATABLEVAR.AMOUNT9,
    P03DATATABLEVAR.AMOUNT10,
  ];
  List<TextEditingController> materialControllers = [
    Material1Controller,
    Material2Controller,
    Material3Controller,
    Material4Controller,
    Material5Controller,
    Material6Controller,
    Material7Controller,
    Material8Controller,
    Material9Controller,
    Material10Controller,
  ];
  List<FocusNode> materialFocusNodes = [
    Material1FocusNode,
    Material2FocusNode,
    Material3FocusNode,
    Material4FocusNode,
    Material5FocusNode,
    Material6FocusNode,
    Material7FocusNode,
    Material8FocusNode,
    Material9FocusNode,
    Material10FocusNode,
  ];
  List<String> materialVAR = [
    P03DATATABLEVAR.MATERIAL1,
    P03DATATABLEVAR.MATERIAL2,
    P03DATATABLEVAR.MATERIAL3,
    P03DATATABLEVAR.MATERIAL4,
    P03DATATABLEVAR.MATERIAL5,
    P03DATATABLEVAR.MATERIAL6,
    P03DATATABLEVAR.MATERIAL7,
    P03DATATABLEVAR.MATERIAL8,
    P03DATATABLEVAR.MATERIAL9,
    P03DATATABLEVAR.MATERIAL10,
  ];
  List<TextEditingController> processControllers = [
    Process1Controller,
    Process2Controller,
    Process3Controller,
    Process4Controller,
    Process5Controller,
    Process6Controller,
    Process7Controller,
    Process8Controller,
    Process9Controller,
    Process10Controller,
  ];
  List<FocusNode> processFocusNodes = [
    Process1FocusNode,
    Process2FocusNode,
    Process3FocusNode,
    Process4FocusNode,
    Process5FocusNode,
    Process6FocusNode,
    Process7FocusNode,
    Process8FocusNode,
    Process9FocusNode,
    Process10FocusNode,
  ];
  List<String> processVAR = [
    P03DATATABLEVAR.PROCESS1,
    P03DATATABLEVAR.PROCESS2,
    P03DATATABLEVAR.PROCESS3,
    P03DATATABLEVAR.PROCESS4,
    P03DATATABLEVAR.PROCESS5,
    P03DATATABLEVAR.PROCESS6,
    P03DATATABLEVAR.PROCESS7,
    P03DATATABLEVAR.PROCESS8,
    P03DATATABLEVAR.PROCESS9,
    P03DATATABLEVAR.PROCESS10,
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
  // List<FocusNode> tempDateFocusNodes = [
  //   TempDate1FocusNode,
  //   TempDate2FocusNode,
  //   TempDate3FocusNode,
  //   TempDate4FocusNode,
  //   TempDate5FocusNode,
  //   TempDate6FocusNode,
  //   TempDate7FocusNode,
  //   TempDate8FocusNode,
  //   TempDate9FocusNode,
  //   TempDate10FocusNode,
  // ];
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
  // List<FocusNode> dueDateFocusNodes = [
  //   DueDate1FocusNode,
  //   DueDate2FocusNode,
  //   DueDate3FocusNode,
  //   DueDate4FocusNode,
  //   DueDate5FocusNode,
  //   DueDate6FocusNode,
  //   DueDate7FocusNode,
  //   DueDate8FocusNode,
  //   DueDate9FocusNode,
  //   DueDate10FocusNode,
  // ];

  int _visiblePartNameCount = 0;
  // int _visiblePartNoCount = 0;
  int _visibleTimeCount = 0;

  showDialog(
    context: context,
    barrierDismissible: false,
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
                // spacing: 10,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          'เพิ่มงานใหม่',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
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
                            context: P03DATATABLEMAINcontext,
                            controller: CustomerNameController,
                            focusNode: CustomerNameFocusNode,
                            labelText: "Customer Name",
                            icon: Icons.people,
                            dropdownItems: P03DATATABLEVAR.dropdownCustomer,
                            onChanged: (value) {
                              P03DATATABLEVAR.CUSTOMERNAME = value;
                              setState(() {
                                if (P03DATATABLEVAR.CUSTOMERNAME == 'PM') {
                                  P03DATATABLEVAR.CustomerIsPM = true;
                                  StatusController.text = 'PM';
                                } else {
                                  P03DATATABLEVAR.CustomerIsPM = false;
                                }
                              });
                            },
                          ),
                          buildCustomField(
                            context: P03DATATABLEMAINcontext,
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
                          if (InstrumentController.text != '')
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
                              controller: selectslot,
                              focusNode: CheckBoxFocusNode,
                              labelText: "Select Slot",
                              icon: Icons.add_box_rounded,
                              onChanged: (value) {
                                P03DATATABLEVAR.CHECKBOX = value;
                                StartDateController.text = StartDateControllerGlobal.text;
                                setState(() {});
                                // print(StartDateController.text);
                              },
                              ontap: () {
                                P03DATATABLEVAR.STATUS = StatusController.text;
                                selectstatus = StatusController.text;
                                selectpage = 'Salt Spray Tester : ${P03DATATABLEVAR.INSTRUMENT}';
                                showChooseSlot(context);
                                setState(() {});
                              },
                            ),
                          buildCustomField(
                            context: P03DATATABLEMAINcontext,
                            controller: StartDateController,
                            focusNode: StartDateFocusNode,
                            labelText: "Start Date",
                            icon: Icons.calendar_month_rounded,
                            onChanged: (value) async {
                              for (int i = 0; i < 10; i++) {
                                await calculateFinishDate(
                                  startDateController: StartDateController,
                                  timeController: timeControllers[i],
                                  finishDateController: finishDateControllers[i],
                                );
                                DateTime? FinishDateToDateTime =
                                    convertStringToDateTime(finishDateControllers[i].text);
                                if (FinishDateToDateTime != '' &&
                                    FinishDateToDateTime != null &&
                                    P03DATATABLEVAR.CustomerIsPM == false) {
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
                              if (P03DATATABLEVAR.CustomerIsPM == false) {
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
                              }
                              setState(() {});
                            },
                          ),
                          // if (StartDateController.text != '') ...[
                          for (int i = 0; i < _visibleTimeCount + 1 && i < 10; i++)
                            Column(
                              spacing: 10,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: buildCustomField(
                                        context: P03DATATABLEMAINcontext,
                                        controller: timeControllers[i],
                                        focusNode: timeFocusNodes[i],
                                        labelText: "Time ${i + 1} (Hrs.)",
                                        icon: Icons.timer_sharp,
                                        onChanged: (value) async {
                                          EditTextController(
                                            controller: timeControllers[i],
                                            value: value,
                                          );
                                          P03DATATABLEVAR.TIME1 = int.tryParse(timeControllers[0].text) ?? 0;
                                          P03DATATABLEVAR.TIME2 = int.tryParse(timeControllers[1].text) ?? 0;
                                          P03DATATABLEVAR.TIME3 = int.tryParse(timeControllers[2].text) ?? 0;
                                          P03DATATABLEVAR.TIME4 = int.tryParse(timeControllers[3].text) ?? 0;
                                          P03DATATABLEVAR.TIME5 = int.tryParse(timeControllers[4].text) ?? 0;
                                          P03DATATABLEVAR.TIME6 = int.tryParse(timeControllers[5].text) ?? 0;
                                          P03DATATABLEVAR.TIME7 = int.tryParse(timeControllers[6].text) ?? 0;
                                          P03DATATABLEVAR.TIME8 = int.tryParse(timeControllers[7].text) ?? 0;
                                          P03DATATABLEVAR.TIME9 = int.tryParse(timeControllers[8].text) ?? 0;
                                          P03DATATABLEVAR.TIME10 = int.tryParse(timeControllers[9].text) ?? 0;
                                          await calculateFinishDate(
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
                                          if (P03DATATABLEVAR.CustomerIsPM == false) {
                                            await calculateAndSetTempDate(
                                              finishDateController: finishDateControllers[i],
                                              DateController: tempDateControllers[i],
                                              addDays: P03DATATABLEVAR.TempAddDays,
                                            );
                                            for (int i = finishDateControllers.length - 1; i >= 0; i--) {
                                              if (finishDateControllers[i].text.isNotEmpty) {
                                                await calculateAndSetTempDate(
                                                  finishDateController: finishDateControllers[i],
                                                  DateController: TempDate0Controller,
                                                  addDays: P03DATATABLEVAR.TempAddDays,
                                                );
                                                await calculateAndSetTempDate(
                                                  finishDateController: finishDateControllers[i],
                                                  DateController: DueDate0Controller,
                                                  addDays: P03DATATABLEVAR.DueAddDays,
                                                );
                                                break;
                                              }
                                            }
                                            P03DATATABLEVAR.TEMPDATE0 =
                                                convertStringToDateTime(TempDate0Controller.text).toString();
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

                                            P03DATATABLEVAR.DUEDATE0 =
                                                convertStringToDateTime(DueDate0Controller.text).toString();
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
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: buildCustomField(
                                        context: P03DATATABLEMAINcontext,
                                        controller: finishDateControllers[i],
                                        focusNode: finishDateFocusNodes[i],
                                        labelText: "Finish Date ${i + 1}",
                                        icon: Icons.calendar_month_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                                // if (P03DATATABLEVAR.CustomerIsPM == false)
                                //   Row(
                                //     children: [
                                //       Expanded(
                                //         child: buildCustomField(
                                //           context: P03DATATABLEMAINcontext,
                                //           controller: tempDateControllers[i],
                                //           focusNode: tempDateFocusNodes[i],
                                //           labelText: "Temp Report ${i + 1}",
                                //           icon: Icons.calendar_month_rounded,
                                //         ),
                                //       ),
                                //       const SizedBox(width: 10),
                                //       Expanded(
                                //         child: buildCustomField(
                                //           context: P03DATATABLEMAINcontext,
                                //           controller: dueDateControllers[i],
                                //           focusNode: dueDateFocusNodes[i],
                                //           labelText: "Due Report ${i + 1}",
                                //           icon: Icons.calendar_month_rounded,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                              ],
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: buildCustomField(
                                  context: P03DATATABLEMAINcontext,
                                  controller: TempDate0Controller,
                                  focusNode: TempDate0FocusNode,
                                  labelText: "Temp Report",
                                  icon: Icons.calendar_month_rounded,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildCustomField(
                                  context: P03DATATABLEMAINcontext,
                                  controller: DueDate0Controller,
                                  focusNode: DueDate0FocusNode,
                                  labelText: "Due Report",
                                  icon: Icons.calendar_month_rounded,
                                ),
                              ),
                            ],
                          ),
                          if (_visibleTimeCount < 9 && P03DATATABLEVAR.CustomerIsPM == false)
                            buildAddPartNameButton(
                              visibleCount: _visibleTimeCount,
                              onPressed: () {
                                setState(() {
                                  _visibleTimeCount++;
                                });
                              },
                            ),
                          buildCustomField(
                            context: P03DATATABLEMAINcontext,
                            controller: TypeController,
                            focusNode: TypeFocusNode,
                            labelText: "Type",
                            icon: Icons.description,
                            dropdownItems: ['Service lab', 'Special request'],
                            onChanged: (value) {
                              P03DATATABLEVAR.TYPE = value;
                            },
                          ),
                          buildCustomField(
                            context: P03DATATABLEMAINcontext,
                            controller: RequestNoController,
                            focusNode: RequestNoFocusNode,
                            labelText: "Request No.",
                            icon: Icons.assignment,
                            onChanged: (value) {
                              P03DATATABLEVAR.REQUESTNO = value;
                              P03DATATABLEVAR.REPORTNO = value;
                              ReportNoController.text = value;
                            },
                          ),
                          buildCustomField(
                            context: P03DATATABLEMAINcontext,
                            controller: ReportNoController,
                            focusNode: ReportNoFocusNode,
                            labelText: "Report No.",
                            icon: Icons.assignment,
                          ),
                          if (P03DATATABLEVAR.CustomerIsPM == false) ...[
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
                              controller: RequesterController,
                              focusNode: RequesterFocusNode,
                              labelText: "Requester",
                              icon: Icons.person,
                              onChanged: (value) {
                                P03DATATABLEVAR.REQUESTER = value;
                              },
                            ),
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
                              controller: SamplingDateController,
                              focusNode: SamplingDateFocusNode,
                              labelText: "Sampling Date",
                              icon: Icons.calendar_month_rounded,
                              onChanged: (value) {
                                P03DATATABLEVAR.SAMPLINGDATE = convertStringToDateTime(value).toString();
                              },
                            ),
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
                              controller: ReceivedDateController,
                              focusNode: ReceivedDateFocusNode,
                              labelText: "Received Date",
                              icon: Icons.calendar_month_rounded,
                              onChanged: (value) {
                                P03DATATABLEVAR.RECEIVEDDATE = convertStringToDateTime(value).toString();
                              },
                            ),

                            for (int i = 0; i < _visiblePartNameCount + 1 && i < 10; i++) ...[
                              buildCustomField(
                                context: P03DATATABLEMAINcontext,
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
                              // for (int i = 0; i < _visiblePartNoCount + 1 && i < 10; i++)
                              buildCustomField(
                                context: P03DATATABLEMAINcontext,
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
                              buildCustomField(
                                context: P03DATATABLEMAINcontext,
                                controller: lotNoControllers[i],
                                focusNode: lotNoFocusNodes[i],
                                labelText: "Lot No ${i + 1}",
                                icon: Icons.settings,
                                onChanged: (value) {
                                  lotNoVAR[i] = value;
                                  P03DATATABLEVAR.LOTNO1 = lotNoVAR[0];
                                  P03DATATABLEVAR.LOTNO2 = lotNoVAR[1];
                                  P03DATATABLEVAR.LOTNO3 = lotNoVAR[2];
                                  P03DATATABLEVAR.LOTNO4 = lotNoVAR[3];
                                  P03DATATABLEVAR.LOTNO5 = lotNoVAR[4];
                                  P03DATATABLEVAR.LOTNO6 = lotNoVAR[5];
                                  P03DATATABLEVAR.LOTNO7 = lotNoVAR[6];
                                  P03DATATABLEVAR.LOTNO8 = lotNoVAR[7];
                                  P03DATATABLEVAR.LOTNO9 = lotNoVAR[8];
                                  P03DATATABLEVAR.LOTNO10 = lotNoVAR[9];
                                },
                              ),
                              buildCustomField(
                                context: P03DATATABLEMAINcontext,
                                controller: amountControllers[i],
                                focusNode: amountFocusNodes[i],
                                labelText: "Amount ${i + 1}",
                                icon: Icons.settings,
                                onChanged: (value) {
                                  amountVAR[i] = value;
                                  P03DATATABLEVAR.AMOUNT1 = amountVAR[0];
                                  P03DATATABLEVAR.AMOUNT2 = amountVAR[1];
                                  P03DATATABLEVAR.AMOUNT3 = amountVAR[2];
                                  P03DATATABLEVAR.AMOUNT4 = amountVAR[3];
                                  P03DATATABLEVAR.AMOUNT5 = amountVAR[4];
                                  P03DATATABLEVAR.AMOUNT6 = amountVAR[5];
                                  P03DATATABLEVAR.AMOUNT7 = amountVAR[6];
                                  P03DATATABLEVAR.AMOUNT8 = amountVAR[7];
                                  P03DATATABLEVAR.AMOUNT9 = amountVAR[8];
                                  P03DATATABLEVAR.AMOUNT10 = amountVAR[9];
                                },
                              ),
                              buildCustomField(
                                context: P03DATATABLEMAINcontext,
                                controller: materialControllers[i],
                                focusNode: materialFocusNodes[i],
                                labelText: "Material ${i + 1}",
                                icon: Icons.settings,
                                onChanged: (value) {
                                  materialVAR[i] = value;
                                  P03DATATABLEVAR.MATERIAL1 = materialVAR[0];
                                  P03DATATABLEVAR.MATERIAL2 = materialVAR[1];
                                  P03DATATABLEVAR.MATERIAL3 = materialVAR[2];
                                  P03DATATABLEVAR.MATERIAL4 = materialVAR[3];
                                  P03DATATABLEVAR.MATERIAL5 = materialVAR[4];
                                  P03DATATABLEVAR.MATERIAL6 = materialVAR[5];
                                  P03DATATABLEVAR.MATERIAL7 = materialVAR[6];
                                  P03DATATABLEVAR.MATERIAL8 = materialVAR[7];
                                  P03DATATABLEVAR.MATERIAL9 = materialVAR[8];
                                  P03DATATABLEVAR.MATERIAL10 = materialVAR[9];
                                },
                              ),
                              buildCustomField(
                                context: P03DATATABLEMAINcontext,
                                controller: processControllers[i],
                                focusNode: processFocusNodes[i],
                                labelText: "Process ${i + 1}",
                                icon: Icons.settings,
                                onChanged: (value) {
                                  processVAR[i] = value;
                                  P03DATATABLEVAR.PROCESS1 = processVAR[0];
                                  P03DATATABLEVAR.PROCESS2 = processVAR[1];
                                  P03DATATABLEVAR.PROCESS3 = processVAR[2];
                                  P03DATATABLEVAR.PROCESS4 = processVAR[3];
                                  P03DATATABLEVAR.PROCESS5 = processVAR[4];
                                  P03DATATABLEVAR.PROCESS6 = processVAR[5];
                                  P03DATATABLEVAR.PROCESS7 = processVAR[6];
                                  P03DATATABLEVAR.PROCESS8 = processVAR[7];
                                  P03DATATABLEVAR.PROCESS9 = processVAR[8];
                                  P03DATATABLEVAR.PROCESS10 = processVAR[9];
                                },
                              ),
                            ],
                            if (_visiblePartNameCount < 9)
                              buildAddPartNameButton(
                                visibleCount: _visiblePartNameCount,
                                onPressed: () {
                                  setState(() {
                                    _visiblePartNameCount++;
                                  });
                                },
                              ),
                            // if (_visiblePartNoCount < 9)
                            //   buildAddPartNameButton(
                            //     visibleCount: _visiblePartNoCount,
                            //     onPressed: () {
                            //       setState(() {
                            //         _visiblePartNoCount++;
                            //       });
                            //     },
                            //   ),
                            // buildCustomField(
                            //   context: P03DATATABLEMAINcontext,
                            //   controller: AmountOfSampleController,
                            //   focusNode: AmountOfSampleFocusNode,
                            //   labelText: "Amount of Sample (Pcs)",
                            //   icon: Icons.science,
                            //   onChanged: (value) {
                            //     P03DATATABLEVAR.AMOUNTSAMPLE = int.parse(value);
                            //   },
                            // ),
                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
                              controller: TakePhotoController,
                              focusNode: TakePhotoFocusNode,
                              labelText: "Take photo (Pcs)",
                              icon: Icons.photo_camera,
                              onChanged: (value) {
                                P03DATATABLEVAR.TAKEPHOTO = int.parse(value);
                              },
                            ),

                            // ],

                            buildCustomField(
                              context: P03DATATABLEMAINcontext,
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
                              context: P03DATATABLEMAINcontext,
                              controller: InchargeController,
                              focusNode: InchargeFocusNode,
                              labelText: "Incharge",
                              icon: Icons.person,
                              dropdownItems: P03DATATABLEVAR.dropdownIncharge,
                              onChanged: (value) {
                                P03DATATABLEVAR.INCHARGE = value;
                              },
                            ),
                          ],
                          // buildCustomField(
                          //   context: P03DATATABLEMAINcontext,
                          //   controller: ApprovedDateController,
                          //   focusNode: ApprovedDateFocusNode,
                          //   labelText: "Approved Date",
                          //   icon: Icons.calendar_month_rounded,
                          //   onChanged: (value) {
                          //     P03DATATABLEVAR.APPROVEDDATE = convertStringToDateTime(value).toString();
                          //   },
                          // ),
                          // buildCustomField(
                          //   context: P03DATATABLEMAINcontext,
                          //   controller: ApprovedByController,
                          //   focusNode: ApprovedByFocusNode,
                          //   labelText: "Approved By",
                          //   icon: Icons.assignment,
                          //   dropdownItems: P03DATATABLEVAR.dropdownApprover,
                          //   onChanged: (value) {
                          //     P03DATATABLEVAR.APPROVEDBY = value;
                          //   },
                          // ),
                          if (InstrumentController.text != '')
                            buildCustomFieldforEditData(
                              controller: StatusController,
                              focusNode: StatusFocusNode,
                              labelText: "Status",
                              icon: Icons.info,
                              onChanged: (value) {
                                P03DATATABLEVAR.STATUS = value;
                              },
                            ),
                          // if (StatusController.text != '')

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                CheckSlotAndTimeOverlabToAPI(context);
                                // await showAddConfirmationDialog(
                                //   context: context,
                                //   onConfirm: () async {
                                //     P03DATATABLEVAR.SendAddDataToAPI = jsonEncode(toJsonAddDate());
                                //     // print(P03DATATABLEVAR.SendAddDataToAPI);
                                //     AddDataToAPI();
                                //     // initSocketConnection();
                                //     // sendDataToServer('AddJob');
                                //     // await AddDataToAPI();
                                //     // await initSocketConnection();
                                //     // await sendDataToServer('AddJob');
                                //   },
                                // );
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

Future<void> _fetchCustomerAndIncharge() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final responseCustomer = await Dio().post(
      "$ToServer/02SALTSPRAY/SearchCustomer",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
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
          return true;
        },
      ),
    );
    // print(responseIncharge);
    if (responseIncharge.statusCode == 200 && responseIncharge.data is List) {
      List data = responseIncharge.data;
      P03DATATABLEVAR.dropdownIncharge = data
          .where((item) => item['Roleid'] == 1 || item['Roleid'] == 5)
          .map((item) => item['Name'].toString())
          .where((name) => name.isNotEmpty)
          .toList();
      P03DATATABLEVAR.dropdownApprover = data
          .where((item) => item['Roleid'] == 5 || item['Roleid'] == 10)
          .map((item) => item['Name'].toString())
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
          return true;
        },
      ),
    );

    if (responseHolidays.statusCode == 200 && responseHolidays.data is List) {
      List data = responseHolidays.data;
      holidays = data.map((item) => item['HolidayDate'].toString()).where((name) => name.isNotEmpty).toList();
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

Future<void> _EditDataToAPI() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/EditData",
      data: {
        'dataRow': P03DATATABLEVAR.SendEditDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true;
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

Future<void> _StatJobToAPI() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/StartJob",
      data: {
        'dataRow': P03DATATABLEVAR.SendEditDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true;
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

Future<void> _CancelJobToAPI() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/CancelJob",
      data: {
        'dataRow': P03DATATABLEVAR.SendEditDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true;
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

Future<void> _FinishJobToAPI() async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/FinishJob",
      data: {
        'dataRow': P03DATATABLEVAR.SendEditDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true;
        },
      ),
    );

    if (response.statusCode == 200) {
      P03DATATABLEMAINcontext.read<P03DATATABLEGETDATA_Bloc>().add(P03DATATABLEGETDATA_GET());
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
          return true;
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

Future<void> CheckSlotAndTimeOverlabToAPI(BuildContext context) async {
  try {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    P03DATATABLEVAR.STARTDATE = convertStringToDateTime(StartDateController.text).toString();
    DateTime? startDate = DateTime.tryParse(P03DATATABLEVAR.STARTDATE);

    DateTime? finishDate;
    List<String?> finishDates = [
      P03DATATABLEVAR.FINISHDATE1,
      P03DATATABLEVAR.FINISHDATE2,
      P03DATATABLEVAR.FINISHDATE3,
      P03DATATABLEVAR.FINISHDATE4,
      P03DATATABLEVAR.FINISHDATE5,
      P03DATATABLEVAR.FINISHDATE6,
      P03DATATABLEVAR.FINISHDATE7,
      P03DATATABLEVAR.FINISHDATE8,
      P03DATATABLEVAR.FINISHDATE9,
      P03DATATABLEVAR.FINISHDATE10,
    ];

    for (var dateStr in finishDates.reversed) {
      if (dateStr == null || dateStr.trim().isEmpty) {
        continue;
      }

      finishDate = DateTime.tryParse(dateStr.trim());

      if (finishDate != null) break;
    }

    // print(startDate);
    // print(finishDate);

    if (startDate == null ||
        finishDate == null ||
        P03DATATABLEVAR.CHECKBOX == '' ||
        P03DATATABLEVAR.INSTRUMENT == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('วันที่เริ่มต้น ,สิ้นสุด ,Slot หรือ Instrument ไม่ถูกต้อง'),
      ));
      return;
    }

    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/CheckSlotAndTimeOverlab",
      data: {
        "startDate": startDate.toIso8601String(),
        "finishDate": finishDate.toIso8601String(),
        "checkBox": P03DATATABLEVAR.CHECKBOX,
        "Instrument": P03DATATABLEVAR.INSTRUMENT,
      },
    );

    if (response.statusCode == 200 && response.data['isOverlap'] == false) {
      // print("ไม่ซ้อนกัน");
      await showAddConfirmationDialog(
        context: context,
        onConfirm: () async {
          P03DATATABLEVAR.SendAddDataToAPI = jsonEncode(toJsonAddDate());
          AddDataToAPI();
        },
      );
    } else {
      // print("ซ้อนกัน");
      // print(response.data['overlappedRequests']);
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          title: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
              SizedBox(width: 8),
              Text(
                "ไม่สามารถจองได้",
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ช่วงเวลาและช่อง ${P03DATATABLEVAR.CHECKBOX} นี้มีการจองแล้ว กรุณาเลือกเวลาใหม่",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  "รายการที่ทับซ้อน:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                ...List<Widget>.from(
                  (response.data['overlappedRequests'] as List<dynamic>).map(
                    (req) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 6, color: Colors.redAccent),
                          SizedBox(width: 6),
                          Expanded(child: Text(req.toString(), style: TextStyle(fontSize: 14))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ตกลง", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P03DATATABLEMAINcontext, e.toString());
  } finally {
    Navigator.pop(P03DATATABLEMAINcontext);
  }
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

Future<void> exportToExcel(List<P03DATATABLEGETDATAclass> filteredData) async {
  final workbook = xlsio.Workbook();
  final sheet = workbook.worksheets[0];
  sheet.name = 'SALT SPRAY';

  sheet.importList([
    'Type (SP/SV)',
    'Request No.',
    'Report No.',
    'Section Request',
    'Requester',
    'Sampling Date (dd-MM-yy)',
    'Received Date (dd-MM-yy)',
    'Customer Name',
    'Part Name',
    'Part No.',
    'Lot No.',
    'Amount',
    'Material',
    'Process',
    // 'Amount of sample (Pcs)',
    'Take Photo (Pcs)',
    'Start Date (dd-MM-yy)',
    'Time (Hrs.)',
    'Finish Date (dd-MM-yy)',
    'Temp Report (dd-MM-yy)',
    'Due Report (dd-MM-yy)',
    'Instrument',
    'Method',
    'Person incharge',
    'Approved Date',
    'Approved By',
    'Status',
    'Remark',
  ], 1, 1, false);

  int currentRow = 2;
  final centerStyleHeader = workbook.styles.add('centerStyleHeader');
  centerStyleHeader.hAlign = xlsio.HAlignType.center;
  centerStyleHeader.vAlign = xlsio.VAlignType.center;
  centerStyleHeader.bold = true;
  final centerStyleData = workbook.styles.add('centerStyleData');
  centerStyleData.hAlign = xlsio.HAlignType.center;
  centerStyleData.vAlign = xlsio.VAlignType.center;
  final headerRange = sheet.getRangeByIndex(1, 1, 1, 27);
  headerRange.cellStyle = centerStyleHeader;

  for (var item in filteredData) {
    List<String> partNames = [];
    List<String> partNos = [];
    List<String> lotNos = [];
    List<String> amounts = [];
    List<String> materials = [];
    List<String> processs = [];
    List<String> times = [];
    List<String> finishDates = [];
    // List<String> tempDates = [];
    // List<String> dueDates = [];
    List<String> partNamesBloc = [
      item.PARTNAME1,
      item.PARTNAME2,
      item.PARTNAME3,
      item.PARTNAME4,
      item.PARTNAME5,
      item.PARTNAME6,
      item.PARTNAME7,
      item.PARTNAME8,
      item.PARTNAME9,
      item.PARTNAME10
    ];
    List<String> partNosBloc = [
      item.PARTNO1,
      item.PARTNO2,
      item.PARTNO3,
      item.PARTNO4,
      item.PARTNO5,
      item.PARTNO6,
      item.PARTNO7,
      item.PARTNO8,
      item.PARTNO9,
      item.PARTNO10
    ];
    List<String> lotNosBloc = [
      item.LOTNO1,
      item.LOTNO2,
      item.LOTNO3,
      item.LOTNO4,
      item.LOTNO5,
      item.LOTNO6,
      item.LOTNO7,
      item.LOTNO8,
      item.LOTNO9,
      item.LOTNO10
    ];
    List<String> amountsBloc = [
      item.AMOUNT1,
      item.AMOUNT2,
      item.AMOUNT3,
      item.AMOUNT4,
      item.AMOUNT5,
      item.AMOUNT6,
      item.AMOUNT7,
      item.AMOUNT8,
      item.AMOUNT9,
      item.AMOUNT10
    ];
    List<String> materialsBloc = [
      item.MATERIAL1,
      item.MATERIAL2,
      item.MATERIAL3,
      item.MATERIAL4,
      item.MATERIAL5,
      item.MATERIAL6,
      item.MATERIAL7,
      item.MATERIAL8,
      item.MATERIAL9,
      item.MATERIAL10
    ];
    List<String> processsBloc = [
      item.PROCESS1,
      item.PROCESS2,
      item.PROCESS3,
      item.PROCESS4,
      item.PROCESS5,
      item.PROCESS6,
      item.PROCESS7,
      item.PROCESS8,
      item.PROCESS9,
      item.PROCESS10
    ];
    List<int> timesBloc = [
      item.TIME1,
      item.TIME2,
      item.TIME3,
      item.TIME4,
      item.TIME5,
      item.TIME6,
      item.TIME7,
      item.TIME8,
      item.TIME9,
      item.TIME10
    ];
    List<String> finishDatesBloc = [
      item.FINISHDATE1,
      item.FINISHDATE2,
      item.FINISHDATE3,
      item.FINISHDATE4,
      item.FINISHDATE5,
      item.FINISHDATE6,
      item.FINISHDATE7,
      item.FINISHDATE8,
      item.FINISHDATE9,
      item.FINISHDATE10
    ];
    // List<String> tempDatesBloc = [
    //   item.TEMPDATE1,
    //   item.TEMPDATE2,
    //   item.TEMPDATE3,
    //   item.TEMPDATE4,
    //   item.TEMPDATE5,
    //   item.TEMPDATE6,
    //   item.TEMPDATE7,
    //   item.TEMPDATE8,
    //   item.TEMPDATE9,
    //   item.TEMPDATE10
    // ];
    // List<String> dueDatesBloc = [
    //   item.DUEDATE1,
    //   item.DUEDATE2,
    //   item.DUEDATE3,
    //   item.DUEDATE4,
    //   item.DUEDATE5,
    //   item.DUEDATE6,
    //   item.DUEDATE7,
    //   item.DUEDATE8,
    //   item.DUEDATE9,
    //   item.DUEDATE10
    // ];

    for (int i = 0; i <= 9; i++) {
      final name = partNamesBloc[i];
      final no = partNosBloc[i];
      final lot = lotNosBloc[i];
      final amount = amountsBloc[i];
      final material = materialsBloc[i];
      final process = processsBloc[i];
      final time = timesBloc[i];
      final finish = finishDatesBloc[i];
      // final temp = tempDatesBloc[i];
      // final due = dueDatesBloc[i];

      if (name.toString().trim().isNotEmpty) partNames.add(name);
      if (no.toString().trim().isNotEmpty) partNos.add(no);
      if (lot.toString().trim().isNotEmpty) lotNos.add(lot);
      if (amount.toString().trim().isNotEmpty) amounts.add(amount);
      if (material.toString().trim().isNotEmpty) materials.add(material);
      if (process.toString().trim().isNotEmpty) processs.add(process);
      if (time.toString().trim().isNotEmpty && time != 0) times.add(time.toString());
      if (finish.toString().trim().isNotEmpty) finishDates.add(finish);
      // if (temp.toString().trim().isNotEmpty) tempDates.add(temp);
      // if (due.toString().trim().isNotEmpty) dueDates.add(due);
    }

    int maxRows = [
      partNames.length,
      partNos.length,
      lotNos.length,
      amounts.length,
      materials.length,
      processs.length,
      times.length,
      finishDates.length,
      // tempDates.length,
      // dueDates.length
    ].reduce((a, b) => a > b ? a : b);
    maxRows = maxRows == 0 ? 1 : maxRows;

    for (int i = 0; i < maxRows; i++) {
      sheet.getRangeByIndex(currentRow + i, 9)
        ..setText(i < partNames.length ? partNames[i] : '')
        ..cellStyle = centerStyleData;
      sheet.getRangeByIndex(currentRow + i, 10)
        ..setText(i < partNos.length ? partNos[i] : '')
        ..cellStyle = centerStyleData;
      sheet.getRangeByIndex(currentRow + i, 11)
        ..setText(i < lotNos.length ? lotNos[i] : '')
        ..cellStyle = centerStyleData;
      sheet.getRangeByIndex(currentRow + i, 12)
        ..setText(i < amounts.length ? amounts[i] : '')
        ..cellStyle = centerStyleData;
      sheet.getRangeByIndex(currentRow + i, 13)
        ..setText(i < materials.length ? materials[i] : '')
        ..cellStyle = centerStyleData;
      sheet.getRangeByIndex(currentRow + i, 14)
        ..setText(i < processs.length ? processs[i] : '')
        ..cellStyle = centerStyleData;
      sheet.getRangeByIndex(currentRow + i, 17)
        ..setText(i < times.length ? times[i] : '')
        ..cellStyle = centerStyleData;
      sheet.getRangeByIndex(currentRow + i, 18)
        ..setText(i < finishDates.length ? finishDates[i] : '')
        ..cellStyle = centerStyleData;
      // sheet.getRangeByIndex(currentRow + i, 18)
      //   ..setText(i < tempDates.length ? tempDates[i] : '')
      //   ..cellStyle = centerStyleData;
      // sheet.getRangeByIndex(currentRow + i, 19)
      //   ..setText(i < dueDates.length ? dueDates[i] : '')
      //   ..cellStyle = centerStyleData;
    }

    void mergeAndSet(int col, dynamic value) {
      sheet.getRangeByIndex(currentRow, col, currentRow + maxRows - 1, col).merge();
      sheet.getRangeByIndex(currentRow, col)
        ..setText(value?.toString() ?? '')
        ..cellStyle = centerStyleData;
    }

    mergeAndSet(1, item.TYPE);
    mergeAndSet(2, item.REQUESTNO);
    mergeAndSet(3, item.REPORTNO);
    mergeAndSet(4, item.SECTION);
    mergeAndSet(5, item.REQUESTER);
    mergeAndSet(6, item.SAMPLINGDATE);
    mergeAndSet(7, item.RECEIVEDDATE);
    mergeAndSet(8, item.CUSTOMERNAME);
    // mergeAndSet(10, item.AMOUNTSAMPLE);
    mergeAndSet(15, item.TAKEPHOTO);
    mergeAndSet(16, item.STARTDATE);
    mergeAndSet(19, item.TEMPDATE0);
    mergeAndSet(20, item.DUEDATE0);
    mergeAndSet(21, item.INSTRUMENT);
    mergeAndSet(22, item.METHOD);
    mergeAndSet(23, item.INCHARGE);
    mergeAndSet(24, item.APPROVEDDATE);
    mergeAndSet(25, item.APPROVEDBY);
    mergeAndSet(26, item.STATUS);
    mergeAndSet(27, item.REMARK);

    currentRow += maxRows;
  }

  for (int col = 1; col <= 27; col++) {
    sheet.autoFitColumn(col);
  }

  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  if (kIsWeb) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "SaltSprayExport.xlsx")
      ..click();
    html.Url.revokeObjectUrl(url);
  } else {
    if (await Permission.storage.request().isGranted) {
      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/SaltSprayExport.xlsx';
      final file = io.File(path);
      await file.writeAsBytes(bytes, flush: true);
      print('Saved to $path');
    }
  }
}
