// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/widget/common/Loading.dart';
import '../../data/global.dart';
import '../../page/P01ALLCUSTOMER/P01ALLCUSTOMERMAIN.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/function/ForUseAllPage.dart';

//-------------------------------------------------

abstract class P01ALLCUSTOMERGETDATA_Event {}

class P01ALLCUSTOMERGETDATA_GET extends P01ALLCUSTOMERGETDATA_Event {}

class P01ALLCUSTOMERGETDATA_GET2 extends P01ALLCUSTOMERGETDATA_Event {}

class P01ALLCUSTOMERGETDATA_GET3 extends P01ALLCUSTOMERGETDATA_Event {}

class P01ALLCUSTOMERGETDATA_FLUSH extends P01ALLCUSTOMERGETDATA_Event {}

class P01ALLCUSTOMERGETDATA_Bloc extends Bloc<P01ALLCUSTOMERGETDATA_Event, List<P01ALLCUSTOMERGETDATAclass>> {
  P01ALLCUSTOMERGETDATA_Bloc() : super([]) {
    on<P01ALLCUSTOMERGETDATA_GET>((event, emit) {
      return _P01ALLCUSTOMERGETDATA_GET([], emit);
    });

    on<P01ALLCUSTOMERGETDATA_GET2>((event, emit) {
      return _P01ALLCUSTOMERGETDATA_GET2([], emit);
    });
    on<P01ALLCUSTOMERGETDATA_GET3>((event, emit) {
      return _P01ALLCUSTOMERGETDATA_GET3([], emit);
    });
    on<P01ALLCUSTOMERGETDATA_FLUSH>((event, emit) {
      return _P01ALLCUSTOMERGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P01ALLCUSTOMERGETDATA_GET(
      List<P01ALLCUSTOMERGETDATAclass> toAdd, Emitter<List<P01ALLCUSTOMERGETDATAclass>> emit) async {
    // FreeLoadingTan(P01ALLCUSTOMERMAINcontext);
    List<P01ALLCUSTOMERGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    try {
      FreeLoadingTan(P01ALLCUSTOMERMAINcontext);
      final response = await Dio().post(
        "$ToServer/02MASTERSAR/getAllCustomer",
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
        // print(response.statusCode);
        // print(response.data);
        var databuff = response.data;
        input = databuff;
        // var input = dummyAchievedCust;
        // print(input);
        List<P01ALLCUSTOMERGETDATAclass> outputdata = input.map((data) {
          return P01ALLCUSTOMERGETDATAclass(
            CustFull: savenull(data['CustFull']),
            CustShort: savenull(data['CustShort']),
            GroupNameTS: savenull(data['GroupNameTS']),
            TYPE: savenull(data['TYPE']),
            GROUP: savenull(data['GROUP']),
            MKTGROUP: savenull(data['MKTGROUP']),
            FRE: savenull(data['FRE']),
            REPORTITEMS: savenull(data['REPORTITEMS']),
          );
        }).toList();
        Navigator.pop(P01ALLCUSTOMERMAINcontext);

        output = outputdata;
        emit(output);
      } else {
        Navigator.pop(P01ALLCUSTOMERMAINcontext);
        showErrorPopup(P01ALLCUSTOMERMAINcontext, response.toString());
        output = [];
        emit(output);
      }
    } on DioException catch (e) {
      // Navigator.pop(P01ALLCUSTOMERMAINcontext);
      if (e.type == DioExceptionType.sendTimeout) {
        // showErrorPopup(P01ALLCUSTOMERMAINcontext, "Send timeout");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // showErrorPopup(P01ALLCUSTOMERMAINcontext, "Receive timeout");
      } else {
        // showErrorPopup(P01ALLCUSTOMERMAINcontext, e.message ?? "Unknown Dio error");
      }
    } catch (e) {
      Navigator.pop(P01ALLCUSTOMERMAINcontext);
      // showErrorPopup(P01ALLCUSTOMERMAINcontext, e.toString());
    }
  }

  Future<void> _P01ALLCUSTOMERGETDATA_GET2(
      List<P01ALLCUSTOMERGETDATAclass> toAdd, Emitter<List<P01ALLCUSTOMERGETDATAclass>> emit) async {
    // FreeLoadingTan(P01ALLCUSTOMERMAINcontext);
    // List<P01ALLCUSTOMERGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // final responseInstrument = await Dio().post(
    //   "$ToServer/02SALTSPRAY/InstrumentStatus",
    //   data: {},
    // );

    // if (responseInstrument.statusCode == 200) {
    //   print(responseInstrument.statusCode);
    //   var databuff = responseInstrument.data;
    //   P01ALLCUSTOMERVAR.SST1Staus = databuff[0]['Status'];
    //   P01ALLCUSTOMERVAR.SST2Staus = databuff[1]['Status'];
    //   P01ALLCUSTOMERVAR.SST3Staus = databuff[2]['Status'];
    //   P01ALLCUSTOMERVAR.SST4Staus = databuff[3]['Status'];
    //   // Navigator.pop(P01ALLCUSTOMERMAINcontext);
    // } else {
    //   // Navigator.pop(P01ALLCUSTOMERMAINcontext);
    //   showErrorPopup(P01ALLCUSTOMERMAINcontext, responseInstrument.toString());
    // }
  }

  Future<void> _P01ALLCUSTOMERGETDATA_GET3(
      List<P01ALLCUSTOMERGETDATAclass> toAdd, Emitter<List<P01ALLCUSTOMERGETDATAclass>> emit) async {
    // List<P01ALLCUSTOMERGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P01ALLCUSTOMERGETDATAclass> datadummy = [
    //   P01ALLCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P01ALLCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P01ALLCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P01ALLCUSTOMERGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P01ALLCUSTOMERGETDATA_FLUSH(
      List<P01ALLCUSTOMERGETDATAclass> toAdd, Emitter<List<P01ALLCUSTOMERGETDATAclass>> emit) async {
    List<P01ALLCUSTOMERGETDATAclass> output = [];
    emit(output);
  }
}

class P01ALLCUSTOMERGETDATAclass {
  P01ALLCUSTOMERGETDATAclass({
    this.Id = '',
    this.CustFull = '',
    this.CustShort = '',
    this.GroupNameTS = '',
    this.TYPE = '',
    this.GROUP = '',
    this.MKTGROUP = '',
    this.FRE = '',
    this.REPORTITEMS = '',
  });

  String Id;
  String CustFull;
  String CustShort;
  String GroupNameTS;
  String TYPE;
  String GROUP;
  String MKTGROUP;
  String FRE;
  String REPORTITEMS;
}
