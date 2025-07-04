// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, avoid_print, file_names

import 'package:flutter_bloc/flutter_bloc.dart';

//-------------------------------------------------

abstract class P07CHANGEPASSWORDGETDATA_Event {}

class P07CHANGEPASSWORDGETDATA_GET extends P07CHANGEPASSWORDGETDATA_Event {}

class P07CHANGEPASSWORDGETDATA_GET2 extends P07CHANGEPASSWORDGETDATA_Event {}

class P07CHANGEPASSWORDGETDATA_GET3 extends P07CHANGEPASSWORDGETDATA_Event {}

class P07CHANGEPASSWORDGETDATA_FLUSH extends P07CHANGEPASSWORDGETDATA_Event {}

class P07CHANGEPASSWORDGETDATA_Bloc
    extends Bloc<P07CHANGEPASSWORDGETDATA_Event, List<P07CHANGEPASSWORDGETDATAclass>> {
  P07CHANGEPASSWORDGETDATA_Bloc() : super([]) {
    on<P07CHANGEPASSWORDGETDATA_GET>((event, emit) {
      return _P07CHANGEPASSWORDGETDATA_GET([], emit);
    });

    on<P07CHANGEPASSWORDGETDATA_GET2>((event, emit) {
      return _P07CHANGEPASSWORDGETDATA_GET2([], emit);
    });
    on<P07CHANGEPASSWORDGETDATA_GET3>((event, emit) {
      return _P07CHANGEPASSWORDGETDATA_GET3([], emit);
    });
    on<P07CHANGEPASSWORDGETDATA_FLUSH>((event, emit) {
      return _P07CHANGEPASSWORDGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P07CHANGEPASSWORDGETDATA_GET(
      List<P07CHANGEPASSWORDGETDATAclass> toAdd, Emitter<List<P07CHANGEPASSWORDGETDATAclass>> emit) async {
    // FreeLoadingTan(P07CHANGEPASSWORDMAINcontext);
    // List<P07CHANGEPASSWORDGETDATAclass> output = [];
    // final response = await Dio().post(
    //   "$ToServer/02SALTSPRAY/SearchCustomer",
    //   data: {},
    //   options: Options(
    //     validateStatus: (status) {
    //       return true;
    //     },
    //   ),
    // );
    // var input = [];
    // if (response.statusCode == 200) {
    //   print(response.statusCode);
    //   // print(response.data);
    //   var databuff = response.data;
    //   input = databuff;

    //   // var input = dummyOverDueTable;
    //   // print(input);
    //   List<P07CHANGEPASSWORDGETDATAclass> outputdata = input.map((data) {
    //     return P07CHANGEPASSWORDGETDATAclass(
    //       ID: data['ID'],
    //       CUSTOMER: savenull(data['Customer_Name']),
    //     );
    //   }).toList();
    //   // Navigator.pop(P01DASHBOARDMAINcontext);

    //   output = outputdata;
    //   emit(output);
    // } else {
    //   // Navigator.pop(P01DASHBOARDMAINcontext);
    //   showErrorPopup(P07CHANGEPASSWORDMAINcontext, response.toString());
    //   output = [];
    //   emit(output);
    // }
  }

  Future<void> _P07CHANGEPASSWORDGETDATA_GET2(
      List<P07CHANGEPASSWORDGETDATAclass> toAdd, Emitter<List<P07CHANGEPASSWORDGETDATAclass>> emit) async {
    // List<P07CHANGEPASSWORDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P07CHANGEPASSWORDGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P07CHANGEPASSWORDGETDATAclass(
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

  Future<void> _P07CHANGEPASSWORDGETDATA_GET3(
      List<P07CHANGEPASSWORDGETDATAclass> toAdd, Emitter<List<P07CHANGEPASSWORDGETDATAclass>> emit) async {
    // List<P07CHANGEPASSWORDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P07CHANGEPASSWORDGETDATAclass> datadummy = [
    //   P07CHANGEPASSWORDGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P07CHANGEPASSWORDGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P07CHANGEPASSWORDGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P07CHANGEPASSWORDGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P07CHANGEPASSWORDGETDATA_FLUSH(
      List<P07CHANGEPASSWORDGETDATAclass> toAdd, Emitter<List<P07CHANGEPASSWORDGETDATAclass>> emit) async {
    List<P07CHANGEPASSWORDGETDATAclass> output = [];
    emit(output);
  }
}

class P07CHANGEPASSWORDGETDATAclass {
  P07CHANGEPASSWORDGETDATAclass({
    this.ID = 0,
    this.CUSTOMER = '',
  });

  int ID;
  String CUSTOMER;

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'CUSTOMER': CUSTOMER,
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
