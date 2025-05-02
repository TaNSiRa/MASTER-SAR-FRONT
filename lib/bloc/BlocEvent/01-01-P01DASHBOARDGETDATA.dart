// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/global.dart';
import '../../page/P1DASHBOARD/P01DASHBOARDMAIN.dart';
import '../../page/P1DASHBOARD/P01DASHBOARDVAR.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_GET extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_GET2 extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_GET3 extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_FLUSH extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_Bloc extends Bloc<P01DASHBOARDGETDATA_Event, List<P01DASHBOARDGETDATAclass>> {
  P01DASHBOARDGETDATA_Bloc() : super([]) {
    on<P01DASHBOARDGETDATA_GET>((event, emit) {
      return _P01DASHBOARDGETDATA_GET([], emit);
    });

    on<P01DASHBOARDGETDATA_GET2>((event, emit) {
      return _P01DASHBOARDGETDATA_GET2([], emit);
    });
    on<P01DASHBOARDGETDATA_GET3>((event, emit) {
      return _P01DASHBOARDGETDATA_GET3([], emit);
    });
    on<P01DASHBOARDGETDATA_FLUSH>((event, emit) {
      return _P01DASHBOARDGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P01DASHBOARDGETDATA_GET(
      List<P01DASHBOARDGETDATAclass> toAdd, Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    // FreeLoadingTan(P01DASHBOARDMAINcontext);
    List<P01DASHBOARDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/DataTable",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
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
      List<P01DASHBOARDGETDATAclass> outputdata = input.map((data) {
        return P01DASHBOARDGETDATAclass(
          REQUESTNO: savenull(data['Request_No']),
          REPORTNO: savenull(data['Report_No']),
          SECTION: savenull(data['Section']),
          REQUESTER: savenull(data['Requester']),
          RECEIVEDDATE: formatDate(savenull(data['Received_Date'])),
          CUSTOMERNAME: savenull(data['Customer_Name']),
          PARTNAME1: savenull(data['Part_Name1']),
          PARTNO1: savenull(data['Part_No1']),
          PARTNAME2: savenull(data['Part_Name2']),
          PARTNO2: savenull(data['Part_No2']),
          PARTNAME3: savenull(data['Part_Name3']),
          PARTNO3: savenull(data['Part_No3']),
          PARTNAME4: savenull(data['Part_Name4']),
          PARTNO4: savenull(data['Part_No4']),
          PARTNAME5: savenull(data['Part_Name5']),
          PARTNO5: savenull(data['Part_No5']),
          PARTNAME6: savenull(data['Part_Name6']),
          PARTNO6: savenull(data['Part_No6']),
          PARTNAME7: savenull(data['Part_Name7']),
          PARTNO7: savenull(data['Part_No7']),
          PARTNAME8: savenull(data['Part_Name8']),
          PARTNO8: savenull(data['Part_No8']),
          PARTNAME9: savenull(data['Part_Name9']),
          PARTNO9: savenull(data['Part_No9']),
          PARTNAME10: savenull(data['Part_Name10']),
          PARTNO10: savenull(data['Part_No10']),
          AMOUNTSAMPLE: savenullint(data['Amount_Sample']),
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
      // Navigator.pop(P01DASHBOARDMAINcontext);

      output = outputdata;
      emit(output);
    } else {
      // Navigator.pop(P01DASHBOARDMAINcontext);
      showErrorPopup(P01DASHBOARDMAINcontext, response.toString());
      output = [];
      emit(output);
    }
  }

  Future<void> _P01DASHBOARDGETDATA_GET2(
      List<P01DASHBOARDGETDATAclass> toAdd, Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    FreeLoadingTan(P01DASHBOARDMAINcontext);
    // List<P01DASHBOARDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    final responseInstrument = await Dio().post(
      "$ToServer/02SALTSPRAY/InstrumentStatus",
      data: {},
      // options: Options(
      //   validateStatus: (status) {
      //     return true;
      //   },
      // ),
    );

    if (responseInstrument.statusCode == 200) {
      print(responseInstrument.statusCode);
      // print(response.data);
      var databuff = responseInstrument.data;
      // print(databuff);
      // print(databuff[0]['Status']);
      // print(databuff[1]['Status']);
      // print(databuff[2]['Status']);
      // print(databuff[3]['Status']);
      P01DASHBOARDVAR.SST1Staus = databuff[0]['Status'];
      P01DASHBOARDVAR.SST2Staus = databuff[1]['Status'];
      P01DASHBOARDVAR.SST3Staus = databuff[2]['Status'];
      P01DASHBOARDVAR.SST4Staus = databuff[3]['Status'];
      // print(P01DASHBOARDVAR.SST1Staus);
      // print(P01DASHBOARDVAR.SST2Staus);
      // print(P01DASHBOARDVAR.SST3Staus);
      // print(P01DASHBOARDVAR.SST4Staus);
      Navigator.pop(P01DASHBOARDMAINcontext);
    } else {
      Navigator.pop(P01DASHBOARDMAINcontext);
      showErrorPopup(P01DASHBOARDMAINcontext, responseInstrument.toString());
    }
  }

  Future<void> _P01DASHBOARDGETDATA_GET3(
      List<P01DASHBOARDGETDATAclass> toAdd, Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    // List<P01DASHBOARDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P01DASHBOARDGETDATAclass> datadummy = [
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P01DASHBOARDGETDATA_FLUSH(
      List<P01DASHBOARDGETDATAclass> toAdd, Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    List<P01DASHBOARDGETDATAclass> output = [];
    emit(output);
  }
}

class P01DASHBOARDGETDATAclass {
  P01DASHBOARDGETDATAclass({
    this.REQUESTNO = '',
    this.REPORTNO = '',
    this.SECTION = '',
    this.REQUESTER = '',
    this.RECEIVEDDATE = '',
    this.CUSTOMERNAME = '',
    this.PARTNAME1 = '',
    this.PARTNO1 = '',
    this.PARTNAME2 = '',
    this.PARTNO2 = '',
    this.PARTNAME3 = '',
    this.PARTNO3 = '',
    this.PARTNAME4 = '',
    this.PARTNO4 = '',
    this.PARTNAME5 = '',
    this.PARTNO5 = '',
    this.PARTNAME6 = '',
    this.PARTNO6 = '',
    this.PARTNAME7 = '',
    this.PARTNO7 = '',
    this.PARTNAME8 = '',
    this.PARTNO8 = '',
    this.PARTNAME9 = '',
    this.PARTNO9 = '',
    this.PARTNAME10 = '',
    this.PARTNO10 = '',
    this.AMOUNTSAMPLE = 0,
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
    this.INSTRUMENT = '',
    this.METHOD = '',
    this.INCHARGE = '',
    this.APPROVEDDATE = '',
    this.APPROVEDBY = '',
    this.STATUS = '',
    this.REMARK = '',
    this.CHECKBOX = '',
  });

  String REQUESTNO;
  String REPORTNO;
  String SECTION;
  String REQUESTER;
  String RECEIVEDDATE;
  String CUSTOMERNAME;
  String PARTNAME1;
  String PARTNO1;
  String PARTNAME2;
  String PARTNO2;
  String PARTNAME3;
  String PARTNO3;
  String PARTNAME4;
  String PARTNO4;
  String PARTNAME5;
  String PARTNO5;
  String PARTNAME6;
  String PARTNO6;
  String PARTNAME7;
  String PARTNO7;
  String PARTNAME8;
  String PARTNO8;
  String PARTNAME9;
  String PARTNO9;
  String PARTNAME10;
  String PARTNO10;
  int AMOUNTSAMPLE;
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
  String INSTRUMENT;
  String METHOD;
  String INCHARGE;
  String APPROVEDDATE;
  String APPROVEDBY;
  String STATUS;
  String REMARK;
  String CHECKBOX;
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

String formatDate(String? date) {
  if (date == null || date.isEmpty) return '';
  try {
    DateTime parsedDate = DateTime.parse(date);
    if (parsedDate.hour == 0 && parsedDate.minute == 0 && parsedDate.second == 0) {
      return DateFormat('dd-MM-yy').format(parsedDate);
    } else {
      return DateFormat('dd-MM-yy HH:mm').format(parsedDate);
    }
  } catch (e) {
    return '';
  }
}

DateTime? convertStringToDateTime(String input) {
  try {
    if (input == '') {
      return null;
    }
    final formatter = input.contains(' ') ? DateFormat("dd-MM-yy HH:mm") : DateFormat("dd-MM-yy");
    return formatter.parseStrict(input);
  } catch (e) {
    print("Error parsing date: $e");
    return null;
  }
}
