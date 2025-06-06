// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../page/P7ASSEMBLEGRAPH/P07ASSEMBLEGRAPHMAIN.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/ForUseAllPage.dart';

//-------------------------------------------------

abstract class P07ASSEMBLEGRAPHGETDATA_Event {}

class P07ASSEMBLEGRAPHGETDATA_GET extends P07ASSEMBLEGRAPHGETDATA_Event {}

class P07ASSEMBLEGRAPHGETDATA_GET2 extends P07ASSEMBLEGRAPHGETDATA_Event {}

class P07ASSEMBLEGRAPHGETDATA_GET3 extends P07ASSEMBLEGRAPHGETDATA_Event {}

class P07ASSEMBLEGRAPHGETDATA_FLUSH extends P07ASSEMBLEGRAPHGETDATA_Event {}

class P07ASSEMBLEGRAPHGETDATA_Bloc
    extends Bloc<P07ASSEMBLEGRAPHGETDATA_Event, List<P07ASSEMBLEGRAPHGETDATAclass>> {
  P07ASSEMBLEGRAPHGETDATA_Bloc() : super([]) {
    on<P07ASSEMBLEGRAPHGETDATA_GET>((event, emit) {
      return _P07ASSEMBLEGRAPHGETDATA_GET([], emit);
    });

    on<P07ASSEMBLEGRAPHGETDATA_GET2>((event, emit) {
      return _P07ASSEMBLEGRAPHGETDATA_GET2([], emit);
    });
    on<P07ASSEMBLEGRAPHGETDATA_GET3>((event, emit) {
      return _P07ASSEMBLEGRAPHGETDATA_GET3([], emit);
    });
    on<P07ASSEMBLEGRAPHGETDATA_FLUSH>((event, emit) {
      return _P07ASSEMBLEGRAPHGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P07ASSEMBLEGRAPHGETDATA_GET(
      List<P07ASSEMBLEGRAPHGETDATAclass> toAdd, Emitter<List<P07ASSEMBLEGRAPHGETDATAclass>> emit) async {
    FreeLoadingTan(P07ASSEMBLEGRAPHMAINcontext);
    List<P07ASSEMBLEGRAPHGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().post(
      "http://172.23.10.51:14000/02SARKPI/AchievedCustomerSelect",
      data: {
        // 'TYPE': P07ASSEMBLEGRAPHVAR.DropDownType.toString(),
        // 'MONTH': P07ASSEMBLEGRAPHVAR.DropDownMonth.toString(),
        // 'YEAR': P07ASSEMBLEGRAPHVAR.DropDownYear.toString(),
      },
    );
    var input = [];
    if (response.statusCode == 200) {
      print(response.statusCode);
      // print(response.data);
      var databuff = response.data;
      input = databuff;
      // var input = dummyAchievedCust;

      List<P07ASSEMBLEGRAPHGETDATAclass> outputdata = input.map((data) {
        return P07ASSEMBLEGRAPHGETDATAclass(
          TYPE: savenull(data['Type']),
          MKTGROUP: savenull(data['MKTGroup']),
          GROUP: savenull(data['Group']),
          CUSTOMER: savenull(data['Customer']),
          CUSTSHORT: savenull(data['CustShort']),
          FREQUENCY: savenull(data['Frequency']),
          INCHARGE: savenull(data['Incharge']),
          KPISERV: savenull(data['KPIServ']),
          KPIPERIOD: savenull(data['KPIPeriod']),
          REPITEM: savenull(data['RepItems']),
          MONTH: savenull(data['Month']),
          YEAR: savenull(data['Year']),
          REQNO1: savenull(data['ReqNo1']),
          FREQ1: savenull(data['Freq1']),
          PLANSAM1: formatDate(savenull(data['PlanSam1'])),
          ACTSAM1: formatDate(savenull(data['ActSam1'])),
          REPDUE1: formatDate(savenull(data['RepDue1'])),
          SENTREP1: formatDate(savenull(data['SentRep1'])),
          REPDAYS1: savenull(data['RepDays1']),
          REQUEST1: formatDate(savenull(data['Request1'])),
          TTCRESULT1: formatDate(savenull(data['TTCResult1'])),
          ISSUEDATE1: formatDate(savenull(data['IssueDate1'])),
          SUBLEAD1: formatDate(savenull(data['Sublead1'])),
          GL1: formatDate(savenull(data['GL1'])),
          MGR1: formatDate(savenull(data['MGR1'])),
          JP1: formatDate(savenull(data['JP1'])),
          REVISE1_1: formatDate(savenull(data['Revise1_1'])),
          SUBLEAD1_1: formatDate(savenull(data['Sublead1_1'])),
          GL1_1: formatDate(savenull(data['GL1_1'])),
          MGR1_1: formatDate(savenull(data['MGR1_1'])),
          JP1_1: formatDate(savenull(data['JP1_1'])),
          REVISE1_2: formatDate(savenull(data['Revise1_2'])),
          SUBLEAD1_2: formatDate(savenull(data['Sublead1_2'])),
          GL1_2: formatDate(savenull(data['GL1_2'])),
          MGR1_2: formatDate(savenull(data['MGR1_2'])),
          JP1_2: formatDate(savenull(data['JP1_2'])),
          REVISE1_3: formatDate(savenull(data['Revise1_3'])),
          SUBLEAD1_3: formatDate(savenull(data['Sublead1_3'])),
          GL1_3: formatDate(savenull(data['GL1_3'])),
          MGR1_3: formatDate(savenull(data['MGR1_3'])),
          JP1_3: formatDate(savenull(data['JP1_3'])),
          BDPREPARE1: savenull(data['BDPrepare1']),
          BDTTC1: savenull(data['BDTTC1']),
          BDISSUE1: savenull(data['BDIssue1']),
          BDSUBLEAD1: savenull(data['BDSublead1']),
          BDGL1: savenull(data['BDGL1']),
          BDMGR1: savenull(data['BDMGR1']),
          BDJP1: savenull(data['BDJP1']),
          BDREVISE1_1: savenull(data['BDRevise1_1']),
          BDSUBLEAD1_1: savenull(data['BDSublead1_1']),
          BDGL1_1: savenull(data['BDGL1_1']),
          BDMGR1_1: savenull(data['BDMGR1_1']),
          BDJP1_1: savenull(data['BDJP1_1']),
          BDREVISE1_2: savenull(data['BDRevise1_2']),
          BDSUBLEAD1_2: savenull(data['BDSublead1_2']),
          BDGL1_2: savenull(data['BDGL1_2']),
          BDMGR1_2: savenull(data['BDMGR1_2']),
          BDJP1_2: savenull(data['BDJP1_2']),
          BDREVISE1_3: savenull(data['BDRevise1_3']),
          BDSUBLEAD1_3: savenull(data['BDSublead1_3']),
          BDGL1_3: savenull(data['BDGL1_3']),
          BDMGR1_3: savenull(data['BDMGR1_3']),
          BDJP1_3: savenull(data['BDJP1_3']),
          BDSENT1: savenull(data['BDSent1']),
          REASON1: savenull(data['Reason1']),
          REQNO2: savenull(data['ReqNo2']),
          FREQ2: savenull(data['Freq2']),
          PLANSAM2: formatDate(savenull(data['PlanSam2'])),
          ACTSAM2: formatDate(savenull(data['ActSam2'])),
          REPDUE2: formatDate(savenull(data['RepDue2'])),
          SENTREP2: formatDate(savenull(data['SentRep2'])),
          REPDAYS2: savenull(data['RepDays2']),
          REQUEST2: formatDate(savenull(data['Request2'])),
          TTCRESULT2: formatDate(savenull(data['TTCResult2'])),
          ISSUEDATE2: formatDate(savenull(data['IssueDate2'])),
          SUBLEAD2: formatDate(savenull(data['Sublead2'])),
          GL2: formatDate(savenull(data['GL2'])),
          MGR2: formatDate(savenull(data['MGR2'])),
          JP2: formatDate(savenull(data['JP2'])),
          REVISE2_1: formatDate(savenull(data['Revise2_1'])),
          SUBLEAD2_1: formatDate(savenull(data['Sublead2_1'])),
          GL2_1: formatDate(savenull(data['GL2_1'])),
          MGR2_1: formatDate(savenull(data['MGR2_1'])),
          JP2_1: formatDate(savenull(data['JP2_1'])),
          REVISE2_2: formatDate(savenull(data['Revise2_2'])),
          SUBLEAD2_2: formatDate(savenull(data['Sublead2_2'])),
          GL2_2: formatDate(savenull(data['GL2_2'])),
          MGR2_2: formatDate(savenull(data['MGR2_2'])),
          JP2_2: formatDate(savenull(data['JP2_2'])),
          REVISE2_3: formatDate(savenull(data['Revise2_3'])),
          SUBLEAD2_3: formatDate(savenull(data['Sublead2_3'])),
          GL2_3: formatDate(savenull(data['GL2_3'])),
          MGR2_3: formatDate(savenull(data['MGR2_3'])),
          JP2_3: formatDate(savenull(data['JP2_3'])),
          BDPREPARE2: savenull(data['BDPrepare2']),
          BDTTC2: savenull(data['BDTTC2']),
          BDISSUE2: savenull(data['BDIssue2']),
          BDSUBLEAD2: savenull(data['BDSublead2']),
          BDGL2: savenull(data['BDGL2']),
          BDMGR2: savenull(data['BDMGR2']),
          BDJP2: savenull(data['BDJP2']),
          BDREVISE2_1: savenull(data['BDRevise2_1']),
          BDSUBLEAD2_1: savenull(data['BDSublead2_1']),
          BDGL2_1: savenull(data['BDGL2_1']),
          BDMGR2_1: savenull(data['BDMGR2_1']),
          BDJP2_1: savenull(data['BDJP2_1']),
          BDREVISE2_2: savenull(data['BDRevise2_2']),
          BDSUBLEAD2_2: savenull(data['BDSublead2_2']),
          BDGL2_2: savenull(data['BDGL2_2']),
          BDMGR2_2: savenull(data['BDMGR2_2']),
          BDJP2_2: savenull(data['BDJP2_2']),
          BDREVISE2_3: savenull(data['BDRevise2_3']),
          BDSUBLEAD2_3: savenull(data['BDSublead2_3']),
          BDGL2_3: savenull(data['BDGL2_3']),
          BDMGR2_3: savenull(data['BDMGR2_3']),
          BDJP2_3: savenull(data['BDJP2_3']),
          BDSENT2: savenull(data['BDSent2']),
          REASON2: savenull(data['Reason2']),
          REQNO3: savenull(data['ReqNo3']),
          FREQ3: savenull(data['Freq3']),
          PLANSAM3: formatDate(savenull(data['PlanSam3'])),
          ACTSAM3: formatDate(savenull(data['ActSam3'])),
          REPDUE3: formatDate(savenull(data['RepDue3'])),
          SENTREP3: formatDate(savenull(data['SentRep3'])),
          REPDAYS3: savenull(data['RepDays3']),
          REQUEST3: formatDate(savenull(data['Request3'])),
          TTCRESULT3: formatDate(savenull(data['TTCResult3'])),
          ISSUEDATE3: formatDate(savenull(data['IssueDate3'])),
          SUBLEAD3: formatDate(savenull(data['Sublead3'])),
          GL3: formatDate(savenull(data['GL3'])),
          MGR3: formatDate(savenull(data['MGR3'])),
          JP3: formatDate(savenull(data['JP3'])),
          REVISE3_1: formatDate(savenull(data['Revise3_1'])),
          SUBLEAD3_1: formatDate(savenull(data['Sublead3_1'])),
          GL3_1: formatDate(savenull(data['GL3_1'])),
          MGR3_1: formatDate(savenull(data['MGR3_1'])),
          JP3_1: formatDate(savenull(data['JP3_1'])),
          REVISE3_2: formatDate(savenull(data['Revise3_2'])),
          SUBLEAD3_2: formatDate(savenull(data['Sublead3_2'])),
          GL3_2: formatDate(savenull(data['GL3_2'])),
          MGR3_2: formatDate(savenull(data['MGR3_2'])),
          JP3_2: formatDate(savenull(data['JP3_2'])),
          REVISE3_3: formatDate(savenull(data['Revise3_3'])),
          SUBLEAD3_3: formatDate(savenull(data['Sublead3_3'])),
          GL3_3: formatDate(savenull(data['GL3_3'])),
          MGR3_3: formatDate(savenull(data['MGR3_3'])),
          JP3_3: formatDate(savenull(data['JP3_3'])),
          BDPREPARE3: savenull(data['BDPrepare3']),
          BDTTC3: savenull(data['BDTTC3']),
          BDISSUE3: savenull(data['BDIssue3']),
          BDSUBLEAD3: savenull(data['BDSublead3']),
          BDGL3: savenull(data['BDGL3']),
          BDMGR3: savenull(data['BDMGR3']),
          BDJP3: savenull(data['BDJP3']),
          BDREVISE3_1: savenull(data['BDRevise3_1']),
          BDSUBLEAD3_1: savenull(data['BDSublead3_1']),
          BDGL3_1: savenull(data['BDGL3_1']),
          BDMGR3_1: savenull(data['BDMGR3_1']),
          BDJP3_1: savenull(data['BDJP3_1']),
          BDREVISE3_2: savenull(data['BDRevise3_2']),
          BDSUBLEAD3_2: savenull(data['BDSublead3_2']),
          BDGL3_2: savenull(data['BDGL3_2']),
          BDMGR3_2: savenull(data['BDMGR3_2']),
          BDJP3_2: savenull(data['BDJP3_2']),
          BDREVISE3_3: savenull(data['BDRevise3_3']),
          BDSUBLEAD3_3: savenull(data['BDSublead3_3']),
          BDGL3_3: savenull(data['BDGL3_3']),
          BDMGR3_3: savenull(data['BDMGR3_3']),
          BDJP3_3: savenull(data['BDJP3_3']),
          BDSENT3: savenull(data['BDSent3']),
          REASON3: savenull(data['Reason3']),
          REQNO4: savenull(data['ReqNo4']),
          FREQ4: savenull(data['Freq4']),
          PLANSAM4: formatDate(savenull(data['PlanSam4'])),
          ACTSAM4: formatDate(savenull(data['ActSam4'])),
          REPDUE4: formatDate(savenull(data['RepDue4'])),
          SENTREP4: formatDate(savenull(data['SentRep4'])),
          REPDAYS4: savenull(data['RepDays4']),
          REQUEST4: formatDate(savenull(data['Request4'])),
          TTCRESULT4: formatDate(savenull(data['TTCResult4'])),
          ISSUEDATE4: formatDate(savenull(data['IssueDate4'])),
          SUBLEAD4: formatDate(savenull(data['Sublead4'])),
          GL4: formatDate(savenull(data['GL4'])),
          MGR4: formatDate(savenull(data['MGR4'])),
          JP4: formatDate(savenull(data['JP4'])),
          REVISE4_1: formatDate(savenull(data['Revise4_1'])),
          SUBLEAD4_1: formatDate(savenull(data['Sublead4_1'])),
          GL4_1: formatDate(savenull(data['GL4_1'])),
          MGR4_1: formatDate(savenull(data['MGR4_1'])),
          JP4_1: formatDate(savenull(data['JP4_1'])),
          REVISE4_2: formatDate(savenull(data['Revise4_2'])),
          SUBLEAD4_2: formatDate(savenull(data['Sublead4_2'])),
          GL4_2: formatDate(savenull(data['GL4_2'])),
          MGR4_2: formatDate(savenull(data['MGR4_2'])),
          JP4_2: formatDate(savenull(data['JP4_2'])),
          REVISE4_3: formatDate(savenull(data['Revise4_3'])),
          SUBLEAD4_3: formatDate(savenull(data['Sublead4_3'])),
          GL4_3: formatDate(savenull(data['GL4_3'])),
          MGR4_3: formatDate(savenull(data['MGR4_3'])),
          JP4_3: formatDate(savenull(data['JP4_3'])),
          BDPREPARE4: savenull(data['BDPrepare4']),
          BDTTC4: savenull(data['BDTTC4']),
          BDISSUE4: savenull(data['BDIssue4']),
          BDSUBLEAD4: savenull(data['BDSublead4']),
          BDGL4: savenull(data['BDGL4']),
          BDMGR4: savenull(data['BDMGR4']),
          BDJP4: savenull(data['BDJP4']),
          BDREVISE4_1: savenull(data['BDRevise4_1']),
          BDSUBLEAD4_1: savenull(data['BDSublead4_1']),
          BDGL4_1: savenull(data['BDGL4_1']),
          BDMGR4_1: savenull(data['BDMGR4_1']),
          BDJP4_1: savenull(data['BDJP4_1']),
          BDREVISE4_2: savenull(data['BDRevise4_2']),
          BDSUBLEAD4_2: savenull(data['BDSublead4_2']),
          BDGL4_2: savenull(data['BDGL4_2']),
          BDMGR4_2: savenull(data['BDMGR4_2']),
          BDJP4_2: savenull(data['BDJP4_2']),
          BDREVISE4_3: savenull(data['BDRevise4_3']),
          BDSUBLEAD4_3: savenull(data['BDSublead4_3']),
          BDGL4_3: savenull(data['BDGL4_3']),
          BDMGR4_3: savenull(data['BDMGR4_3']),
          BDJP4_3: savenull(data['BDJP4_3']),
          BDSENT4: savenull(data['BDSent4']),
          REASON4: savenull(data['Reason4']),
        );
      }).toList();
      Navigator.pop(P07ASSEMBLEGRAPHMAINcontext);

      output = outputdata;
      emit(output);
    } else {
      print("where is my server");
      output = [];
      emit(output);
    }
  }

  Future<void> _P07ASSEMBLEGRAPHGETDATA_GET2(
      List<P07ASSEMBLEGRAPHGETDATAclass> toAdd, Emitter<List<P07ASSEMBLEGRAPHGETDATAclass>> emit) async {
    // List<P07ASSEMBLEGRAPHGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P07ASSEMBLEGRAPHGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P07ASSEMBLEGRAPHGETDATAclass(
    //     PLANT: savenull(data['plant']),
    //     ORDER: savenull(data['order']),
    //     MAT: savenull(data['mat']),
    //     LOCATION: savenull(data['location']),
    //     LOT: savenull(data['lot']),
    //     CUSTOMER: savenull(data['customer']),
    //     PARTNO: savenull(data['partno']),
    //     PARTNAME: savenull(data['partname']),
    //     STEP01: savenull(data['step1']),
    //     STEP02: savenull(data['step2']),
    //     STEP03: savenull(data['step3']),
    //     STEP04: savenull(data['step4']),
    //     STEP05: savenull(data['step5']),
    //     STEP06: savenull(data['step6']),
    //     STEP07: savenull(data['step7']),
    //     STEP08: savenull(data['step8']),
    //     STEP09: savenull(data['step9']),
    //   );
    // }).toList();

    // output = outputdata;
    // emit(output);
  }

  Future<void> _P07ASSEMBLEGRAPHGETDATA_GET3(
      List<P07ASSEMBLEGRAPHGETDATAclass> toAdd, Emitter<List<P07ASSEMBLEGRAPHGETDATAclass>> emit) async {
    // List<P07ASSEMBLEGRAPHGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P07ASSEMBLEGRAPHGETDATAclass> datadummy = [
    //   P07ASSEMBLEGRAPHGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P07ASSEMBLEGRAPHGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P07ASSEMBLEGRAPHGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P07ASSEMBLEGRAPHGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P07ASSEMBLEGRAPHGETDATA_FLUSH(
      List<P07ASSEMBLEGRAPHGETDATAclass> toAdd, Emitter<List<P07ASSEMBLEGRAPHGETDATAclass>> emit) async {
    List<P07ASSEMBLEGRAPHGETDATAclass> output = [];
    emit(output);
  }
}

class P07ASSEMBLEGRAPHGETDATAclass {
  P07ASSEMBLEGRAPHGETDATAclass({
    this.TYPE = '',
    this.MKTGROUP = '',
    this.GROUP = '',
    this.CUSTOMER = '',
    this.CUSTSHORT = '',
    this.FREQUENCY = '',
    this.INCHARGE = '',
    this.KPISERV = '',
    this.KPIPERIOD = '',
    this.REPITEM = '',
    this.MONTH = '',
    this.YEAR = '',
    this.REQNO1 = '',
    this.FREQ1 = '',
    this.PLANSAM1 = '',
    this.ACTSAM1 = '',
    this.REPDUE1 = '',
    this.SENTREP1 = '',
    this.REPDAYS1 = '',
    this.REQUEST1 = '',
    this.TTCRESULT1 = '',
    this.ISSUEDATE1 = '',
    this.SUBLEAD1 = '',
    this.GL1 = '',
    this.MGR1 = '',
    this.JP1 = '',
    this.REVISE1_1 = '',
    this.SUBLEAD1_1 = '',
    this.GL1_1 = '',
    this.MGR1_1 = '',
    this.JP1_1 = '',
    this.REVISE1_2 = '',
    this.SUBLEAD1_2 = '',
    this.GL1_2 = '',
    this.MGR1_2 = '',
    this.JP1_2 = '',
    this.REVISE1_3 = '',
    this.SUBLEAD1_3 = '',
    this.GL1_3 = '',
    this.MGR1_3 = '',
    this.JP1_3 = '',
    this.BDPREPARE1 = '',
    this.BDTTC1 = '',
    this.BDISSUE1 = '',
    this.BDSUBLEAD1 = '',
    this.BDGL1 = '',
    this.BDMGR1 = '',
    this.BDJP1 = '',
    this.BDREVISE1_1 = '',
    this.BDSUBLEAD1_1 = '',
    this.BDGL1_1 = '',
    this.BDMGR1_1 = '',
    this.BDJP1_1 = '',
    this.BDREVISE1_2 = '',
    this.BDSUBLEAD1_2 = '',
    this.BDGL1_2 = '',
    this.BDMGR1_2 = '',
    this.BDJP1_2 = '',
    this.BDREVISE1_3 = '',
    this.BDSUBLEAD1_3 = '',
    this.BDGL1_3 = '',
    this.BDMGR1_3 = '',
    this.BDJP1_3 = '',
    this.BDSENT1 = '',
    this.REASON1 = '',
    this.REQNO2 = '',
    this.FREQ2 = '',
    this.PLANSAM2 = '',
    this.ACTSAM2 = '',
    this.REPDUE2 = '',
    this.SENTREP2 = '',
    this.REPDAYS2 = '',
    this.REQUEST2 = '',
    this.TTCRESULT2 = '',
    this.ISSUEDATE2 = '',
    this.SUBLEAD2 = '',
    this.GL2 = '',
    this.MGR2 = '',
    this.JP2 = '',
    this.REVISE2_1 = '',
    this.SUBLEAD2_1 = '',
    this.GL2_1 = '',
    this.MGR2_1 = '',
    this.JP2_1 = '',
    this.REVISE2_2 = '',
    this.SUBLEAD2_2 = '',
    this.GL2_2 = '',
    this.MGR2_2 = '',
    this.JP2_2 = '',
    this.REVISE2_3 = '',
    this.SUBLEAD2_3 = '',
    this.GL2_3 = '',
    this.MGR2_3 = '',
    this.JP2_3 = '',
    this.BDPREPARE2 = '',
    this.BDTTC2 = '',
    this.BDISSUE2 = '',
    this.BDSUBLEAD2 = '',
    this.BDGL2 = '',
    this.BDMGR2 = '',
    this.BDJP2 = '',
    this.BDREVISE2_1 = '',
    this.BDSUBLEAD2_1 = '',
    this.BDGL2_1 = '',
    this.BDMGR2_1 = '',
    this.BDJP2_1 = '',
    this.BDREVISE2_2 = '',
    this.BDSUBLEAD2_2 = '',
    this.BDGL2_2 = '',
    this.BDMGR2_2 = '',
    this.BDJP2_2 = '',
    this.BDREVISE2_3 = '',
    this.BDSUBLEAD2_3 = '',
    this.BDGL2_3 = '',
    this.BDMGR2_3 = '',
    this.BDJP2_3 = '',
    this.BDSENT2 = '',
    this.REASON2 = '',
    this.REQNO3 = '',
    this.FREQ3 = '',
    this.PLANSAM3 = '',
    this.ACTSAM3 = '',
    this.REPDUE3 = '',
    this.SENTREP3 = '',
    this.REPDAYS3 = '',
    this.REQUEST3 = '',
    this.TTCRESULT3 = '',
    this.ISSUEDATE3 = '',
    this.SUBLEAD3 = '',
    this.GL3 = '',
    this.MGR3 = '',
    this.JP3 = '',
    this.REVISE3_1 = '',
    this.SUBLEAD3_1 = '',
    this.GL3_1 = '',
    this.MGR3_1 = '',
    this.JP3_1 = '',
    this.REVISE3_2 = '',
    this.SUBLEAD3_2 = '',
    this.GL3_2 = '',
    this.MGR3_2 = '',
    this.JP3_2 = '',
    this.REVISE3_3 = '',
    this.SUBLEAD3_3 = '',
    this.GL3_3 = '',
    this.MGR3_3 = '',
    this.JP3_3 = '',
    this.BDPREPARE3 = '',
    this.BDTTC3 = '',
    this.BDISSUE3 = '',
    this.BDSUBLEAD3 = '',
    this.BDGL3 = '',
    this.BDMGR3 = '',
    this.BDJP3 = '',
    this.BDREVISE3_1 = '',
    this.BDSUBLEAD3_1 = '',
    this.BDGL3_1 = '',
    this.BDMGR3_1 = '',
    this.BDJP3_1 = '',
    this.BDREVISE3_2 = '',
    this.BDSUBLEAD3_2 = '',
    this.BDGL3_2 = '',
    this.BDMGR3_2 = '',
    this.BDJP3_2 = '',
    this.BDREVISE3_3 = '',
    this.BDSUBLEAD3_3 = '',
    this.BDGL3_3 = '',
    this.BDMGR3_3 = '',
    this.BDJP3_3 = '',
    this.BDSENT3 = '',
    this.REASON3 = '',
    this.REQNO4 = '',
    this.FREQ4 = '',
    this.PLANSAM4 = '',
    this.ACTSAM4 = '',
    this.REPDUE4 = '',
    this.SENTREP4 = '',
    this.REPDAYS4 = '',
    this.REQUEST4 = '',
    this.TTCRESULT4 = '',
    this.ISSUEDATE4 = '',
    this.SUBLEAD4 = '',
    this.GL4 = '',
    this.MGR4 = '',
    this.JP4 = '',
    this.REVISE4_1 = '',
    this.SUBLEAD4_1 = '',
    this.GL4_1 = '',
    this.MGR4_1 = '',
    this.JP4_1 = '',
    this.REVISE4_2 = '',
    this.SUBLEAD4_2 = '',
    this.GL4_2 = '',
    this.MGR4_2 = '',
    this.JP4_2 = '',
    this.REVISE4_3 = '',
    this.SUBLEAD4_3 = '',
    this.GL4_3 = '',
    this.MGR4_3 = '',
    this.JP4_3 = '',
    this.BDPREPARE4 = '',
    this.BDTTC4 = '',
    this.BDISSUE4 = '',
    this.BDSUBLEAD4 = '',
    this.BDGL4 = '',
    this.BDMGR4 = '',
    this.BDJP4 = '',
    this.BDREVISE4_1 = '',
    this.BDSUBLEAD4_1 = '',
    this.BDGL4_1 = '',
    this.BDMGR4_1 = '',
    this.BDJP4_1 = '',
    this.BDREVISE4_2 = '',
    this.BDSUBLEAD4_2 = '',
    this.BDGL4_2 = '',
    this.BDMGR4_2 = '',
    this.BDJP4_2 = '',
    this.BDREVISE4_3 = '',
    this.BDSUBLEAD4_3 = '',
    this.BDGL4_3 = '',
    this.BDMGR4_3 = '',
    this.BDJP4_3 = '',
    this.BDSENT4 = '',
    this.REASON4 = '',
  });

  String TYPE;
  String MKTGROUP;
  String GROUP;
  String CUSTOMER;
  String CUSTSHORT;
  String FREQUENCY;
  String INCHARGE;
  String KPISERV;
  String KPIPERIOD;
  String REPITEM;
  String MONTH;
  String YEAR;
  String REQNO1;
  String FREQ1;
  String PLANSAM1;
  String ACTSAM1;
  String REPDUE1;
  String SENTREP1;
  String REPDAYS1;
  String REQUEST1;
  String TTCRESULT1;
  String ISSUEDATE1;
  String SUBLEAD1;
  String GL1;
  String MGR1;
  String JP1;
  String REVISE1_1;
  String SUBLEAD1_1;
  String GL1_1;
  String MGR1_1;
  String JP1_1;
  String REVISE1_2;
  String SUBLEAD1_2;
  String GL1_2;
  String MGR1_2;
  String JP1_2;
  String REVISE1_3;
  String SUBLEAD1_3;
  String GL1_3;
  String MGR1_3;
  String JP1_3;
  String BDPREPARE1;
  String BDTTC1;
  String BDISSUE1;
  String BDSUBLEAD1;
  String BDGL1;
  String BDMGR1;
  String BDJP1;
  String BDREVISE1_1;
  String BDSUBLEAD1_1;
  String BDGL1_1;
  String BDMGR1_1;
  String BDJP1_1;
  String BDREVISE1_2;
  String BDSUBLEAD1_2;
  String BDGL1_2;
  String BDMGR1_2;
  String BDJP1_2;
  String BDREVISE1_3;
  String BDSUBLEAD1_3;
  String BDGL1_3;
  String BDMGR1_3;
  String BDJP1_3;
  String BDSENT1;
  String REASON1;
  String REQNO2;
  String FREQ2;
  String PLANSAM2;
  String ACTSAM2;
  String REPDUE2;
  String SENTREP2;
  String REPDAYS2;
  String REQUEST2;
  String TTCRESULT2;
  String ISSUEDATE2;
  String SUBLEAD2;
  String GL2;
  String MGR2;
  String JP2;
  String REVISE2_1;
  String SUBLEAD2_1;
  String GL2_1;
  String MGR2_1;
  String JP2_1;
  String REVISE2_2;
  String SUBLEAD2_2;
  String GL2_2;
  String MGR2_2;
  String JP2_2;
  String REVISE2_3;
  String SUBLEAD2_3;
  String GL2_3;
  String MGR2_3;
  String JP2_3;
  String BDPREPARE2;
  String BDTTC2;
  String BDISSUE2;
  String BDSUBLEAD2;
  String BDGL2;
  String BDMGR2;
  String BDJP2;
  String BDREVISE2_1;
  String BDSUBLEAD2_1;
  String BDGL2_1;
  String BDMGR2_1;
  String BDJP2_1;
  String BDREVISE2_2;
  String BDSUBLEAD2_2;
  String BDGL2_2;
  String BDMGR2_2;
  String BDJP2_2;
  String BDREVISE2_3;
  String BDSUBLEAD2_3;
  String BDGL2_3;
  String BDMGR2_3;
  String BDJP2_3;
  String BDSENT2;
  String REASON2;
  String REQNO3;
  String FREQ3;
  String PLANSAM3;
  String ACTSAM3;
  String REPDUE3;
  String SENTREP3;
  String REPDAYS3;
  String REQUEST3;
  String TTCRESULT3;
  String ISSUEDATE3;
  String SUBLEAD3;
  String GL3;
  String MGR3;
  String JP3;
  String REVISE3_1;
  String SUBLEAD3_1;
  String GL3_1;
  String MGR3_1;
  String JP3_1;
  String REVISE3_2;
  String SUBLEAD3_2;
  String GL3_2;
  String MGR3_2;
  String JP3_2;
  String REVISE3_3;
  String SUBLEAD3_3;
  String GL3_3;
  String MGR3_3;
  String JP3_3;
  String BDPREPARE3;
  String BDTTC3;
  String BDISSUE3;
  String BDSUBLEAD3;
  String BDGL3;
  String BDMGR3;
  String BDJP3;
  String BDREVISE3_1;
  String BDSUBLEAD3_1;
  String BDGL3_1;
  String BDMGR3_1;
  String BDJP3_1;
  String BDREVISE3_2;
  String BDSUBLEAD3_2;
  String BDGL3_2;
  String BDMGR3_2;
  String BDJP3_2;
  String BDREVISE3_3;
  String BDSUBLEAD3_3;
  String BDGL3_3;
  String BDMGR3_3;
  String BDJP3_3;
  String BDSENT3;
  String REASON3;
  String REQNO4;
  String FREQ4;
  String PLANSAM4;
  String ACTSAM4;
  String REPDUE4;
  String SENTREP4;
  String REPDAYS4;
  String REQUEST4;
  String TTCRESULT4;
  String ISSUEDATE4;
  String SUBLEAD4;
  String GL4;
  String MGR4;
  String JP4;
  String REVISE4_1;
  String SUBLEAD4_1;
  String GL4_1;
  String MGR4_1;
  String JP4_1;
  String REVISE4_2;
  String SUBLEAD4_2;
  String GL4_2;
  String MGR4_2;
  String JP4_2;
  String REVISE4_3;
  String SUBLEAD4_3;
  String GL4_3;
  String MGR4_3;
  String JP4_3;
  String BDPREPARE4;
  String BDTTC4;
  String BDISSUE4;
  String BDSUBLEAD4;
  String BDGL4;
  String BDMGR4;
  String BDJP4;
  String BDREVISE4_1;
  String BDSUBLEAD4_1;
  String BDGL4_1;
  String BDMGR4_1;
  String BDJP4_1;
  String BDREVISE4_2;
  String BDSUBLEAD4_2;
  String BDGL4_2;
  String BDMGR4_2;
  String BDJP4_2;
  String BDREVISE4_3;
  String BDSUBLEAD4_3;
  String BDGL4_3;
  String BDMGR4_3;
  String BDJP4_3;
  String BDSENT4;
  String REASON4;
}

String savenull(input) {
  String output = '';
  if (input != null) {
    output = input.toString();
  }
  return output;
}

// String formatDate(String? date) {
//   if (date == null || date.isEmpty) return '';
//   if (date == 'CLOSE LINE') return 'CLOSE LINE';
//   try {
//     DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
//     return DateFormat('dd/MM/yyyy').format(parsedDate);
//   } catch (e) {
//     return '';
//   }
// }
