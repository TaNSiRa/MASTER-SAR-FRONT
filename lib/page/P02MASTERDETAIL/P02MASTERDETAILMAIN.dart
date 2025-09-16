// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02GETMASTERDETAIL.dart';
import '../../data/global.dart';
import '../../widget/function/ShowDialog.dart';
import 'Function/api.dart';
import 'Function/text.dart';
import 'P02MASTERDETAILVAR.dart';

late BuildContext P02MASTERDETAILMAINcontext;

class P02MASTERDETAILMAIN extends StatefulWidget {
  P02MASTERDETAILMAIN({
    super.key,
    this.data,
  });
  P02MASTERDETAILGETDATAclass? data;

  @override
  State<P02MASTERDETAILMAIN> createState() => _P02MASTERDETAILMAINState();
}

class _P02MASTERDETAILMAINState extends State<P02MASTERDETAILMAIN> {
  int _selectedPage = 0; // 0 = MasterTS, 1 = MasterLab
  Set<String> editingRows = {};
  Set<String> changedCells = {};
  Set<String> deletingRows = {};

  @override
  void initState() {
    super.initState();
    context.read<P02MASTERDETAILGETDATA_Bloc>().add(P02MASTERDETAILGETDATA_GET());
    editingRows.clear();
    deletingRows.clear();
    changedCells.clear();
    // PageName = 'Master detail';
  }

