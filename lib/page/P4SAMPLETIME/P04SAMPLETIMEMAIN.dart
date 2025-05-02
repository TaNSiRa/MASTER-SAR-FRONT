// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/04-01-P04SAMPLETIMEGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/piechart/chart_values_options.dart';
import '../../widget/piechart/legend_options.dart';
import '../../widget/piechart/pie_chart.dart';
import 'P04SAMPLETIMEVAR.dart';

late BuildContext P04SAMPLETIMEMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P04SAMPLETIMEMAIN extends StatefulWidget {
  P04SAMPLETIMEMAIN({
    super.key,
    this.data,
  });
  List<P04SAMPLETIMEGETDATAclass>? data;

  @override
  State<P04SAMPLETIMEMAIN> createState() => _P04SAMPLETIMEMAINState();
}

class _P04SAMPLETIMEMAINState extends State<P04SAMPLETIMEMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P04SAMPLETIMEGETDATA_Bloc>().add(P04SAMPLETIMEGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P04SAMPLETIMEMAINcontext = context;
    List<P04SAMPLETIMEGETDATAclass> _datain = widget.data ?? [];
    // print(_datain.length);
// ตัวแปรสําหรับใช้กับ Dropdown
    final selectedType = (P04SAMPLETIMEVAR.DropDownType.isNotEmpty) ? P04SAMPLETIMEVAR.DropDownType : 'A';
    final selectedYear = (P04SAMPLETIMEVAR.DropDownYear.isNotEmpty)
        ? P04SAMPLETIMEVAR.DropDownYear
        : P04SAMPLETIMEVAR.currentYear;
    final selectedMonth = (P04SAMPLETIMEVAR.DropDownMonth.isNotEmpty)
        ? P04SAMPLETIMEVAR.DropDownMonth
        : P04SAMPLETIMEVAR.currentMonth2;
    // แปลง MM เป็น MMM
    final selectedMonthMMM = P04SAMPLETIMEVAR.convertMonthToMMM(P04SAMPLETIMEVAR.DropDownMonth);

// Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupTargetDaysMap = {
      'Group A': P04SAMPLETIMEVAR.GroupA,
      'Group B': P04SAMPLETIMEVAR.GroupB,
    };

    // เลือก Group A,B ตาม selectedType
    final GroupTargetDays = groupTargetDaysMap[selectedType] ?? P04SAMPLETIMEVAR.GroupA;

    // กรองข้อมูลด้วยปีและเดือน
    List<P04SAMPLETIMEGETDATAclass> filteredData = _datain.where((data) {
      return data.TYPE == selectedType &&
          data.YEAR == selectedYear &&
          data.MONTH == selectedMonth &&
          data.REPDAYS1 != 'CLOSE LINE' &&
          data.REPDAYS2 != 'CLOSE LINE' &&
          data.REPDAYS3 != 'CLOSE LINE' &&
          data.REPDAYS4 != 'CLOSE LINE';
    }).toList();

