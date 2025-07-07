// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, library_private_types_in_public_api, use_build_context_synchronously, avoid_print, unrelated_type_equality_checks, unnecessary_null_comparison
import 'dart:async';
import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/ForUseAllPage.dart';
import '../../widget/function/Socket.dart';
import '../page2.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'P01DASHBOARDVAR.dart';

// late IO.Socket socket;
late BuildContext P01DASHBOARDMAINcontext;
Timer? timer;
Timer? timerRefreshUI;
// late P01DASHBOARDGETDATA_Bloc dashboardBloc;
List<Map<String, String>> SSTAllData = [];
List<Map<String, String>> ForAlarm = [];

class P01DASHBOARDMAIN extends StatefulWidget {
  P01DASHBOARDMAIN({
    super.key,
    this.data,
  });
  List<P01DASHBOARDGETDATAclass>? data;

  @override
  State<P01DASHBOARDMAIN> createState() => _P01DASHBOARDMAINState();
}

class _P01DASHBOARDMAINState extends State<P01DASHBOARDMAIN> {
  @override
  void initState() {
    super.initState();
    // context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET2());
    fetchInstrumentData();
    context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
    // dashboardBloc = context.read<P01DASHBOARDGETDATA_Bloc>();
    StartDateToDateTimeGlobal = DateTime.now();
    timer?.cancel();
    startChecking(context);
    timerRefreshUI = Timer.periodic(Duration(seconds: 5), (timer) {
      // print('refresh...');
      context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
    });
    selectpage = '';
    selectstatus = '';
    selectslot.text = '';
    PageName = 'SALT SPRAY MONITORING SYSTEM';
  }

