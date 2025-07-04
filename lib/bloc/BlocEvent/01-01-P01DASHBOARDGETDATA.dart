// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/global.dart';
import '../../page/P1DASHBOARD/P01DASHBOARDMAIN.dart';
import '../../page/P1DASHBOARD/P01DASHBOARDVAR.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/function/ForUseAllPage.dart';

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
    // FreeLoadingTan(P01DASHBOARDMAINcontext);
    // List<P01DASHBOARDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // final responseInstrument = await Dio().post(
    //   "$ToServer/02SALTSPRAY/InstrumentStatus",
    //   data: {},
    // );

    // if (responseInstrument.statusCode == 200) {
    //   print(responseInstrument.statusCode);
    //   var databuff = responseInstrument.data;
    //   P01DASHBOARDVAR.SST1Staus = databuff[0]['Status'];
    //   P01DASHBOARDVAR.SST2Staus = databuff[1]['Status'];
    //   P01DASHBOARDVAR.SST3Staus = databuff[2]['Status'];
    //   P01DASHBOARDVAR.SST4Staus = databuff[3]['Status'];
    //   // Navigator.pop(P01DASHBOARDMAINcontext);
    // } else {
    //   // Navigator.pop(P01DASHBOARDMAINcontext);
    //   showErrorPopup(P01DASHBOARDMAINcontext, responseInstrument.toString());
    // }
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
  Map<String, dynamic> toJson() {
    return {
      'REQUESTNO': REQUESTNO,
      'REPORTNO': REPORTNO,
      'SECTION': SECTION,
      'REQUESTER': REQUESTER,
      'RECEIVEDDATE': RECEIVEDDATE,
      'CUSTOMERNAME': CUSTOMERNAME,
      'PARTNAME1': PARTNAME1,
      'PARTNO1': PARTNO1,
      'PARTNAME2': PARTNAME2,
      'PARTNO2': PARTNO2,
      'PARTNAME3': PARTNAME3,
      'PARTNO3': PARTNO3,
      'PARTNAME4': PARTNAME4,
      'PARTNO4': PARTNO4,
      'PARTNAME5': PARTNAME5,
      'PARTNO5': PARTNO5,
      'PARTNAME6': PARTNAME6,
      'PARTNO6': PARTNO6,
      'PARTNAME7': PARTNAME7,
      'PARTNO7': PARTNO7,
      'PARTNAME8': PARTNAME8,
      'PARTNO8': PARTNO8,
      'PARTNAME9': PARTNAME9,
      'PARTNO9': PARTNO9,
      'PARTNAME10': PARTNAME10,
      'PARTNO10': PARTNO10,
      'AMOUNTSAMPLE': AMOUNTSAMPLE,
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
    'REQUESTNO': P01DASHBOARDVAR.REQUESTNO,
    'REPORTNO': P01DASHBOARDVAR.REPORTNO,
    'SECTION': P01DASHBOARDVAR.SECTION,
    'REQUESTER': P01DASHBOARDVAR.REQUESTER,
    'RECEIVEDDATE': P01DASHBOARDVAR.RECEIVEDDATE,
    'CUSTOMERNAME': P01DASHBOARDVAR.CUSTOMERNAME,
    'PARTNAME1': P01DASHBOARDVAR.PARTNAME1,
    'PARTNO1': P01DASHBOARDVAR.PARTNO1,
    'PARTNAME2': P01DASHBOARDVAR.PARTNAME2,
    'PARTNO2': P01DASHBOARDVAR.PARTNO2,
    'PARTNAME3': P01DASHBOARDVAR.PARTNAME3,
    'PARTNO3': P01DASHBOARDVAR.PARTNO3,
    'PARTNAME4': P01DASHBOARDVAR.PARTNAME4,
    'PARTNO4': P01DASHBOARDVAR.PARTNO4,
    'PARTNAME5': P01DASHBOARDVAR.PARTNAME5,
    'PARTNO5': P01DASHBOARDVAR.PARTNO5,
    'PARTNAME6': P01DASHBOARDVAR.PARTNAME6,
    'PARTNO6': P01DASHBOARDVAR.PARTNO6,
    'PARTNAME7': P01DASHBOARDVAR.PARTNAME7,
    'PARTNO7': P01DASHBOARDVAR.PARTNO7,
    'PARTNAME8': P01DASHBOARDVAR.PARTNAME8,
    'PARTNO8': P01DASHBOARDVAR.PARTNO8,
    'PARTNAME9': P01DASHBOARDVAR.PARTNAME9,
    'PARTNO9': P01DASHBOARDVAR.PARTNO9,
    'PARTNAME10': P01DASHBOARDVAR.PARTNAME10,
    'PARTNO10': P01DASHBOARDVAR.PARTNO10,
    'AMOUNTSAMPLE': P01DASHBOARDVAR.AMOUNTSAMPLE,
    'TAKEPHOTO': P01DASHBOARDVAR.TAKEPHOTO,
    'STARTDATE': P01DASHBOARDVAR.STARTDATE,
    'TIME1': P01DASHBOARDVAR.TIME1,
    'FINISHDATE1': P01DASHBOARDVAR.FINISHDATE1,
    'TEMPDATE1': P01DASHBOARDVAR.TEMPDATE1,
    'DUEDATE1': P01DASHBOARDVAR.DUEDATE1,
    'TIME2': P01DASHBOARDVAR.TIME2,
    'FINISHDATE2': P01DASHBOARDVAR.FINISHDATE2,
    'TEMPDATE2': P01DASHBOARDVAR.TEMPDATE2,
    'DUEDATE2': P01DASHBOARDVAR.DUEDATE2,
    'TIME3': P01DASHBOARDVAR.TIME3,
    'FINISHDATE3': P01DASHBOARDVAR.FINISHDATE3,
    'TEMPDATE3': P01DASHBOARDVAR.TEMPDATE3,
    'DUEDATE3': P01DASHBOARDVAR.DUEDATE3,
    'TIME4': P01DASHBOARDVAR.TIME4,
    'FINISHDATE4': P01DASHBOARDVAR.FINISHDATE4,
    'TEMPDATE4': P01DASHBOARDVAR.TEMPDATE4,
    'DUEDATE4': P01DASHBOARDVAR.DUEDATE4,
    'TIME5': P01DASHBOARDVAR.TIME5,
    'FINISHDATE5': P01DASHBOARDVAR.FINISHDATE5,
    'TEMPDATE5': P01DASHBOARDVAR.TEMPDATE5,
    'DUEDATE5': P01DASHBOARDVAR.DUEDATE5,
    'TIME6': P01DASHBOARDVAR.TIME6,
    'FINISHDATE6': P01DASHBOARDVAR.FINISHDATE6,
    'TEMPDATE6': P01DASHBOARDVAR.TEMPDATE6,
    'DUEDATE6': P01DASHBOARDVAR.DUEDATE6,
    'TIME7': P01DASHBOARDVAR.TIME7,
    'FINISHDATE7': P01DASHBOARDVAR.FINISHDATE7,
    'TEMPDATE7': P01DASHBOARDVAR.TEMPDATE7,
    'DUEDATE7': P01DASHBOARDVAR.DUEDATE7,
    'TIME8': P01DASHBOARDVAR.TIME8,
    'FINISHDATE8': P01DASHBOARDVAR.FINISHDATE8,
    'TEMPDATE8': P01DASHBOARDVAR.TEMPDATE8,
    'DUEDATE8': P01DASHBOARDVAR.DUEDATE8,
    'TIME9': P01DASHBOARDVAR.TIME9,
    'FINISHDATE9': P01DASHBOARDVAR.FINISHDATE9,
    'TEMPDATE9': P01DASHBOARDVAR.TEMPDATE9,
    'DUEDATE9': P01DASHBOARDVAR.DUEDATE9,
    'TIME10': P01DASHBOARDVAR.TIME10,
    'FINISHDATE10': P01DASHBOARDVAR.FINISHDATE10,
    'TEMPDATE10': P01DASHBOARDVAR.TEMPDATE10,
    'DUEDATE10': P01DASHBOARDVAR.DUEDATE10,
    'INSTRUMENT': P01DASHBOARDVAR.INSTRUMENT,
    'METHOD': P01DASHBOARDVAR.METHOD,
    'INCHARGE': P01DASHBOARDVAR.INCHARGE,
    'APPROVEDDATE': P01DASHBOARDVAR.APPROVEDDATE,
    'APPROVEDBY': P01DASHBOARDVAR.APPROVEDBY,
    'STATUS': P01DASHBOARDVAR.STATUS,
    'REMARK': P01DASHBOARDVAR.REMARK,
    'CHECKBOX': P01DASHBOARDVAR.CHECKBOX,
  };
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
