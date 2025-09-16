// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/page/P02MASTERDETAIL/P02MASTERDETAILVAR.dart';
import '../../data/global.dart';
import '../../page/P02MASTERDETAIL/Function/api.dart';
import '../../page/P02MASTERDETAIL/P02MASTERDETAILMAIN.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/ForUseAllPage.dart';

//-------------------------------------------------

abstract class P02MASTERDETAILGETDATA_Event {}

class P02MASTERDETAILGETDATA_GET extends P02MASTERDETAILGETDATA_Event {}

class P02MASTERDETAILGETDATA_GET2 extends P02MASTERDETAILGETDATA_Event {}

class P02MASTERDETAILGETDATA_GET3 extends P02MASTERDETAILGETDATA_Event {}

class P02MASTERDETAILGETDATA_FLUSH extends P02MASTERDETAILGETDATA_Event {}

class P02MASTERDETAILGETDATA_Bloc extends Bloc<P02MASTERDETAILGETDATA_Event, P02MASTERDETAILGETDATAclass> {
  P02MASTERDETAILGETDATA_Bloc() : super(P02MASTERDETAILGETDATAclass()) {
    on<P02MASTERDETAILGETDATA_GET>((event, emit) {
      return _P02MASTERDETAILGETDATA_GET(state, emit);
    });
/* 
    on<P02MASTERDETAILGETDATA_GET2>((event, emit) {
      return _P02MASTERDETAILGETDATA_GET2([], emit);
    });
    on<P02MASTERDETAILGETDATA_GET3>((event, emit) {
      return _P02MASTERDETAILGETDATA_GET3([], emit);
    });
    on<P02MASTERDETAILGETDATA_FLUSH>((event, emit) {
      return _P02MASTERDETAILGETDATA_FLUSH([], emit);
    }); */
  }

