// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P8EDITUSER/P08EDITUSERMAIN.dart';
import '../../widget/common/ErrorPopup.dart';

//-------------------------------------------------

abstract class P08EDITUSERGETDATA_Event {}

class P08EDITUSERGETDATA_GET extends P08EDITUSERGETDATA_Event {}

class P08EDITUSERGETDATA_GET2 extends P08EDITUSERGETDATA_Event {}

class P08EDITUSERGETDATA_GET3 extends P08EDITUSERGETDATA_Event {}

class P08EDITUSERGETDATA_FLUSH extends P08EDITUSERGETDATA_Event {}

class P08EDITUSERGETDATA_Bloc extends Bloc<P08EDITUSERGETDATA_Event, List<P08EDITUSERGETDATAclass>> {
  P08EDITUSERGETDATA_Bloc() : super([]) {
    on<P08EDITUSERGETDATA_GET>((event, emit) {
      return _P08EDITUSERGETDATA_GET([], emit);
    });

    on<P08EDITUSERGETDATA_GET2>((event, emit) {
      return _P08EDITUSERGETDATA_GET2([], emit);
    });
    on<P08EDITUSERGETDATA_GET3>((event, emit) {
      return _P08EDITUSERGETDATA_GET3([], emit);
    });
    on<P08EDITUSERGETDATA_FLUSH>((event, emit) {
      return _P08EDITUSERGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P08EDITUSERGETDATA_GET(
      List<P08EDITUSERGETDATAclass> toAdd, Emitter<List<P08EDITUSERGETDATAclass>> emit) async {
    // FreeLoadingTan(P08EDITUSERMAINcontext);
    List<P08EDITUSERGETDATAclass> output = [];
    try {
      final response = await Dio().post(
        "$ToServer/02SALTSPRAY/SearchIncharge",
        data: {},
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
        List<P08EDITUSERGETDATAclass> outputdata = input.map((data) {
          return P08EDITUSERGETDATAclass(
            ID: savenull(data['Id']),
            USERNAME: savenull(data['UserName']),
            NAME: savenull(data['Name']),
            SECTION: savenull(data['Section']),
            BRANCH: savenull(data['Branch']),
            ROLEID: data['Roleid'],
          );
        }).toList();
        // Navigator.pop(P08EDITUSERMAINcontext);

        output = outputdata;
        emit(output);
      } else {
        // Navigator.pop(P08EDITUSERMAINcontext);
        showErrorPopup(P08EDITUSERMAINcontext, response.toString());
        output = [];
        emit(output);
      }
    } on DioException catch (e) {
      Navigator.pop(P08EDITUSERMAINcontext);
      if (e.type == DioExceptionType.sendTimeout) {
        showErrorPopup(P08EDITUSERMAINcontext, "Send timeout");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        showErrorPopup(P08EDITUSERMAINcontext, "Receive timeout");
      } else {
        showErrorPopup(P08EDITUSERMAINcontext, e.message ?? "Unknown Dio error");
      }
    } catch (e) {
      Navigator.pop(P08EDITUSERMAINcontext);
      showErrorPopup(P08EDITUSERMAINcontext, e.toString());
    }
  }
}

Future<void> _P08EDITUSERGETDATA_GET2(
    List<P08EDITUSERGETDATAclass> toAdd, Emitter<List<P08EDITUSERGETDATAclass>> emit) async {
  // List<P08EDITUSERGETDATAclass> output = [];
  //-------------------------------------------------------------------------------------
  // var input = dummydatainput2;

  // List<P08EDITUSERGETDATAclass> outputdata = input
  //     .where((data) =>
  //         data['location'] == 'ESIE1' &&
  //         data['plant'] == 'YES' &&
  //         data['step01'] == 'YES')
  //     .map((data) {
  //   return P08EDITUSERGETDATAclass(
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
  //     STEP06: savenull(data['step5']),
  //     STEP06: savenull(data['step6']),
  //     STEP07: savenull(data['step7']),
  //     STEP08: savenull(data['step8']),
  //     STEP09: savenull(data['step9']),
  //   );
  // }).toList();

  // output = outputdata;
  // emit(output);
}

Future<void> _P08EDITUSERGETDATA_GET3(
    List<P08EDITUSERGETDATAclass> toAdd, Emitter<List<P08EDITUSERGETDATAclass>> emit) async {
  // List<P08EDITUSERGETDATAclass> output = [];
  //-------------------------------------------------------------------------------------
  // List<P08EDITUSERGETDATAclass> datadummy = [
  //   P08EDITUSERGETDATAclass(
  //     PLANT: "PH PO:1234",
  //     STEP01: "YES",
  //     STEP02: "YES",
  //     STEP03: "YES",
  //   ),
  //   P08EDITUSERGETDATAclass(
  //     PLANT: "PH PO:5555",
  //     STEP01: "YES",
  //     STEP02: "YES",
  //     STEP03: "YES",
  //     STEP04: "YES",
  //   ),
  //   P08EDITUSERGETDATAclass(
  //     PLANT: "PH PO:5556",
  //     STEP01: "YES",
  //     STEP02: "YES",
  //   ),
  //   P08EDITUSERGETDATAclass(
  //     PLANT: "PH PO:9999",
  //   ),
  // ];

  // //-------------------------------------------------------------------------------------
  // output = datadummy;
  // emit(output);
}

Future<void> _P08EDITUSERGETDATA_FLUSH(
    List<P08EDITUSERGETDATAclass> toAdd, Emitter<List<P08EDITUSERGETDATAclass>> emit) async {
  List<P08EDITUSERGETDATAclass> output = [];
  emit(output);
}

class P08EDITUSERGETDATAclass {
  P08EDITUSERGETDATAclass({
    this.ID = '',
    this.USERNAME = '',
    this.NAME = '',
    this.SECTION = '',
    this.BRANCH = '',
    this.ROLEID = 0,
  });

  String ID;
  String USERNAME;
  String NAME;
  String SECTION;
  String BRANCH;
  int ROLEID;

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'USERNAME': USERNAME,
      'NAME': NAME,
      'SECTION': SECTION,
      'BRANCH': BRANCH,
      'ROLEID': ROLEID,
    };
  }
}

String savenull(input) {
  String output = '';
  if (input != null) {
    output = input.toString();
    if (output == 'null') {
      output = '';
    }
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
