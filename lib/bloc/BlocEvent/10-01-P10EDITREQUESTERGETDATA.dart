// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/global.dart';
import '../../page/P10EDITREQUESTER/P10EDITREQUESTERMAIN.dart';
import '../../page/P10EDITREQUESTER/P10EDITREQUESTERVAR.dart';
import '../../widget/common/ErrorPopup.dart';

//-------------------------------------------------

abstract class P10EDITREQUESTERGETDATA_Event {}

class P10EDITREQUESTERGETDATA_GET extends P10EDITREQUESTERGETDATA_Event {}

class P10EDITREQUESTERGETDATA_GET2 extends P10EDITREQUESTERGETDATA_Event {}

class P10EDITREQUESTERGETDATA_GET3 extends P10EDITREQUESTERGETDATA_Event {}

class P10EDITREQUESTERGETDATA_FLUSH extends P10EDITREQUESTERGETDATA_Event {}

class P10EDITREQUESTERGETDATA_Bloc
    extends Bloc<P10EDITREQUESTERGETDATA_Event, List<P10EDITREQUESTERGETDATAclass>> {
  P10EDITREQUESTERGETDATA_Bloc() : super([]) {
    on<P10EDITREQUESTERGETDATA_GET>((event, emit) {
      return _P10EDITREQUESTERGETDATA_GET([], emit);
    });

    on<P10EDITREQUESTERGETDATA_GET2>((event, emit) {
      return _P10EDITREQUESTERGETDATA_GET2([], emit);
    });
    on<P10EDITREQUESTERGETDATA_GET3>((event, emit) {
      return _P10EDITREQUESTERGETDATA_GET3([], emit);
    });
    on<P10EDITREQUESTERGETDATA_FLUSH>((event, emit) {
      return _P10EDITREQUESTERGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P10EDITREQUESTERGETDATA_GET(
      List<P10EDITREQUESTERGETDATAclass> toAdd, Emitter<List<P10EDITREQUESTERGETDATAclass>> emit) async {
    // FreeLoadingTan(P10EDITREQUESTERMAINcontext);
    List<P10EDITREQUESTERGETDATAclass> output = [];
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/SearchRequester",
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

      // var input = dummyOverDueTable;
      // print(input);
      List<P10EDITREQUESTERGETDATAclass> outputdata = input.map((data) {
        return P10EDITREQUESTERGETDATAclass(
          ID: data['ID'],
          REQUESTER: savenull(data['Requester_Name']),
        );
      }).toList();
      // Navigator.pop(P01DASHBOARDMAINcontext);

      output = outputdata;
      emit(output);
    } else {
      // Navigator.pop(P01DASHBOARDMAINcontext);
      showErrorPopup(P10EDITREQUESTERMAINcontext, response.toString());
      output = [];
      emit(output);
    }
  }

  Future<void> _P10EDITREQUESTERGETDATA_GET2(
      List<P10EDITREQUESTERGETDATAclass> toAdd, Emitter<List<P10EDITREQUESTERGETDATAclass>> emit) async {
    // List<P10EDITREQUESTERGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P10EDITREQUESTERGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P10EDITREQUESTERGETDATAclass(
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

  Future<void> _P10EDITREQUESTERGETDATA_GET3(
      List<P10EDITREQUESTERGETDATAclass> toAdd, Emitter<List<P10EDITREQUESTERGETDATAclass>> emit) async {
    // List<P10EDITREQUESTERGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P10EDITREQUESTERGETDATAclass> datadummy = [
    //   P10EDITREQUESTERGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P10EDITREQUESTERGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P10EDITREQUESTERGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P10EDITREQUESTERGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P10EDITREQUESTERGETDATA_FLUSH(
      List<P10EDITREQUESTERGETDATAclass> toAdd, Emitter<List<P10EDITREQUESTERGETDATAclass>> emit) async {
    List<P10EDITREQUESTERGETDATAclass> output = [];
    emit(output);
  }
}

class P10EDITREQUESTERGETDATAclass {
  P10EDITREQUESTERGETDATAclass({
    this.ID = 0,
    this.REQUESTER = '',
  });

  int ID;
  String REQUESTER;

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'REQUESTER': REQUESTER,
    };
  }
}

Map<String, dynamic> toJsonAddDate() {
  return {
    'ID': P10EDITREQUESTERVAR.ID,
    'REQUESTER': P10EDITREQUESTERVAR.REQUESTER,
  };
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
