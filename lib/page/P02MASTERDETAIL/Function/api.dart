// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/widget/common/SuccessPopup.dart';

import '../../../bloc/BlocEvent/02-01-P02GETMASTERDETAIL.dart';
import '../../../data/global.dart';
import '../../../widget/common/ErrorPopup.dart';
import '../../../widget/common/Loading.dart';
import '../P02MASTERDETAILVAR.dart';

Future<void> getDropdown(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final responseUser = await Dio().post(
      "$ToServer/02MASTERSAR/getUser",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    if (responseUser.statusCode == 200 && responseUser.data is List) {
      List data = responseUser.data;
      P02MASTERDETAILVAR.dropdownUser =
          data.map((item) => item['Name'].toString()).where((name) => name.isNotEmpty).toList();
    } else {
      showErrorPopup(context, responseUser.toString());
      Navigator.pop(context);
    }

    final responseDropdown = await Dio().post(
      "$ToServer/02MASTERSAR/getDropdown",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    if (responseDropdown.statusCode == 200 && responseDropdown.data is Map) {
      var data = responseDropdown.data as Map;

      P02MASTERDETAILVAR.dropdownGroupName = List<String>.from(data['groupNameTS'] ?? []);

      P02MASTERDETAILVAR.dropdownSampleGroup = List<String>.from(data['sampleGroup'] ?? []);

      P02MASTERDETAILVAR.dropdownSampleType = List<String>.from(data['sampleType'] ?? []);
    } else {
      showErrorPopup(context, responseDropdown.toString());
      Navigator.pop(context);
    }

    // final responseGroupNameTS = await Dio().post(
    //   "$ToServer/02MASTERSAR/getGroupNameTS",
    //   data: {},
    //   options: Options(
    //     validateStatus: (status) {
    //       return true;
    //     },
    //     sendTimeout: const Duration(seconds: 5),
    //     receiveTimeout: const Duration(seconds: 5),
    //   ),
    // );

    // if (responseGroupNameTS.statusCode == 200 && responseGroupNameTS.data is List) {
    //   List data = responseGroupNameTS.data;
    //   P02MASTERDETAILVAR.dropdownGroupNameTS =
    //       data.map((item) => item['GroupNameTS'].toString()).where((name) => name.isNotEmpty).toList();
    // } else {
    //   showErrorPopup(context, responseGroupNameTS.toString());
    //   Navigator.pop(context);
    // }

    // final responseSampleGroup = await Dio().post(
    //   "$ToServer/02MASTERSAR/getSampleGroupTS",
    //   data: {},
    //   options: Options(
    //     validateStatus: (status) {
    //       return true;
    //     },
    //     sendTimeout: const Duration(seconds: 5),
    //     receiveTimeout: const Duration(seconds: 5),
    //   ),
    // );

    // if (responseSampleGroup.statusCode == 200 && responseSampleGroup.data is List) {
    //   List data = responseSampleGroup.data;
    //   P02MASTERDETAILVAR.dropdownSampleGroupTS =
    //       data.map((item) => item['SampleGroup'].toString()).where((name) => name.isNotEmpty).toList();
    // } else {
    //   showErrorPopup(context, responseSampleGroup.toString());
    //   Navigator.pop(context);
    // }

    // final responseSampleType = await Dio().post(
    //   "$ToServer/02MASTERSAR/getSampleTypeTS",
    //   data: {},
    //   options: Options(
    //     validateStatus: (status) {
    //       return true;
    //     },
    //     sendTimeout: const Duration(seconds: 5),
    //     receiveTimeout: const Duration(seconds: 5),
    //   ),
    // );

    // if (responseSampleType.statusCode == 200 && responseSampleType.data is List) {
    //   List data = responseSampleType.data;
    //   P02MASTERDETAILVAR.dropdownSampleTypeTS =
    //       data.map((item) => item['SampleType'].toString()).where((name) => name.isNotEmpty).toList();
    // } else {
    //   showErrorPopup(context, responseSampleType.toString());
    //   Navigator.pop(context);
    // }

    final responseItemTS = await Dio().post(
      "$ToServer/02MASTERSAR/getItemTS",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    if (responseItemTS.statusCode == 200 && responseItemTS.data is List) {
      List data = responseItemTS.data;
      P02MASTERDETAILVAR.dropdownItemTS =
          data.map((item) => item['ItemName'].toString()).where((name) => name.isNotEmpty).toList();
    } else {
      showErrorPopup(context, responseItemTS.toString());
      Navigator.pop(context);
    }

    // final responseSampleGroupLab = await Dio().post(
    //   "$ToServer/02MASTERSAR/getSampleGroupTS",
    //   data: {},
    //   options: Options(
    //     validateStatus: (status) {
    //       return true;
    //     },
    //     sendTimeout: const Duration(seconds: 5),
    //     receiveTimeout: const Duration(seconds: 5),
    //   ),
    // );

    // if (responseSampleGroupLab.statusCode == 200 && responseSampleGroupLab.data is List) {
    //   List data = responseSampleGroupLab.data;
    //   P02MASTERDETAILVAR.dropdownSampleGroupLab =
    //       data.map((item) => item['SampleGroup'].toString()).where((name) => name.isNotEmpty).toList();
    // } else {
    //   showErrorPopup(context, responseSampleGroupLab.toString());
    //   Navigator.pop(context);
    // }

    // final responseSampleTypeLab = await Dio().post(
    //   "$ToServer/02MASTERSAR/getSampleTypeTS",
    //   data: {},
    //   options: Options(
    //     validateStatus: (status) {
    //       return true;
    //     },
    //     sendTimeout: const Duration(seconds: 5),
    //     receiveTimeout: const Duration(seconds: 5),
    //   ),
    // );

    // if (responseSampleTypeLab.statusCode == 200 && responseSampleTypeLab.data is List) {
    //   List data = responseSampleTypeLab.data;
    //   P02MASTERDETAILVAR.dropdownSampleTypeLab =
    //       data.map((item) => item['SampleType'].toString()).where((name) => name.isNotEmpty).toList();
    // } else {
    //   showErrorPopup(context, responseSampleTypeLab.toString());
    //   Navigator.pop(context);
    // }

    final responseItemLab = await Dio().post(
      "$ToServer/02MASTERSAR/getItemLab",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    if (responseItemLab.statusCode == 200 && responseItemLab.data is List) {
      List data = responseItemLab.data;
      P02MASTERDETAILVAR.dropdownItemLab = data
          .map((item) {
            return '${item['InstrumentName']} | ${item['ItemName']}';
          })
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      showErrorPopup(context, responseItemLab.toString());
      Navigator.pop(context);
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  } finally {
    Navigator.pop(context);
  }
}

Future<void> confirmEdit(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post(
      "$ToServer/02MASTERSAR/confirmEditData",
      data: {
        "masterType": masterType,
        "data": P02MASTERDETAILVAR.SendEditDataToAPI,
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
    // print(response.data);
    if (response.statusCode == 200) {
      context.read<P02MASTERDETAILGETDATA_Bloc>().add(P02MASTERDETAILGETDATA_GET());
      showSuccessPopup(context, '${response.data['message']}');
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}
