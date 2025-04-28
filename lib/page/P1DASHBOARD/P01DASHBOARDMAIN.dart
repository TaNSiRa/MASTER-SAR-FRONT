// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../P2INSIDEINSTRUMENT/P02INSIDEINSTRUMENTVAR.dart';
import '../page2.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  }

  final double percentageSST1 =
      (P02INSIDEINSTRUMENTVAR.disabledIndexesSST1.length / 122) * 100;
  final double percentageSST2 =
      (P02INSIDEINSTRUMENTVAR.disabledIndexesSST2.length / 122) * 100;
  final double percentageSST3 =
      (P02INSIDEINSTRUMENTVAR.disabledIndexesSST3.length / 122) * 100;
  final double percentageSST4 =
      (P02INSIDEINSTRUMENTVAR.disabledIndexesSST4.length / 122) * 100;

  @override
  Widget build(BuildContext context) {
    P01DASHBOARDMAINcontext = context;
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
                            .ChangePage_nodrower(
                                'Salt Spray Tester : SST No.1', Page2());
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
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                              Positioned(
                                top: 50,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    children: [
                                      CircularPercentIndicator(
                                        animation: true,
                                        radius: 40.0,
                                        lineWidth: 8.0,
                                        percent: percentageSST1 / 100,
                                        center: Text(
                                          "${percentageSST1.toStringAsFixed(1)}%",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        progressColor: Colors.blueAccent,
                                        backgroundColor: Colors.orange[100]!,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: Text(
                                          "${P02INSIDEINSTRUMENTVAR.disabledIndexesSST1.length} Requests",
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: const Text(
                                          "ASTM-B117",
                                          style: TextStyle(
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
                            .ChangePage_nodrower(
                                'Salt Spray Tester : SST No.2', Page2());
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
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                              Positioned(
                                top: 50,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 40.0,
                                        lineWidth: 8.0,
                                        percent: percentageSST2 / 100,
                                        center: Text(
                                          "${percentageSST2.toStringAsFixed(1)}%",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        progressColor: Colors.blueAccent,
                                        backgroundColor: Colors.orange[100]!,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: Text(
                                          "${P02INSIDEINSTRUMENTVAR.disabledIndexesSST2.length} Requests",
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: const Text(
                                          "ISO-9227",
                                          style: TextStyle(
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
                            .ChangePage_nodrower(
                                'Salt Spray Tester : SST No.3', Page2());
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
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                              Positioned(
                                top: 50,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 40.0,
                                        lineWidth: 8.0,
                                        percent: percentageSST3 / 100,
                                        center: Text(
                                          "${percentageSST3.toStringAsFixed(1)}%",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        progressColor: Colors.blueAccent,
                                        backgroundColor: Colors.orange[100]!,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: Text(
                                          "${P02INSIDEINSTRUMENTVAR.disabledIndexesSST3.length} Requests",
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: const Text(
                                          "ASTM-B117",
                                          style: TextStyle(
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
                            .ChangePage_nodrower(
                                'Salt Spray Tester : SST No.4', Page2());
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
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                              Positioned(
                                top: 50,
                                right: 10,
                                child: Center(
                                  child: Column(
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 40.0,
                                        lineWidth: 8.0,
                                        percent: percentageSST4 / 100,
                                        center: Text(
                                          "${percentageSST4.toStringAsFixed(1)}%",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        progressColor: Colors.blueAccent,
                                        backgroundColor: Colors.orange[100]!,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: Text(
                                          "${P02INSIDEINSTRUMENTVAR.disabledIndexesSST4.length} Requests",
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 1.5),
                                        ),
                                        child: const Text(
                                          "ISO-9227",
                                          style: TextStyle(
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