//แยกข้อมูล week 1-4
    List<Map<String, String>> IssueData = [];
    for (var data in filteredData) {
      if (data.REPDAYS1.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS1)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ1,
          'plan sam': data.PLANSAM1,
          'act sam': data.ACTSAM1,
          'rep due': data.REPDUE1,
          'sent rep': data.SENTREP1,
          'rep days': data.REPDAYS1,
          'request': data.REQUEST1,
          'ttcresult': data.TTCRESULT1,
          'issuedate': data.ISSUEDATE1,
          'sublead': data.SUBLEAD1,
          'gl': data.GL1,
          'mgr': data.MGR1,
          'jp': data.JP1,
          'bdprepare': data.BDPREPARE1,
          'bdttc': data.BDTTC1,
          'bdissue': data.BDISSUE1,
          'bdsublead': data.BDSUBLEAD1,
          'bdgl': data.BDGL1,
          'bdmgr': data.BDMGR1,
          'bdjp': data.BDJP1,
          'bdsent': data.BDSENT1,
          'reason': data.REASON1,
        };
        IssueData.add(transformedData);
      }
      if (data.REPDAYS2.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS2)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ2,
          'plan sam': data.PLANSAM2,
          'act sam': data.ACTSAM2,
          'rep due': data.REPDUE2,
          'sent rep': data.SENTREP2,
          'rep days': data.REPDAYS2,
          'request': data.REQUEST2,
          'ttcresult': data.TTCRESULT2,
          'issuedate': data.ISSUEDATE2,
          'sublead': data.SUBLEAD2,
          'gl': data.GL2,
          'mgr': data.MGR2,
          'jp': data.JP2,
          'bdprepare': data.BDPREPARE2,
          'bdttc': data.BDTTC2,
          'bdissue': data.BDISSUE2,
          'bdsublead': data.BDSUBLEAD2,
          'bdgl': data.BDGL2,
          'bdmgr': data.BDMGR2,
          'bdjp': data.BDJP2,
          'bdsent': data.BDSENT2,
          'reason': data.REASON2,
        };
        IssueData.add(transformedData);
      }
      if (data.REPDAYS3.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS3)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ3,
          'plan sam': data.PLANSAM3,
          'act sam': data.ACTSAM3,
          'rep due': data.REPDUE3,
          'sent rep': data.SENTREP3,
          'rep days': data.REPDAYS3,
          'request': data.REQUEST3,
          'ttcresult': data.TTCRESULT3,
          'issuedate': data.ISSUEDATE3,
          'sublead': data.SUBLEAD3,
          'gl': data.GL3,
          'mgr': data.MGR3,
          'jp': data.JP3,
          'bdprepare': data.BDPREPARE3,
          'bdttc': data.BDTTC3,
          'bdissue': data.BDISSUE3,
          'bdsublead': data.BDSUBLEAD3,
          'bdgl': data.BDGL3,
          'bdmgr': data.BDMGR3,
          'bdjp': data.BDJP3,
          'bdsent': data.BDSENT3,
          'reason': data.REASON3,
        };
        IssueData.add(transformedData);
      }
      if (data.REPDAYS4.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS4)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ4,
          'plan sam': data.PLANSAM4,
          'act sam': data.ACTSAM4,
          'rep due': data.REPDUE4,
          'sent rep': data.SENTREP4,
          'rep days': data.REPDAYS4,
          'request': data.REQUEST4,
          'ttcresult': data.TTCRESULT4,
          'issuedate': data.ISSUEDATE4,
          'sublead': data.SUBLEAD4,
          'gl': data.GL4,
          'mgr': data.MGR4,
          'jp': data.JP4,
          'bdprepare': data.BDPREPARE4,
          'bdttc': data.BDTTC4,
          'bdissue': data.BDISSUE4,
          'bdsublead': data.BDSUBLEAD4,
          'bdgl': data.BDGL4,
          'bdmgr': data.BDMGR4,
          'bdjp': data.BDJP4,
          'bdsent': data.BDSENT4,
          'reason': data.REASON4,
        };
        IssueData.add(transformedData);
      }
    }

    // ข้อมูลทั้งหมด
    List<Map<String, String>> AllData = [];
    for (var data in filteredData) {
      // เก็บข้อมูลแรก
      Map<String, String> transformedData1 = {
        'type': data.TYPE,
        'mktgroup': data.MKTGROUP,
        'group': data.GROUP,
        'customer': data.CUSTOMER,
        'frequency': data.FREQUENCY,
        'incharge': data.INCHARGE,
        'kpi serv': data.KPISERV,
        'kpi period': data.KPIPERIOD,
        'repitems': data.REPITEM,
        'month': data.MONTH,
        'year': data.YEAR,
        'freq': data.FREQ1,
        'plan sam': data.PLANSAM1,
        'act sam': data.ACTSAM1,
        'rep due': data.REPDUE1,
        'sent rep': data.SENTREP1,
        'rep days': data.REPDAYS1,
        'request': data.REQUEST1,
        'ttcresult': data.TTCRESULT1,
        'issuedate': data.ISSUEDATE1,
        'sublead': data.SUBLEAD1,
        'gl': data.GL1,
        'mgr': data.MGR1,
        'jp': data.JP1,
        'bdprepare': data.BDPREPARE1,
        'bdttc': data.BDTTC1,
        'bdissue': data.BDISSUE1,
        'bdsublead': data.BDSUBLEAD1,
        'bdgl': data.BDGL1,
        'bdmgr': data.BDMGR1,
        'bdjp': data.BDJP1,
        'bdsent': data.BDSENT1,
        'reason': data.REASON1,
      };
      AllData.add(transformedData1);

      // เก็บข้อมูลที่สอง
      Map<String, String> transformedData2 = {
        'type': data.TYPE,
        'mktgroup': data.MKTGROUP,
        'group': data.GROUP,
        'customer': data.CUSTOMER,
        'frequency': data.FREQUENCY,
        'incharge': data.INCHARGE,
        'kpi serv': data.KPISERV,
        'kpi period': data.KPIPERIOD,
        'repitems': data.REPITEM,
        'month': data.MONTH,
        'year': data.YEAR,
        'freq': data.FREQ2,
        'plan sam': data.PLANSAM2,
        'act sam': data.ACTSAM2,
        'rep due': data.REPDUE2,
        'sent rep': data.SENTREP2,
        'rep days': data.REPDAYS2,
        'request': data.REQUEST2,
        'ttcresult': data.TTCRESULT2,
        'issuedate': data.ISSUEDATE2,
        'sublead': data.SUBLEAD2,
        'gl': data.GL2,
        'mgr': data.MGR2,
        'jp': data.JP2,
        'bdprepare': data.BDPREPARE2,
        'bdttc': data.BDTTC2,
        'bdissue': data.BDISSUE2,
        'bdsublead': data.BDSUBLEAD2,
        'bdgl': data.BDGL2,
        'bdmgr': data.BDMGR2,
        'bdjp': data.BDJP2,
        'bdsent': data.BDSENT2,
        'reason': data.REASON2,
      };
      AllData.add(transformedData2);

      // เก็บข้อมูลที่สาม
      Map<String, String> transformedData3 = {
        'type': data.TYPE,
        'mktgroup': data.MKTGROUP,
        'group': data.GROUP,
        'customer': data.CUSTOMER,
        'frequency': data.FREQUENCY,
        'incharge': data.INCHARGE,
        'kpi serv': data.KPISERV,
        'kpi period': data.KPIPERIOD,
        'repitems': data.REPITEM,
        'month': data.MONTH,
        'year': data.YEAR,
        'freq': data.FREQ3,
        'plan sam': data.PLANSAM3,
        'act sam': data.ACTSAM3,
        'rep due': data.REPDUE3,
        'sent rep': data.SENTREP3,
        'rep days': data.REPDAYS3,
        'request': data.REQUEST3,
        'ttcresult': data.TTCRESULT3,
        'issuedate': data.ISSUEDATE3,
        'sublead': data.SUBLEAD3,
        'gl': data.GL3,
        'mgr': data.MGR3,
        'jp': data.JP3,
        'bdprepare': data.BDPREPARE3,
        'bdttc': data.BDTTC3,
        'bdissue': data.BDISSUE3,
        'bdsublead': data.BDSUBLEAD3,
        'bdgl': data.BDGL3,
        'bdmgr': data.BDMGR3,
        'bdjp': data.BDJP3,
        'bdsent': data.BDSENT3,
        'reason': data.REASON3,
      };
      AllData.add(transformedData3);

      // เก็บข้อมูลที่สี่
      Map<String, String> transformedData4 = {
        'type': data.TYPE,
        'mktgroup': data.MKTGROUP,
        'group': data.GROUP,
        'customer': data.CUSTOMER,
        'frequency': data.FREQUENCY,
        'incharge': data.INCHARGE,
        'kpi serv': data.KPISERV,
        'kpi period': data.KPIPERIOD,
        'repitems': data.REPITEM,
        'month': data.MONTH,
        'year': data.YEAR,
        'freq': data.FREQ4,
        'plan sam': data.PLANSAM4,
        'act sam': data.ACTSAM4,
        'rep due': data.REPDUE4,
        'sent rep': data.SENTREP4,
        'rep days': data.REPDAYS4,
        'request': data.REQUEST4,
        'ttcresult': data.TTCRESULT4,
        'issuedate': data.ISSUEDATE4,
        'sublead': data.SUBLEAD4,
        'gl': data.GL4,
        'mgr': data.MGR4,
        'jp': data.JP4,
        'bdprepare': data.BDPREPARE4,
        'bdttc': data.BDTTC4,
        'bdissue': data.BDISSUE4,
        'bdsublead': data.BDSUBLEAD4,
        'bdgl': data.BDGL4,
        'bdmgr': data.BDMGR4,
        'bdjp': data.BDJP4,
        'bdsent': data.BDSENT4,
        'reason': data.REASON4,
      };
      AllData.add(transformedData4);
    }

    double IssueReport = IssueData.where((item) =>
            item['type'] == selectedType && item['month'] == selectedMonth && item['year'] == selectedYear)
        .length
        .toDouble();
    IssueReport = double.parse(IssueReport.toStringAsFixed(1));

    double AllReport = AllData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        item['freq'] != '' &&
        item['plan sam'] != '' &&
        item['act sam'] != '' &&
        item['rep due'] != '' &&
        item['sent rep'] != '' &&
        item['rep days'] != '').length.toDouble();
    AllReport = double.parse(AllReport.toStringAsFixed(1));

    double SuccessReport = AllReport - IssueReport;

    double IssueReport1315 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) > 12 &&
        int.parse(item['rep days']!) < 16).length.toDouble();
    IssueReport1315 = double.parse(IssueReport1315.toStringAsFixed(1));

    double IssueReportMore15 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) >= 16).length.toDouble();
    IssueReportMore15 = double.parse(IssueReportMore15.toStringAsFixed(1));

    double IssueReport1113 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) > 10 &&
        int.parse(item['rep days']!) < 14).length.toDouble();
    IssueReport1315 = double.parse(IssueReport1315.toStringAsFixed(1));

    double IssueReportMore13 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) >= 14).length.toDouble();
    IssueReportMore15 = double.parse(IssueReportMore15.toStringAsFixed(1));

    // Map pieData1 กับข้อมูลที่คำนวณมา
    Map<String, double> pieData1 = {};
    pieData1['Achieved KPI (Iss.)'] = SuccessReport;
    pieData1['Not Achieved KPI (Iss.)'] = IssueReport;

    // คำนวณมุมของ Not Achieved KPI (Iss.) ที่ต้องแสดงด้านขวาของ pieData1
    double IssueReportPercent = (IssueReport / AllReport) * 100;

    double initialAngleInDegree = (IssueReportPercent * 3.6) / 2;

    if (initialAngleInDegree.isNaN) {
      initialAngleInDegree = 0;
    }

    // Map pieData2 กับข้อมูลที่คำนวณมา
    Map<String, double> pieData2 = {};
    pieData2['13-15 Working days'] = IssueReport1315;
    pieData2['More than 15 Working days'] = IssueReportMore15;

    // คำนวณมุมของ 13-15 Working days ที่ต้องแสดงด้านซ้ายของ pieData2
    double notAchievedPercent1315 = (IssueReportMore15 / IssueReport) * 100;

    double initialAngleInDegree1315 = ((notAchievedPercent1315 * 3.6) / 2);

    if (initialAngleInDegree1315.isNaN) {
      initialAngleInDegree1315 = 0;
    }

