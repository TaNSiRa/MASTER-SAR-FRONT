// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, library_private_types_in_public_api
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';
import '../page2.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'P01DASHBOARDVAR.dart';

late BuildContext P01DASHBOARDMAINcontext;

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
  }

  @override
  Widget build(BuildContext context) {
    P01DASHBOARDMAINcontext = context;
    List<P01DASHBOARDGETDATAclass> _datain = widget.data ?? [];
    List<P01DASHBOARDGETDATAclass> AllSSTCheckBox = _datain.toList();
    selectpage = '';
    selectstatus = '';
    selectslot.text = '';
    // loadData();

    // setState(() {
    //   P01DASHBOARDVAR.SST1Staus;
    //   P01DASHBOARDVAR.SST2Staus;
    //   P01DASHBOARDVAR.SST3Staus;
    //   P01DASHBOARDVAR.SST4Staus;
    // });

    List<Map<String, String>> SST1Data = [];
    List<Map<String, String>> SST2Data = [];
    List<Map<String, String>> SST3Data = [];
    List<Map<String, String>> SST4Data = [];
    List<int> allCheckboxSST1 = [];
    List<int> allCheckboxSST2 = [];
    List<int> allCheckboxSST3 = [];
    List<int> allCheckboxSST4 = [];

    for (var data in AllSSTCheckBox) {
      if (data.INSTRUMENT == 'SST No.1' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
        };
        SST1Data.add(transformedData);
      } else if (data.INSTRUMENT == 'SST No.2' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
        };
        SST2Data.add(transformedData);
      } else if (data.INSTRUMENT == 'SST No.3' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
        };
        SST3Data.add(transformedData);
      } else if (data.INSTRUMENT == 'SST No.4' && data.STATUS == 'RECEIVED') {
        Map<String, String> transformedData = {
          'CHECKBOX': data.CHECKBOX,
          'METHOD': data.METHOD,
        };
        SST4Data.add(transformedData);
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
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.1",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
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
                                child: CircularPercentIndicator(
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
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
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
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST1!,
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
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.2",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
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
                                child: CircularPercentIndicator(
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
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
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
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST2!,
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
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.3",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
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
                                child: CircularPercentIndicator(
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
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
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
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST3!,
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
                                  children: [
                                    Text(
                                      "Salt Spray Tester : SST No.4",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
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
                                child: CircularPercentIndicator(
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
                              ),
                              Positioned(
                                top: 130,
                                right: 10,
                                child: Center(
                                  child: Column(
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
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        child: Text(
                                          lastMethodSST4!,
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
    dynamic _datain = widget.data ?? [];
    // print(_datain);

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
                    color: _isRunning ? Colors.green : Colors.red, // เปลี่ยนสีตามสถานะ
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
                  color: Colors.black, // สีดำตลอด
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