  @override
  Widget build(BuildContext context) {
    P02MASTERDETAILMAINcontext = context;
    P02MASTERDETAILGETDATAclass _datain = widget.data ?? P02MASTERDETAILGETDATAclass();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Toggle Buttons for page switching
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              masterType = 'Routine_MasterPatternTS';
                              editingRows.clear();
                              deletingRows.clear();
                              changedCells.clear();
                              context.read<P02MASTERDETAILGETDATA_Bloc>().add(P02MASTERDETAILGETDATA_GET());
                              _selectedPage = 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedPage == 0 ? Colors.blueAccent : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "MasterTS",
                              style: TextStyle(
                                color: _selectedPage == 0 ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              masterType = 'Routine_MasterPatternLab';
                              editingRows.clear();
                              deletingRows.clear();
                              changedCells.clear();
                              context.read<P02MASTERDETAILGETDATA_Bloc>().add(P02MASTERDETAILGETDATA_GET());
                              _selectedPage = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedPage == 1 ? Colors.greenAccent.shade100 : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "MasterLab",
                              style: TextStyle(
                                color: _selectedPage == 1 ? Colors.black87 : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Table area
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child:
                          _selectedPage == 0 ? _buildMasterTSTable(_datain) : _buildMasterLabTable(_datain),
                    ),
                  ),
                ),
              ),
            ),
            if (editingRows.isNotEmpty || deletingRows.isNotEmpty || changedCells.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        ConfirmationDialog.show(
                          context,
                          icon: Icons.edit_document,
                          iconColor: Colors.blue,
                          title: 'Update data',
                          content: 'Did you update the data?',
                          confirmText: 'Confirm',
                          confirmButtonColor: Colors.blue,
                          cancelText: 'Cancel',
                          cancelButtonColor: Colors.blue,
                          onConfirm: () async {
                            List<Map<String, dynamic>> sendData;
                            if (masterType == 'Routine_MasterPatternTS') {
                              sendData = _datain.MasterTS.map((row) => row.toJson()).toList();
                            } else {
                              sendData = _datain.MasterLab.map((row) => row.toJson()).toList();
                            }
                            for (var row in sendData) {
                              if (deletingRows.contains(row['Id'])) {
                                row['deleted'] = true;
                              }
                            }
                            setState(() {
                              editingRows.clear();
                              deletingRows.clear();
                              changedCells.clear();
                            });
                            P02MASTERDETAILVAR.SendEditDataToAPI = jsonEncode(sendData);
                            await confirmEdit(context);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        shadowColor: Colors.greenAccent,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.green, width: 2),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: const [
                          Text(
                            'Comfirm edit',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.edit_document,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Table for MasterTS
  Widget _buildMasterTSTable(P02MASTERDETAILGETDATAclass? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.blueAccent.shade100),
          headingRowHeight: 50,
          dataRowColor: MaterialStateProperty.all(Colors.white),
          dataRowHeight: 40,
          columnSpacing: 16,
          columns: [
            DataColumn(label: columnText("Copy & Add")),
            DataColumn(label: columnText("CustFull")),
            DataColumn(label: columnText("CustShort")),
            DataColumn(label: columnText("Incharge")),
            DataColumn(label: columnText("SampleNo")),
            DataColumn(label: columnText("GroupNameTS")),
            DataColumn(label: columnText("SampleGroup")),
            DataColumn(label: columnText("SampleType")),
            DataColumn(label: columnText("SampleTank")),
            DataColumn(label: columnText("SampleName")),
            DataColumn(label: columnText("ProcessReportName")),
            DataColumn(label: columnText("ItemNo")),
            DataColumn(label: columnText("ItemName")),
            DataColumn(label: columnText("ItemReportName")),
            DataColumn(label: columnText("StdFactor")),
            DataColumn(label: columnText("StdMin")),
            DataColumn(label: columnText("StdSymbol")),
            DataColumn(label: columnText("StdMax")),
            DataColumn(label: columnText("ControlRange")),
            DataColumn(label: columnText("SubLeader")),
            DataColumn(label: columnText("GL")),
            DataColumn(label: columnText("JP")),
            DataColumn(label: columnText("DGM")),
            DataColumn(label: columnText("PatternReport")),
            DataColumn(label: columnText("ReportOrder")),
            DataColumn(label: columnText("TYPE")),
            DataColumn(label: columnText("GROUP")),
            DataColumn(label: columnText("MKTGROUP")),
            DataColumn(label: columnText("FRE")),
            DataColumn(label: columnText("REPORTITEMS")),
            DataColumn(label: columnText("Actions")),
          ],
          rows: data?.MasterTS.map((e) {
                final isEditing = editingRows.contains(e.Id);
                return DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (deletingRows.contains(e.Id)) {
                        return Colors.redAccent.withOpacity(0.5); // สีแดงชั่วคราว
                      }
                      return Colors.white; // ปกติ
                    }),
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            if (e.isNewRow) ...[
                              IconButton(
                                icon: Icon(Icons.cancel_rounded, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    data.MasterTS.remove(e);
                                    editingRows.remove(e.Id);
                                  });
                                },
                              ),
                            ] else ...[
                              IconButton(
                                icon: Icon(Icons.copy_rounded, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    final sameSampleRows =
                                        data.MasterTS.where((row) => row.SampleNo == e.SampleNo).toList();

                                    int maxItemNo = 0;
                                    for (var row in sameSampleRows) {
                                      final itemNoInt = int.tryParse(row.ItemNo) ?? 0;
                                      if (itemNoInt > maxItemNo) {
                                        maxItemNo = itemNoInt;
                                      }
                                    }
                                    final newRow = MasterTSclass(
                                      Id: UniqueKey().toString(),
                                      CustId: e.CustId,
                                      CustFull: e.CustFull,
                                      CustShort: e.CustShort,
                                      Incharge: e.Incharge,
                                      SampleNo: e.SampleNo,
                                      GroupNameTS: e.GroupNameTS,
                                      SampleGroup: e.SampleGroup,
                                      SampleType: e.SampleType,
                                      SampleTank: e.SampleTank,
                                      SampleName: e.SampleName,
                                      ProcessReportName: e.ProcessReportName,
                                      ItemNo: (maxItemNo + 1).toString(),
                                      ItemName: '',
                                      ItemReportName: '',
                                      StdFactor: '',
                                      StdMin: '',
                                      StdSymbol: '',
                                      StdMax: '',
                                      ControlRange: '',
                                      SubLeader: e.SubLeader,
                                      GL: e.GL,
                                      JP: e.JP,
                                      DGM: e.DGM,
                                      PatternReport: e.PatternReport,
                                      ReportOrder: '',
                                      TYPE: e.TYPE,
                                      GROUP: e.GROUP,
                                      MKTGROUP: e.MKTGROUP,
                                      FRE: e.FRE,
                                      REPORTITEMS: e.REPORTITEMS,
                                      isNewRow: true,
                                    );
                                    final index = data.MasterTS.indexOf(e);
                                    data.MasterTS.insert(index + 1, newRow);
                                    editingRows.add(newRow.Id);
                                  });
                                },
                              ),
                            ]
                          ],
                        ),
                      ),
                      DataCell(dataText(e.CustFull)),
                      DataCell(dataText(e.CustShort)),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Incharge')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Incharge,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownUser,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.Incharge = value;
                                        changedCells.add('${item.Id}_Incharge');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.Incharge),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleNo')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleNo,
                                  onChanged: (value) {
                                    setState(() {
                                      e.SampleNo = value;
                                      changedCells.add('${e.Id}_SampleNo');
                                    });
                                  },
                                )
                              : dataText(e.SampleNo),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_GroupNameTS')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.GroupNameTS,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownGroupNameTS,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.GroupNameTS = value;
                                          changedCells.add('${item.Id}_GroupNameTS');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.GroupNameTS),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleGroup')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleGroup,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleGroupTS,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleGroup = value;
                                          changedCells.add('${item.Id}_SampleGroup');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleGroup),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleType')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleType,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleTypeTS,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleType = value;
                                          changedCells.add('${item.Id}_SampleType');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleType),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleTank')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleTank,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleTank = value;
                                          changedCells.add('${item.Id}_SampleTank');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleTank),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleName,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleName = value;
                                          changedCells.add('${item.Id}_SampleName');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ProcessReportName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ProcessReportName,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.ProcessReportName = value;
                                          changedCells.add('${item.Id}_ProcessReportName');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.ProcessReportName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ItemNo')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ItemNo,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ItemNo = value;
                                      changedCells.add('${e.Id}_ItemNo');
                                    });
                                  },
                                )
                              : dataText(e.ItemNo),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ItemName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ItemName,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownItemTS,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ItemName = value;
                                      changedCells.add('${e.Id}_ItemName');
                                    });
                                  },
                                )
                              : dataText(e.ItemName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ItemReportName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ItemReportName,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ItemReportName = value;
                                      changedCells.add('${e.Id}_ItemReportName');
                                    });
                                  },
                                )
                              : dataText(e.ItemReportName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdFactor')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdFactor,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdFactor = value;
                                      changedCells.add('${e.Id}_StdFactor');
                                    });
                                  },
                                )
                              : dataText(e.StdFactor),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdMin')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdMin,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMin = value;
                                      changedCells.add('${e.Id}_StdMin');
                                    });
                                  },
                                )
                              : dataText(e.StdMin),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdSymbol')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdSymbol,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdSymbol = value;
                                      changedCells.add('${e.Id}_StdSymbol');
                                    });
                                  },
                                )
                              : dataText(e.StdSymbol),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdMax')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdMax,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMax = value;
                                      changedCells.add('${e.Id}_StdMax');
                                    });
                                  },
                                )
                              : dataText(e.StdMax),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ControlRange')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ControlRange,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ControlRange = value;
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.ControlRange),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SubLeader')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SubLeader,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownUser,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.SubLeader = value;
                                        changedCells.add('${item.Id}_SubLeader');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SubLeader),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_GL')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.GL,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownUser,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.GL = value;
                                        changedCells.add('${item.Id}_GL');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.GL),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_JP')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.JP,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownUser,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.JP = value;
                                        changedCells.add('${item.Id}_JP');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.JP),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_DGM')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.DGM,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownUser,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.DGM = value;
                                        changedCells.add('${item.Id}_DGM');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.DGM),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_PatternReport')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.PatternReport,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.PatternReport = value;
                                        changedCells.add('${item.Id}_PatternReport');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.PatternReport),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ReportOrder')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ReportOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ReportOrder = value;
                                      changedCells.add('${e.Id}_ReportOrder');
                                    });
                                  },
                                )
                              : dataText(e.ReportOrder),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_TYPE')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.TYPE,
                                  dropdownItems: ['A', 'B'],
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.TYPE = value;
                                        changedCells.add('${item.Id}_TYPE');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.TYPE),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_GROUP')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.GROUP,
                                  dropdownItems: ['KAC', 'MEDIUM'],
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.GROUP = value;
                                        changedCells.add('${item.Id}_GROUP');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.GROUP),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_MKTGROUP')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.MKTGROUP,
                                  dropdownItems: ['1', '2', '5', '6'],
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.MKTGROUP = value;
                                        changedCells.add('${item.Id}_MKTGROUP');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.MKTGROUP),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_FRE')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.FRE,
                                  dropdownItems: ['1<', '1', '2', '3', '4'],
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.FRE = value;
                                        changedCells.add('${item.Id}_FRE');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.FRE),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_REPORTITEMS')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.REPORTITEMS,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterTS) {
                                        item.REPORTITEMS = value;
                                        changedCells.add('${item.Id}_REPORTITEMS');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.REPORTITEMS),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isEditing ? Icons.check : Icons.edit,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isEditing) {
                                    editingRows.remove(e.Id);
                                  } else {
                                    editingRows.add(e.Id);
                                  }
                                });
                              },
                            ),
                            if (!e.isNewRow) ...[
                              IconButton(
                                icon: Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
                                onPressed: () {
                                  setState(() {
                                    ConfirmationDialog.show(
                                      context,
                                      icon: Icons.delete_forever_rounded,
                                      iconColor: Colors.red,
                                      title: 'Delete data',
                                      content: 'Did you delete the data?',
                                      confirmText: 'Confirm',
                                      confirmButtonColor: Colors.red,
                                      cancelText: 'Cancel',
                                      cancelButtonColor: Colors.red,
                                      onConfirm: () async {
                                        setState(() {
                                          deletingRows.add(e.Id);
                                          // data.MasterTS.remove(e);
                                        });
                                      },
                                    );
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }

  /// Table for MasterLab
  Widget _buildMasterLabTable(P02MASTERDETAILGETDATAclass? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.greenAccent.shade100),
          headingRowHeight: 50,
          dataRowColor: MaterialStateProperty.all(Colors.white),
          dataRowHeight: 40,
          columnSpacing: 16,
          columns: [
            DataColumn(label: columnText("Copy & Add")),
            DataColumn(label: columnText("CustFull")),
            DataColumn(label: columnText("CustShort")),
            DataColumn(label: columnText("Branch")),
            DataColumn(label: columnText("Code")),
            DataColumn(label: columnText("Incharge")),
            DataColumn(label: columnText("FrequencyRequest")),
            DataColumn(label: columnText("SampleNo")),
            DataColumn(label: columnText("SampleGroup")),
            DataColumn(label: columnText("SampleType")),
            DataColumn(label: columnText("SampleTank")),
            DataColumn(label: columnText("SampleName")),
            DataColumn(label: columnText("SampleAmount")),
            DataColumn(label: columnText("ProcessReportName")),
            DataColumn(label: columnText("Frequency")),
            DataColumn(label: columnText("ItemNo")),
            DataColumn(label: columnText("InstrumentName")),
            DataColumn(label: columnText("ItemName")),
            DataColumn(label: columnText("ItemReportName")),
            DataColumn(label: columnText("Position")),
            DataColumn(label: columnText("Mag")),
            DataColumn(label: columnText("Temp")),
            DataColumn(label: columnText("StdMinL")),
            DataColumn(label: columnText("StdMaxL")),
            DataColumn(label: columnText("StdFactor")),
            DataColumn(label: columnText("Std1")),
            DataColumn(label: columnText("Std2")),
            DataColumn(label: columnText("Std3")),
            DataColumn(label: columnText("Std4")),
            DataColumn(label: columnText("Std5")),
            DataColumn(label: columnText("Std6")),
            DataColumn(label: columnText("Std7")),
            DataColumn(label: columnText("Std8")),
            DataColumn(label: columnText("Std9")),
            DataColumn(label: columnText("StdMin")),
            DataColumn(label: columnText("StdSymbol")),
            DataColumn(label: columnText("StdMax")),
            DataColumn(label: columnText("ControlRange")),
            DataColumn(label: columnText("ReportOrder")),
            DataColumn(label: columnText("Actions")),
          ],
          rows: data?.MasterLab.map((e) {
                final isEditing = editingRows.contains(e.Id);
                return DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (deletingRows.contains(e.Id)) {
                        return Colors.redAccent.withOpacity(0.5);
                      }
                      return Colors.white;
                    }),
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            if (e.isNewRow) ...[
                              IconButton(
                                icon: Icon(Icons.cancel_rounded, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    data.MasterLab.remove(e);
                                    editingRows.remove(e.Id);
                                  });
                                },
                              ),
                            ] else ...[
                              IconButton(
                                icon: Icon(Icons.copy_rounded, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    final sameSampleRows =
                                        data.MasterLab.where((row) => row.SampleNo == e.SampleNo).toList();
                                    int maxItemNo = 0;
                                    for (var row in sameSampleRows) {
                                      final itemNoInt = int.tryParse(row.ItemNo) ?? 0;
                                      if (itemNoInt > maxItemNo) {
                                        maxItemNo = itemNoInt;
                                      }
                                    }
                                    final newRow = MasterLabclass(
                                      Id: UniqueKey().toString(),
                                      CustId: e.CustId,
                                      CustFull: e.CustFull,
                                      CustShort: e.CustShort,
                                      Branch: e.Branch,
                                      Code: e.Code,
                                      Incharge: e.Incharge,
                                      FrequencyRequest: e.FrequencyRequest,
                                      SampleNo: e.SampleNo,
                                      SampleGroup: e.SampleGroup,
                                      SampleType: e.SampleType,
                                      SampleTank: e.SampleTank,
                                      SampleName: e.SampleName,
                                      SampleAmount: e.SampleAmount,
                                      ProcessReportName: e.ProcessReportName,
                                      Frequency: e.Frequency,
                                      ItemNo: (maxItemNo + 1).toString(),
                                      InstrumentName: '',
                                      ItemName: '',
                                      ItemReportName: '',
                                      Position: '',
                                      Mag: '',
                                      Temp: '',
                                      StdMinL: '',
                                      StdMaxL: '',
                                      StdFactor: '',
                                      Std1: '',
                                      Std2: '',
                                      Std3: '',
                                      Std4: '',
                                      Std5: '',
                                      Std6: '',
                                      Std7: '',
                                      Std8: '',
                                      Std9: '',
                                      StdMin: '',
                                      StdSymbol: '',
                                      StdMax: '',
                                      ControlRange: '',
                                      ReportOrder: '',
                                      FactorC: '',
                                      isNewRow: true,
                                    );
                                    final index = data.MasterLab.indexOf(e);
                                    data.MasterLab.insert(index + 1, newRow);
                                    editingRows.add(newRow.Id);
                                  });
                                },
                              ),
                            ]
                          ],
                        ),
                      ),
                      DataCell(dataText(e.CustFull)),
                      DataCell(dataText(e.CustShort)),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Branch')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Branch,
                                  dropdownItems: ['BANGPOO', 'RAYONG'],
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        item.Branch = value;
                                        changedCells.add('${item.Id}_Branch');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.Branch),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Code')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Code,
                                  dropdownItems: ['MKT', 'ENV', 'KAN', 'CHE', 'ISN', 'GAS', 'PHO'],
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        item.Code = value;
                                        changedCells.add('${item.Id}_Code');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.Code),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Incharge')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Incharge,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownUser,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        item.Incharge = value;
                                        changedCells.add('${item.Id}_Incharge');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.Incharge),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_FrequencyRequest')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.FrequencyRequest,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        item.FrequencyRequest = value;
                                        changedCells.add('${item.Id}_FrequencyRequest');
                                      }
                                    });
                                  },
                                )
                              : dataText(e.FrequencyRequest),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleNo')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleNo,
                                  onChanged: (value) {
                                    setState(() {
                                      e.SampleNo = value;
                                      changedCells.add('${e.Id}_SampleNo');
                                    });
                                  },
                                )
                              : dataText(e.SampleNo),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleGroup')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleGroup,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleGroupLab,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleGroup = value;
                                          changedCells.add('${item.Id}_SampleGroup');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleGroup),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleType')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleType,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleTypeLab,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleType = value;
                                          changedCells.add('${item.Id}_SampleType');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleType),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleTank')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleTank,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleTank = value;
                                          changedCells.add('${item.Id}_SampleTank');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleTank),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleName,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleName = value;
                                          changedCells.add('${item.Id}_SampleName');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_SampleAmount')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.SampleAmount,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.SampleAmount = value;
                                          changedCells.add('${item.Id}_SampleAmount');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.SampleAmount),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ProcessReportName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ProcessReportName,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var item in data.MasterLab) {
                                        if (item.SampleNo == e.SampleNo) {
                                          item.ProcessReportName = value;
                                          changedCells.add('${item.Id}_ProcessReportName');
                                        }
                                      }
                                    });
                                  },
                                )
                              : dataText(e.ProcessReportName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Frequency')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Frequency,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Frequency = value;
                                      changedCells.add('${e.Id}_Frequency');
                                    });
                                  },
                                )
                              : dataText(e.Frequency),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ItemNo')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ItemNo,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ItemNo = value;
                                      changedCells.add('${e.Id}_ItemNo');
                                    });
                                  },
                                )
                              : dataText(e.ItemNo),
                        ),
                      ),
                      DataCell(dataText(e.InstrumentName)),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ItemName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ItemName,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownItemLab,
                                  onChanged: (value) {
                                    setState(() {
                                      final parts = value.split('|');
                                      e.InstrumentName = parts.isNotEmpty ? parts[0].trim() : '';
                                      e.ItemName = parts.length > 1 ? parts[1].trim() : '';
                                      changedCells.add('${e.Id}_InstrumentName');
                                      changedCells.add('${e.Id}_ItemName');
                                    });
                                  },
                                )
                              : dataText(e.ItemName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ItemReportName')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ItemReportName,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ItemReportName = value;
                                      changedCells.add('${e.Id}_ItemReportName');
                                    });
                                  },
                                )
                              : dataText(e.ItemReportName),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Position')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Position,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Position = value;
                                      changedCells.add('${e.Id}_Position');
                                    });
                                  },
                                )
                              : dataText(e.Position),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Mag')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Mag,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Mag = value;
                                      changedCells.add('${e.Id}_Mag');
                                    });
                                  },
                                )
                              : dataText(e.Mag),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Temp')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Temp,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Temp = value;
                                      changedCells.add('${e.Id}_Temp');
                                    });
                                  },
                                )
                              : dataText(e.Temp),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdMinL')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdMinL,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMinL = value;
                                      changedCells.add('${e.Id}_StdMinL');
                                    });
                                  },
                                )
                              : dataText(e.StdMinL),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdMaxL')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdMaxL,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMaxL = value;
                                      changedCells.add('${e.Id}_StdMaxL');
                                    });
                                  },
                                )
                              : dataText(e.StdMaxL),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdFactor')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdFactor,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdFactor = value;
                                      changedCells.add('${e.Id}_StdFactor');
                                    });
                                  },
                                )
                              : dataText(e.StdFactor),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std1')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std1,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std1 = value;
                                      changedCells.add('${e.Id}_Std1');
                                    });
                                  },
                                )
                              : dataText(e.Std1),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std2')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std2,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std2 = value;
                                      changedCells.add('${e.Id}_Std2');
                                    });
                                  },
                                )
                              : dataText(e.Std2),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std3')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std3,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std3 = value;
                                      changedCells.add('${e.Id}_Std3');
                                    });
                                  },
                                )
                              : dataText(e.Std3),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std4')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std4,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std4 = value;
                                      changedCells.add('${e.Id}_Std4');
                                    });
                                  },
                                )
                              : dataText(e.Std4),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std5')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std5,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std5 = value;
                                      changedCells.add('${e.Id}_Std5');
                                    });
                                  },
                                )
                              : dataText(e.Std5),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std6')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std6,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std6 = value;
                                      changedCells.add('${e.Id}_Std6');
                                    });
                                  },
                                )
                              : dataText(e.Std6),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std7')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std7,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std7 = value;
                                      changedCells.add('${e.Id}_Std7');
                                    });
                                  },
                                )
                              : dataText(e.Std7),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std8')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std8,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std8 = value;
                                      changedCells.add('${e.Id}_Std8');
                                    });
                                  },
                                )
                              : dataText(e.Std8),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_Std9')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.Std9,
                                  onChanged: (value) {
                                    setState(() {
                                      e.Std9 = value;
                                      changedCells.add('${e.Id}_Std9');
                                    });
                                  },
                                )
                              : dataText(e.Std9),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdMin')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdMin,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMin = value;
                                      changedCells.add('${e.Id}_StdMin');
                                    });
                                  },
                                )
                              : dataText(e.StdMin),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdSymbol')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdSymbol,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdSymbol = value;
                                      changedCells.add('${e.Id}_StdSymbol');
                                    });
                                  },
                                )
                              : dataText(e.StdSymbol),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_StdMax')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.StdMax,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMax = value;
                                      changedCells.add('${e.Id}_StdMax');
                                    });
                                  },
                                )
                              : dataText(e.StdMax),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ControlRange')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ControlRange,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ControlRange = value;
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.ControlRange),
                        ),
                      ),
                      DataCell(
                        Container(
                          color: changedCells.contains('${e.Id}_ReportOrder')
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                          child: isEditing
                              ? dataInputCell(
                                  value: e.ReportOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      e.ReportOrder = value;
                                      changedCells.add('${e.Id}_ReportOrder');
                                    });
                                  },
                                )
                              : dataText(e.ReportOrder),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isEditing ? Icons.check : Icons.edit,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isEditing) {
                                    editingRows.remove(e.Id);
                                  } else {
                                    editingRows.add(e.Id);
                                  }
                                });
                              },
                            ),
                            if (!e.isNewRow) ...[
                              IconButton(
                                icon: Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
                                onPressed: () {
                                  setState(() {
                                    ConfirmationDialog.show(
                                      context,
                                      icon: Icons.delete_forever_rounded,
                                      iconColor: Colors.red,
                                      title: 'Delete data',
                                      content: 'Did you delete the data?',
                                      confirmText: 'Confirm',
                                      confirmButtonColor: Colors.red,
                                      cancelText: 'Cancel',
                                      cancelButtonColor: Colors.red,
                                      onConfirm: () async {
                                        setState(() {
                                          deletingRows.add(e.Id);
                                          // data.MasterTS.remove(e);
                                        });
                                      },
                                    );
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
