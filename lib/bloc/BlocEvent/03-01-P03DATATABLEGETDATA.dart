// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/global.dart';
import '../../page/P3DATATABLE/P03DATATABLEMAIN.dart';
import '../../page/P3DATATABLE/P03DATATABLEVAR.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/ForUseAllPage.dart';

//-------------------------------------------------

abstract class P03DATATABLEGETDATA_Event {}

class P03DATATABLEGETDATA_GET extends P03DATATABLEGETDATA_Event {}

class P03DATATABLEGETDATA_GET2 extends P03DATATABLEGETDATA_Event {}

class P03DATATABLEGETDATA_GET3 extends P03DATATABLEGETDATA_Event {}

class P03DATATABLEGETDATA_FLUSH extends P03DATATABLEGETDATA_Event {}

class P03DATATABLEGETDATA_Bloc extends Bloc<P03DATATABLEGETDATA_Event, List<P03DATATABLEGETDATAclass>> {
  P03DATATABLEGETDATA_Bloc() : super([]) {
    on<P03DATATABLEGETDATA_GET>((event, emit) {
      return _P03DATATABLEGETDATA_GET([], emit);
    });

    on<P03DATATABLEGETDATA_GET2>((event, emit) {
      return _P03DATATABLEGETDATA_GET2([], emit);
    });
    on<P03DATATABLEGETDATA_GET3>((event, emit) {
      return _P03DATATABLEGETDATA_GET3([], emit);
    });
    on<P03DATATABLEGETDATA_FLUSH>((event, emit) {
      return _P03DATATABLEGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P03DATATABLEGETDATA_GET(
      List<P03DATATABLEGETDATAclass> toAdd, Emitter<List<P03DATATABLEGETDATAclass>> emit) async {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    List<P03DATATABLEGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    try {
      final response = await Dio().post(
        "$ToServer/02SALTSPRAY/DataforTableStatus",
        data: {
          'Year': P03DATATABLEVAR.DropdownYear,
          'Month': P03DATATABLEVAR.DropdownMonth,
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
        print(response.statusCode);
        // print(response.data);
        var databuff = response.data;
        input = databuff;
        // var input = dummyAchievedCust;
        // print(input);
        List<P03DATATABLEGETDATAclass> outputdata = input.map((data) {
          return P03DATATABLEGETDATAclass(
            ID: savenull(data['ID']),
            TYPE: savenull(data['Type']),
            REQUESTNO: savenull(data['Request_No']),
            REPORTNO: savenull(data['Report_No']),
            SECTION: savenull(data['Section']),
            REQUESTER: savenull(data['Requester']),
            SAMPLINGDATE: formatDate(savenull(data['Sampling_Date'])),
            RECEIVEDDATE: formatDate(savenull(data['Received_Date'])),
            CUSTOMERNAME: savenull(data['Customer_Name']),
            PARTNAME1: savenull(data['Part_Name1']),
            PARTNO1: savenull(data['Part_No1']),
            LOTNO1: savenull(data['Lot_No1']),
            AMOUNT1: savenull(data['Amount1']),
            MATERIAL1: savenull(data['Material1']),
            PROCESS1: savenull(data['Process1']),
            PARTNAME2: savenull(data['Part_Name2']),
            PARTNO2: savenull(data['Part_No2']),
            LOTNO2: savenull(data['Lot_No2']),
            AMOUNT2: savenull(data['Amount2']),
            MATERIAL2: savenull(data['Material2']),
            PROCESS2: savenull(data['Process2']),
            PARTNAME3: savenull(data['Part_Name3']),
            PARTNO3: savenull(data['Part_No3']),
            LOTNO3: savenull(data['Lot_No3']),
            AMOUNT3: savenull(data['Amount3']),
            MATERIAL3: savenull(data['Material3']),
            PROCESS3: savenull(data['Process3']),
            PARTNAME4: savenull(data['Part_Name4']),
            PARTNO4: savenull(data['Part_No4']),
            LOTNO4: savenull(data['Lot_No4']),
            AMOUNT4: savenull(data['Amount4']),
            MATERIAL4: savenull(data['Material4']),
            PROCESS4: savenull(data['Process4']),
            PARTNAME5: savenull(data['Part_Name5']),
            PARTNO5: savenull(data['Part_No5']),
            LOTNO5: savenull(data['Lot_No5']),
            AMOUNT5: savenull(data['Amount5']),
            MATERIAL5: savenull(data['Material5']),
            PROCESS5: savenull(data['Process5']),
            PARTNAME6: savenull(data['Part_Name6']),
            PARTNO6: savenull(data['Part_No6']),
            LOTNO6: savenull(data['Lot_No6']),
            AMOUNT6: savenull(data['Amount6']),
            MATERIAL6: savenull(data['Material6']),
            PROCESS6: savenull(data['Process6']),
            PARTNAME7: savenull(data['Part_Name7']),
            PARTNO7: savenull(data['Part_No7']),
            LOTNO7: savenull(data['Lot_No7']),
            AMOUNT7: savenull(data['Amount7']),
            MATERIAL7: savenull(data['Material7']),
            PROCESS7: savenull(data['Process7']),
            PARTNAME8: savenull(data['Part_Name8']),
            PARTNO8: savenull(data['Part_No8']),
            LOTNO8: savenull(data['Lot_No8']),
            AMOUNT8: savenull(data['Amount8']),
            MATERIAL8: savenull(data['Material8']),
            PROCESS8: savenull(data['Process8']),
            PARTNAME9: savenull(data['Part_Name9']),
            PARTNO9: savenull(data['Part_No9']),
            LOTNO9: savenull(data['Lot_No9']),
            AMOUNT9: savenull(data['Amount9']),
            MATERIAL9: savenull(data['Material9']),
            PROCESS9: savenull(data['Process9']),
            PARTNAME10: savenull(data['Part_Name10']),
            PARTNO10: savenull(data['Part_No10']),
            LOTNO10: savenull(data['Lot_No10']),
            AMOUNT10: savenull(data['Amount10']),
            MATERIAL10: savenull(data['Material10']),
            PROCESS10: savenull(data['Process10']),
            // AMOUNTSAMPLE: savenullint(data['Amount_Sample']),
            TAKEPHOTO: savenullint(data['Take_Photo']),
            STARTDATE: formatDate(savenull(data['Start_Date'])),
            TIME1: savenullint(data['Time1']),
            FINISHDATE1: formatDate(savenull(data['Finish_Date1'])),
            TEMPDATE1: formatDate(savenull(data['Temp_Date1'])),
            DUEDATE1: formatDate(savenull(data['Due_Date1'])),
            TIME2: savenullint(data['Time2']),
            FINISHDATE2: formatDate(savenull(data['Finish_Date2'])),
            TEMPDATE2: formatDate(savenull(data['Temp_Date2'])),
            DUEDATE2: formatDate(savenull(data['Due_Date2'])),
            TIME3: savenullint(data['Time3']),
            FINISHDATE3: formatDate(savenull(data['Finish_Date3'])),
            TEMPDATE3: formatDate(savenull(data['Temp_Date3'])),
            DUEDATE3: formatDate(savenull(data['Due_Date3'])),
            TIME4: savenullint(data['Time4']),
            FINISHDATE4: formatDate(savenull(data['Finish_Date4'])),
            TEMPDATE4: formatDate(savenull(data['Temp_Date4'])),
            DUEDATE4: formatDate(savenull(data['Due_Date4'])),
            TIME5: savenullint(data['Time5']),
            FINISHDATE5: formatDate(savenull(data['Finish_Date5'])),
            TEMPDATE5: formatDate(savenull(data['Temp_Date5'])),
            DUEDATE5: formatDate(savenull(data['Due_Date5'])),
            TIME6: savenullint(data['Time6']),
            FINISHDATE6: formatDate(savenull(data['Finish_Date6'])),
            TEMPDATE6: formatDate(savenull(data['Temp_Date6'])),
            DUEDATE6: formatDate(savenull(data['Due_Date6'])),
            TIME7: savenullint(data['Time7']),
            FINISHDATE7: formatDate(savenull(data['Finish_Date7'])),
            TEMPDATE7: formatDate(savenull(data['Temp_Date7'])),
            DUEDATE7: formatDate(savenull(data['Due_Date7'])),
            TIME8: savenullint(data['Time8']),
            FINISHDATE8: formatDate(savenull(data['Finish_Date8'])),
            TEMPDATE8: formatDate(savenull(data['Temp_Date8'])),
            DUEDATE8: formatDate(savenull(data['Due_Date8'])),
            TIME9: savenullint(data['Time9']),
            FINISHDATE9: formatDate(savenull(data['Finish_Date9'])),
            TEMPDATE9: formatDate(savenull(data['Temp_Date9'])),
            DUEDATE9: formatDate(savenull(data['Due_Date9'])),
            TIME10: savenullint(data['Time10']),
            FINISHDATE10: formatDate(savenull(data['Finish_Date10'])),
            TEMPDATE10: formatDate(savenull(data['Temp_Date10'])),
            DUEDATE10: formatDate(savenull(data['Due_Date10'])),
            TEMPDATE0: formatDate(savenull(data['Temp_Date0'])),
            DUEDATE0: formatDate(savenull(data['Due_Date0'])),
            INSTRUMENT: savenull(data['Instrument']),
            METHOD: savenull(data['Method']),
            INCHARGE: savenull(data['Incharge']),
            APPROVEDDATE: formatDate(savenull(data['Approved_Date'])),
            APPROVEDBY: savenull(data['Approved_By']),
            STATUS: savenull(data['Status']),
            REMARK: savenull(data['Remark']),
            CHECKBOX: savenull(data['CheckBox']),
          );
        }).toList();
        Navigator.pop(P03DATATABLEMAINcontext);

        output = outputdata;
        emit(output);
      } else {
        Navigator.pop(P03DATATABLEMAINcontext);
        showErrorPopup(P03DATATABLEMAINcontext, response.toString());
        output = [];
        emit(output);
      }
    } on DioException catch (e) {
      Navigator.pop(P03DATATABLEMAINcontext);
      if (e.type == DioExceptionType.sendTimeout) {
        showErrorPopup(P03DATATABLEMAINcontext, "Send timeout");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        showErrorPopup(P03DATATABLEMAINcontext, "Receive timeout");
      } else {
        showErrorPopup(P03DATATABLEMAINcontext, e.message ?? "Unknown Dio error");
      }
    } catch (e) {
      Navigator.pop(P03DATATABLEMAINcontext);
      showErrorPopup(P03DATATABLEMAINcontext, e.toString());
    }
  }

  Future<void> _P03DATATABLEGETDATA_GET2(
      List<P03DATATABLEGETDATAclass> toAdd, Emitter<List<P03DATATABLEGETDATAclass>> emit) async {
    FreeLoadingTan(P03DATATABLEMAINcontext);
    // List<P03DATATABLEGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
  }

  Future<void> _P03DATATABLEGETDATA_GET3(
      List<P03DATATABLEGETDATAclass> toAdd, Emitter<List<P03DATATABLEGETDATAclass>> emit) async {
    // List<P03DATATABLEGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P03DATATABLEGETDATAclass> datadummy = [
    //   P03DATATABLEGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P03DATATABLEGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P03DATATABLEGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P03DATATABLEGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P03DATATABLEGETDATA_FLUSH(
      List<P03DATATABLEGETDATAclass> toAdd, Emitter<List<P03DATATABLEGETDATAclass>> emit) async {
    List<P03DATATABLEGETDATAclass> output = [];
    emit(output);
  }
}

class P03DATATABLEGETDATAclass {
  P03DATATABLEGETDATAclass({
    this.ID = '',
    this.TYPE = '',
    this.REQUESTNO = '',
    this.REPORTNO = '',
    this.SECTION = '',
    this.REQUESTER = '',
    this.SAMPLINGDATE = '',
    this.RECEIVEDDATE = '',
    this.CUSTOMERNAME = '',
    this.PARTNAME1 = '',
    this.PARTNO1 = '',
    this.LOTNO1 = '',
    this.AMOUNT1 = '',
    this.MATERIAL1 = '',
    this.PROCESS1 = '',
    this.PARTNAME2 = '',
    this.PARTNO2 = '',
    this.LOTNO2 = '',
    this.AMOUNT2 = '',
    this.MATERIAL2 = '',
    this.PROCESS2 = '',
    this.PARTNAME3 = '',
    this.PARTNO3 = '',
    this.LOTNO3 = '',
    this.AMOUNT3 = '',
    this.MATERIAL3 = '',
    this.PROCESS3 = '',
    this.PARTNAME4 = '',
    this.PARTNO4 = '',
    this.LOTNO4 = '',
    this.AMOUNT4 = '',
    this.MATERIAL4 = '',
    this.PROCESS4 = '',
    this.PARTNAME5 = '',
    this.PARTNO5 = '',
    this.LOTNO5 = '',
    this.AMOUNT5 = '',
    this.MATERIAL5 = '',
    this.PROCESS5 = '',
    this.PARTNAME6 = '',
    this.PARTNO6 = '',
    this.LOTNO6 = '',
    this.AMOUNT6 = '',
    this.MATERIAL6 = '',
    this.PROCESS6 = '',
    this.PARTNAME7 = '',
    this.PARTNO7 = '',
    this.LOTNO7 = '',
    this.AMOUNT7 = '',
    this.MATERIAL7 = '',
    this.PROCESS7 = '',
    this.PARTNAME8 = '',
    this.PARTNO8 = '',
    this.LOTNO8 = '',
    this.AMOUNT8 = '',
    this.MATERIAL8 = '',
    this.PROCESS8 = '',
    this.PARTNAME9 = '',
    this.PARTNO9 = '',
    this.LOTNO9 = '',
    this.AMOUNT9 = '',
    this.MATERIAL9 = '',
    this.PROCESS9 = '',
    this.PARTNAME10 = '',
    this.PARTNO10 = '',
    this.LOTNO10 = '',
    this.AMOUNT10 = '',
    this.MATERIAL10 = '',
    this.PROCESS10 = '',
    // this.AMOUNTSAMPLE = 0,
    this.TAKEPHOTO = 0,
    this.STARTDATE = '',
    this.TIME1 = 0,
    this.FINISHDATE1 = '',
    this.TEMPDATE1 = '',
    this.DUEDATE1 = '',
    this.TIME2 = 0,
    this.FINISHDATE2 = '',
    this.TEMPDATE2 = '',
    this.DUEDATE2 = '',
    this.TIME3 = 0,
    this.FINISHDATE3 = '',
    this.TEMPDATE3 = '',
    this.DUEDATE3 = '',
    this.TIME4 = 0,
    this.FINISHDATE4 = '',
    this.TEMPDATE4 = '',
    this.DUEDATE4 = '',
    this.TIME5 = 0,
    this.FINISHDATE5 = '',
    this.TEMPDATE5 = '',
    this.DUEDATE5 = '',
    this.TIME6 = 0,
    this.FINISHDATE6 = '',
    this.TEMPDATE6 = '',
    this.DUEDATE6 = '',
    this.TIME7 = 0,
    this.FINISHDATE7 = '',
    this.TEMPDATE7 = '',
    this.DUEDATE7 = '',
    this.TIME8 = 0,
    this.FINISHDATE8 = '',
    this.TEMPDATE8 = '',
    this.DUEDATE8 = '',
    this.TIME9 = 0,
    this.FINISHDATE9 = '',
    this.TEMPDATE9 = '',
    this.DUEDATE9 = '',
    this.TIME10 = 0,
    this.FINISHDATE10 = '',
    this.TEMPDATE10 = '',
    this.DUEDATE10 = '',
    this.TEMPDATE0 = '',
    this.DUEDATE0 = '',
    this.INSTRUMENT = '',
    this.METHOD = '',
    this.INCHARGE = '',
    this.APPROVEDDATE = '',
    this.APPROVEDBY = '',
    this.STATUS = '',
    this.REMARK = '',
    this.CHECKBOX = '',
  });
  String ID;
  String TYPE;
  String REQUESTNO;
  String REPORTNO;
  String SECTION;
  String REQUESTER;
  String SAMPLINGDATE;
  String RECEIVEDDATE;
  String CUSTOMERNAME;
  String PARTNAME1;
  String PARTNO1;
  String LOTNO1;
  String AMOUNT1;
  String MATERIAL1;
  String PROCESS1;
  String PARTNAME2;
  String PARTNO2;
  String LOTNO2;
  String AMOUNT2;
  String MATERIAL2;
  String PROCESS2;
  String PARTNAME3;
  String PARTNO3;
  String LOTNO3;
  String AMOUNT3;
  String MATERIAL3;
  String PROCESS3;
  String PARTNAME4;
  String PARTNO4;
  String LOTNO4;
  String AMOUNT4;
  String MATERIAL4;
  String PROCESS4;
  String PARTNAME5;
  String PARTNO5;
  String LOTNO5;
  String AMOUNT5;
  String MATERIAL5;
  String PROCESS5;
  String PARTNAME6;
  String PARTNO6;
  String LOTNO6;
  String AMOUNT6;
  String MATERIAL6;
  String PROCESS6;
  String PARTNAME7;
  String PARTNO7;
  String LOTNO7;
  String AMOUNT7;
  String MATERIAL7;
  String PROCESS7;
  String PARTNAME8;
  String PARTNO8;
  String LOTNO8;
  String AMOUNT8;
  String MATERIAL8;
  String PROCESS8;
  String PARTNAME9;
  String PARTNO9;
  String LOTNO9;
  String AMOUNT9;
  String MATERIAL9;
  String PROCESS9;
  String PARTNAME10;
  String PARTNO10;
  String LOTNO10;
  String AMOUNT10;
  String MATERIAL10;
  String PROCESS10;
  // int AMOUNTSAMPLE;
  int TAKEPHOTO;
  String STARTDATE;
  int TIME1;
  String FINISHDATE1;
  String TEMPDATE1;
  String DUEDATE1;
  int TIME2;
  String FINISHDATE2;
  String TEMPDATE2;
  String DUEDATE2;
  int TIME3;
  String FINISHDATE3;
  String TEMPDATE3;
  String DUEDATE3;
  int TIME4;
  String FINISHDATE4;
  String TEMPDATE4;
  String DUEDATE4;
  int TIME5;
  String FINISHDATE5;
  String TEMPDATE5;
  String DUEDATE5;
  int TIME6;
  String FINISHDATE6;
  String TEMPDATE6;
  String DUEDATE6;
  int TIME7;
  String FINISHDATE7;
  String TEMPDATE7;
  String DUEDATE7;
  int TIME8;
  String FINISHDATE8;
  String TEMPDATE8;
  String DUEDATE8;
  int TIME9;
  String FINISHDATE9;
  String TEMPDATE9;
  String DUEDATE9;
  int TIME10;
  String FINISHDATE10;
  String TEMPDATE10;
  String DUEDATE10;
  String TEMPDATE0;
  String DUEDATE0;
  String INSTRUMENT;
  String METHOD;
  String INCHARGE;
  String APPROVEDDATE;
  String APPROVEDBY;
  String STATUS;
  String REMARK;
  String CHECKBOX;
  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'TYPE': TYPE,
      'REQUESTNO': REQUESTNO,
      'REPORTNO': REPORTNO,
      'SECTION': SECTION,
      'REQUESTER': REQUESTER,
      'SAMPLINGDATE': SAMPLINGDATE,
      'RECEIVEDDATE': RECEIVEDDATE,
      'CUSTOMERNAME': CUSTOMERNAME,
      'PARTNAME1': PARTNAME1,
      'PARTNO1': PARTNO1,
      'LOTNO1': LOTNO1,
      'AMOUNT1': AMOUNT1,
      'MATERIAL1': MATERIAL1,
      'PROCESS1': PROCESS1,
      'PARTNAME2': PARTNAME2,
      'PARTNO2': PARTNO2,
      'LOTNO2': LOTNO2,
      'AMOUNT2': AMOUNT2,
      'MATERIAL2': MATERIAL2,
      'PROCESS2': PROCESS2,
      'PARTNAME3': PARTNAME3,
      'PARTNO3': PARTNO3,
      'LOTNO3': LOTNO3,
      'AMOUNT3': AMOUNT3,
      'MATERIAL3': MATERIAL3,
      'PROCESS3': PROCESS3,
      'PARTNAME4': PARTNAME4,
      'PARTNO4': PARTNO4,
      'LOTNO4': LOTNO4,
      'AMOUNT4': AMOUNT4,
      'MATERIAL4': MATERIAL4,
      'PROCESS4': PROCESS4,
      'PARTNAME5': PARTNAME5,
      'PARTNO5': PARTNO5,
      'LOTNO5': LOTNO5,
      'AMOUNT5': AMOUNT5,
      'MATERIAL5': MATERIAL5,
      'PROCESS5': PROCESS5,
      'PARTNAME6': PARTNAME6,
      'PARTNO6': PARTNO6,
      'LOTNO6': LOTNO6,
      'AMOUNT6': AMOUNT6,
      'MATERIAL6': MATERIAL6,
      'PROCESS6': PROCESS6,
      'PARTNAME7': PARTNAME7,
      'PARTNO7': PARTNO7,
      'LOTNO7': LOTNO7,
      'AMOUNT7': AMOUNT7,
      'MATERIAL7': MATERIAL7,
      'PROCESS7': PROCESS7,
      'PARTNAME8': PARTNAME8,
      'PARTNO8': PARTNO8,
      'LOTNO8': LOTNO8,
      'AMOUNT8': AMOUNT8,
      'MATERIAL8': MATERIAL8,
      'PROCESS8': PROCESS8,
      'PARTNAME9': PARTNAME9,
      'PARTNO9': PARTNO9,
      'LOTNO9': LOTNO9,
      'AMOUNT9': AMOUNT9,
      'MATERIAL9': MATERIAL9,
      'PROCESS9': PROCESS9,
      'PARTNAME10': PARTNAME10,
      'PARTNO10': PARTNO10,
      'LOTNO10': LOTNO10,
      'AMOUNT10': AMOUNT10,
      'MATERIAL10': MATERIAL10,
      'PROCESS10': PROCESS10,
      // 'AMOUNTSAMPLE': AMOUNTSAMPLE,
      'TAKEPHOTO': TAKEPHOTO,
      'STARTDATE': STARTDATE,
      'TIME1': TIME1,
      'FINISHDATE1': FINISHDATE1,
      'TEMPDATE1': TEMPDATE1,
      'DUEDATE1': DUEDATE1,
      'TIME2': TIME2,
      'FINISHDATE2': FINISHDATE2,
      'TEMPDATE2': TEMPDATE2,
      'DUEDATE2': DUEDATE2,
      'TIME3': TIME3,
      'FINISHDATE3': FINISHDATE3,
      'TEMPDATE3': TEMPDATE3,
      'DUEDATE3': DUEDATE3,
      'TIME4': TIME4,
      'FINISHDATE4': FINISHDATE4,
      'TEMPDATE4': TEMPDATE4,
      'DUEDATE4': DUEDATE4,
      'TIME5': TIME5,
      'FINISHDATE5': FINISHDATE5,
      'TEMPDATE5': TEMPDATE5,
      'DUEDATE5': DUEDATE5,
      'TIME6': TIME6,
      'FINISHDATE6': FINISHDATE6,
      'TEMPDATE6': TEMPDATE6,
      'DUEDATE6': DUEDATE6,
      'TIME7': TIME7,
      'FINISHDATE7': FINISHDATE7,
      'TEMPDATE7': TEMPDATE7,
      'DUEDATE7': DUEDATE7,
      'TIME8': TIME8,
      'FINISHDATE8': FINISHDATE8,
      'TEMPDATE8': TEMPDATE8,
      'DUEDATE8': DUEDATE8,
      'TIME9': TIME9,
      'FINISHDATE9': FINISHDATE9,
      'TEMPDATE9': TEMPDATE9,
      'DUEDATE9': DUEDATE9,
      'TIME10': TIME10,
      'FINISHDATE10': FINISHDATE10,
      'TEMPDATE10': TEMPDATE10,
      'DUEDATE10': DUEDATE10,
      'TEMPDATE0': TEMPDATE0,
      'DUEDATE0': DUEDATE0,
      'INSTRUMENT': INSTRUMENT,
      'METHOD': METHOD,
      'INCHARGE': INCHARGE,
      'APPROVEDDATE': APPROVEDDATE,
      'APPROVEDBY': APPROVEDBY,
      'STATUS': STATUS,
      'REMARK': REMARK,
      'CHECKBOX': CHECKBOX,
    };
  }
}

Map<String, dynamic> toJsonAddDate() {
  return {
    'ID': P03DATATABLEVAR.ID,
    'TYPE': P03DATATABLEVAR.TYPE,
    'REQUESTNO': P03DATATABLEVAR.REQUESTNO,
    'REPORTNO': P03DATATABLEVAR.REPORTNO,
    'SECTION': P03DATATABLEVAR.SECTION,
    'REQUESTER': P03DATATABLEVAR.REQUESTER,
    'SAMPLINGDATE': P03DATATABLEVAR.SAMPLINGDATE,
    'RECEIVEDDATE': P03DATATABLEVAR.RECEIVEDDATE,
    'CUSTOMERNAME': P03DATATABLEVAR.CUSTOMERNAME,
    'PARTNAME1': P03DATATABLEVAR.PARTNAME1,
    'PARTNO1': P03DATATABLEVAR.PARTNO1,
    'LOTNO1': P03DATATABLEVAR.LOTNO1,
    'AMOUNT1': P03DATATABLEVAR.AMOUNT1,
    'MATERIAL1': P03DATATABLEVAR.MATERIAL1,
    'PROCESS1': P03DATATABLEVAR.PROCESS1,
    'PARTNAME2': P03DATATABLEVAR.PARTNAME2,
    'PARTNO2': P03DATATABLEVAR.PARTNO2,
    'LOTNO2': P03DATATABLEVAR.LOTNO2,
    'AMOUNT2': P03DATATABLEVAR.AMOUNT2,
    'MATERIAL2': P03DATATABLEVAR.MATERIAL2,
    'PROCESS2': P03DATATABLEVAR.PROCESS2,
    'PARTNAME3': P03DATATABLEVAR.PARTNAME3,
    'PARTNO3': P03DATATABLEVAR.PARTNO3,
    'LOTNO3': P03DATATABLEVAR.LOTNO3,
    'AMOUNT3': P03DATATABLEVAR.AMOUNT3,
    'MATERIAL3': P03DATATABLEVAR.MATERIAL3,
    'PROCESS3': P03DATATABLEVAR.PROCESS3,
    'PARTNAME4': P03DATATABLEVAR.PARTNAME4,
    'PARTNO4': P03DATATABLEVAR.PARTNO4,
    'LOTNO4': P03DATATABLEVAR.LOTNO4,
    'AMOUNT4': P03DATATABLEVAR.AMOUNT4,
    'MATERIAL4': P03DATATABLEVAR.MATERIAL4,
    'PROCESS4': P03DATATABLEVAR.PROCESS4,
    'PARTNAME5': P03DATATABLEVAR.PARTNAME5,
    'PARTNO5': P03DATATABLEVAR.PARTNO5,
    'LOTNO5': P03DATATABLEVAR.LOTNO5,
    'AMOUNT5': P03DATATABLEVAR.AMOUNT5,
    'MATERIAL5': P03DATATABLEVAR.MATERIAL5,
    'PROCESS5': P03DATATABLEVAR.PROCESS5,
    'PARTNAME6': P03DATATABLEVAR.PARTNAME6,
    'PARTNO6': P03DATATABLEVAR.PARTNO6,
    'LOTNO6': P03DATATABLEVAR.LOTNO6,
    'AMOUNT6': P03DATATABLEVAR.AMOUNT6,
    'MATERIAL6': P03DATATABLEVAR.MATERIAL6,
    'PROCESS6': P03DATATABLEVAR.PROCESS6,
    'PARTNAME7': P03DATATABLEVAR.PARTNAME7,
    'PARTNO7': P03DATATABLEVAR.PARTNO7,
    'LOTNO7': P03DATATABLEVAR.LOTNO7,
    'AMOUNT7': P03DATATABLEVAR.AMOUNT7,
    'MATERIAL7': P03DATATABLEVAR.MATERIAL7,
    'PROCESS7': P03DATATABLEVAR.PROCESS7,
    'PARTNAME8': P03DATATABLEVAR.PARTNAME8,
    'PARTNO8': P03DATATABLEVAR.PARTNO8,
    'LOTNO8': P03DATATABLEVAR.LOTNO8,
    'AMOUNT8': P03DATATABLEVAR.AMOUNT8,
    'MATERIAL8': P03DATATABLEVAR.MATERIAL8,
    'PROCESS8': P03DATATABLEVAR.PROCESS8,
    'PARTNAME9': P03DATATABLEVAR.PARTNAME9,
    'PARTNO9': P03DATATABLEVAR.PARTNO9,
    'LOTNO9': P03DATATABLEVAR.LOTNO9,
    'AMOUNT9': P03DATATABLEVAR.AMOUNT9,
    'MATERIAL9': P03DATATABLEVAR.MATERIAL9,
    'PROCESS9': P03DATATABLEVAR.PROCESS9,
    'PARTNAME10': P03DATATABLEVAR.PARTNAME10,
    'PARTNO10': P03DATATABLEVAR.PARTNO10,
    'LOTNO10': P03DATATABLEVAR.LOTNO10,
    'AMOUNT10': P03DATATABLEVAR.AMOUNT10,
    'MATERIAL10': P03DATATABLEVAR.MATERIAL10,
    'PROCESS10': P03DATATABLEVAR.PROCESS10,
    // 'AMOUNTSAMPLE': P03DATATABLEVAR.AMOUNTSAMPLE,
    'TAKEPHOTO': P03DATATABLEVAR.TAKEPHOTO,
    'STARTDATE': P03DATATABLEVAR.STARTDATE,
    'TIME1': P03DATATABLEVAR.TIME1,
    'FINISHDATE1': P03DATATABLEVAR.FINISHDATE1,
    'TEMPDATE1': P03DATATABLEVAR.TEMPDATE1,
    'DUEDATE1': P03DATATABLEVAR.DUEDATE1,
    'TIME2': P03DATATABLEVAR.TIME2,
    'FINISHDATE2': P03DATATABLEVAR.FINISHDATE2,
    'TEMPDATE2': P03DATATABLEVAR.TEMPDATE2,
    'DUEDATE2': P03DATATABLEVAR.DUEDATE2,
    'TIME3': P03DATATABLEVAR.TIME3,
    'FINISHDATE3': P03DATATABLEVAR.FINISHDATE3,
    'TEMPDATE3': P03DATATABLEVAR.TEMPDATE3,
    'DUEDATE3': P03DATATABLEVAR.DUEDATE3,
    'TIME4': P03DATATABLEVAR.TIME4,
    'FINISHDATE4': P03DATATABLEVAR.FINISHDATE4,
    'TEMPDATE4': P03DATATABLEVAR.TEMPDATE4,
    'DUEDATE4': P03DATATABLEVAR.DUEDATE4,
    'TIME5': P03DATATABLEVAR.TIME5,
    'FINISHDATE5': P03DATATABLEVAR.FINISHDATE5,
    'TEMPDATE5': P03DATATABLEVAR.TEMPDATE5,
    'DUEDATE5': P03DATATABLEVAR.DUEDATE5,
    'TIME6': P03DATATABLEVAR.TIME6,
    'FINISHDATE6': P03DATATABLEVAR.FINISHDATE6,
    'TEMPDATE6': P03DATATABLEVAR.TEMPDATE6,
    'DUEDATE6': P03DATATABLEVAR.DUEDATE6,
    'TIME7': P03DATATABLEVAR.TIME7,
    'FINISHDATE7': P03DATATABLEVAR.FINISHDATE7,
    'TEMPDATE7': P03DATATABLEVAR.TEMPDATE7,
    'DUEDATE7': P03DATATABLEVAR.DUEDATE7,
    'TIME8': P03DATATABLEVAR.TIME8,
    'FINISHDATE8': P03DATATABLEVAR.FINISHDATE8,
    'TEMPDATE8': P03DATATABLEVAR.TEMPDATE8,
    'DUEDATE8': P03DATATABLEVAR.DUEDATE8,
    'TIME9': P03DATATABLEVAR.TIME9,
    'FINISHDATE9': P03DATATABLEVAR.FINISHDATE9,
    'TEMPDATE9': P03DATATABLEVAR.TEMPDATE9,
    'DUEDATE9': P03DATATABLEVAR.DUEDATE9,
    'TIME10': P03DATATABLEVAR.TIME10,
    'FINISHDATE10': P03DATATABLEVAR.FINISHDATE10,
    'TEMPDATE10': P03DATATABLEVAR.TEMPDATE10,
    'DUEDATE10': P03DATATABLEVAR.DUEDATE10,
    'TEMPDATE0': P03DATATABLEVAR.TEMPDATE0,
    'DUEDATE0': P03DATATABLEVAR.DUEDATE0,
    'INSTRUMENT': P03DATATABLEVAR.INSTRUMENT,
    'METHOD': P03DATATABLEVAR.METHOD,
    'INCHARGE': P03DATATABLEVAR.INCHARGE,
    'APPROVEDDATE': P03DATATABLEVAR.APPROVEDDATE,
    'APPROVEDBY': P03DATATABLEVAR.APPROVEDBY,
    'STATUS': P03DATATABLEVAR.STATUS,
    'REMARK': P03DATATABLEVAR.REMARK,
    'CHECKBOX': P03DATATABLEVAR.CHECKBOX,
  };
}

String savenull(input) {
  String output = '';
  if (input != null) {
    output = input.toString();
  }
  return output;
}

int savenullint(input) {
  int output = 0;
  if (input != null) {
    output = input;
  }
  return output;
}

// String formatDate(String? date) {
//   if (date == null || date.isEmpty) return '';
//   try {
//     DateTime parsedDate = DateTime.parse(date);
//     if (parsedDate.hour == 0 && parsedDate.minute == 0 && parsedDate.second == 0) {
//       return DateFormat('dd-MM-yy').format(parsedDate);
//     } else {
//       return DateFormat('dd-MM-yy HH:mm').format(parsedDate);
//     }
//   } catch (e) {
//     return '';
//   }
// }

// DateTime? convertStringToDateTime(String input) {
//   try {
//     if (input == '') {
//       return null;
//     }
//     final formatter = input.contains(' ') ? DateFormat("dd-MM-yy HH:mm") : DateFormat("dd-MM-yy");
//     return formatter.parseStrict(input);
//   } catch (e) {
//     print("Error parsing date: $e");
//     return null;
//   }
// }