// Map pieData2 กับข้อมูลที่คำนวณมา
    Map<String, double> pieData3 = {};
    pieData3['11-13 Working days'] = IssueReport1113;
    pieData3['More than 13 Working days'] = IssueReportMore13;

    // คำนวณมุมของ 13-15 Working days ที่ต้องแสดงด้านซ้ายของ pieData2
    double notAchievedPercent1113 = (IssueReportMore13 / IssueReport) * 100;

    double initialAngleInDegree1113 = ((notAchievedPercent1113 * 3.6) / 2);

    if (initialAngleInDegree1113.isNaN) {
      initialAngleInDegree1113 = 0;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        controller: _controllerIN01,
        thumbVisibility: true,
        interactive: true,
        thickness: 10,
        radius: Radius.circular(20),
        child: Center(
          child: SingleChildScrollView(
            controller: _controllerIN01,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'SAR : Report Performance',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Group $selectedType\n'
                    '$GroupTargetDays ($selectedMonthMMM $selectedYear)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 1000,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  if (P04SAMPLETIMEVAR.DropDownType.isNotEmpty ||
                                      P04SAMPLETIMEVAR.DropDownYear.isNotEmpty ||
                                      P04SAMPLETIMEVAR.DropDownMonth.isNotEmpty)
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'TYPE',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  AdvanceDropDown(
                                    hint: "TYPE",
                                    listdropdown: const [
                                      // MapEntry("TYPE", ""),
                                      MapEntry("Group A", "A"),
                                      MapEntry("Group B", "B"),
                                    ],
                                    onChangeinside: (d, k) {
                                      setState(() {
                                        P04SAMPLETIMEVAR.DropDownType = d;
                                        // context
                                        //     .read<P04SAMPLETIMEGETDATA_Bloc>()
                                        //     .add(P04SAMPLETIMEGETDATA_GET());
                                      });
                                    },
                                    value: P04SAMPLETIMEVAR.DropDownType,
                                    height: 30,
                                    width: 100,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  if (P04SAMPLETIMEVAR.DropDownType.isNotEmpty ||
                                      P04SAMPLETIMEVAR.DropDownYear.isNotEmpty ||
                                      P04SAMPLETIMEVAR.DropDownMonth.isNotEmpty)
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'YEAR',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  AdvanceDropDown(
                                    hint: "YEAR",
                                    listdropdown: const [
                                      // MapEntry("YEAR", ""),
                                      MapEntry("2023", "2023"),
                                      MapEntry("2024", "2024"),
                                      MapEntry("2025", "2025"),
                                      MapEntry("2026", "2026"),
                                      MapEntry("2027", "2027"),
                                      MapEntry("2028", "2028"),
                                      MapEntry("2029", "2029"),
                                      MapEntry("2030", "2030"),
                                      MapEntry("2031", "2031"),
                                      MapEntry("2032", "2032"),
                                      MapEntry("2033", "2033"),
                                      MapEntry("2034", "2034"),
                                      MapEntry("2035", "2035"),
                                      MapEntry("2036", "2036"),
                                      MapEntry("2037", "2037"),
                                      MapEntry("2038", "2038"),
                                      MapEntry("2039", "2039"),
                                      MapEntry("2040", "2040"),
                                    ],
                                    onChangeinside: (d, k) {
                                      setState(() {
                                        P04SAMPLETIMEVAR.DropDownYear = d;
                                        // context
                                        //     .read<P04SAMPLETIMEGETDATA_Bloc>()
                                        //     .add(P04SAMPLETIMEGETDATA_GET());
                                      });
                                    },
                                    value: P04SAMPLETIMEVAR.DropDownYear,
                                    height: 30,
                                    width: 100,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  if (P04SAMPLETIMEVAR.DropDownType.isNotEmpty ||
                                      P04SAMPLETIMEVAR.DropDownYear.isNotEmpty ||
                                      P04SAMPLETIMEVAR.DropDownMonth.isNotEmpty)
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'MONTH',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  AdvanceDropDown(
                                    hint: "MONTH",
                                    listdropdown: const [
                                      // MapEntry("MONTH", ""),
                                      MapEntry("Jan", "01"),
                                      MapEntry("Feb", "02"),
                                      MapEntry("Mar", "03"),
                                      MapEntry("Apr", "04"),
                                      MapEntry("May", "05"),
                                      MapEntry("Jun", "06"),
                                      MapEntry("Jul", "07"),
                                      MapEntry("Aug", "08"),
                                      MapEntry("Sep", "09"),
                                      MapEntry("Oct", "10"),
                                      MapEntry("Nov", "11"),
                                      MapEntry("Dec", "12"),
                                    ],
                                    onChangeinside: (d, k) {
                                      setState(() {
                                        P04SAMPLETIMEVAR.DropDownMonth = d;
                                        // context
                                        //     .read<P04SAMPLETIMEGETDATA_Bloc>()
                                        //     .add(P04SAMPLETIMEGETDATA_GET());
                                      });
                                    },
                                    value: P04SAMPLETIMEVAR.DropDownMonth,
                                    height: 30,
                                    width: 100,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              bottom: 35,
                              left: 188,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  'Total report : $AllReport Iss.',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 85,
                              right: 190,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  'Total over due : $IssueReport Iss.',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PieChart(
                                  dataMap: pieData1,
                                  chartRadius: 300,
                                  colorList: [Colors.lightGreen, Colors.yellow.shade200],
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValueBackground: true,
                                    chartValueBackgroundColor: Colors.white,
                                    showChartValues: true,
                                    chartValueStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  legendOptions: LegendOptions(
                                    legendPosition: LegendPosition.bottom,
                                    showLegendsInRow: true,
                                    legendTextStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  chartType: ChartType.disc,
                                  baseChartColor: Colors.grey[300]!,
                                  centerTextStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  initialAngleInDegree: initialAngleInDegree,
                                ),
                                SizedBox(width: 160),
                                PieChart(
                                    dataMap: P04SAMPLETIMEVAR.DropDownType == 'B'
                                        ? pieData3
                                        : P04SAMPLETIMEVAR.DropDownType == 'A'
                                            ? pieData2
                                            : {},
                                    chartRadius: 200,
                                    colorList: [Colors.yellow.shade200, Colors.red],
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: true,
                                      chartValueBackgroundColor: Colors.white,
                                      showChartValues: true,
                                      chartValueStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    legendOptions: LegendOptions(
                                      legendPosition: LegendPosition.bottom,
                                      showLegendsInRow: true,
                                      legendTextStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chartType: ChartType.disc,
                                    baseChartColor: Colors.grey[300]!,
                                    centerTextStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    initialAngleInDegree: P04SAMPLETIMEVAR.DropDownType == 'B'
                                        ? initialAngleInDegree1113
                                        : P04SAMPLETIMEVAR.DropDownType == 'A'
                                            ? initialAngleInDegree1315
                                            : 0.0),
                              ],
                            ),
                          ],
                        ),
                        CustomPaint(
                          size: Size(800, 400), // กำหนดขนาดของพื้นที่วาด
                          painter: LinePainter(), // ใช้ CustomPainter ที่สร้างขึ้น
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // สีเส้น
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    // จุดเริ่มต้นและสิ้นสุดของเส้น
    final startPoint = Offset(150, 13);
    final endPoint = Offset(645, 62);

    // วาดเส้น
    canvas.drawLine(startPoint, endPoint, paint);

    // วาดเส้นที่สอง
    final startPoint2 = Offset(150, 315);
    final endPoint2 = Offset(645, 265);

    // วาดเส้นที่สอง
    canvas.drawLine(startPoint2, endPoint2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // ไม่ต้อง repaint ถ้าไม่มีอะไรเปลี่ยนแปลง
  }
}
