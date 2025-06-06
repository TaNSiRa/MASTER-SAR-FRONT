// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/global.dart';
import '../../page/P6EDITCUSTOMER/P06EDITCUSTOMERMAIN.dart';
import '../../page/P6EDITCUSTOMER/P06EDITCUSTOMERVAR.dart';
import '../../widget/common/ErrorPopup.dart';

//-------------------------------------------------

abstract class P06EDITCUSTOMERGETDATA_Event {}

class P06EDITCUSTOMERGETDATA_GET extends P06EDITCUSTOMERGETDATA_Event {}

class P06EDITCUSTOMERGETDATA_GET2 extends P06EDITCUSTOMERGETDATA_Event {}

class P06EDITCUSTOMERGETDATA_GET3 extends P06EDITCUSTOMERGETDATA_Event {}

class P06EDITCUSTOMERGETDATA_FLUSH extends P06EDITCUSTOMERGETDATA_Event {}

class P06EDITCUSTOMERGETDATA_Bloc
    extends Bloc<P06EDITCUSTOMERGETDATA_Event, List<P06EDITCUSTOMERGETDATAclass>> {
  P06EDITCUSTOMERGETDATA_Bloc() : super([]) {
    on<P06EDITCUSTOMERGETDATA_GET>((event, emit) {
      return _P06EDITCUSTOMERGETDATA_GET([], emit);
    });

    on<P06EDITCUSTOMERGETDATA_GET2>((event, emit) {
      return _P06EDITCUSTOMERGETDATA_GET2([], emit);
    });
    on<P06EDITCUSTOMERGETDATA_GET3>((event, emit) {
      return _P06EDITCUSTOMERGETDATA_GET3([], emit);
    });
    on<P06EDITCUSTOMERGETDATA_FLUSH>((event, emit) {
      return _P06EDITCUSTOMERGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P06EDITCUSTOMERGETDATA_GET(
      List<P06EDITCUSTOMERGETDATAclass> toAdd, Emitter<List<P06EDITCUSTOMERGETDATAclass>> emit) async {
    // FreeLoadingTan(P06EDITCUSTOMERMAINcontext);
    List<P06EDITCUSTOMERGETDATAclass> output = [];
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/SearchCustomer",
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
      List<P06EDITCUSTOMERGETDATAclass> outputdata = input.map((data) {
        return P06EDITCUSTOMERGETDATAclass(
          ID: data['ID'],
          CUSTOMER: savenull(data['Customer_Name']),
        );
      }).toList();
      // Navigator.pop(P01DASHBOARDMAINcontext);

      output = outputdata;
      emit(output);
    } else {
      // Navigator.pop(P01DASHBOARDMAINcontext);
      showErrorPopup(P06EDITCUSTOMERMAINcontext, response.toString());
      output = [];
      emit(output);
    }
  }

  Future<void> _P06EDITCUSTOMERGETDATA_GET2(
      List<P06EDITCUSTOMERGETDATAclass> toAdd, Emitter<List<P06EDITCUSTOMERGETDATAclass>> emit) async {
    // List<P06EDITCUSTOMERGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P06EDITCUSTOMERGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P06EDITCUSTOMERGETDATAclass(
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

  Future<void> _P06EDITCUSTOMERGETDATA_GET3(
      List<P06EDITCUSTOMERGETDATAclass> toAdd, Emitter<List<P06EDITCUSTOMERGETDATAclass>> emit) async {
    // List<P06EDITCUSTOMERGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P06EDITCUSTOMERGETDATAclass> datadummy = [
    //   P06EDITCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P06EDITCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P06EDITCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P06EDITCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P06EDITCUSTOMERGETDATA_FLUSH(
      List<P06EDITCUSTOMERGETDATAclass> toAdd, Emitter<List<P06EDITCUSTOMERGETDATAclass>> emit) async {
    List<P06EDITCUSTOMERGETDATAclass> output = [];
    emit(output);
  }
}

class P06EDITCUSTOMERGETDATAclass {
  P06EDITCUSTOMERGETDATAclass({
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

Map<String, dynamic> toJsonAddDate() {
  return {
    'ID': P06EDITCUSTOMERVAR.ID,
    'CUSTOMER': P06EDITCUSTOMERVAR.CUSTOMER,
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
