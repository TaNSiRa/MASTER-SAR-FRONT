// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/widget/common/SuccessPopup.dart';

import '../../../bloc/BlocEvent/01-01-P01GETALLCUSTOMER.dart';
import '../../../data/global.dart';
import '../../../widget/common/ErrorPopup.dart';
import '../../../widget/common/Loading.dart';
import '../../../widget/function/SaveNull.dart';
import '../P01ALLCUSTOMERMAIN.dart';
import '../P01ALLCUSTOMERVAR.dart';

Future<void> getMasterSarStatus(BuildContext context) async {
  try {
    final response = await Dio().post(
      "$ToServer/02MASTERSAR/masterStatus",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    if (response.statusCode == 200) {
      P01ALLCUSTOMERVAR.master_Status = response.data[0]['status'].toString();
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> updateMasterSarStatus(BuildContext context) async {
  try {
    final response = await Dio().post(
      "$ToServer/02MASTERSAR/updateMasterStatus",
      data: {
        "status": P01ALLCUSTOMERVAR.master_Status,
      },
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    if (response.statusCode == 200) {
      showSuccessPopup(context, '${response.data['message']}');
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> addNewCustomer(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post(
      "$ToServer/02MASTERSAR/addNewCustomer",
      data: {
        "data": P01ALLCUSTOMERVAR.SendEditDataToAPI,
      },
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    Navigator.pop(context);
    Navigator.pop(context);
    // print(response.data);
    if (response.statusCode == 200) {
      P01ALLCUSTOMERMAINcontext.read<P01ALLCUSTOMERGETDATA_Bloc>().add(P01ALLCUSTOMERGETDATA_GET());
      showSuccessPopup(context, '${response.data['message']}');
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> getMasterTS(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post(
      "$ToServer/02MASTERSAR/getMasterTS",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    Navigator.pop(context);
    // print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> input = response.data;
      P01ALLCUSTOMERVAR.masterTS = input.map((data) {
        return P01MASTERTSclass(
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
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> getMasterLab(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post(
      "$ToServer/02MASTERSAR/getMasterLab",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    Navigator.pop(context);
    // print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> input = response.data;
      P01ALLCUSTOMERVAR.masterLab = input.map((data) {
        return P01MASTERLABclass(
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
      print(P01ALLCUSTOMERVAR.masterLab.length);
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}
