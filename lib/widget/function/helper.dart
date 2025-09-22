// // ignore_for_file: non_constant_identifier_names, avoid_web_libraries_in_flutter

// import 'dart:convert';
// import 'dart:html';
// import 'dart:ui' as dart_ui;

// import 'dart:typed_data';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:pdf/pdf.dart';

// import 'dart:async';
// import 'package:pdf/widgets.dart' as pw;

// import '../../page/P5CALENDARJOB/P05CALENDARJOBVAR.dart';

// String server = 'http://172.23.10.40:16700/';

// class FileSaveHelper {
//   static Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
//     AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
//       ..setAttribute('download', fileName)
//       ..click();
//   }
// }

// // Future<String> capture(
// //     GlobalKey<State<StatefulWidget>> globalKey, String PO) async {
// //   try {
// //     // FreeLoading(contextin);
// //     RenderRepaintBoundary? boundary =
// //         globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

// //     final image = await boundary!.toImage(pixelRatio: 2);

// //     final ByteData? bytes =
// //         await image.toByteData(format: dart_ui.ImageByteFormat.png);
// //     Uint8List dataImage =
// //         bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

// //     final imagePDF = pw.MemoryImage(
// //       dataImage,
// //     );

// //     final pdf = pw.Document();

// //     pdf.addPage(
// //       pw.Page(
// //         pageFormat: PdfPageFormat.a3.portrait,
// //         margin: const pw.EdgeInsets.all(20),
// //         build: (pw.Context context) => pw.Column(children: [
// //           pw.SizedBox(height: 5),
// //           pw.Row(children: [
// //             pw.Spacer(),
// //             pw.Text(
// //               'FR-CTS-02/005-09-31/05/21',
// //               style: const pw.TextStyle(fontSize: 8),
// //               textAlign: pw.TextAlign.end,
// //             ),
// //             pw.SizedBox(width: 7),
// //           ]),
// //           pw.Row(children: [
// //             pw.SizedBox(width: 13),
// //             pw.Text(
// //               'Technical service report of group ${P05TABLESERVICEVAR.DropDownGroup}',
// //               style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
// //               textAlign: pw.TextAlign.start,
// //             ),
// //           ]),
// //           pw.SizedBox(height: 5),
// //           pw.Align(
// //             alignment: pw.Alignment.topCenter,
// //             child: pw.Image(imagePDF,
// //                 // fit: pw.BoxFit.contain, height: 650, width: 1300), //for landscape
// //                 fit: pw.BoxFit.contain,
// //                 height: 1020,
// //                 width: 792), //for portrait
// //           ),
// //           pw.SizedBox(height: 10),
// //           pw.Column(children: [
// //             pw.Row(children: [
// //               pw.Spacer(),
// //               pw.Container(
// //                 width: 100,
// //                 height: 20,
// //                 decoration: pw.BoxDecoration(
// //                     border: pw.Border.all(
// //                   width: 0.7,
// //                 )),
// //                 child: pw.Center(
// //                   child: pw.Text(
// //                     'Issued by',
// //                     style: pw.TextStyle(
// //                         fontSize: 6, fontWeight: pw.FontWeight.bold),
// //                   ),
// //                 ),
// //               ),
// //               pw.Container(
// //                 width: 100,
// //                 height: 20,
// //                 decoration: pw.BoxDecoration(
// //                     border: pw.Border.all(
// //                   width: 0.7,
// //                 )),
// //                 child: pw.Center(
// //                   child: pw.Text(
// //                     'Checked by',
// //                     style: pw.TextStyle(
// //                         fontSize: 6, fontWeight: pw.FontWeight.bold),
// //                   ),
// //                 ),
// //               ),
// //               pw.Container(
// //                 width: 100,
// //                 height: 20,
// //                 decoration: pw.BoxDecoration(
// //                     border: pw.Border.all(
// //                   width: 0.7,
// //                 )),
// //                 child: pw.Center(
// //                   child: pw.Text(
// //                     'Approved by',
// //                     style: pw.TextStyle(
// //                         fontSize: 6, fontWeight: pw.FontWeight.bold),
// //                   ),
// //                 ),
// //               ),
// //               pw.SizedBox(width: 7),
// //             ]),
// //             pw.Row(children: [
// //               pw.Spacer(),
// //               pw.Container(
// //                 width: 100,
// //                 height: 40,
// //                 decoration: pw.BoxDecoration(
// //                     border: pw.Border.all(
// //                   width: 0.7,
// //                 )),
// //               ),
// //               pw.Container(
// //                 width: 100,
// //                 height: 40,
// //                 decoration: pw.BoxDecoration(
// //                     border: pw.Border.all(
// //                   width: 0.7,
// //                 )),
// //               ),
// //               pw.Container(
// //                 width: 100,
// //                 height: 40,
// //                 decoration: pw.BoxDecoration(
// //                     border: pw.Border.all(
// //                   width: 0.7,
// //                 )),
// //               ),
// //               pw.SizedBox(width: 7),
// //             ]),
// //             pw.Row(children: [
// //               pw.Spacer(),
// //               pw.Container(
// //                 width: 100,
// //                 height: 20,
// //                 decoration: pw.BoxDecoration(
// //                   border: pw.Border.all(
// //                     width: 0.7,
// //                   ),
// //                 ),
// //                 child: pw.Center(
// //                   child: pw.Text(
// //                     P05TABLESERVICEVAR.DropDownGroup == '1'
// //                         ? 'Ms. Pornthip Khowawintaweewat\nIssue Staff'
// //                         : P05TABLESERVICEVAR.DropDownGroup == '2'
// //                             ? 'Mr. Nattapon Anasura\nIssue Staff'
// //                             : P05TABLESERVICEVAR.DropDownGroup == '5'
// //                                 ? 'Mr. Natawut Khampan\nIssue Staff'
// //                                 : P05TABLESERVICEVAR.DropDownGroup == '6'
// //                                     ? 'Mr. Chawasorn Intaraprasit\nIssue Staff'
// //                                     : 'Unknown Issue Staff',
// //                     style: pw.TextStyle(
// //                         fontSize: 6, fontWeight: pw.FontWeight.bold),
// //                     textAlign: pw.TextAlign.center,
// //                   ),
// //                 ),
// //               ),
// //               pw.Container(
// //                 width: 100,
// //                 height: 20,
// //                 decoration: pw.BoxDecoration(
// //                   border: pw.Border.all(
// //                     width: 0.7,
// //                   ),
// //                 ),
// //                 child: pw.Center(
// //                   child: pw.Text(
// //                     P05TABLESERVICEVAR.DropDownGroup == '1'
// //                         ? 'Mr. Worachai Kunadirek\nLeader Manager'
// //                         : P05TABLESERVICEVAR.DropDownGroup == '2'
// //                             ? 'Mr. Yanyong Chompoo\nLeader Manager'
// //                             : P05TABLESERVICEVAR.DropDownGroup == '5'
// //                                 ? 'Mr. Sutat Teevasuveat\nLeader Manager'
// //                                 : P05TABLESERVICEVAR.DropDownGroup == '6'
// //                                     ? 'Mr. Santiparp Rattanapun\nLeader Manager'
// //                                     : 'Unknown Leader Manager',
// //                     style: pw.TextStyle(
// //                         fontSize: 6, fontWeight: pw.FontWeight.bold),
// //                     textAlign: pw.TextAlign.center,
// //                   ),
// //                 ),
// //               ),
// //               pw.Container(
// //                 width: 100,
// //                 height: 20,
// //                 decoration: pw.BoxDecoration(
// //                   border: pw.Border.all(
// //                     width: 0.7,
// //                   ),
// //                 ),
// //                 child: pw.Center(
// //                   child: pw.Text(
// //                     P05TABLESERVICEVAR.DropDownGroup == '1'
// //                         ? 'Mr. Seksan Vivon\nDepartment Manager'
// //                         : P05TABLESERVICEVAR.DropDownGroup == '2'
// //                             ? 'Mr. Seksan Vivon\nDepartment Manager'
// //                             : P05TABLESERVICEVAR.DropDownGroup == '5'
// //                                 ? 'Mr. Sahaphap Samor\nDepartment Manager'
// //                                 : P05TABLESERVICEVAR.DropDownGroup == '6'
// //                                     ? 'Mr. Sahaphap Samor\nDepartment Manager'
// //                                     : 'Unknown Department Manager',
// //                     style: pw.TextStyle(
// //                         fontSize: 6, fontWeight: pw.FontWeight.bold),
// //                     textAlign: pw.TextAlign.center,
// //                   ),
// //                 ),
// //               ),
// //               pw.SizedBox(width: 7),
// //             ]),
// //           ]),
// //         ]),
// //       ),
// //     );

