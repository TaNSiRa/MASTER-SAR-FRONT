// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/BlocEvent/02-01-P02INSIDEINSTRUMENTGETDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/function/ForUseAllPage.dart';
import '../P1DASHBOARD/P01DASHBOARDVAR.dart';
import '../P3DATATABLE/P03DATATABLEVAR.dart';
import '../page1.dart';
import 'P02INSIDEINSTRUMENTVAR.dart';

late BuildContext P02INSIDEINSTRUMENTMAINcontext;

class P02INSIDEINSTRUMENTMAIN extends StatefulWidget {
  P02INSIDEINSTRUMENTMAIN({
    super.key,
    this.data,
  });
  List<P02INSIDEINSTRUMENTGETDATAclass>? data;

  @override
  State<P02INSIDEINSTRUMENTMAIN> createState() => _P02INSIDEINSTRUMENTMAINState();
}

class _P02INSIDEINSTRUMENTMAINState extends State<P02INSIDEINSTRUMENTMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P02INSIDEINSTRUMENTGETDATA_Bloc>().add(P02INSIDEINSTRUMENTGETDATA_GET());
    StartDateToDateTimeGlobal = DateTime.now();
    StartDateControllerGlobal.text = DateFormat('dd-MM-yy HH:mm').format(StartDateToDateTimeGlobal);
    P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot = false;
    PageName = selectpage;
  }

  List<bool> selectedTickets = List.generate(18 * 4, (index) => false);
  List<bool> selectedTickets2 = List.generate(18 * 4, (index2) => false);
  bool isSelecting = false;
  List<int> UseBoxSTART = [];
  List<int> UseBoxRECEIVED = [];
  List<int> UseBoxWAITTRANSFER = [];
  List<int> UseBoxPM = [];
  List<int> selectedTicketIndexes = [];

  @override
  Widget build(BuildContext context) {
    P02INSIDEINSTRUMENTMAINcontext = context;
    // print(selectpage);
    List<P02INSIDEINSTRUMENTGETDATAclass> _datain = widget.data ?? [];
    // List<P02INSIDEINSTRUMENTGETDATAclass> AllSSTCheckBox = _datain.toList();
    // print(_datain);

    DateTime checkDate = StartDateToDateTimeGlobal;
    // print(checkDate);
    List<P02INSIDEINSTRUMENTGETDATAclass> AllSSTCheckBox = _datain.where((data) {
      DateTime? start;
      DateTime? finish;

      try {
        start = data.STARTDATE != null ? convertStringToDateTime(data.STARTDATE) : null;
        // print(data.STARTDATE);

        List<String?> finishDateStrings = [
          data.FINISHDATE1,
          data.FINISHDATE2,
          data.FINISHDATE3,
          data.FINISHDATE4,
          data.FINISHDATE5,
          data.FINISHDATE6,
          data.FINISHDATE7,
          data.FINISHDATE8,
          data.FINISHDATE9,
          data.FINISHDATE10,
        ];

        for (var dateStr in finishDateStrings.reversed) {
          if (dateStr != null && dateStr.trim().isNotEmpty) {
            finish = convertStringToDateTime(dateStr);
            break;
          }
        }
        // print(finish);
      } catch (e) {
        print("Error parsing date: $e");
        return false;
      }

      if (start == null || finish == null) return false;
      // print(!checkDate.isBefore(start) && !checkDate.isAfter(finish));

      return !checkDate.isBefore(start) && !checkDate.isAfter(finish);
    }).toList();

    List<Map<String, String>> selectedDataSTART = [];
    List<Map<String, String>> selectedDataRECEIVED = [];
    List<Map<String, String>> selectedDataWAITTRANSFER = [];
    List<Map<String, String>> selectedDataPM = [];
    List<Map<String, String>> SST1DataSTART = [];
    List<Map<String, String>> SST2DataSTART = [];
    List<Map<String, String>> SST3DataSTART = [];
    List<Map<String, String>> SST4DataSTART = [];
    List<Map<String, String>> SST1DataRECEIVED = [];
    List<Map<String, String>> SST2DataRECEIVED = [];
    List<Map<String, String>> SST3DataRECEIVED = [];
    List<Map<String, String>> SST4DataRECEIVED = [];
    List<Map<String, String>> SST1DataWAITTRANSFER = [];
    List<Map<String, String>> SST2DataWAITTRANSFER = [];
    List<Map<String, String>> SST3DataWAITTRANSFER = [];
    List<Map<String, String>> SST4DataWAITTRANSFER = [];
    List<Map<String, String>> SST1DataPM = [];
    List<Map<String, String>> SST2DataPM = [];
    List<Map<String, String>> SST3DataPM = [];
    List<Map<String, String>> SST4DataPM = [];
    List<int> allCheckboxSST1START = [];
    List<int> allCheckboxSST2START = [];
    List<int> allCheckboxSST3START = [];
    List<int> allCheckboxSST4START = [];
    List<int> allCheckboxSST1RECEIVED = [];
    List<int> allCheckboxSST2RECEIVED = [];
    List<int> allCheckboxSST3RECEIVED = [];
    List<int> allCheckboxSST4RECEIVED = [];
    List<int> allCheckboxSST1WAITTRANSFER = [];
    List<int> allCheckboxSST2WAITTRANSFER = [];
    List<int> allCheckboxSST3WAITTRANSFER = [];
    List<int> allCheckboxSST4WAITTRANSFER = [];
    List<int> allCheckboxSST1PM = [];
    List<int> allCheckboxSST2PM = [];
    List<int> allCheckboxSST3PM = [];
    List<int> allCheckboxSST4PM = [];

    for (var data in AllSSTCheckBox) {
      if (data.INSTRUMENT == 'SST No.1') {
        if (data.STATUS == 'START') {
          SST1DataSTART.add(toMap(data));
        } else if (data.STATUS == 'RECEIVED') {
          SST1DataRECEIVED.add(toMap(data));
        } else if (data.STATUS == 'WAIT TRANSFER') {
          SST1DataWAITTRANSFER.add(toMap(data));
        } else if (data.STATUS == 'PM') {
          SST1DataPM.add(toMap(data));
        }
      } else if (data.INSTRUMENT == 'SST No.2') {
        if (data.STATUS == 'START') {
          SST2DataSTART.add(toMap(data));
        } else if (data.STATUS == 'RECEIVED') {
          SST2DataRECEIVED.add(toMap(data));
        } else if (data.STATUS == 'WAIT TRANSFER') {
          SST2DataWAITTRANSFER.add(toMap(data));
        } else if (data.STATUS == 'PM') {
          SST2DataPM.add(toMap(data));
        }
      } else if (data.INSTRUMENT == 'SST No.3') {
        if (data.STATUS == 'START') {
          SST3DataSTART.add(toMap(data));
        } else if (data.STATUS == 'RECEIVED') {
          SST3DataRECEIVED.add(toMap(data));
        } else if (data.STATUS == 'WAIT TRANSFER') {
          SST3DataWAITTRANSFER.add(toMap(data));
        } else if (data.STATUS == 'PM') {
          SST3DataPM.add(toMap(data));
        }
      } else if (data.INSTRUMENT == 'SST No.4') {
        if (data.STATUS == 'START') {
          SST4DataSTART.add(toMap(data));
        } else if (data.STATUS == 'RECEIVED') {
          SST4DataRECEIVED.add(toMap(data));
        } else if (data.STATUS == 'WAIT TRANSFER') {
          SST4DataWAITTRANSFER.add(toMap(data));
        } else if (data.STATUS == 'PM') {
          SST4DataPM.add(toMap(data));
        }
      }
    }

    for (var item in SST1DataSTART) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1START.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST1DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST1DataWAITTRANSFER) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1WAITTRANSFER.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST1DataPM) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST1PM.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST2DataSTART) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2START.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST2DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST2DataWAITTRANSFER) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2WAITTRANSFER.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST2DataPM) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST2PM.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST3DataSTART) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3START.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST3DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST3DataWAITTRANSFER) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3WAITTRANSFER.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST3DataPM) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST3PM.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST4DataSTART) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4START.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST4DataRECEIVED) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4RECEIVED.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST4DataWAITTRANSFER) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4WAITTRANSFER.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    for (var item in SST4DataPM) {
      if (item['CHECKBOX'] != null && item['CHECKBOX']!.isNotEmpty) {
        List<String> CheckBox = item['CHECKBOX']!.split(',');
        allCheckboxSST4PM.addAll(CheckBox.map((e) => int.parse(e)).toList());
      }
    }
    allCheckboxSST1START.sort();
    allCheckboxSST2START.sort();
    allCheckboxSST3START.sort();
    allCheckboxSST4START.sort();
    allCheckboxSST1RECEIVED.sort();
    allCheckboxSST2RECEIVED.sort();
    allCheckboxSST3RECEIVED.sort();
    allCheckboxSST4RECEIVED.sort();
    allCheckboxSST1WAITTRANSFER.sort();
    allCheckboxSST2WAITTRANSFER.sort();
    allCheckboxSST3WAITTRANSFER.sort();
    allCheckboxSST4WAITTRANSFER.sort();
    allCheckboxSST1PM.sort();
    allCheckboxSST2PM.sort();
    allCheckboxSST3PM.sort();
    allCheckboxSST4PM.sort();

    // String? lastMethodSST1 = '';
    // String? lastMethodSST2 = '';
    // String? lastMethodSST3 = '';
    // String? lastMethodSST4 = '';

    // if (SST1DataSTART.isNotEmpty) {
    //   lastMethodSST1 = SST1DataSTART.last['METHOD'];
    // }
    // if (SST2DataSTART.isNotEmpty) {
    //   lastMethodSST2 = SST2DataSTART.last['METHOD'];
    // }
    // if (SST3DataSTART.isNotEmpty) {
    //   lastMethodSST3 = SST3DataSTART.last['METHOD'];
    // }
    // if (SST4DataSTART.isNotEmpty) {
    //   lastMethodSST4 = SST4DataSTART.last['METHOD'];
    // }

    if (selectpage == "Salt Spray Tester : SST No.1") {
      UseBoxSTART = allCheckboxSST1START;
      UseBoxRECEIVED = allCheckboxSST1RECEIVED;
      UseBoxWAITTRANSFER = allCheckboxSST1WAITTRANSFER;
      UseBoxPM = allCheckboxSST1PM;
      selectedDataSTART = SST1DataSTART;
      selectedDataRECEIVED = SST1DataRECEIVED;
      selectedDataWAITTRANSFER = SST1DataWAITTRANSFER;
      selectedDataPM = SST1DataPM;
    } else if (selectpage == "Salt Spray Tester : SST No.2") {
      UseBoxSTART = allCheckboxSST2START;
      UseBoxRECEIVED = allCheckboxSST2RECEIVED;
      UseBoxWAITTRANSFER = allCheckboxSST2WAITTRANSFER;
      UseBoxPM = allCheckboxSST2PM;
      selectedDataSTART = SST2DataSTART;
      selectedDataRECEIVED = SST2DataRECEIVED;
      selectedDataWAITTRANSFER = SST2DataWAITTRANSFER;
      selectedDataPM = SST2DataPM;
    } else if (selectpage == "Salt Spray Tester : SST No.3") {
      UseBoxSTART = allCheckboxSST3START;
      UseBoxRECEIVED = allCheckboxSST3RECEIVED;
      UseBoxWAITTRANSFER = allCheckboxSST3WAITTRANSFER;
      UseBoxPM = allCheckboxSST3PM;
      selectedDataSTART = SST3DataSTART;
      selectedDataRECEIVED = SST3DataRECEIVED;
      selectedDataWAITTRANSFER = SST3DataWAITTRANSFER;
      selectedDataPM = SST3DataPM;
    } else if (selectpage == "Salt Spray Tester : SST No.4") {
      UseBoxSTART = allCheckboxSST4START;
      UseBoxRECEIVED = allCheckboxSST4RECEIVED;
      UseBoxWAITTRANSFER = allCheckboxSST4WAITTRANSFER;
      UseBoxPM = allCheckboxSST4PM;
      selectedDataSTART = SST4DataSTART;
      selectedDataRECEIVED = SST4DataRECEIVED;
      selectedDataWAITTRANSFER = SST4DataWAITTRANSFER;
      selectedDataPM = SST4DataPM;
    }

    // print('selectstatus: $selectstatus');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(1.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.blueGrey[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectpage,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (selectstatus != 'START' &&
                            selectstatus != 'RECEIVED' &&
                            selectstatus != 'WAIT TRANSFER' &&
                            selectstatus != 'PM')
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 225,
                              height: 600,
                              color: Colors.green[200],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      selectedDataPM.isNotEmpty
                                          ? 'Preventive Maintenance'
                                          : selectedDataWAITTRANSFER.isNotEmpty
                                              ? 'WAIT TRANSFER'
                                              : 'START JOB',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: (selectedDataPM.isNotEmpty
                                                ? selectedDataPM
                                                : selectedDataWAITTRANSFER.isNotEmpty
                                                    ? selectedDataWAITTRANSFER
                                                    : selectedDataSTART)
                                            .map((data) {
                                          final reqNo = data['REQUESTNO'] ?? '';
                                          final checkbox = data['CHECKBOX'] ?? '';
                                          return Padding(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                                            child: Text(
                                              "$reqNo = $checkbox",
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Center(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: 1030,
                                  height: 600,
                                  child: Image.asset(
                                    "assets/images/InsideSST.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 5,
                                child: Column(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 20,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.5),
                                            border: Border.all(color: Colors.green, width: 1),
                                          ),
                                        ),
                                        Text('=   Available for use',
                                            style: TextStyle(fontSize: 12, color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 20,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            border: Border.all(color: Colors.green, width: 1),
                                          ),
                                        ),
                                        Text('=   START JOB',
                                            style: TextStyle(fontSize: 12, color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 20,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[200],
                                            border: Border.all(color: Colors.green, width: 1),
                                          ),
                                        ),
                                        Text('=   RECEIVED JOB',
                                            style: TextStyle(fontSize: 12, color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 20,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            border: Border.all(color: Colors.green, width: 1),
                                          ),
                                        ),
                                        Text('=   WAIT TRANSFER JOB',
                                            style: TextStyle(fontSize: 12, color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 20,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            border: Border.all(color: Colors.green, width: 1),
                                          ),
                                        ),
                                        Text('=  PM JOB',
                                            style: TextStyle(fontSize: 12, color: Colors.white)),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 20,
                                          margin: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            border: Border.all(color: Colors.green, width: 1),
                                          ),
                                        ),
                                        Text('=   Do not use',
                                            style: TextStyle(fontSize: 12, color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 240,
                                top: 150,
                                child: SizedBox(
                                  width: 170,
                                  height: 370,
                                  child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 2.07,
                                    ),
                                    itemCount: 18 * 4,
                                    itemBuilder: (context, index) {
                                      bool isRedDisabled = UseBoxSTART.contains(index + 1);
                                      bool isOrangeDisabled = UseBoxWAITTRANSFER.contains(index + 1);
                                      bool isGreyDisabled = UseBoxPM.contains(index + 1);
                                      bool isBlueDisabled = UseBoxRECEIVED.contains(index + 1);
                                      bool isBlackDisabled =
                                          [1, 5, 9, 36, 40, 44, 48, 52, 61, 65, 69].contains(index + 1);
                                      return Container(
                                        margin: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          color: isBlackDisabled
                                              ? Colors.black
                                              : (isGreyDisabled
                                                  ? Colors.blueGrey
                                                  : isOrangeDisabled
                                                      ? Colors.orange
                                                      : isRedDisabled
                                                          ? Colors.red
                                                          : isBlueDisabled
                                                              ? Colors.blue[200]
                                                              : (index < selectedTickets.length &&
                                                                      selectedTickets[index]
                                                                  ? Colors.yellow
                                                                  : Colors.green.withOpacity(0.5))),
                                          border: Border.all(color: Colors.green, width: 1),
                                        ),
                                        child: InkWell(
                                          onTap: (isRedDisabled ||
                                                  isBlackDisabled ||
                                                  isBlueDisabled ||
                                                  isOrangeDisabled ||
                                                  isGreyDisabled)
                                              ? null
                                              : () {
                                                  if (index < selectedTickets.length) {
                                                    setState(() {
                                                      // print('--selectstatus--: $selectstatus');
                                                      selectedTickets[index] = !selectedTickets[index];
                                                      int realIndex = index + 1;

                                                      if (selectedTickets[index]) {
                                                        if (!selectedTicketIndexes.contains(realIndex)) {
                                                          selectedTicketIndexes.add(realIndex);
                                                        }
                                                      } else {
                                                        selectedTicketIndexes.remove(realIndex);
                                                      }
                                                      // print(selectedTicketIndexes);
                                                    });
                                                  }
                                                  // print(index + 1);
                                                },
                                          child: Center(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Text(
                                                  '${index + 1}',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 195,
                                top: 150,
                                child: SizedBox(
                                  width: 170,
                                  height: 370,
                                  child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 2.07,
                                    ),
                                    itemCount: 18 * 4,
                                    itemBuilder: (context, index2) {
                                      bool isRedDisabled = UseBoxSTART.contains(index2 + 73);
                                      bool isOrangeDisabled = UseBoxWAITTRANSFER.contains(index2 + 73);
                                      bool isGreyDisabled = UseBoxPM.contains(index2 + 73);
                                      bool isBlueDisabled = UseBoxRECEIVED.contains(index2 + 73);
                                      bool isBlackDisabled = [
                                        76,
                                        80,
                                        84,
                                        105,
                                        109,
                                        113,
                                        117,
                                        121,
                                        136,
                                        140,
                                        144
                                      ].contains(index2 + 73);

                                      return Container(
                                        margin: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          color: isBlackDisabled
                                              ? Colors.black
                                              : (isGreyDisabled
                                                  ? Colors.blueGrey
                                                  : isOrangeDisabled
                                                      ? Colors.orange
                                                      : isRedDisabled
                                                          ? Colors.red
                                                          : isBlueDisabled
                                                              ? Colors.blue[200]
                                                              : (selectedTickets2[index2]
                                                                  ? Colors.yellow
                                                                  : Colors.green.withOpacity(0.5))),
                                          border: Border.all(color: Colors.green, width: 1),
                                        ),
                                        child: InkWell(
                                          onTap: (isRedDisabled ||
                                                  isBlackDisabled ||
                                                  isBlueDisabled ||
                                                  isOrangeDisabled ||
                                                  isGreyDisabled)
                                              ? null
                                              : () {
                                                  setState(() {
                                                    selectedTickets2[index2] = !selectedTickets2[index2];
                                                    int realIndex = index2 + 73;

                                                    if (selectedTickets2[index2]) {
                                                      if (!selectedTicketIndexes.contains(realIndex)) {
                                                        selectedTicketIndexes.add(realIndex);
                                                      }
                                                    } else {
                                                      selectedTicketIndexes.remove(realIndex);
                                                    }
                                                    // print(selectedTicketIndexes);
                                                  });
                                                  // print(index2 + 73);
                                                },
                                          child: Center(
                                            child: Text(
                                              '${index2 + 73}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (selectstatus != 'START' &&
                            selectstatus != 'RECEIVED' &&
                            selectstatus != 'WAIT TRANSFER' &&
                            selectstatus != 'PM')
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 225,
                              height: 600,
                              color: Colors.yellow[100],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  const Center(
                                    child: Text(
                                      'RECEIVED JOB',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: selectedDataRECEIVED.map((data) {
                                          final reqNo = data['REQUESTNO'] ?? '';
                                          final checkbox = data['CHECKBOX'] ?? '';
                                          return Padding(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                                            child: Text(
                                              "$reqNo = $checkbox",
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selectstatus != 'START' &&
              selectstatus != 'RECEIVED' &&
              selectstatus != 'WAIT TRANSFER' &&
              selectstatus != 'PM')
            Positioned(
              top: 16,
              left: 16,
              child: ElevatedButton(
                onPressed: () {
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('SALT SPRAY MONITORING SYSTEM', Page1());
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    spacing: 4,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      Text(
                        'Back to main page',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            top: 16,
            right: 255,
            child: SizedBox(
              width: 170,
              height: 41,
              child: buildCustomField(
                context: P02INSIDEINSTRUMENTMAINcontext,
                controller: StartDateControllerGlobal,
                focusNode: StartDateFocusNodeGlobal,
                labelText: "Start Date",
                icon: Icons.calendar_month_rounded,
                onChanged: (value) async {
                  setState(() {
                    StartDateControllerGlobal.text = value;
                    StartDateToDateTimeGlobal = convertStringToDateTime(StartDateControllerGlobal.text)!;
                    // print(StartDateToDateTimeGlobal);
                  });
                },
              ),
            ),
          ),
          if (selectstatus == 'START' ||
              selectstatus == 'RECEIVED' ||
              selectstatus == 'WAIT TRANSFER' ||
              selectstatus == 'PM')
            Positioned(
              bottom: 60,
              right: 16,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot =
                          !P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot;

                      selectedTicketIndexes.clear();

                      for (int i = 0; i < 72; i++) {
                        int realIndex = i + 1;
                        bool isDisabled = UseBoxSTART.contains(realIndex) ||
                            UseBoxWAITTRANSFER.contains(realIndex) ||
                            UseBoxPM.contains(realIndex) ||
                            UseBoxRECEIVED.contains(realIndex) ||
                            [1, 5, 9, 36, 40, 44, 48, 52, 61, 65, 69].contains(realIndex);

                        if (!isDisabled && P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot) {
                          selectedTickets[i] = true;
                          selectedTicketIndexes.add(realIndex);
                        } else {
                          selectedTickets[i] = false;
                        }
                      }

                      for (int i = 0; i < 72; i++) {
                        int realIndex = i + 73;
                        bool isDisabled = UseBoxSTART.contains(realIndex) ||
                            UseBoxWAITTRANSFER.contains(realIndex) ||
                            UseBoxPM.contains(realIndex) ||
                            UseBoxRECEIVED.contains(realIndex) ||
                            [76, 80, 84, 105, 109, 113, 117, 121, 136, 140, 144].contains(realIndex);

                        if (!isDisabled && P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot) {
                          selectedTickets2[i] = true;
                          selectedTicketIndexes.add(realIndex);
                        } else {
                          selectedTickets2[i] = false;
                        }
                      }
                    });
                  },
                  child: Container(
                    width: 130,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade700, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot,
                            activeColor: Colors.green.shade700,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot = value ?? false;

                                selectedTicketIndexes.clear();

                                for (int i = 0; i < 72; i++) {
                                  int realIndex = i + 1;
                                  bool isDisabled = UseBoxSTART.contains(realIndex) ||
                                      UseBoxWAITTRANSFER.contains(realIndex) ||
                                      UseBoxPM.contains(realIndex) ||
                                      UseBoxRECEIVED.contains(realIndex) ||
                                      [1, 5, 9, 36, 40, 44, 48, 52, 61, 65, 69].contains(realIndex);

                                  if (!isDisabled && P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot) {
                                    selectedTickets[i] = true;
                                    selectedTicketIndexes.add(realIndex);
                                  } else {
                                    selectedTickets[i] = false;
                                  }
                                }

                                for (int i = 0; i < 72; i++) {
                                  int realIndex = i + 73;
                                  bool isDisabled = UseBoxSTART.contains(realIndex) ||
                                      UseBoxWAITTRANSFER.contains(realIndex) ||
                                      UseBoxPM.contains(realIndex) ||
                                      UseBoxRECEIVED.contains(realIndex) ||
                                      [76, 80, 84, 105, 109, 113, 117, 121, 136, 140, 144]
                                          .contains(realIndex);

                                  if (!isDisabled && P02INSIDEINSTRUMENTVAR.isCheckedSelectAllSlot) {
                                    selectedTickets2[i] = true;
                                    selectedTicketIndexes.add(realIndex);
                                  } else {
                                    selectedTickets2[i] = false;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        // SizedBox(width: 10),
                        Text(
                          "Select all",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (selectstatus == 'START' ||
              selectstatus == 'RECEIVED' ||
              selectstatus == 'WAIT TRANSFER' ||
              selectstatus == 'PM')
            Positioned(
              bottom: 16,
              right: 86,
              child: ElevatedButton(
                onPressed: () {
                  selectslot.text = selectedTicketIndexes.join(',');
                  // print(selectslot.text);
                  P03DATATABLEVAR.CHECKBOX = selectslot.text;
                  P01DASHBOARDVAR.CHECKBOX = selectslot.text;
                  // P01DASHBOARDVAR.STARTDATE = StartDateControllerGlobal.text;
                  StartDateController.text = StartDateControllerGlobal.text;
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          if (selectstatus == 'START' ||
              selectstatus == 'RECEIVED' ||
              selectstatus == 'WAIT TRANSFER' ||
              selectstatus == 'PM')
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // int _getTicketIndexFromPosition(Offset position) {
  //   final double cellWidth = MediaQuery.of(context).size.width / 4;
  //   final double cellHeight = MediaQuery.of(context).size.height / (18 * 4);

  //   int columnIndex = (position.dx / cellWidth).floor();
  //   int rowIndex = (position.dy / cellHeight).floor();
  //   int index = rowIndex * 4 + columnIndex;

  //   return index;
  // }
}

Map<String, String> toMap(P02INSIDEINSTRUMENTGETDATAclass data) {
  return {
    'REQUESTNO': data.REQUESTNO,
    'CHECKBOX': data.CHECKBOX,
    'METHOD': data.METHOD,
  };
}