  Future<void> _P02MASTERDETAILGETDATA_GET(
      P02MASTERDETAILGETDATAclass toAdd, Emitter<P02MASTERDETAILGETDATAclass> emit) async {
    FreeLoadingTan(P02MASTERDETAILMAINcontext);
    // List<P02MASTERDETAILGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    try {
      final response = await Dio().post(
        "$ToServer/02MASTERSAR/masterDetail",
        data: {
          "masterType": masterType,
          "CustShort": CustShort,
        },
        options: Options(
          validateStatus: (status) {
            return true;
          },
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );
      var input = [];
      if (response.statusCode == 200) {
        // print(response.statusCode);
        // print(response.data);
        var databuff = response.data;
        input = databuff;
        // var input = dummyAchievedCust;
        // print(input);
        if (masterType == 'Routine_MasterPatternTS') {
          List<MasterTSclass> output = input.map((data) {
            return MasterTSclass(
              Id: savenull(data['Id']),
              CustId: savenull(data['CustId']),
              CustFull: savenull(data['CustFull']),
              CustShort: savenull(data['CustShort']),
              Incharge: savenull(data['Incharge']),
              SampleNo: savenull(data['SampleNo']),
              GroupNameTS: savenull(data['GroupNameTS']),
              SampleGroup: savenull(data['SampleGroup']),
              SampleType: savenull(data['SampleType']),
              SampleTank: savenull(data['SampleTank']),
              SampleName: savenull(data['SampleName']),
              ProcessReportName: savenull(data['ProcessReportName']),
              ItemNo: savenull(data['ItemNo']),
              ItemName: savenull(data['ItemName']),
              ItemReportName: savenull(data['ItemReportName']),
              StdFactor: savenull(data['StdFactor']),
              StdMin: savenull(data['StdMin']),
              StdSymbol: savenull(data['StdSymbol']),
              StdMax: savenull(data['StdMax']),
              ControlRange: savenull(data['ControlRange']),
              SubLeader: savenull(data['SubLeader']),
              GL: savenull(data['GL']),
              JP: savenull(data['JP']),
              DGM: savenull(data['DGM']),
              PatternReport: savenull(data['PatternReport']),
              ReportOrder: savenull(data['ReportOrder']),
              TYPE: savenull(data['TYPE']),
              GROUP: savenull(data['GROUP']),
              MKTGROUP: savenull(data['MKTGROUP']),
              FRE: savenull(data['FRE']),
              REPORTITEMS: savenull(data['REPORTITEMS']),
            );
          }).toList();
          Navigator.pop(P02MASTERDETAILMAINcontext);
          toAdd.MasterTS = output;
        } else if (masterType == 'Routine_MasterPatternLab') {
          List<MasterLabclass> output = input.map((data) {
            return MasterLabclass(
              Id: savenull(data['Id']),
              CustId: savenull(data['CustId']),
              CustFull: savenull(data['CustFull']),
              CustShort: savenull(data['CustShort']),
              Branch: savenull(data['Branch']),
              Code: savenull(data['Code']),
              Incharge: savenull(data['Incharge']),
              FrequencyRequest: savenull(data['FrequencyRequest']),
              SampleNo: savenull(data['SampleNo']),
              SampleGroup: savenull(data['SampleGroup']),
              SampleType: savenull(data['SampleType']),
              SampleTank: savenull(data['SampleTank']),
              SampleName: savenull(data['SampleName']),
              SampleAmount: savenull(data['SampleAmount']),
              ProcessReportName: savenull(data['ProcessReportName']),
              Frequency: savenull(data['Frequency']),
              ItemNo: savenull(data['ItemNo']),
              InstrumentName: savenull(data['InstrumentName']),
              ItemName: savenull(data['ItemName']),
              ItemReportName: savenull(data['ItemReportName']),
              Position: savenull(data['Position']),
              Mag: savenull(data['Mag']),
              Temp: savenull(data['Temp']),
              StdMinL: savenull(data['StdMinL']),
              StdMaxL: savenull(data['StdMaxL']),
              StdFactor: savenull(data['StdFactor']),
              Std1: savenull(data['Std1']),
              Std2: savenull(data['Std2']),
              Std3: savenull(data['Std3']),
              Std4: savenull(data['Std4']),
              Std5: savenull(data['Std5']),
              Std6: savenull(data['Std6']),
              Std7: savenull(data['Std7']),
              Std8: savenull(data['Std8']),
              Std9: savenull(data['Std9']),
              StdMin: savenull(data['StdMin']),
              StdSymbol: savenull(data['StdSymbol']),
              StdMax: savenull(data['StdMax']),
              ControlRange: savenull(data['ControlRange']),
              ReportOrder: savenull(data['ReportOrder']),
              FactorC: savenull(data['FactorC']),
            );
          }).toList();
          Navigator.pop(P02MASTERDETAILMAINcontext);
          toAdd.MasterLab = output;
        }

        if (P02MASTERDETAILVAR.dropdownUser.isEmpty) {
          await getDropdown(P02MASTERDETAILMAINcontext);
        }

        emit(state.copyWith(
          MasterTS: state.MasterTS,
          MasterLab: state.MasterLab,
        ));

        // หรือ
        // final newState = state.copyWith(
        //   MasterTS: toAdd.MasterTS,
        //   MasterLab: toAdd.MasterLab,
        // );
        // emit(newState);

        //emit(toAdd);
      } else {
        Navigator.pop(P02MASTERDETAILMAINcontext);
        showErrorPopup(P02MASTERDETAILMAINcontext, response.toString());
        // output = [];
        emit(toAdd);
      }
    } on DioException catch (e) {
      Navigator.pop(P02MASTERDETAILMAINcontext);
      showErrorPopup(P02MASTERDETAILMAINcontext, "DIO");
      if (e.type == DioExceptionType.sendTimeout) {
        showErrorPopup(P02MASTERDETAILMAINcontext, "Send timeout");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        showErrorPopup(P02MASTERDETAILMAINcontext, "Receive timeout");
      } else {
        showErrorPopup(P02MASTERDETAILMAINcontext, e.message ?? "Unknown Dio error");
      }
    } catch (e) {
      Navigator.pop(P02MASTERDETAILMAINcontext);
      showErrorPopup(P02MASTERDETAILMAINcontext, e.toString());
    }
  }

  // Future<void> _P02MASTERDETAILGETDATA_GET2(
  //     List<P02MASTERDETAILGETDATAclass> toAdd, Emitter<List<P02MASTERDETAILGETDATAclass>> emit) async {
  //   // List<P02MASTERDETAILGETDATAclass> output = [];
  //   //-------------------------------------------------------------------------------------
  //   // var input = dummydatainput2;

  //   // List<P02MASTERDETAILGETDATAclass> outputdata = input
  //   //     .where((data) =>
  //   //         data['location'] == 'ESIE1' &&
  //   //         data['plant'] == 'YES' &&
  //   //         data['step01'] == 'YES')
  //   //     .map((data) {
  //   //   return P02MASTERDETAILGETDATAclass(
  //   //     PLANT: savenull(data['plant']),
  //   //     ORDER: savenull(data['order']),
  //   //     MAT: savenull(data['mat']),
  //   //     LOCATION: savenull(data['location']),
  //   //     LOT: savenull(data['lot']),
  //   //     CUSTOMER: savenull(data['customer']),
  //   //     PARTNO: savenull(data['partno']),
  //   //     PARTNAME: savenull(data['partname']),
  //   //     STEP01: savenull(data['step1']),
  //   //     STEP02: savenull(data['step2']),
  //   //     STEP03: savenull(data['step3']),
  //   //     STEP04: savenull(data['step4']),
  //   //     STEP05: savenull(data['step5']),
  //   //     STEP06: savenull(data['step6']),
  //   //     STEP07: savenull(data['step7']),
  //   //     STEP08: savenull(data['step8']),
  //   //     STEP09: savenull(data['step9']),
  //   //   );
  //   // }).toList();