// //     // print(await pdf.save());
// //     final bytesPDF = await pdf.save();
// //     await FileSaveHelper.saveAndLaunchFile(bytesPDF, '$PO.pdf');

// //     // Navigator.pop(contextin);
// //     return 'ok';
// //   } catch (e) {
// //     rethrow;
// //   }
// // }

// Future<String> captureDefault(GlobalKey<State<StatefulWidget>> globalKey, String PO) async {
//   try {
//     // FreeLoading(contextin);
//     RenderRepaintBoundary? boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

//     final image = await boundary!.toImage(pixelRatio: 2);

//     final ByteData? bytes = await image.toByteData(format: dart_ui.ImageByteFormat.png);
//     Uint8List dataImage = bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

//     final imagePDF = pw.MemoryImage(
//       dataImage,
//     );

//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4.landscape,
//         margin: const pw.EdgeInsets.all(4),
//         build: (pw.Context context) => pw.Center(
//           child: pw.Column(children: [pw.Image(imagePDF)]),
//         ),
//       ),
//     );

//     // print(await pdf.save());
//     final bytesPDF = await pdf.save();
//     await FileSaveHelper.saveAndLaunchFile(bytesPDF, '$PO.pdf');

//     // Navigator.pop(contextin);
//     return 'ok';
//   } catch (e) {
//     rethrow;
//   }
// }

