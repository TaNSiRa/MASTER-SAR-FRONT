// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, library_private_types_in_public_api, use_build_context_synchronously, avoid_print, unrelated_type_equality_checks, unnecessary_null_comparison, avoid_web_libraries_in_flutter, unused_import, unused_local_variable
import 'dart:async';
import 'dart:html';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/html.dart' as html;
import '../../bloc/BlocEvent/01-01-P01GETALLCUSTOMER.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';

import '../../mainBody.dart';
import '../../widget/common/ComInputTextTan.dart';
import '../P02MASTERDETAIL/P02MASTERDETAILVAR.dart';
import '../page2.dart';
import 'Function/buildColumn.dart';
import 'Function/showDialog.dart';
import 'P01ALLCUSTOMERVAR.dart';

late BuildContext P01ALLCUSTOMERMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P01ALLCUSTOMERMAIN extends StatefulWidget {
  P01ALLCUSTOMERMAIN({
    super.key,
    this.data,
  });
  List<P01ALLCUSTOMERGETDATAclass>? data;

  @override
  State<P01ALLCUSTOMERMAIN> createState() => _P01ALLCUSTOMERMAINState();
}

class _P01ALLCUSTOMERMAINState extends State<P01ALLCUSTOMERMAIN> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<P01ALLCUSTOMERGETDATAclass> sortedData = [];

  @override
  void initState() {
    super.initState();
    context.read<P01ALLCUSTOMERGETDATA_Bloc>().add(P01ALLCUSTOMERGETDATA_GET());
    PageName = 'All Customer';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    P01ALLCUSTOMERMAINcontext = context;
    List<P01ALLCUSTOMERGETDATAclass> _datain = widget.data ?? [];

    List<P01ALLCUSTOMERGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      _datain.where(
        (data) =>
            data.CustFull.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()) ||
            data.CustShort.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()) ||
            data.GroupNameTS.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()) ||
            data.TYPE.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()) ||
            data.GROUP.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()) ||
            data.MKTGROUP.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()) ||
            data.FRE.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()) ||
            data.REPORTITEMS.toLowerCase().contains(P01ALLCUSTOMERVAR.search.toLowerCase()),
      ),
    );

    final SampleDataSource dataSource = SampleDataSource(
      _datasearch,
      (selectedRow) async {
        masterType = 'Routine_MasterPatternTS';
        CustShort = selectedRow.CustShort;
        PageName = '${selectedRow.CustFull} (Master detail)';
        MainBodyContext.read<ChangePage_Bloc>().ChangePage_nodrower('', const Page2());
        // String? result = await showSelectionDialog(context, selectedRow.CustFull);

        // CustShort = selectedRow.CustShort;
        // if (result == 'MasterTS') {
        //   masterType = 'Routine_MasterPatternTS';
        //   MainBodyContext.read<ChangePage_Bloc>().ChangePage_nodrower('', const Page2());
        // } else if (result == 'MasterLab') {
        //   masterType = 'Routine_MasterPatternLab';
        //   MainBodyContext.read<ChangePage_Bloc>().ChangePage_nodrower('', const Page2());
        // }
      },
    );

    void sortData(int columnIndex, bool ascending) {
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;

        List<P01ALLCUSTOMERGETDATAclass> dataToSort = _datasearch;

        switch (columnIndex) {
          case 1:
            dataToSort.sort(
                (a, b) => ascending ? a.CustFull.compareTo(b.CustFull) : b.CustFull.compareTo(a.CustFull));
            break;
          case 2:
            dataToSort.sort((a, b) =>
                ascending ? a.CustShort.compareTo(b.CustShort) : b.CustShort.compareTo(a.CustShort));
            break;
          case 3:
            dataToSort.sort((a, b) =>
                ascending ? a.GroupNameTS.compareTo(b.GroupNameTS) : b.GroupNameTS.compareTo(a.GroupNameTS));
            break;
          case 4:
            dataToSort.sort((a, b) => ascending ? a.TYPE.compareTo(b.TYPE) : b.TYPE.compareTo(a.TYPE));
            break;
          case 5:
            dataToSort.sort((a, b) => ascending ? a.GROUP.compareTo(b.GROUP) : b.GROUP.compareTo(a.GROUP));
            break;
          case 6:
            dataToSort.sort(
                (a, b) => ascending ? a.MKTGROUP.compareTo(b.MKTGROUP) : b.MKTGROUP.compareTo(a.MKTGROUP));
            break;
          case 7:
            dataToSort.sort((a, b) => ascending ? a.FRE.compareTo(b.FRE) : b.FRE.compareTo(a.FRE));
            break;
          case 8:
            dataToSort.sort((a, b) =>
                ascending ? a.REPORTITEMS.compareTo(b.REPORTITEMS) : b.REPORTITEMS.compareTo(a.REPORTITEMS));
            break;
        }

        sortedData = List.from(dataToSort);
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Theme(
          data: Theme.of(context).copyWith(
            cardTheme: const CardThemeData(color: Colors.white),
          ),
          child: SingleChildScrollView(
            controller: _controllerIN01,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ComInputTextTan(
                        sPlaceholder: "Search...",
                        isSideIcon: true,
                        height: 40,
                        width: 400,
                        isContr: P01ALLCUSTOMERVAR.iscontrol,
                        fnContr: (input) {
                          P01ALLCUSTOMERVAR.iscontrol = input;
                        },
                        sValue: P01ALLCUSTOMERVAR.search,
                        returnfunc: (String s) {
                          P01ALLCUSTOMERVAR.search = s;
                          Future.delayed(const Duration(seconds: 1), () {
                            if (P01ALLCUSTOMERVAR.search == s) {
                              setState(() {
                                P01ALLCUSTOMERVAR.search = s;
                              });
                            }
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            P01ALLCUSTOMERVAR.isHoveredClear = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            P01ALLCUSTOMERVAR.isHoveredClear = false;
                          });
                        },
                        child: InkWell(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          onTap: () {
                            setState(() {
                              P01ALLCUSTOMERVAR.isHoveredClear = false;
                              P01ALLCUSTOMERVAR.iscontrol = true;
                              P01ALLCUSTOMERVAR.search = '';
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: P01ALLCUSTOMERVAR.isHoveredClear
                                    ? Colors.yellowAccent.shade700
                                    : Colors.redAccent.shade700,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: const [
                                      Colors.white,
                                      Colors.red,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ).createShader(bounds),
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: P01ALLCUSTOMERVAR.isHoveredClear ? 15 : 17,
                                      end: P01ALLCUSTOMERVAR.isHoveredClear ? 17 : 15,
                                    ),
                                    duration: Duration(milliseconds: 200),
                                    builder: (context, size, child) {
                                      return TweenAnimationBuilder<Color?>(
                                        tween: ColorTween(
                                          begin: P01ALLCUSTOMERVAR.isHoveredClear
                                              ? Colors.redAccent.shade700
                                              : Colors.yellowAccent.shade700,
                                          end: P01ALLCUSTOMERVAR.isHoveredClear
                                              ? Colors.yellowAccent.shade700
                                              : Colors.redAccent.shade700,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        builder: (context, color, child) {
                                          return Text(
                                            'CLEAR',
                                            style: TextStyle(
                                              fontSize: size,
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<P01ALLCUSTOMERGETDATA_Bloc>().add(P01ALLCUSTOMERGETDATA_GET());
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Icon(
                                Icons.refresh_rounded,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Refresh',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                exportToExcel(_datasearch);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Icon(
                                Icons.download,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Export Excel',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: PaginatedDataTable(
                      headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                      columnSpacing: 16,
                      horizontalMargin: 12,
                      showCheckboxColumn: false,
                      rowsPerPage: P01ALLCUSTOMERVAR.rowsPerPage,
                      availableRowsPerPage: const <int>[10, 15, 20],
                      onRowsPerPageChanged: (value) => setState(() {
                        P01ALLCUSTOMERVAR.rowsPerPage = value ?? 20;
                      }),
                      dataRowHeight: 35,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: [
                        buildStyledColumn('No.'),
                        buildSortableColumn('CustFull', 1, sortData),
                        buildSortableColumn('CustShort', 2, sortData),
                        buildSortableColumn('Group Name TS', 3, sortData),
                        buildSortableColumn('Type', 4, sortData),
                        buildSortableColumn('Group', 5, sortData),
                        buildSortableColumn('MKT Group', 6, sortData),
                        buildSortableColumn('Frequency', 7, sortData),
                        buildSortableColumn('Report Items', 8, sortData),
                      ],
                      source: dataSource,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SampleDataSource extends DataTableSource {
  final List<P01ALLCUSTOMERGETDATAclass> data;
  final void Function(P01ALLCUSTOMERGETDATAclass) onRowTap;

  SampleDataSource(this.data, this.onRowTap);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow(
        onSelectChanged: (selected) {
          if (selected == true) {
            onRowTap(item);
          }
        },
        cells: [
          DataCell(Text(
            (index + 1).toString(),
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(Text(item.CustFull, style: const TextStyle(fontSize: 12))),
          DataCell(Text(item.CustShort, style: const TextStyle(fontSize: 12))),
          DataCell(Text(item.GroupNameTS, style: const TextStyle(fontSize: 12))),
          DataCell(Text(item.TYPE, style: const TextStyle(fontSize: 12))),
          DataCell(Text(item.GROUP, style: const TextStyle(fontSize: 12))),
          DataCell(Text(item.MKTGROUP, style: const TextStyle(fontSize: 12))),
          DataCell(Text(item.FRE, style: const TextStyle(fontSize: 12))),
          DataCell(Text(item.REPORTITEMS, style: const TextStyle(fontSize: 12))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

Future<void> exportToExcel(List<P01ALLCUSTOMERGETDATAclass> filteredData) async {
  final workbook = xlsio.Workbook();
  final sheet = workbook.worksheets[0];
  sheet.name = 'MASTER SAR';

  // ✅ Header
  sheet.importList([
    'No.',
    'CustFull',
    'CustShort',
    'Group Name TS',
    'Type',
    'Group',
    'MKT Group',
    'Frequency',
    'Report Items',
  ], 1, 1, false);

  // ✅ Style
  final centerStyleHeader = workbook.styles.add('centerStyleHeader');
  centerStyleHeader.hAlign = xlsio.HAlignType.center;
  centerStyleHeader.vAlign = xlsio.VAlignType.center;
  centerStyleHeader.bold = true;

  final centerStyleData = workbook.styles.add('centerStyleData');
  centerStyleData.hAlign = xlsio.HAlignType.center;
  centerStyleData.vAlign = xlsio.VAlignType.center;

  // ✅ Apply style to header row
  final headerRange = sheet.getRangeByIndex(1, 1, 1, 9);
  headerRange.cellStyle = centerStyleHeader;

  // ✅ Fill data
  int currentRow = 2;
  for (var item in filteredData) {
    sheet.getRangeByIndex(currentRow, 1).setText((currentRow - 1).toString());
    sheet.getRangeByIndex(currentRow, 2).setText(item.CustFull);
    sheet.getRangeByIndex(currentRow, 3).setText(item.CustShort);
    sheet.getRangeByIndex(currentRow, 4).setText(item.GroupNameTS);
    sheet.getRangeByIndex(currentRow, 5).setText(item.TYPE);
    sheet.getRangeByIndex(currentRow, 6).setText(item.GROUP);
    sheet.getRangeByIndex(currentRow, 7).setText(item.MKTGROUP);
    sheet.getRangeByIndex(currentRow, 8).setText(item.FRE);
    sheet.getRangeByIndex(currentRow, 9).setText(item.REPORTITEMS);

    // Apply style row data
    final dataRange = sheet.getRangeByIndex(currentRow, 1, currentRow, 9);
    dataRange.cellStyle = centerStyleData;

    currentRow++;
  }

  // ✅ Save
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  if (kIsWeb) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "MasterSAR.xlsx")
      ..click();
    html.Url.revokeObjectUrl(url);
  } else {
    if (await Permission.storage.request().isGranted) {
      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/MasterSAR.xlsx';
      final file = io.File(path);
      await file.writeAsBytes(bytes, flush: true);
      print('✅ Saved to $path');
    }
  }
}
