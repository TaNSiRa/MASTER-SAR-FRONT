// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, library_private_types_in_public_api
import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../page2.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'P01DASHBOARDVAR.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

late IO.Socket socket;
late BuildContext P01DASHBOARDMAINcontext;
Timer? _timer;
late P01DASHBOARDGETDATA_Bloc dashboardBloc;

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
    context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET2());
    context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
    initSocketConnection();
    dashboardBloc = context.read<P01DASHBOARDGETDATA_Bloc>();
  }

  @override
  void dispose() {
    _timer?.cancel();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    P01DASHBOARDMAINcontext = context;
    List<P01DASHBOARDGETDATAclass> _datain = widget.data ?? [];
    List<P01DASHBOARDGETDATAclass> AllSSTCheckBox = _datain.toList();
    selectpage = '';
    selectstatus = '';
    selectslot.text = '';

    List<Map<String, String>> SST1Data = [];
    List<Map<String, String>> SST2Data = [];
    List<Map<String, String>> SST3Data = [];
    List<Map<String, String>> SST4Data = [];
    List<Map<String, String>> SSTAllData = [];
    List<int> allCheckboxSST1 = [];
    List<int> allCheckboxSST2 = [];
    List<int> allCheckboxSST3 = [];
    List<int> allCheckboxSST4 = [];

    for (var data in AllSSTCheckBox) {
      if (data.INSTRUMENT == 'SST No.1' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'REQUESTNO': data.REQUESTNO,
          'INSTRUMENT': data.INSTRUMENT,
          'CUSTOMERNAME': data.CUSTOMERNAME,
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
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
        SST1Data.add(transformedData);
        SSTAllData.add(transformedData);
      } else if (data.INSTRUMENT == 'SST No.2' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'REQUESTNO': data.REQUESTNO,
          'INSTRUMENT': data.INSTRUMENT,
          'CUSTOMERNAME': data.CUSTOMERNAME,
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
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
        SST2Data.add(transformedData);
        SSTAllData.add(transformedData);
      } else if (data.INSTRUMENT == 'SST No.3' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'REQUESTNO': data.REQUESTNO,
          'INSTRUMENT': data.INSTRUMENT,
          'CUSTOMERNAME': data.CUSTOMERNAME,
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
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
        SST3Data.add(transformedData);
        SSTAllData.add(transformedData);
      } else if (data.INSTRUMENT == 'SST No.4' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'REQUESTNO': data.REQUESTNO,
          'INSTRUMENT': data.INSTRUMENT,
          'CUSTOMERNAME': data.CUSTOMERNAME,
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
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
        SST4Data.add(transformedData);
        SSTAllData.add(transformedData);
      }
    }

    for (var item in SST1Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST2Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST3Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST4Data) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    allCheckboxSST1.sort();
    allCheckboxSST2.sort();
    allCheckboxSST3.sort();
    allCheckboxSST4.sort();

    final double percentageSST1 = (allCheckboxSST1.length / 122) * 100;
    final double percentageSST2 = (allCheckboxSST2.length / 122) * 100;
    final double percentageSST3 = (allCheckboxSST3.length / 122) * 100;
    final double percentageSST4 = (allCheckboxSST4.length / 122) * 100;

    String? lastMethodSST1 = '';
    String? lastMethodSST2 = '';
    String? lastMethodSST3 = '';
    String? lastMethodSST4 = '';

    if (SST1Data.isNotEmpty) {
      lastMethodSST1 = SST1Data.last['METHOD'];
    }
    if (SST2Data.isNotEmpty) {
      lastMethodSST2 = SST2Data.last['METHOD'];
    }
    if (SST3Data.isNotEmpty) {
      lastMethodSST3 = SST3Data.last['METHOD'];
    }
    if (SST4Data.isNotEmpty) {
      lastMethodSST4 = SST4Data.last['METHOD'];
    }

    // print(lastMethodSST1);
    // print(lastMethodSST2);
    // print(lastMethodSST3);
    // print(lastMethodSST4);

    // print(SSTAllData);
    startChecking(P01DASHBOARDMAINcontext, SSTAllData);

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
                              if (P01DASHBOARDVAR.SST1Staus.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: BlinkingStatusButton(data: P01DASHBOARDVAR.SST1Staus),
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
                                        "${allCheckboxSST1.length} / 122 Slots",
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
                                          "${SST1Data.length} Requests",
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
                              if (P01DASHBOARDVAR.SST2Staus.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: BlinkingStatusButton(data: P01DASHBOARDVAR.SST2Staus),
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
                                        "${allCheckboxSST2.length} / 122 Slots",
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
                                          "${SST2Data.length} Requests",
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
                                          lastMethodSST2!.isNotEmpty ? lastMethodSST1 : 'Method',
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
                              if (P01DASHBOARDVAR.SST3Staus.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: BlinkingStatusButton(data: P01DASHBOARDVAR.SST3Staus),
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
                                        "${allCheckboxSST3.length} / 122 Slots",
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
                                          "${SST3Data.length} Requests",
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
                                          lastMethodSST3!.isNotEmpty ? lastMethodSST1 : 'Method',
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
                              if (P01DASHBOARDVAR.SST4Staus.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: BlinkingStatusButton(data: P01DASHBOARDVAR.SST4Staus),
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
                                        "${allCheckboxSST4.length} / 122 Slots",
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
                                          "${SST4Data.length} Requests",
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
                                          lastMethodSST4!.isNotEmpty ? lastMethodSST1 : 'Method',
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

class BlinkingStatusButton extends StatefulWidget {
  const BlinkingStatusButton({super.key, this.data});
  final dynamic data;

  @override
  _BlinkingStatusButtonState createState() => _BlinkingStatusButtonState();
}

class _BlinkingStatusButtonState extends State<BlinkingStatusButton> {
  bool _isFadingOut = true;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    if (widget.data != '' && widget.data == 'Running') {
      _isRunning;
    } else {
      _isRunning = !_isRunning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isRunning = !_isRunning;
        });
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
                    color: _isRunning ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                _isRunning ? "Running..." : "Instrument breakdown",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _isRunning ? Colors.black : Colors.red[800], // สีตามสถานะ
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void startChecking(BuildContext context, List<Map<String, String>> SSTAllData) {
  checkForNotification(context, SSTAllData);
  _timer = Timer.periodic(Duration(minutes: 1), (timer) {
    checkForNotification(context, SSTAllData);
  });
}

void checkForNotification(BuildContext context, List<Map<String, String>> SSTAllData) {
  final now = DateTime.now();
  print('in Checking...');
  for (var item in SSTAllData) {
    for (int i = 1; i <= 10; i++) {
      String key = 'FINISHDATE$i';
      String? dateString = item[key];
      if (dateString != null && dateString.isNotEmpty) {
        try {
          DateTime finishDate = DateFormat('dd-MM-yy HH:mm').parse(dateString);
          final difference = now.difference(finishDate).inSeconds;
          if (difference >= 0 && difference <= 60) {
            if (i == 10) {
              showAlert(
                  context, item['INSTRUMENT']!, item['CUSTOMERNAME']!, item[key]!, item['CHECKBOX']!, "ออก");
              break;
            } else {
              String key2 = 'FINISHDATE${i + 1}';
              String? dateString2 = item[key2];

              if (dateString2 == null || dateString2.isEmpty) {
                showAlert(context, item['INSTRUMENT']!, item['CUSTOMERNAME']!, item[key]!, item['CHECKBOX']!,
                    "ถึงเวลาเอางานออก");
                break;
              } else {
                showAlert(context, item['INSTRUMENT']!, item['CUSTOMERNAME']!, item[key]!, item['CHECKBOX']!,
                    "หยุดครั้งที่ $i");
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

void showAlert(BuildContext context, String instrument, String customerName, String finishDate,
    String checkbox, String StopFinish) {
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
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 24, color: Colors.black),
                      children: [
                        TextSpan(
                          text: StopFinish,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' กรุณาตรวจสอบชิ้นงานดังรูปภาพข้างล่าง !!!',
                        ),
                      ],
                    ),
                  ),
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

// Future<void> initSocketConnection() async {
//   socket = IO.io('http://127.0.0.1:14001', <String, dynamic>{
//     'transports': ['websocket'],
//     'autoConnect': false,
//   });

//   socket.connect();

//   // รอให้เชื่อมต่อสำเร็จก่อนดำเนินการต่อ
//   final completer = Completer<void>();

//   socket.on('connect', (_) {
//     print('Connected to socket.io server: ${socket.id}');
//     completer.complete(); // แจ้งว่าเชื่อมต่อเสร็จแล้ว
//   });

//   socket.on('refresh-ui', (data) {
//     print('Refresh UI with data: $data');
//     dashboardBloc.add(P01DASHBOARDGETDATA_GET());
//   });

//   socket.on('disconnect', (_) {
//     print('Disconnected from socket.io');
//   });

//   await completer.future; // รอจนกว่าจะเชื่อมต่อเสร็จ
// }

void initSocketConnection() {
  socket = IO.io('http://127.0.0.1:14001', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  socket.connect();

  // เมื่อเชื่อมต่อสำเร็จ
  socket.on('connect', (_) {
    print('Connected to socket.io server: ${socket.id}');
  });

  // รับข้อมูลเพื่อรีเฟรช UI
  socket.on('refresh-ui', (data) {
    print('Refresh UI with data: $data');
    // P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
    dashboardBloc.add(P01DASHBOARDGETDATA_GET());
  });

  // disconnect
  socket.on('disconnect', (_) {
    print('Disconnected from socket.io');
  });
}