  @override
  void dispose() {
    timerRefreshUI?.cancel();
    // socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    P01DASHBOARDMAINcontext = context;
    List<P01DASHBOARDGETDATAclass> _datain = widget.data ?? [];

    DateTime checkDate = StartDateToDateTimeGlobal;
    // print(checkDate);
    ForAlarm = _datain.map((e) => toMap(e)).toList();
    // print(ForAlarm);
    List<P01DASHBOARDGETDATAclass> AllSSTCheckBox = _datain.where((data) {
      DateTime? start;
      DateTime? finish;

      try {
        start = data.STARTDATE != null ? convertStringToDateTime(data.STARTDATE) : null;
        // print(data.STARTDATE);

        List<String?> finishDateStrings = [
          data.FINISHDATE1,
          data.FINISHDATE2,
          data.FINISHDATE3,
          data.FINISHDATE4,
          data.FINISHDATE5,
          data.FINISHDATE6,
          data.FINISHDATE7,
          data.FINISHDATE8,
          data.FINISHDATE9,
          data.FINISHDATE10,
        ];

        for (var dateStr in finishDateStrings.reversed) {
          if (dateStr != null && dateStr.trim().isNotEmpty) {
            finish = convertStringToDateTime(dateStr);
            break;
          }
        }
        // print(finish);
      } catch (e) {
        print("Error parsing date: $e");
        return false;
      }

      if (start == null || finish == null) return false;
      // print(!checkDate.isBefore(start) && !checkDate.isAfter(finish));

      return !checkDate.isBefore(start) && !checkDate.isAfter(finish);
    }).toList();

    // print(AllSSTCheckBox.length);

    // List<P01DASHBOARDGETDATAclass> AllSSTCheckBox = _datain.toList();
    List<P01DASHBOARDGETDATAclass> allSST1DataBloc = AllSSTCheckBox.where((item) =>
        item.INSTRUMENT == 'SST No.1' &&
        (item.STATUS == 'START' || item.STATUS == 'WAIT TRANSFER' || item.STATUS == 'RECEIVED')).toList();
    List<P01DASHBOARDGETDATAclass> allSST2DataBloc = AllSSTCheckBox.where((item) =>
        item.INSTRUMENT == 'SST No.2' &&
        (item.STATUS == 'START' || item.STATUS == 'WAIT TRANSFER' || item.STATUS == 'RECEIVED')).toList();
    List<P01DASHBOARDGETDATAclass> allSST3DataBloc = AllSSTCheckBox.where((item) =>
        item.INSTRUMENT == 'SST No.3' &&
        (item.STATUS == 'START' || item.STATUS == 'WAIT TRANSFER' || item.STATUS == 'RECEIVED')).toList();
    List<P01DASHBOARDGETDATAclass> allSST4DataBloc = AllSSTCheckBox.where((item) =>
        item.INSTRUMENT == 'SST No.4' &&
        (item.STATUS == 'START' || item.STATUS == 'WAIT TRANSFER' || item.STATUS == 'RECEIVED')).toList();

    // PageName = 'Dashboard';
    SSTAllData.clear();
    List<Map<String, String>> allSST1Data = [];
    List<Map<String, String>> allSST2Data = [];
    List<Map<String, String>> allSST3Data = [];
    List<Map<String, String>> allSST4Data = [];
    List<Map<String, String>> receivedSST1Data = [];
    List<Map<String, String>> receivedSST2Data = [];
    List<Map<String, String>> receivedSST3Data = [];
    List<Map<String, String>> receivedSST4Data = [];
    List<int> receivedCheckboxSST1 = [];
    List<int> receivedCheckboxSST2 = [];
    List<int> receivedCheckboxSST3 = [];
    List<int> receivedCheckboxSST4 = [];
    List<int> allCheckboxSST1 = [];
    List<int> allCheckboxSST2 = [];
    List<int> allCheckboxSST3 = [];
    List<int> allCheckboxSST4 = [];
    // print(PageName);
    for (var data in AllSSTCheckBox) {
      if (data.INSTRUMENT == 'SST No.1' && (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER')) {
        receivedSST1Data.add(toMap2(data));
      } else if (data.INSTRUMENT == 'SST No.2' &&
          (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER')) {
        receivedSST2Data.add(toMap2(data));
      } else if (data.INSTRUMENT == 'SST No.3' &&
          (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER')) {
        receivedSST3Data.add(toMap2(data));
      } else if (data.INSTRUMENT == 'SST No.4' &&
          (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER')) {
        receivedSST4Data.add(toMap2(data));
      }
      if (data.INSTRUMENT == 'SST No.1' &&
          (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER' || data.STATUS == 'RECEIVED')) {
        allSST1Data.add(toMap(data));
        SSTAllData.add(toMap(data));
      }
      if (data.INSTRUMENT == 'SST No.2' &&
          (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER' || data.STATUS == 'RECEIVED')) {
        allSST2Data.add(toMap(data));
        SSTAllData.add(toMap(data));
      }
      if (data.INSTRUMENT == 'SST No.3' &&
          (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER' || data.STATUS == 'RECEIVED')) {
        allSST3Data.add(toMap(data));
        SSTAllData.add(toMap(data));
      }
      if (data.INSTRUMENT == 'SST No.4' &&
          (data.STATUS == 'START' || data.STATUS == 'WAIT TRANSFER' || data.STATUS == 'RECEIVED')) {
        allSST4Data.add(toMap(data));
        SSTAllData.add(toMap(data));
      }
      // print(SSTAllData.length);
    }

    for (var item in allSST1Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        receivedCheckboxSST1.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER' ||
          item['STATUS'] == 'RECEIVED') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in allSST2Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        receivedCheckboxSST2.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER' ||
          item['STATUS'] == 'RECEIVED') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in allSST3Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        receivedCheckboxSST3.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER' ||
          item['STATUS'] == 'RECEIVED') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in allSST4Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        receivedCheckboxSST4.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty && item['STATUS'] == 'START' ||
          item['STATUS'] == 'WAIT TRANSFER' ||
          item['STATUS'] == 'RECEIVED') {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    receivedCheckboxSST1.sort();
    receivedCheckboxSST2.sort();
    receivedCheckboxSST3.sort();
    receivedCheckboxSST4.sort();

    final double percentageSST1 = (receivedCheckboxSST1.length / 122) * 100;
    final double percentageSST2 = (receivedCheckboxSST2.length / 122) * 100;
    final double percentageSST3 = (receivedCheckboxSST3.length / 122) * 100;
    final double percentageSST4 = (receivedCheckboxSST4.length / 122) * 100;
    final double allPercentageSST1 = (allCheckboxSST1.length / 122) * 100;
    final double allPercentageSST2 = (allCheckboxSST2.length / 122) * 100;
    final double allPercentageSST3 = (allCheckboxSST3.length / 122) * 100;
    final double allPercentageSST4 = (allCheckboxSST4.length / 122) * 100;

    String? lastMethodSST1 = '';
    String? lastMethodSST2 = '';
    String? lastMethodSST3 = '';
    String? lastMethodSST4 = '';

    if (allSST1Data.isNotEmpty) {
      lastMethodSST1 = allSST1Data.last['METHOD'];
    }
    if (allSST2Data.isNotEmpty) {
      lastMethodSST2 = allSST2Data.last['METHOD'];
    }
    if (allSST3Data.isNotEmpty) {
      lastMethodSST3 = allSST3Data.last['METHOD'];
    }
    if (allSST4Data.isNotEmpty) {
      lastMethodSST4 = allSST4Data.last['METHOD'];
    }

    // print(lastMethodSST1);
    // print(lastMethodSST2);
    // print(lastMethodSST3);
    // print(lastMethodSST4);

    // convertPrintMap(SSTAllData);
    // startChecking(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        MainBodyContext.read<ChangePage_Bloc>()
                            .ChangePage_nodrower('Salt Spray Tester : SST No.1', Page2());
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.blueGrey[100],
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.1",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Image.asset(
                                        "assets/images/Salt-Spray-Machine.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (P01DASHBOARDVAR.SST1Status.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BlinkingStatusButton(
                                        data: P01DASHBOARDVAR.SST1Status,
                                        instrument: "SST No.1",
                                        allSSTDataBloc: allSST1DataBloc,
                                        onStatusChanged: () {
                                          setState(() {});
                                        },
                                      ),
                                      if (P01DASHBOARDVAR.SST1Status == 'Instrument Breakdown')
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>()
                                                .add(P01DASHBOARDGETDATA_GET());
                                            showTableDialog(context, allSST1DataBloc, onConfirm: () {
                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(Icons.sync_alt, size: 15, color: Colors.white),
                                          label: Text('Transfer',
                                              style: TextStyle(fontSize: 10, color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber[700],
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 5,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              Positioned(
                                top: 120,
                                right: 270,
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    CircularPercentIndicator(
                                      animation: true,
                                      animationDuration: 1200,
                                      radius: 60.0,
                                      lineWidth: 14.0,
                                      percent: percentageSST1 / 100,
                                      center: Text(
                                        "${percentageSST1.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4.0,
                                              color: Colors.black.withOpacity(0.3),
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.orange[100]!,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF2196F3),
                                          Color(0xFF21CBF3),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.green, width: 1.5),
                                      ),
                                      child: Text(
                                        "${receivedCheckboxSST1.length} / 122 Slots",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 110,
                                right: 240,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: LinearPercentIndicator(
                                      width: 135.0,
                                      lineHeight: 15.0,
                                      percent: allPercentageSST1 / 100,
                                      backgroundColor: Colors.orange[100]!,
                                      progressColor: Colors.green,
                                      animation: true,
                                      animationDuration: 1000,
                                      barRadius: Radius.circular(10),
                                      center: Text(
                                        "${allPercentageSST1.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   Currently in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   All in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    spacing: 30,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          "${receivedSST1Data.length} Requests",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            letterSpacing: 1.2,
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST1!.isNotEmpty ? lastMethodSST1 : 'Method',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
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
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  'Mr.Parkpoom Kongprasit: 061-389-0471\nWitchuda Kaewcharoensuk: 02-3246600',
                                  style: TextStyle(fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        MainBodyContext.read<ChangePage_Bloc>()
                            .ChangePage_nodrower('Salt Spray Tester : SST No.2', Page2());
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.blueGrey[100],
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.2",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Image.asset(
                                        "assets/images/Salt-Spray-Machine.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (P01DASHBOARDVAR.SST2Status.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BlinkingStatusButton(
                                        data: P01DASHBOARDVAR.SST2Status,
                                        instrument: "SST No.2",
                                        allSSTDataBloc: allSST2DataBloc,
                                        onStatusChanged: () {
                                          setState(() {});
                                        },
                                      ),
                                      if (P01DASHBOARDVAR.SST2Status == 'Instrument Breakdown')
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>()
                                                .add(P01DASHBOARDGETDATA_GET());
                                            showTableDialog(context, allSST2DataBloc, onConfirm: () {
                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(Icons.sync_alt, size: 15, color: Colors.white),
                                          label: Text('Transfer',
                                              style: TextStyle(fontSize: 10, color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber[700],
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 5,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              Positioned(
                                top: 120,
                                right: 270,
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    CircularPercentIndicator(
                                      animation: true,
                                      animationDuration: 1200,
                                      radius: 60.0,
                                      lineWidth: 14.0,
                                      percent: percentageSST2 / 100,
                                      center: Text(
                                        "${percentageSST2.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4.0,
                                              color: Colors.black.withOpacity(0.3),
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.orange[100]!,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF2196F3),
                                          Color(0xFF21CBF3),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.green, width: 1.5),
                                      ),
                                      child: Text(
                                        "${receivedCheckboxSST2.length} / 122 Slots",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 110,
                                right: 240,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: LinearPercentIndicator(
                                      width: 135.0,
                                      lineHeight: 15.0,
                                      percent: allPercentageSST2 / 100,
                                      backgroundColor: Colors.orange[100]!,
                                      progressColor: Colors.green,
                                      animation: true,
                                      animationDuration: 1000,
                                      barRadius: Radius.circular(10),
                                      center: Text(
                                        "${allPercentageSST2.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   Currently in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   All in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    spacing: 30,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          "${receivedSST2Data.length} Requests",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            letterSpacing: 1.2,
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST2!.isNotEmpty ? lastMethodSST2 : 'Method',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            letterSpacing: 1.2,
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  'Mr.Parkpoom Kongprasit: 061-389-0471\nWitchuda Kaewcharoensuk: 02-3246600',
                                  style: TextStyle(fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        MainBodyContext.read<ChangePage_Bloc>()
                            .ChangePage_nodrower('Salt Spray Tester : SST No.3', Page2());
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.blueGrey[100],
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.3",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Image.asset(
                                        "assets/images/Salt-Spray-Machine.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (P01DASHBOARDVAR.SST3Status.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BlinkingStatusButton(
                                        data: P01DASHBOARDVAR.SST3Status,
                                        instrument: 'SST No.3',
                                        allSSTDataBloc: allSST3DataBloc,
                                        onStatusChanged: () {
                                          setState(() {});
                                        },
                                      ),
                                      if (P01DASHBOARDVAR.SST3Status == 'Instrument Breakdown')
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>()
                                                .add(P01DASHBOARDGETDATA_GET());
                                            showTableDialog(context, allSST3DataBloc, onConfirm: () {
                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(Icons.sync_alt, size: 15, color: Colors.white),
                                          label: Text('Transfer',
                                              style: TextStyle(fontSize: 10, color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber[700],
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 5,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              Positioned(
                                top: 120,
                                right: 270,
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    CircularPercentIndicator(
                                      animation: true,
                                      animationDuration: 1200,
                                      radius: 60.0,
                                      lineWidth: 14.0,
                                      percent: percentageSST3 / 100,
                                      center: Text(
                                        "${percentageSST3.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4.0,
                                              color: Colors.black.withOpacity(0.3),
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.orange[100]!,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF2196F3),
                                          Color(0xFF21CBF3),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.green, width: 1.5),
                                      ),
                                      child: Text(
                                        "${receivedCheckboxSST3.length} / 122 Slots",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 110,
                                right: 240,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: LinearPercentIndicator(
                                      width: 135.0,
                                      lineHeight: 15.0,
                                      percent: allPercentageSST3 / 100,
                                      backgroundColor: Colors.orange[100]!,
                                      progressColor: Colors.green,
                                      animation: true,
                                      animationDuration: 1000,
                                      barRadius: Radius.circular(10),
                                      center: Text(
                                        "${allPercentageSST3.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   Currently in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   All in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    spacing: 30,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          "${receivedSST3Data.length} Requests",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            letterSpacing: 1.2,
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST3!.isNotEmpty ? lastMethodSST3 : 'Method',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            letterSpacing: 1.2,
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  'Mr.Parkpoom Kongprasit: 061-389-0471\nWitchuda Kaewcharoensuk: 02-3246600',
                                  style: TextStyle(fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        MainBodyContext.read<ChangePage_Bloc>()
                            .ChangePage_nodrower('Salt Spray Tester : SST No.4', Page2());
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.blueGrey[100],
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.4",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Image.asset(
                                        "assets/images/Salt-Spray-Machine.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (P01DASHBOARDVAR.SST4Status.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BlinkingStatusButton(
                                        data: P01DASHBOARDVAR.SST4Status,
                                        instrument: 'SST No.4',
                                        allSSTDataBloc: allSST4DataBloc,
                                        onStatusChanged: () {
                                          setState(() {});
                                        },
                                      ),
                                      if (P01DASHBOARDVAR.SST4Status == 'Instrument Breakdown')
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>()
                                                .add(P01DASHBOARDGETDATA_GET());
                                            showTableDialog(context, allSST4DataBloc, onConfirm: () {
                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(Icons.sync_alt, size: 15, color: Colors.white),
                                          label: Text('Transfer',
                                              style: TextStyle(fontSize: 10, color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber[700],
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 5,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              Positioned(
                                top: 120,
                                right: 270,
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    CircularPercentIndicator(
                                      animation: true,
                                      animationDuration: 1200,
                                      radius: 60.0,
                                      lineWidth: 14.0,
                                      percent: percentageSST4 / 100,
                                      center: Text(
                                        "${percentageSST4.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4.0,
                                              color: Colors.black.withOpacity(0.3),
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.orange[100]!,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF2196F3),
                                          Color(0xFF21CBF3),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.green, width: 1.5),
                                      ),
                                      child: Text(
                                        "${receivedCheckboxSST4.length} / 122 Slots",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 110,
                                right: 240,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: LinearPercentIndicator(
                                      width: 135.0,
                                      lineHeight: 15.0,
                                      percent: allPercentageSST4 / 100,
                                      backgroundColor: Colors.orange[100]!,
                                      progressColor: Colors.green,
                                      animation: true,
                                      animationDuration: 1000,
                                      barRadius: Radius.circular(10),
                                      center: Text(
                                        "${allPercentageSST4.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   Currently in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 10,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Text('=   All in use',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    spacing: 30,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          "${receivedSST4Data.length} Requests",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            letterSpacing: 1.2,
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST4!.isNotEmpty ? lastMethodSST4 : 'Method',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            letterSpacing: 1.2,
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  'Mr.Parkpoom Kongprasit: 061-389-0471\nWitchuda Kaewcharoensuk: 02-3246600',
                                  style: TextStyle(fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> fetchInstrumentData() async {
  try {
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/InstrumentStatus",
      data: {},
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      var databuff = response.data;
      P01DASHBOARDVAR.SST1Status = databuff[0]['Status'];
      P01DASHBOARDVAR.SST2Status = databuff[1]['Status'];
      P01DASHBOARDVAR.SST3Status = databuff[2]['Status'];
      P01DASHBOARDVAR.SST4Status = databuff[3]['Status'];
      // Navigator.pop(P01DASHBOARDMAINcontext);
    } else {
      // Navigator.pop();
      showErrorPopup(P01DASHBOARDMAINcontext, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P01DASHBOARDMAINcontext, e.toString());
  } finally {
    // Navigator.pop(P01DASHBOARDMAINcontext);
  }
}

Future<void> SendStatusInstrument(String Instrument, String Status) async {
  try {
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/EditInstrumentStatus",
      data: {
        'Instrument': Instrument,
        'Status': Status,
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      // Navigator.pop(P01DASHBOARDMAINcontext);
    } else {
      // Navigator.pop();
      showErrorPopup(P01DASHBOARDMAINcontext, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P01DASHBOARDMAINcontext, e.toString());
  } finally {
    // Navigator.pop(P01DASHBOARDMAINcontext);
  }
}

Future<void> SendStatusJob(String Instrument, String Status) async {
  try {
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/EditStatusJob",
      data: {
        'Instrument': Instrument,
        'Status': Status,
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      // Navigator.pop(P01DASHBOARDMAINcontext);
    } else {
      // Navigator.pop();
      showErrorPopup(P01DASHBOARDMAINcontext, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P01DASHBOARDMAINcontext, e.toString());
  } finally {
    // Navigator.pop(P01DASHBOARDMAINcontext);
  }
}

class BlinkingStatusButton extends StatefulWidget {
  const BlinkingStatusButton(
      {super.key, this.data, this.instrument, required this.allSSTDataBloc, required this.onStatusChanged});
  final dynamic data;
  final String? instrument;
  final List<P01DASHBOARDGETDATAclass> allSSTDataBloc;
  final VoidCallback onStatusChanged;

  @override
  _BlinkingStatusButtonState createState() => _BlinkingStatusButtonState();
}

class _BlinkingStatusButtonState extends State<BlinkingStatusButton> {
  bool _isFadingOut = true;
  String? _currentStatus;

  @override
  void initState() {
    super.initState();
    if (widget.data != null && widget.data is String) {
      _currentStatus = widget.data;
    } else {
      _currentStatus = 'Instrument Breakdown'; // default
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (_currentStatus) {
        case 'Running':
          return Colors.green;
        case 'Instrument Breakdown':
          return Colors.red;
        case 'PM':
          return Colors.blue;
        default:
          return Colors.grey;
      }
    }

    String getStatusText() {
      switch (_currentStatus) {
        case 'Running':
          return "Running...";
        case 'Instrument Breakdown':
          return "Instrument Breakdown";
        case 'PM':
          return "Preventive maintenance";
        default:
          return "Unknown";
      }
    }

    return GestureDetector(
      onTap: () async {
        if (USERDATA.UserLV >= 5) {
          showChangeStatusDialog(context, (selectedStatus) async {
            if (selectedStatus == 'Running') {
              await showInstrumentbreakdownDialog(
                context: context,
                onConfirm: () async {
                  setState(() {
                    _currentStatus = 'Running';
                  });
                  await SendStatusInstrument(widget.instrument ?? '', 'Running');
                  await fetchInstrumentData();
                  await SendStatusJob(widget.instrument ?? '', 'RECEIVED');
                  Navigator.pop(context);
                  widget.onStatusChanged();
                  context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
                },
              );
            } else if (selectedStatus == 'Instrument Breakdown') {
              await showInstrumentbreakdownDialog(
                context: context,
                onConfirm: () async {
                  setState(() {
                    _currentStatus = 'Instrument Breakdown';
                  });
                  await SendStatusInstrument(widget.instrument ?? '', 'Instrument Breakdown');
                  await fetchInstrumentData();
                  await SendStatusJob(widget.instrument ?? '', 'WAIT TRANSFER');
                  Navigator.pop(context);
                  widget.onStatusChanged();
                  context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
                },
              );
            } else if (selectedStatus == 'PM') {
              await showInstrumentbreakdownDialog(
                context: context,
                onConfirm: () async {
                  setState(() {
                    _currentStatus = 'PM';
                  });
                  await SendStatusInstrument(widget.instrument ?? '', 'PM');
                  await fetchInstrumentData();
                  Navigator.pop(context);
                  widget.onStatusChanged();
                  context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
                },
              );
            }
          });
        }
      },
      child: Row(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: _isFadingOut ? 1.0 : 0.2, end: _isFadingOut ? 0.2 : 1.0),
            duration: const Duration(milliseconds: 800),
            onEnd: () {
              setState(() {
                _isFadingOut = !_isFadingOut;
              });
            },
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: getStatusColor(),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              const Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                getStatusText(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _currentStatus == 'Instrument Breakdown'
                      ? Colors.red[800]
                      : (_currentStatus == 'PM' ? Colors.blue[800] : Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void startChecking(BuildContext context) {
  // print('startChecking...');
  checkForNotification(context);
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    checkForNotification(context);
  });
}

void checkForNotification(BuildContext context) {
  final now = DateTime.now();
  // print(ForAlarm);
  // print('in Checking...');
  for (var item in ForAlarm) {
    // print('repeat...');
    int totalFinishDates = countNonEmptyFinishDates(item);

    if (item['STATUS'] == 'RECEIVED' && item['STARTDATE'] != null && item['STARTDATE']!.isNotEmpty) {
      try {
        DateTime startDate = DateFormat('dd-MM-yy HH:mm').parse(item['STARTDATE']!);
        final difference = now.difference(startDate).inSeconds;
        if (difference >= (1799.5) && difference <= (1800)) {
          showAlert(context, item['INSTRUMENT']!, item['CUSTOMERNAME']!, item['STARTDATE']!,
              item['CHECKBOX']!, "กรุณานำงานเข้า", 0, "รอนำงานเข้า");
          continue;
        }
      } catch (e) {
        print('Error parsing STARTDATE: ${item['STARTDATE']}');
      }
    }

    for (int i = 1; i <= 10; i++) {
      String key = 'FINISHDATE$i';
      String? dateString = item[key];
      if (dateString != null && dateString.isNotEmpty) {
        try {
          DateTime finishDate = DateFormat('dd-MM-yy HH:mm').parse(dateString);
          final difference = finishDate.difference(now).inSeconds;
          // print(now);
          // print(finishDate);
          // print(difference);
          if (difference >= (1799.5) && difference <= (1800)) {
            double percentage = (i / totalFinishDates) * 100;
            if (i == 10) {
              showAlert(context, item['INSTRUMENT']!, item['CUSTOMERNAME']!, item[key]!, item['CHECKBOX']!,
                  "ถึงเวลาเอางานออก", percentage, "ครบแล้ว");
              break;
            } else {
              String key2 = 'FINISHDATE${i + 1}';
              String? dateString2 = item[key2];

              if (dateString2 == null || dateString2.isEmpty) {
                showAlert(context, item['INSTRUMENT']!, item['CUSTOMERNAME']!, item[key]!, item['CHECKBOX']!,
                    "ถึงเวลาเอางานออก", percentage, "ครบแล้ว");
                break;
              } else {
                showAlert(context, item['INSTRUMENT']!, item['CUSTOMERNAME']!, item[key]!, item['CHECKBOX']!,
                    "หยุดครั้งที่ $i / $totalFinishDates", percentage, item[key2]!);
                break;
              }
            }
          }
        } catch (e) {
          print('Error parsing date: $dateString');
        }
      }
    }
  }
}

int countNonEmptyFinishDates(Map<String, String> item) {
  int count = 0;
  for (int i = 1; i <= 10; i++) {
    String key = 'FINISHDATE$i';
    String? value = item[key];
    if (value != null && value.isNotEmpty) {
      count++;
    }
  }
  return count;
}

void showAlert(BuildContext context, String instrument, String customerName, String finishDate,
    String checkbox, String StopFinish, double percentage, String NextFinish) {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  bool isMuted = false;
  bool isPlaying = true;

  void startAlarm() {
    _audioPlayer.open(
      Audio('assets/alertalarm/alarm.wav'),
      autoStart: true,
      loopMode: LoopMode.single,
      showNotification: false,
    );
  }

  void stopAlarm() {
    _audioPlayer.stop();
    isPlaying = false;
  }

  startAlarm();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    List<bool> selectedTickets = List.generate(18 * 4, (index) => false);
    List<bool> selectedTickets2 = List.generate(18 * 4, (index2) => false);
    List<int> selectedTicketIndexes = [];
    List<int> UseBoxAlarm = [];
    List<String> CheckBox = checkbox.split(',');
    UseBoxAlarm.addAll(CheckBox.map((e) => int.parse(e)).toList());

    // print(percentage / 100);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  Icon(Icons.notifications_active, size: 50, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    StopFinish,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: Center(
                      child: LinearPercentIndicator(
                        lineHeight: 20.0,
                        percent: (percentage / 100).clamp(0.0, 1.0),
                        backgroundColor: Colors.orange[100]!,
                        progressColor: Colors.green,
                        animation: true,
                        animationDuration: 1000,
                        barRadius: const Radius.circular(10),
                        center: Text(
                          "${percentage.toStringAsFixed(1)}%",
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
                  ),
                  Text(' กรุณาตรวจสอบชิ้นงานดังรูปภาพข้างล่าง !!!',
                      style: TextStyle(fontSize: 24, color: Colors.black)),
                  Spacer(),
                  IconButton(
                    icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                    onPressed: () {
                      setState(() {
                        isMuted = !isMuted;
                        if (isMuted) {
                          stopAlarm();
                        } else if (!isPlaying) {
                          startAlarm();
                        }
                      });
                    },
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Text('ชื่อลูกค้า:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 50,
                        ),
                        Text(customerName, style: TextStyle(fontSize: 14)),
                        SizedBox(
                          width: 50,
                        ),
                        Text('เวลา: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(finishDate, style: TextStyle(fontSize: 14)),
                        SizedBox(
                          width: 50,
                        ),
                        Text('ที่: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(instrument, style: TextStyle(fontSize: 14)),
                        SizedBox(
                          width: 50,
                        ),
                        Text('หยุดครั้งถัดไป: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(NextFinish, style: TextStyle(fontSize: 14)),
                      ],
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
                                        color: Colors.purpleAccent,
                                        border: Border.all(color: Colors.green, width: 1),
                                      ),
                                    ),
                                    Text('=   WORK PIECE', style: TextStyle(color: Colors.white)),
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
                                  bool isTealDisabled = UseBoxAlarm.contains(index + 1);
                                  bool isBlackDisabled =
                                      [1, 5, 9, 36, 40, 44, 48, 52, 61, 65, 69].contains(index + 1);
                                  return Container(
                                    margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: isBlackDisabled
                                          ? Colors.black
                                          : (isTealDisabled
                                              ? Colors.purpleAccent
                                              : (index < selectedTickets.length && selectedTickets[index]
                                                  ? Colors.yellow
                                                  : Colors.green.withOpacity(0.5))),
                                      border: Border.all(color: Colors.green, width: 1),
                                    ),
                                    child: InkWell(
                                      onTap: (isTealDisabled || isBlackDisabled)
                                          ? null
                                          : () {
                                              if (index < selectedTickets.length) {
                                                setState(() {
                                                  selectedTickets[index] = !selectedTickets[index];
                                                  int realIndex = index + 1;

                                                  if (selectedTickets[index]) {
                                                    if (!selectedTicketIndexes.contains(realIndex)) {
                                                      selectedTicketIndexes.add(realIndex);
                                                    }
                                                  } else {
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
                                  bool isTealDisabled = UseBoxAlarm.contains(index2 + 73);

                                  bool isBlackDisabled = [76, 80, 84, 105, 109, 113, 117, 121, 136, 140, 144]
                                      .contains(index2 + 73);

                                  return Container(
                                    margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: isBlackDisabled
                                          ? Colors.black
                                          : (isTealDisabled
                                              ? Colors.purpleAccent
                                              : (selectedTickets2[index2]
                                                  ? Colors.yellow
                                                  : Colors.green.withOpacity(0.5))),
                                      border: Border.all(color: Colors.green, width: 1),
                                    ),
                                    child: InkWell(
                                      onTap: (isTealDisabled || isBlackDisabled)
                                          ? null
                                          : () {
                                              setState(() {
                                                selectedTickets2[index2] = !selectedTickets2[index2];
                                                int realIndex = index2 + 73;

                                                if (selectedTickets2[index2]) {
                                                  if (!selectedTicketIndexes.contains(realIndex)) {
                                                    selectedTicketIndexes.add(realIndex);
                                                  }
                                                } else {
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
                          Positioned(
                            bottom: 70,
                            right: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                stopAlarm();
                                sendDataToServer('Close popup');
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
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
          },
        );
      },
    );
  });
}

void showTableDialog(BuildContext context, List<P01DASHBOARDGETDATAclass> allSSTDataBloc,
    {required Null Function() onConfirm}) {
  // print(allSSTDataBloc);
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (allSSTDataBloc.isEmpty) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 48,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ไม่พบข้อมูลใน Instrument นี้',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('ปิด'),
                  ),
                ],
              );
            }
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'All jobs in ${allSSTDataBloc[0].INSTRUMENT}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DataTable(
                    columnSpacing: 30,
                    headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    columns: const [
                      DataColumn(label: Text('Request No.')),
                      DataColumn(label: Text('Transfer')),
                    ],
                    rows: allSSTDataBloc.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data.REQUESTNO)),
                          DataCell(
                            ElevatedButton(
                              onPressed: () async {
                                await _fetchCustomerAndIncharge();
                                P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>()
                                    .add(P01DASHBOARDGETDATA_GET());
                                final result = await showEditDialog(P01DASHBOARDMAINcontext, data);

                                if (result == true) {
                                  onConfirm();
                                  Navigator.of(context).pop();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[700],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              child: const Text('Transfer'),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'ปิด',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      });
}

Future<void> showInstrumentbreakdownDialog({
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
            Text('ยืนยัน Status Instrument?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะเปลี่ยน Status ของ Instrument หรือไม่?',
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
              Navigator.of(context).pop();
              onConfirm();
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

Future<bool?> showEditDialog(BuildContext context, P01DASHBOARDGETDATAclass item) async {
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
  final FocusNode CheckBoxFocusNode = FocusNode();

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
  // TextEditingController CheckBoxController = TextEditingController(text: item.CHECKBOX);

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
  // void updateMultipleDatesAll() {
  //   updateMultipleDates({
  //     ReceivedDateController: (val) => item.RECEIVEDDATE = val,
  //     StartDateController: (val) => item.STARTDATE = val,
  //     FinishDate1Controller: (val) => item.FINISHDATE1 = val,
  //     FinishDate2Controller: (val) => item.FINISHDATE2 = val,
  //     FinishDate3Controller: (val) => item.FINISHDATE3 = val,
  //     FinishDate4Controller: (val) => item.FINISHDATE4 = val,
  //     FinishDate5Controller: (val) => item.FINISHDATE5 = val,
  //     FinishDate6Controller: (val) => item.FINISHDATE6 = val,
  //     FinishDate7Controller: (val) => item.FINISHDATE7 = val,
  //     FinishDate8Controller: (val) => item.FINISHDATE8 = val,
  //     FinishDate9Controller: (val) => item.FINISHDATE9 = val,
  //     FinishDate10Controller: (val) => item.FINISHDATE10 = val,
  //     TempDate1Controller: (val) => item.TEMPDATE1 = val,
  //     TempDate2Controller: (val) => item.TEMPDATE2 = val,
  //     TempDate3Controller: (val) => item.TEMPDATE3 = val,
  //     TempDate4Controller: (val) => item.TEMPDATE4 = val,
  //     TempDate5Controller: (val) => item.TEMPDATE5 = val,
  //     TempDate6Controller: (val) => item.TEMPDATE6 = val,
  //     TempDate7Controller: (val) => item.TEMPDATE7 = val,
  //     TempDate8Controller: (val) => item.TEMPDATE8 = val,
  //     TempDate9Controller: (val) => item.TEMPDATE9 = val,
  //     TempDate10Controller: (val) => item.TEMPDATE10 = val,
  //     DueDate1Controller: (val) => item.DUEDATE1 = val,
  //     DueDate2Controller: (val) => item.DUEDATE2 = val,
  //     DueDate3Controller: (val) => item.DUEDATE3 = val,
  //     DueDate4Controller: (val) => item.DUEDATE4 = val,
  //     DueDate5Controller: (val) => item.DUEDATE5 = val,
  //     DueDate6Controller: (val) => item.DUEDATE6 = val,
  //     DueDate7Controller: (val) => item.DUEDATE7 = val,
  //     DueDate8Controller: (val) => item.DUEDATE8 = val,
  //     DueDate9Controller: (val) => item.DUEDATE9 = val,
  //     DueDate10Controller: (val) => item.DUEDATE10 = val,
  //     ApprovedDateController: (val) => item.APPROVEDDATE = val,
  //   });
  // }

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
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
              Stack(
                children: [
                  Center(
                    child: Text(
                      'Transfer: ${item.REQUESTNO}',
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
                        context: P01DASHBOARDMAINcontext,
                        controller: TypeController,
                        focusNode: TypeFocusNode,
                        labelText: "Type",
                        icon: Icons.account_tree,
                        dropdownItems: ['Service lab', 'Special request'],
                        onChanged: (value) {
                          item.TYPE = value;
                          P01DASHBOARDVAR.TYPE = value;
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
                        context: P01DASHBOARDMAINcontext,
                        controller: SectionRequestController,
                        focusNode: SectionRequestFocusNode,
                        labelText: "Section Request",
                        icon: Icons.account_tree,
                        dropdownItems: ['QC HP', 'QC BP', 'MKT ES1'],
                        onChanged: (value) {
                          item.SECTION = value;
                          P01DASHBOARDVAR.SECTION = value;
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: RequesterController,
                        focusNode: RequesterFocusNode,
                        labelText: "Requester",
                        icon: Icons.person,
                        onChanged: (value) {
                          item.REQUESTER = value;
                          P01DASHBOARDVAR.REQUESTER = value;
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: SamplingDateController,
                        focusNode: SamplingDateFocusNode,
                        labelText: "Sampling Date",
                        icon: Icons.calendar_month_rounded,
                        onChanged: (value) {
                          EditTextController(
                            controller: SamplingDateController,
                            value: value,
                          );
                          P01DASHBOARDVAR.SAMPLINGDATE = value;
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: ReceivedDateController,
                        focusNode: ReceivedDateFocusNode,
                        labelText: "Received Date",
                        icon: Icons.calendar_month_rounded,
                        onChanged: (value) {
                          EditTextController(
                            controller: ReceivedDateController,
                            value: value,
                          );
                          P01DASHBOARDVAR.RECEIVEDDATE = convertStringToDateTime(value).toString();
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: CustomerNameController,
                        focusNode: CustomerNameFocusNode,
                        labelText: "Customer Name",
                        icon: Icons.people,
                        dropdownItems: P01DASHBOARDVAR.dropdownCustomer,
                        onChanged: (value) {
                          item.CUSTOMERNAME = value;
                          P01DASHBOARDVAR.CUSTOMERNAME = value;
                        },
                      ),

                      for (int i = 0; i < 10; i++) ...[
                        if (partNameControllers[i].text != '')
                          buildCustomField(
                            context: P01DASHBOARDMAINcontext,
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
                              P01DASHBOARDVAR.PARTNAME1 = partNames[0];
                              P01DASHBOARDVAR.PARTNAME2 = partNames[1];
                              P01DASHBOARDVAR.PARTNAME3 = partNames[2];
                              P01DASHBOARDVAR.PARTNAME4 = partNames[3];
                              P01DASHBOARDVAR.PARTNAME5 = partNames[4];
                              P01DASHBOARDVAR.PARTNAME6 = partNames[5];
                              P01DASHBOARDVAR.PARTNAME7 = partNames[6];
                              P01DASHBOARDVAR.PARTNAME8 = partNames[7];
                              P01DASHBOARDVAR.PARTNAME9 = partNames[8];
                              P01DASHBOARDVAR.PARTNAME10 = partNames[9];
                            },
                          ),
                        if (partNoControllers[i].text != '')
                          buildCustomField(
                            context: P01DASHBOARDMAINcontext,
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
                              P01DASHBOARDVAR.PARTNO1 = partNos[0];
                              P01DASHBOARDVAR.PARTNO2 = partNos[1];
                              P01DASHBOARDVAR.PARTNO3 = partNos[2];
                              P01DASHBOARDVAR.PARTNO4 = partNos[3];
                              P01DASHBOARDVAR.PARTNO5 = partNos[4];
                              P01DASHBOARDVAR.PARTNO6 = partNos[5];
                              P01DASHBOARDVAR.PARTNO7 = partNos[6];
                              P01DASHBOARDVAR.PARTNO8 = partNos[7];
                              P01DASHBOARDVAR.PARTNO9 = partNos[8];
                              P01DASHBOARDVAR.PARTNO10 = partNos[9];
                            },
                          ),
                        if (lotNoControllers[i].text != '')
                          buildCustomField(
                            context: P01DASHBOARDMAINcontext,
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
                              P01DASHBOARDVAR.LOTNO1 = lotNos[0];
                              P01DASHBOARDVAR.LOTNO2 = lotNos[1];
                              P01DASHBOARDVAR.LOTNO3 = lotNos[2];
                              P01DASHBOARDVAR.LOTNO4 = lotNos[3];
                              P01DASHBOARDVAR.LOTNO5 = lotNos[4];
                              P01DASHBOARDVAR.LOTNO6 = lotNos[5];
                              P01DASHBOARDVAR.LOTNO7 = lotNos[6];
                              P01DASHBOARDVAR.LOTNO8 = lotNos[7];
                              P01DASHBOARDVAR.LOTNO9 = lotNos[8];
                              P01DASHBOARDVAR.LOTNO10 = lotNos[9];
                            },
                          ),
                        if (amountControllers[i].text != '')
                          buildCustomField(
                            context: P01DASHBOARDMAINcontext,
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
                              P01DASHBOARDVAR.AMOUNT1 = amounts[0];
                              P01DASHBOARDVAR.AMOUNT2 = amounts[1];
                              P01DASHBOARDVAR.AMOUNT3 = amounts[2];
                              P01DASHBOARDVAR.AMOUNT4 = amounts[3];
                              P01DASHBOARDVAR.AMOUNT5 = amounts[4];
                              P01DASHBOARDVAR.AMOUNT6 = amounts[5];
                              P01DASHBOARDVAR.AMOUNT7 = amounts[6];
                              P01DASHBOARDVAR.AMOUNT8 = amounts[7];
                              P01DASHBOARDVAR.AMOUNT9 = amounts[8];
                              P01DASHBOARDVAR.AMOUNT10 = amounts[9];
                            },
                          ),
                        if (materialControllers[i].text != '')
                          buildCustomField(
                            context: P01DASHBOARDMAINcontext,
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
                              P01DASHBOARDVAR.MATERIAL1 = materials[0];
                              P01DASHBOARDVAR.MATERIAL2 = materials[1];
                              P01DASHBOARDVAR.MATERIAL3 = materials[2];
                              P01DASHBOARDVAR.MATERIAL4 = materials[3];
                              P01DASHBOARDVAR.MATERIAL5 = materials[4];
                              P01DASHBOARDVAR.MATERIAL6 = materials[5];
                              P01DASHBOARDVAR.MATERIAL7 = materials[6];
                              P01DASHBOARDVAR.MATERIAL8 = materials[7];
                              P01DASHBOARDVAR.MATERIAL9 = materials[8];
                              P01DASHBOARDVAR.MATERIAL10 = materials[9];
                            },
                          ),
                        if (processControllers[i].text != '')
                          buildCustomField(
                            context: P01DASHBOARDMAINcontext,
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
                              P01DASHBOARDVAR.PROCESS1 = processs[0];
                              P01DASHBOARDVAR.PROCESS2 = processs[1];
                              P01DASHBOARDVAR.PROCESS3 = processs[2];
                              P01DASHBOARDVAR.PROCESS4 = processs[3];
                              P01DASHBOARDVAR.PROCESS5 = processs[4];
                              P01DASHBOARDVAR.PROCESS6 = processs[5];
                              P01DASHBOARDVAR.PROCESS7 = processs[6];
                              P01DASHBOARDVAR.PROCESS8 = processs[7];
                              P01DASHBOARDVAR.PROCESS9 = processs[8];
                              P01DASHBOARDVAR.PROCESS10 = processs[9];
                            },
                          ),
                      ],
                      // buildCustomField(
                      //   context: P01DASHBOARDMAINcontext,
                      //   controller: AmountOfSampleController,
                      //   focusNode: AmountOfSampleFocusNode,
                      //   labelText: "Amount of Sample (Pcs)",
                      //   icon: Icons.science,
                      //   onChanged: (value) {
                      //     item.AMOUNTSAMPLE = value.isNotEmpty ? int.parse(value) : 0;
                      //     P01DASHBOARDVAR.AMOUNTSAMPLE = int.parse(value);
                      //   },
                      // ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: TakePhotoController,
                        focusNode: TakePhotoFocusNode,
                        labelText: "Take photo (Pcs)",
                        icon: Icons.photo_camera,
                        onChanged: (value) {
                          item.TAKEPHOTO = value.isNotEmpty ? int.parse(value) : 0;
                          P01DASHBOARDVAR.TAKEPHOTO = int.parse(value);
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
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
                                addDays: P01DASHBOARDVAR.TempAddDays,
                              );
                              tempDateControllers[i].text = CalTemp;
                              // print('temp ${tempDateControllers[i].text}');
                              String CalDue = await calculateRepDue(
                                startDate: DateTime(FinishDateToDateTime.year, FinishDateToDateTime.month,
                                    FinishDateToDateTime.day),
                                addDays: P01DASHBOARDVAR.DueAddDays,
                              );
                              dueDateControllers[i].text = CalDue;
                              // print('temp ${tempDateControllers[i].text}');
                              P01DASHBOARDVAR.FINISHDATE1 =
                                  convertStringToDateTime(finishDateControllers[0].text).toString();
                              P01DASHBOARDVAR.FINISHDATE2 =
                                  convertStringToDateTime(finishDateControllers[1].text).toString();
                              P01DASHBOARDVAR.FINISHDATE3 =
                                  convertStringToDateTime(finishDateControllers[2].text).toString();
                              P01DASHBOARDVAR.FINISHDATE4 =
                                  convertStringToDateTime(finishDateControllers[3].text).toString();
                              P01DASHBOARDVAR.FINISHDATE5 =
                                  convertStringToDateTime(finishDateControllers[4].text).toString();
                              P01DASHBOARDVAR.FINISHDATE6 =
                                  convertStringToDateTime(finishDateControllers[5].text).toString();
                              P01DASHBOARDVAR.FINISHDATE7 =
                                  convertStringToDateTime(finishDateControllers[6].text).toString();
                              P01DASHBOARDVAR.FINISHDATE8 =
                                  convertStringToDateTime(finishDateControllers[7].text).toString();
                              P01DASHBOARDVAR.FINISHDATE9 =
                                  convertStringToDateTime(finishDateControllers[8].text).toString();
                              P01DASHBOARDVAR.FINISHDATE10 =
                                  convertStringToDateTime(finishDateControllers[9].text).toString();
                              P01DASHBOARDVAR.TEMPDATE1 =
                                  convertStringToDateTime(tempDateControllers[0].text).toString();
                              P01DASHBOARDVAR.TEMPDATE2 =
                                  convertStringToDateTime(tempDateControllers[1].text).toString();
                              P01DASHBOARDVAR.TEMPDATE3 =
                                  convertStringToDateTime(tempDateControllers[2].text).toString();
                              P01DASHBOARDVAR.TEMPDATE4 =
                                  convertStringToDateTime(tempDateControllers[3].text).toString();
                              P01DASHBOARDVAR.TEMPDATE5 =
                                  convertStringToDateTime(tempDateControllers[4].text).toString();
                              P01DASHBOARDVAR.TEMPDATE6 =
                                  convertStringToDateTime(tempDateControllers[5].text).toString();
                              P01DASHBOARDVAR.TEMPDATE7 =
                                  convertStringToDateTime(tempDateControllers[6].text).toString();
                              P01DASHBOARDVAR.TEMPDATE8 =
                                  convertStringToDateTime(tempDateControllers[7].text).toString();
                              P01DASHBOARDVAR.TEMPDATE9 =
                                  convertStringToDateTime(tempDateControllers[8].text).toString();
                              P01DASHBOARDVAR.TEMPDATE10 =
                                  convertStringToDateTime(tempDateControllers[9].text).toString();
                              P01DASHBOARDVAR.DUEDATE1 =
                                  convertStringToDateTime(dueDateControllers[0].text).toString();
                              P01DASHBOARDVAR.DUEDATE2 =
                                  convertStringToDateTime(dueDateControllers[1].text).toString();
                              P01DASHBOARDVAR.DUEDATE3 =
                                  convertStringToDateTime(dueDateControllers[2].text).toString();
                              P01DASHBOARDVAR.DUEDATE4 =
                                  convertStringToDateTime(dueDateControllers[3].text).toString();
                              P01DASHBOARDVAR.DUEDATE5 =
                                  convertStringToDateTime(dueDateControllers[4].text).toString();
                              P01DASHBOARDVAR.DUEDATE6 =
                                  convertStringToDateTime(dueDateControllers[5].text).toString();
                              P01DASHBOARDVAR.DUEDATE7 =
                                  convertStringToDateTime(dueDateControllers[6].text).toString();
                              P01DASHBOARDVAR.DUEDATE8 =
                                  convertStringToDateTime(dueDateControllers[7].text).toString();
                              P01DASHBOARDVAR.DUEDATE9 =
                                  convertStringToDateTime(dueDateControllers[8].text).toString();
                              P01DASHBOARDVAR.DUEDATE10 =
                                  convertStringToDateTime(dueDateControllers[9].text).toString();
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
                                      context: P01DASHBOARDMAINcontext,
                                      controller: timeControllers[i],
                                      focusNode: timeFocusNodes[i],
                                      labelText: "Time ${i + 1} (Hrs.)",
                                      icon: Icons.timer_sharp,
                                      onChanged: (value) async {
                                        EditTextController(
                                          controller: timeControllers[i],
                                          value: value,
                                        );
                                        P01DASHBOARDVAR.TIME1 = int.tryParse(timeControllers[0].text) ?? 0;
                                        P01DASHBOARDVAR.TIME2 = int.tryParse(timeControllers[1].text) ?? 0;
                                        P01DASHBOARDVAR.TIME3 = int.tryParse(timeControllers[2].text) ?? 0;
                                        P01DASHBOARDVAR.TIME4 = int.tryParse(timeControllers[3].text) ?? 0;
                                        P01DASHBOARDVAR.TIME5 = int.tryParse(timeControllers[4].text) ?? 0;
                                        P01DASHBOARDVAR.TIME6 = int.tryParse(timeControllers[5].text) ?? 0;
                                        P01DASHBOARDVAR.TIME7 = int.tryParse(timeControllers[6].text) ?? 0;
                                        P01DASHBOARDVAR.TIME8 = int.tryParse(timeControllers[7].text) ?? 0;
                                        P01DASHBOARDVAR.TIME9 = int.tryParse(timeControllers[8].text) ?? 0;
                                        P01DASHBOARDVAR.TIME10 = int.tryParse(timeControllers[9].text) ?? 0;
                                        calculateFinishDate(
                                          startDateController: StartDateController,
                                          timeController: timeControllers[i],
                                          finishDateController: finishDateControllers[i],
                                        );
                                        P01DASHBOARDVAR.FINISHDATE1 =
                                            convertStringToDateTime(finishDateControllers[0].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE2 =
                                            convertStringToDateTime(finishDateControllers[1].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE3 =
                                            convertStringToDateTime(finishDateControllers[2].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE4 =
                                            convertStringToDateTime(finishDateControllers[3].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE5 =
                                            convertStringToDateTime(finishDateControllers[4].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE6 =
                                            convertStringToDateTime(finishDateControllers[5].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE7 =
                                            convertStringToDateTime(finishDateControllers[6].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE8 =
                                            convertStringToDateTime(finishDateControllers[7].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE9 =
                                            convertStringToDateTime(finishDateControllers[8].text).toString();
                                        P01DASHBOARDVAR.FINISHDATE10 =
                                            convertStringToDateTime(finishDateControllers[9].text).toString();
                                        await calculateAndSetTempDate(
                                          finishDateController: finishDateControllers[i],
                                          DateController: tempDateControllers[i],
                                          addDays: P01DASHBOARDVAR.TempAddDays,
                                        );
                                        P01DASHBOARDVAR.TEMPDATE1 =
                                            convertStringToDateTime(tempDateControllers[0].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE2 =
                                            convertStringToDateTime(tempDateControllers[1].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE3 =
                                            convertStringToDateTime(tempDateControllers[2].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE4 =
                                            convertStringToDateTime(tempDateControllers[3].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE5 =
                                            convertStringToDateTime(tempDateControllers[4].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE6 =
                                            convertStringToDateTime(tempDateControllers[5].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE7 =
                                            convertStringToDateTime(tempDateControllers[6].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE8 =
                                            convertStringToDateTime(tempDateControllers[7].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE9 =
                                            convertStringToDateTime(tempDateControllers[8].text).toString();
                                        P01DASHBOARDVAR.TEMPDATE10 =
                                            convertStringToDateTime(tempDateControllers[9].text).toString();
                                        await calculateAndSetTempDate(
                                          finishDateController: finishDateControllers[i],
                                          DateController: dueDateControllers[i],
                                          addDays: P01DASHBOARDVAR.DueAddDays,
                                        );
                                        P01DASHBOARDVAR.DUEDATE1 =
                                            convertStringToDateTime(dueDateControllers[0].text).toString();
                                        P01DASHBOARDVAR.DUEDATE2 =
                                            convertStringToDateTime(dueDateControllers[1].text).toString();
                                        P01DASHBOARDVAR.DUEDATE3 =
                                            convertStringToDateTime(dueDateControllers[2].text).toString();
                                        P01DASHBOARDVAR.DUEDATE4 =
                                            convertStringToDateTime(dueDateControllers[3].text).toString();
                                        P01DASHBOARDVAR.DUEDATE5 =
                                            convertStringToDateTime(dueDateControllers[4].text).toString();
                                        P01DASHBOARDVAR.DUEDATE6 =
                                            convertStringToDateTime(dueDateControllers[5].text).toString();
                                        P01DASHBOARDVAR.DUEDATE7 =
                                            convertStringToDateTime(dueDateControllers[6].text).toString();
                                        P01DASHBOARDVAR.DUEDATE8 =
                                            convertStringToDateTime(dueDateControllers[7].text).toString();
                                        P01DASHBOARDVAR.DUEDATE9 =
                                            convertStringToDateTime(dueDateControllers[8].text).toString();
                                        P01DASHBOARDVAR.DUEDATE10 =
                                            convertStringToDateTime(dueDateControllers[9].text).toString();
                                        for (int i = finishDateControllers.length - 1; i >= 0; i--) {
                                          if (finishDateControllers[i].text.isNotEmpty) {
                                            await calculateAndSetTempDate(
                                              finishDateController: finishDateControllers[i],
                                              DateController: TempDate0Controller,
                                              addDays: P01DASHBOARDVAR.TempAddDays,
                                            );
                                            await calculateAndSetTempDate(
                                              finishDateController: finishDateControllers[i],
                                              DateController: DueDate0Controller,
                                              addDays: P01DASHBOARDVAR.DueAddDays,
                                            );
                                            break;
                                          }
                                        }
                                        P01DASHBOARDVAR.TEMPDATE0 =
                                            convertStringToDateTime(TempDate0Controller.text).toString();
                                        P01DASHBOARDVAR.DUEDATE0 =
                                            convertStringToDateTime(DueDate0Controller.text).toString();
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
                                        P01DASHBOARDVAR.TYPE = item.TYPE;
                                        P01DASHBOARDVAR.REQUESTNO = item.REQUESTNO;
                                        P01DASHBOARDVAR.REPORTNO = item.REPORTNO;
                                        P01DASHBOARDVAR.SECTION = item.SECTION;
                                        P01DASHBOARDVAR.REQUESTER = item.REQUESTER;
                                        P01DASHBOARDVAR.SAMPLINGDATE =
                                            convertStringToDateTime(item.SAMPLINGDATE).toString();
                                        P01DASHBOARDVAR.RECEIVEDDATE =
                                            convertStringToDateTime(item.RECEIVEDDATE).toString();
                                        P01DASHBOARDVAR.CUSTOMERNAME = item.CUSTOMERNAME;
                                        P01DASHBOARDVAR.PARTNAME1 = item.PARTNAME1;
                                        P01DASHBOARDVAR.PARTNAME2 = item.PARTNAME2;
                                        P01DASHBOARDVAR.PARTNAME3 = item.PARTNAME3;
                                        P01DASHBOARDVAR.PARTNAME4 = item.PARTNAME4;
                                        P01DASHBOARDVAR.PARTNAME5 = item.PARTNAME5;
                                        P01DASHBOARDVAR.PARTNAME6 = item.PARTNAME6;
                                        P01DASHBOARDVAR.PARTNAME7 = item.PARTNAME7;
                                        P01DASHBOARDVAR.PARTNAME8 = item.PARTNAME8;
                                        P01DASHBOARDVAR.PARTNAME9 = item.PARTNAME9;
                                        P01DASHBOARDVAR.PARTNAME10 = item.PARTNAME10;
                                        P01DASHBOARDVAR.PARTNO1 = item.PARTNO1;
                                        P01DASHBOARDVAR.PARTNO2 = item.PARTNO2;
                                        P01DASHBOARDVAR.PARTNO3 = item.PARTNO3;
                                        P01DASHBOARDVAR.PARTNO4 = item.PARTNO4;
                                        P01DASHBOARDVAR.PARTNO5 = item.PARTNO5;
                                        P01DASHBOARDVAR.PARTNO6 = item.PARTNO6;
                                        P01DASHBOARDVAR.PARTNO7 = item.PARTNO7;
                                        P01DASHBOARDVAR.PARTNO8 = item.PARTNO8;
                                        P01DASHBOARDVAR.PARTNO9 = item.PARTNO9;
                                        P01DASHBOARDVAR.PARTNO10 = item.PARTNO10;
                                        P01DASHBOARDVAR.LOTNO1 = item.LOTNO1;
                                        P01DASHBOARDVAR.LOTNO2 = item.LOTNO2;
                                        P01DASHBOARDVAR.LOTNO3 = item.LOTNO3;
                                        P01DASHBOARDVAR.LOTNO4 = item.LOTNO4;
                                        P01DASHBOARDVAR.LOTNO5 = item.LOTNO5;
                                        P01DASHBOARDVAR.LOTNO6 = item.LOTNO6;
                                        P01DASHBOARDVAR.LOTNO7 = item.LOTNO7;
                                        P01DASHBOARDVAR.LOTNO8 = item.LOTNO8;
                                        P01DASHBOARDVAR.LOTNO9 = item.LOTNO9;
                                        P01DASHBOARDVAR.LOTNO10 = item.LOTNO10;
                                        P01DASHBOARDVAR.AMOUNT1 = item.AMOUNT1;
                                        P01DASHBOARDVAR.AMOUNT2 = item.AMOUNT2;
                                        P01DASHBOARDVAR.AMOUNT3 = item.AMOUNT3;
                                        P01DASHBOARDVAR.AMOUNT4 = item.AMOUNT4;
                                        P01DASHBOARDVAR.AMOUNT5 = item.AMOUNT5;
                                        P01DASHBOARDVAR.AMOUNT6 = item.AMOUNT6;
                                        P01DASHBOARDVAR.AMOUNT7 = item.AMOUNT7;
                                        P01DASHBOARDVAR.AMOUNT8 = item.AMOUNT8;
                                        P01DASHBOARDVAR.AMOUNT9 = item.AMOUNT9;
                                        P01DASHBOARDVAR.AMOUNT10 = item.AMOUNT10;
                                        P01DASHBOARDVAR.MATERIAL1 = item.MATERIAL1;
                                        P01DASHBOARDVAR.MATERIAL2 = item.MATERIAL2;
                                        P01DASHBOARDVAR.MATERIAL3 = item.MATERIAL3;
                                        P01DASHBOARDVAR.MATERIAL4 = item.MATERIAL4;
                                        P01DASHBOARDVAR.MATERIAL5 = item.MATERIAL5;
                                        P01DASHBOARDVAR.MATERIAL6 = item.MATERIAL6;
                                        P01DASHBOARDVAR.MATERIAL7 = item.MATERIAL7;
                                        P01DASHBOARDVAR.MATERIAL8 = item.MATERIAL8;
                                        P01DASHBOARDVAR.MATERIAL9 = item.MATERIAL9;
                                        P01DASHBOARDVAR.MATERIAL10 = item.MATERIAL10;
                                        P01DASHBOARDVAR.PROCESS1 = item.PROCESS1;
                                        P01DASHBOARDVAR.PROCESS2 = item.PROCESS2;
                                        P01DASHBOARDVAR.PROCESS3 = item.PROCESS3;
                                        P01DASHBOARDVAR.PROCESS4 = item.PROCESS4;
                                        P01DASHBOARDVAR.PROCESS5 = item.PROCESS5;
                                        P01DASHBOARDVAR.PROCESS6 = item.PROCESS6;
                                        P01DASHBOARDVAR.PROCESS7 = item.PROCESS7;
                                        P01DASHBOARDVAR.PROCESS8 = item.PROCESS8;
                                        P01DASHBOARDVAR.PROCESS9 = item.PROCESS9;
                                        P01DASHBOARDVAR.PROCESS10 = item.PROCESS10;
                                        // P01DASHBOARDVAR.AMOUNTSAMPLE = item.AMOUNTSAMPLE;
                                        P01DASHBOARDVAR.TAKEPHOTO = item.TAKEPHOTO;
                                        P01DASHBOARDVAR.METHOD = item.METHOD;
                                        P01DASHBOARDVAR.INCHARGE = item.INCHARGE;
                                        P01DASHBOARDVAR.APPROVEDDATE =
                                            convertStringToDateTime(item.APPROVEDDATE).toString();
                                        P01DASHBOARDVAR.APPROVEDBY = item.APPROVEDBY;
                                        P01DASHBOARDVAR.REMARK = item.REMARK;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: buildCustomField(
                                      context: P01DASHBOARDMAINcontext,
                                      controller: finishDateControllers[i],
                                      focusNode: finishDateFocusNodes[i],
                                      labelText: "Finish Date ${i + 1}",
                                      icon: Icons.calendar_month_rounded,
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: buildCustomField(
                              //         context: P01DASHBOARDMAINcontext,
                              //         controller: tempDateControllers[i],
                              //         focusNode: tempDateFocusNodes[i],
                              //         labelText: "Temp Date ${i + 1}",
                              //         icon: Icons.calendar_month_rounded,
                              //       ),
                              //     ),
                              //     const SizedBox(width: 10),
                              //     Expanded(
                              //       child: buildCustomField(
                              //         context: P01DASHBOARDMAINcontext,
                              //         controller: dueDateControllers[i],
                              //         focusNode: dueDateFocusNodes[i],
                              //         labelText: "Due Date ${i + 1}",
                              //         icon: Icons.calendar_month_rounded,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildCustomField(
                                      context: P01DASHBOARDMAINcontext,
                                      controller: TempDate0Controller,
                                      focusNode: TempDate0FocusNode,
                                      labelText: "Temp Report",
                                      icon: Icons.calendar_month_rounded,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: buildCustomField(
                                      context: P01DASHBOARDMAINcontext,
                                      controller: DueDate0Controller,
                                      focusNode: DueDate0FocusNode,
                                      labelText: "Due Report",
                                      icon: Icons.calendar_month_rounded,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: InstrumentController,
                        focusNode: InstrumentFocusNode,
                        labelText: "Instrument",
                        icon: Icons.analytics_outlined,
                        dropdownItems: ['SST No.1', 'SST No.2', 'SST No.3', 'SST No.4'],
                        onChanged: (value) {
                          item.INSTRUMENT = value;
                          P01DASHBOARDVAR.INSTRUMENT = value;
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: MethodController,
                        focusNode: MethodFocusNode,
                        labelText: "Method",
                        icon: Icons.precision_manufacturing,
                        dropdownItems: ['ASTM-B117', 'ISO-9227', 'Other'],
                        onChanged: (value) {
                          item.METHOD = value;
                          P01DASHBOARDVAR.METHOD = value;
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: InchargeController,
                        focusNode: InchargeFocusNode,
                        labelText: "Incharge",
                        icon: Icons.person,
                        dropdownItems: P01DASHBOARDVAR.dropdownIncharge,
                        onChanged: (value) {
                          item.INCHARGE = value;
                          P01DASHBOARDVAR.INCHARGE = value;
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: ApprovedDateController,
                        focusNode: ApprovedDateFocusNode,
                        labelText: "Approved Date",
                        icon: Icons.calendar_month_rounded,
                        onChanged: (value) {
                          EditTextController(
                            controller: ApprovedDateController,
                            value: value,
                          );
                          P01DASHBOARDVAR.APPROVEDDATE = convertStringToDateTime(value).toString();
                        },
                      ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: ApprovedByController,
                        focusNode: ApprovedByFocusNode,
                        labelText: "Approved By",
                        icon: Icons.assignment,
                        dropdownItems: P01DASHBOARDVAR.dropdownApprover,
                        onChanged: (value) {
                          item.APPROVEDBY = value;
                          P01DASHBOARDVAR.APPROVEDBY = value;
                        },
                      ),
                      if (InstrumentController.text != '')
                        buildCustomFieldforEditData(
                          controller: StatusController,
                          focusNode: StatusFocusNode,
                          labelText: "Status",
                          icon: Icons.info,
                          dropdownItems: ['RECEIVED', 'WAIT TRANSFER'],
                          onChanged: (value) {
                            P01DASHBOARDVAR.STATUS = value;
                          },
                        ),
                      if (InstrumentController.text != '')
                        buildCustomField(
                          context: P01DASHBOARDMAINcontext,
                          controller: selectslot,
                          focusNode: CheckBoxFocusNode,
                          labelText: "Select Slot",
                          icon: Icons.add_box_rounded,
                          onChanged: (value) {
                            P01DASHBOARDVAR.CHECKBOX = value;
                            StartDateController.text = StartDateControllerGlobal.text;
                            // setState(() {});
                            print(StartDateController.text);
                          },
                          ontap: () {
                            P01DASHBOARDVAR.STATUS = StatusController.text;
                            selectstatus = StatusController.text;
                            // print(selectstatus);
                            selectpage = 'Salt Spray Tester : ${item.INSTRUMENT}';
                            showChooseSlot(context);
                            // setState(() {});
                          },
                        ),
                      buildCustomField(
                        context: P01DASHBOARDMAINcontext,
                        controller: RemarkController,
                        focusNode: RemarkFocusNode,
                        labelText: "Remark",
                        icon: Icons.comment,
                        onChanged: (value) {
                          item.REMARK = value;
                          P01DASHBOARDVAR.REMARK = value;
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
                                CheckSlotAndTimeOverlabToAPI(context, finishDateControllers);

                                // await showEditConfirmationDialog(
                                //   context: context,
                                //   onConfirm: () async {
                                //     updateMultipleDatesAll();
                                //     P01DASHBOARDVAR.SendEditDataToAPI = jsonEncode(item.toJson());
                                //     // print(P01DASHBOARDVAR.SendEditDataToAPI);
                                //     await _TransferDataToAPI();
                                //     Navigator.of(context).pop(true);
                                //     // initSocketConnection();
                                //     // sendDataToServer('TransferJob');
                                //     // await EditDataToAPI();
                                //     // await initSocketConnection();
                                //     // await sendDataToServer('EditJob');
                                //   },
                                // );
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
                                    'Transfer',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.swap_horizontal_circle_sharp,
                                    color: Colors.amber,
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

Future<void> _TransferDataToAPI() async {
  try {
    FreeLoadingTan(P01DASHBOARDMAINcontext);
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/TranferInstrument",
      data: {
        'dataRow': P01DASHBOARDVAR.SendEditDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
        },
      ),
    );

    if (response.statusCode == 200) {
      P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
      // initSocketConnection();
      // sendDataToServer('EditJob');
      // Navigator.pop(P01DASHBOARDMAINcontext);
    } else {
      // Navigator.pop(P01DASHBOARDMAINcontext);
      showErrorPopup(P01DASHBOARDMAINcontext, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P01DASHBOARDMAINcontext, e.toString());
  } finally {
    Navigator.pop(P01DASHBOARDMAINcontext);
  }
}

Future<void> _fetchCustomerAndIncharge() async {
  try {
    FreeLoadingTan(P01DASHBOARDMAINcontext);
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
      P01DASHBOARDVAR.dropdownCustomer =
          data.map((item) => item['Customer_Name'].toString()).where((name) => name.isNotEmpty).toList();
    } else {
      print("SearchCustomer failed");
      showErrorPopup(P01DASHBOARDMAINcontext, responseCustomer.toString());
      Navigator.pop(P01DASHBOARDMAINcontext);
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
      P01DASHBOARDVAR.dropdownIncharge = data
          .where((item) => item['Permission'] == 1)
          .map((item) => item['Incharge'].toString())
          .where((name) => name.isNotEmpty)
          .toList();
      P01DASHBOARDVAR.dropdownApprover = data
          .where((item) => item['Permission'] == 2)
          .map((item) => item['Incharge'].toString())
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      print("SearchIncharge failed");
      showErrorPopup(P01DASHBOARDMAINcontext, responseCustomer.toString());
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
      holidays = data.map((item) => item['HolidayDate'].toString()).where((name) => name.isNotEmpty).toList();
      // print(P01DASHBOARDVAR.holidays);
    } else {
      print("SearchCustomer failed");
      showErrorPopup(P01DASHBOARDMAINcontext, responseHolidays.toString());
      Navigator.pop(P01DASHBOARDMAINcontext);
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P01DASHBOARDMAINcontext, e.toString());
  } finally {
    Navigator.pop(P01DASHBOARDMAINcontext);
  }
}

void showChangeStatusDialog(BuildContext context, void Function(String) onStatusSelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'เปลี่ยนสถานะ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'กรุณาเลือกสถานะใหม่:',
            style: TextStyle(fontSize: 16),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          SizedBox(
            width: 150,
            child: ElevatedButton.icon(
              onPressed: () {
                onStatusSelected('Running');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text(
                'Running',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: ElevatedButton.icon(
              onPressed: () {
                onStatusSelected('PM');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              icon: const Icon(Icons.cleaning_services),
              label: const Text(
                'PM',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: ElevatedButton.icon(
              onPressed: () {
                print('TEST');
                onStatusSelected('Instrument Breakdown');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              icon: const Icon(Icons.build),
              label: const Text(
                'Breakdown',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> CheckSlotAndTimeOverlabToAPI(
    BuildContext context, List<TextEditingController> FinishDateControllers) async {
  try {
    FreeLoadingTan(P01DASHBOARDMAINcontext);
    // print(P01DASHBOARDVAR.STARTDATE);
    P01DASHBOARDVAR.STARTDATE = convertStringToDateTime(StartDateController.text).toString();
    DateTime? startDate = DateTime.tryParse(P01DASHBOARDVAR.STARTDATE);

    DateTime? finishDate;

    List<String?> finishDates = [
      convertStringToDateTime(FinishDateControllers[0].text).toString(),
      convertStringToDateTime(FinishDateControllers[1].text).toString(),
      convertStringToDateTime(FinishDateControllers[2].text).toString(),
      convertStringToDateTime(FinishDateControllers[3].text).toString(),
      convertStringToDateTime(FinishDateControllers[4].text).toString(),
      convertStringToDateTime(FinishDateControllers[5].text).toString(),
      convertStringToDateTime(FinishDateControllers[6].text).toString(),
      convertStringToDateTime(FinishDateControllers[7].text).toString(),
      convertStringToDateTime(FinishDateControllers[8].text).toString(),
      convertStringToDateTime(FinishDateControllers[9].text).toString(),
    ];

    for (var dateStr in finishDates.reversed) {
      if (dateStr == null || dateStr.trim().isEmpty) {
        continue;
      }

      finishDate = DateTime.tryParse(dateStr.trim());

      if (finishDate != null) break;
    }

    print(startDate);
    print(finishDate);

    if (startDate == null ||
        finishDate == null ||
        P01DASHBOARDVAR.CHECKBOX == '' ||
        P01DASHBOARDVAR.INSTRUMENT == '') {
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
        "checkBox": P01DASHBOARDVAR.CHECKBOX,
        "Instrument": P01DASHBOARDVAR.INSTRUMENT,
      },
    );

    if (response.statusCode == 200 && response.data['isOverlap'] == false) {
      // print("ไม่ซ้อนกัน");
      await showAddConfirmationDialog(
        context: context,
        onConfirm: () async {
          P01DASHBOARDVAR.SendEditDataToAPI = jsonEncode(toJsonAddDate());
          print(P01DASHBOARDVAR.SendEditDataToAPI);
          _TransferDataToAPI();
          Navigator.of(context).pop(true);
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
                  "ช่วงเวลาและช่อง ${P01DASHBOARDVAR.CHECKBOX} นี้มีการจองแล้ว กรุณาเลือกเวลาใหม่",
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
    showErrorPopup(P01DASHBOARDMAINcontext, e.toString());
  } finally {
    Navigator.pop(P01DASHBOARDMAINcontext);
  }
}

Map<String, String> toMap(P01DASHBOARDGETDATAclass data) {
  return {
    'REQUESTNO': data.REQUESTNO,
    'INSTRUMENT': data.INSTRUMENT,
    'CUSTOMERNAME': data.CUSTOMERNAME,
    'CHECKBOX': data.CHECKBOX,
    'METHOD': data.METHOD,
    'STATUS': data.STATUS,
    'STARTDATE': data.STARTDATE,
    'FINISHDATE1': data.FINISHDATE1,
    'FINISHDATE2': data.FINISHDATE2,
    'FINISHDATE3': data.FINISHDATE3,
    'FINISHDATE4': data.FINISHDATE4,
    'FINISHDATE5': data.FINISHDATE5,
    'FINISHDATE6': data.FINISHDATE6,
    'FINISHDATE7': data.FINISHDATE7,
    'FINISHDATE8': data.FINISHDATE8,
    'FINISHDATE9': data.FINISHDATE9,
    'FINISHDATE10': data.FINISHDATE10,
  };
}

Map<String, String> toMap2(P01DASHBOARDGETDATAclass data) {
  return {
    'REQUESTNO': data.REQUESTNO,
  };
}