  //   // output = outputdata;
  //   // emit(output);
  // }

  // Future<void> _P02MASTERDETAILGETDATA_GET3(
  //     List<P02MASTERDETAILGETDATAclass> toAdd, Emitter<List<P02MASTERDETAILGETDATAclass>> emit) async {
  //   // List<P02MASTERDETAILGETDATAclass> output = [];
  //   //-------------------------------------------------------------------------------------
  //   // List<P02MASTERDETAILGETDATAclass> datadummy = [
  //   //   P02MASTERDETAILGETDATAclass(
  //   //     PLANT: "PH PO:1234",
  //   //     STEP01: "YES",
  //   //     STEP02: "YES",
  //   //     STEP03: "YES",
  //   //   ),
  //   //   P02MASTERDETAILGETDATAclass(
  //   //     PLANT: "PH PO:5555",
  //   //     STEP01: "YES",
  //   //     STEP02: "YES",
  //   //     STEP03: "YES",
  //   //     STEP04: "YES",
  //   //   ),
  //   //   P02MASTERDETAILGETDATAclass(
  //   //     PLANT: "PH PO:5556",
  //   //     STEP01: "YES",
  //   //     STEP02: "YES",
  //   //   ),
  //   //   P02MASTERDETAILGETDATAclass(
  //   //     PLANT: "PH PO:9999",
  //   //   ),
  //   // ];

  //   // //-------------------------------------------------------------------------------------
  //   // output = datadummy;
  //   // emit(output);
  // }

  // Future<void> _P02MASTERDETAILGETDATA_FLUSH(
  //     List<P02MASTERDETAILGETDATAclass> toAdd, Emitter<List<P02MASTERDETAILGETDATAclass>> emit) async {
  //   List<P02MASTERDETAILGETDATAclass> output = [];
  //   emit(output);
  // }
}

class P02MASTERDETAILGETDATAclass {
  P02MASTERDETAILGETDATAclass({
    this.MasterTS = const [],
    this.MasterLab = const [],
  });
  List<MasterTSclass> MasterTS;
  List<MasterLabclass> MasterLab;

  P02MASTERDETAILGETDATAclass copyWith({
    List<MasterTSclass>? MasterTS,
    List<MasterLabclass>? MasterLab,
  }) {
    return P02MASTERDETAILGETDATAclass(
      MasterTS: MasterTS ?? this.MasterTS,
      MasterLab: MasterLab ?? this.MasterLab,
    );
  }
}

class MasterTSclass {
  MasterTSclass({
    this.Id = '',
    this.CustId = '',
    this.CustFull = '',
    this.CustShort = '',
    this.Incharge = '',
    this.SampleNo = '',
    this.GroupNameTS = '',
    this.SampleGroup = '',
    this.SampleType = '',
    this.SampleTank = '',
    this.SampleName = '',
    this.ProcessReportName = '',
    this.ItemNo = '',
    this.ItemName = '',
    this.ItemReportName = '',
    this.StdFactor = '',
    this.StdMin = '',
    this.StdSymbol = '',
    this.StdMax = '',
    this.ControlRange = '',
    this.SubLeader = '',
    this.GL = '',
    this.JP = '',
    this.DGM = '',
    this.PatternReport = '',
    this.ReportOrder = '',
    this.TYPE = '',
    this.GROUP = '',
    this.MKTGROUP = '',
    this.FRE = '',
    this.REPORTITEMS = '',
    this.isNewRow = false,
  });