// Future<String> captureToback(GlobalKey<State<StatefulWidget>> globalKey, String PO) async {
//   try {
//     // FreeLoading(contextin);
//     RenderRepaintBoundary? boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

//     final image = await boundary!.toImage(pixelRatio: 2);

//     final ByteData? bytes = await image.toByteData(format: dart_ui.ImageByteFormat.png);
//     Uint8List dataImage = bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

//     final imageEncoded = base64.encode(dataImage);

//     // print(imageEncoded);
//     final response = await Dio().post(
//       '${server}goPDF',
//       data: {
//         "PIC": imageEncoded,
//         "PO": PO,
//       },
//     );
//     // String output = '';

//     if (response.statusCode == 200) {
//       var databuff = response.data;

//       // output = 'OK';
//       if (databuff['PIC'] != null) {
//         // final imageEncoded = base64.encode(databuff['PIC']);
//         var base64 = databuff['PIC'].toString();
//         var bytes = base64Decode(base64);
//         await FileSaveHelper.saveAndLaunchFile(bytes, '$PO.pdf');
//       }
//     } else {
//       //
//     }
//     return 'ok';
//   } catch (e) {
//     rethrow;
//   }
// }

// // num? percentageToValue(String? value, num size) {
// //   if (value != null) {
// //     return value.contains('%')
// //         ? (size / 100) * num.tryParse(value.replaceAll(RegExp('%'), ''))!
// //         : num.tryParse(value);
// //   }
// //   return null;
// // }