  String Id;
  String CustId;
  String CustFull;
  String CustShort;
  String Incharge;
  String SampleNo;
  String GroupNameTS;
  String SampleGroup;
  String SampleType;
  String SampleTank;
  String SampleName;
  String ProcessReportName;
  String ItemNo;
  String ItemName;
  String ItemReportName;
  String StdFactor;
  String StdMin;
  String StdSymbol;
  String StdMax;
  String ControlRange;
  String SubLeader;
  String GL;
  String JP;
  String DGM;
  String PatternReport;
  String ReportOrder;
  String TYPE;
  String GROUP;
  String MKTGROUP;
  String FRE;
  String REPORTITEMS;
  bool isNewRow;

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'CustId': CustId,
      'CustFull': CustFull,
      'CustShort': CustShort,
      'Incharge': Incharge,
      'SampleNo': SampleNo,
      'GroupNameTS': GroupNameTS,
      'SampleGroup': SampleGroup,
      'SampleType': SampleType,
      'SampleTank': SampleTank,
      'SampleName': SampleName,
      'ProcessReportName': ProcessReportName,
      'ItemNo': ItemNo,
      'ItemName': ItemName,
      'ItemReportName': ItemReportName,
      'StdFactor': StdFactor,
      'StdMin': StdMin,
      'StdSymbol': StdSymbol,
      'StdMax': StdMax,
      'ControlRange': ControlRange,
      'SubLeader': SubLeader,
      'GL': GL,
      'JP': JP,
      'DGM': DGM,
      'PatternReport': PatternReport,
      'ReportOrder': ReportOrder,
      'TYPE': TYPE,
      'GROUP': GROUP,
      'MKTGROUP': MKTGROUP,
      'FRE': FRE,
      'REPORTITEMS': REPORTITEMS,
    };
  }
}

class MasterLabclass {
  MasterLabclass({
    this.Id = '',
    this.CustId = '',
    this.CustFull = '',
    this.CustShort = '',
    this.Branch = '',
    this.Code = '',
    this.Incharge = '',
    this.FrequencyRequest = '',
    this.SampleNo = '',
    this.SampleGroup = '',
    this.SampleType = '',
    this.SampleTank = '',
    this.SampleName = '',
    this.SampleAmount = '',
    this.ProcessReportName = '',
    this.Frequency = '',
    this.ItemNo = '',
    this.InstrumentName = '',
    this.ItemName = '',
    this.ItemReportName = '',
    this.Position = '',
    this.Mag = '',
    this.Temp = '',
    this.StdMinL = '',
    this.StdMaxL = '',
    this.StdFactor = '',
    this.Std1 = '',
    this.Std2 = '',
    this.Std3 = '',
    this.Std4 = '',
    this.Std5 = '',
    this.Std6 = '',
    this.Std7 = '',
    this.Std8 = '',
    this.Std9 = '',
    this.StdMin = '',
    this.StdSymbol = '',
    this.StdMax = '',
    this.ControlRange = '',
    this.ReportOrder = '',
    this.FactorC = '',
    this.isNewRow = false,
  });

  String Id;
  String CustId;
  String CustFull;
  String CustShort;
  String Branch;
  String Code;
  String Incharge;
  String FrequencyRequest;
  String SampleNo;
  String SampleGroup;
  String SampleType;
  String SampleTank;
  String SampleName;
  String SampleAmount;
  String ProcessReportName;
  String Frequency;
  String ItemNo;
  String InstrumentName;
  String ItemName;
  String ItemReportName;
  String Position;
  String Mag;
  String Temp;
  String StdMinL;
  String StdMaxL;
  String StdFactor;
  String Std1;
  String Std2;
  String Std3;
  String Std4;
  String Std5;
  String Std6;
  String Std7;
  String Std8;
  String Std9;
  String StdMin;
  String StdSymbol;
  String StdMax;
  String ControlRange;
  String ReportOrder;
  String FactorC;
  bool isNewRow;

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'CustId': CustId,
      'CustFull': CustFull,
      'CustShort': CustShort,
      'Branch': Branch,
      'Code': Code,
      'Incharge': Incharge,
      'FrequencyRequest': FrequencyRequest,
      'SampleNo': SampleNo,
      'SampleGroup': SampleGroup,
      'SampleType': SampleType,
      'SampleTank': SampleTank,
      'SampleName': SampleName,
      'SampleAmount': SampleAmount,
      'ProcessReportName': ProcessReportName,
      'Frequency': Frequency,
      'ItemNo': ItemNo,
      'InstrumentName': InstrumentName,
      'ItemName': ItemName,
      'ItemReportName': ItemReportName,
      'Position': Position,
      'Mag': Mag,
      'Temp': Temp,
      'StdMinL': StdMinL,
      'StdMaxL': StdMaxL,
      'StdFactor': StdFactor,
      'Std1': Std1,
      'Std2': Std2,
      'Std3': Std3,
      'Std4': Std4,
      'Std5': Std5,
      'Std6': Std6,
      'Std7': Std7,
      'Std8': Std8,
      'Std9': Std9,
      'StdMin': StdMin,
      'StdSymbol': StdSymbol,
      'StdMax': StdMax,
      'ControlRange': ControlRange,
      'ReportOrder': ReportOrder,
      'FactorC': FactorC,
    };
  }
}
