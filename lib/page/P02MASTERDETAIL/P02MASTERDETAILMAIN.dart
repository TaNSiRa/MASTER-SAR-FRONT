// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02GETMASTERDETAIL.dart';
import '../../data/global.dart';
import '../../widget/function/ShowDialog.dart';
import 'Function/api.dart';
import 'Function/controlRange.dart';
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
  Map<String, Map<String, String>> originalRowData = {};
  bool isInitialLoadTS = true;
  bool isInitialLoadLab = true;

  @override
  void initState() {
    super.initState();
    context.read<P02MASTERDETAILGETDATA_Bloc>().add(P02MASTERDETAILGETDATA_GET());
    editingRows.clear();
    deletingRows.clear();
    changedCells.clear();
    originalRowData.clear();
    // PageName = 'Master detail';
  }

// Add method to store original row data when starting edit
  void _storeOriginalRowData(String rowId, dynamic rowData) {
    if (rowData is MasterTSclass) {
      originalRowData[rowId] = {
        'Incharge': rowData.Incharge,
        'SampleNo': rowData.SampleNo,
        'GroupNameTS': rowData.GroupNameTS,
        'SampleGroup': rowData.SampleGroup,
        'SampleType': rowData.SampleType,
        'SampleTank': rowData.SampleTank,
        'SampleName': rowData.SampleName,
        'ProcessReportName': rowData.ProcessReportName,
        'ItemNo': rowData.ItemNo,
        'ItemName': rowData.ItemName,
        'ItemReportName': rowData.ItemReportName,
        'StdFactor': rowData.StdFactor,
        'StdMin': rowData.StdMin,
        'StdSymbol': rowData.StdSymbol,
        'StdMax': rowData.StdMax,
        'ControlRange': rowData.ControlRange,
        'SubLeader': rowData.SubLeader,
        'GL': rowData.GL,
        'JP': rowData.JP,
        'DGM': rowData.DGM,
        'PatternReport': rowData.PatternReport,
        'ReportOrder': rowData.ReportOrder,
        'TYPE': rowData.TYPE,
        'GROUP': rowData.GROUP,
        'MKTGROUP': rowData.MKTGROUP,
        'FRE': rowData.FRE,
        'REPORTITEMS': rowData.REPORTITEMS,
      };
    } else if (rowData is MasterLabclass) {
      originalRowData[rowId] = {
        'Branch': rowData.Branch,
        'Code': rowData.Code,
        'Incharge': rowData.Incharge,
        'FrequencyRequest': rowData.FrequencyRequest,
        'SampleNo': rowData.SampleNo,
        'SampleGroup': rowData.SampleGroup,
        'SampleType': rowData.SampleType,
        'SampleTank': rowData.SampleTank,
        'SampleName': rowData.SampleName,
        'SampleAmount': rowData.SampleAmount,
        'ProcessReportName': rowData.ProcessReportName,
        'Frequency': rowData.Frequency,
        'ItemNo': rowData.ItemNo,
        'InstrumentName': rowData.InstrumentName,
        'ItemName': rowData.ItemName,
        'ItemReportName': rowData.ItemReportName,
        'Position': rowData.Position,
        'Mag': rowData.Mag,
        'Temp': rowData.Temp,
        'StdMinL': rowData.StdMinL,
        'StdMaxL': rowData.StdMaxL,
        'StdFactor': rowData.StdFactor,
        'Std1': rowData.Std1,
        'Std2': rowData.Std2,
        'Std3': rowData.Std3,
        'Std4': rowData.Std4,
        'Std5': rowData.Std5,
        'Std6': rowData.Std6,
        'Std7': rowData.Std7,
        'Std8': rowData.Std8,
        'Std9': rowData.Std9,
        'StdMin': rowData.StdMin,
        'StdSymbol': rowData.StdSymbol,
        'StdMax': rowData.StdMax,
        'ControlRange': rowData.ControlRange,
        'ReportOrder': rowData.ReportOrder,
      };
    }
  }

  // Add method to restore original row data
  void _restoreOriginalRowData(String rowId, dynamic rowData, P02MASTERDETAILGETDATAclass data) {
    final originalData = originalRowData[rowId];
    if (originalData == null) return;

    if (rowData is MasterTSclass) {
      rowData.Incharge = originalData['Incharge'] ?? '';
      rowData.SampleNo = originalData['SampleNo'] ?? '';
      rowData.GroupNameTS = originalData['GroupNameTS'] ?? '';
      rowData.SampleGroup = originalData['SampleGroup'] ?? '';
      rowData.SampleType = originalData['SampleType'] ?? '';
      rowData.SampleTank = originalData['SampleTank'] ?? '';
      rowData.SampleName = originalData['SampleName'] ?? '';
      rowData.ProcessReportName = originalData['ProcessReportName'] ?? '';
      rowData.ItemNo = originalData['ItemNo'] ?? '';
      rowData.ItemName = originalData['ItemName'] ?? '';
      rowData.ItemReportName = originalData['ItemReportName'] ?? '';
      rowData.StdFactor = originalData['StdFactor'] ?? '';
      rowData.StdMin = originalData['StdMin'] ?? '';
      rowData.StdSymbol = originalData['StdSymbol'] ?? '';
      rowData.StdMax = originalData['StdMax'] ?? '';
      rowData.ControlRange = originalData['ControlRange'] ?? '';
      rowData.SubLeader = originalData['SubLeader'] ?? '';
      rowData.GL = originalData['GL'] ?? '';
      rowData.JP = originalData['JP'] ?? '';
      rowData.DGM = originalData['DGM'] ?? '';
      rowData.PatternReport = originalData['PatternReport'] ?? '';
      rowData.ReportOrder = originalData['ReportOrder'] ?? '';
      rowData.TYPE = originalData['TYPE'] ?? '';
      rowData.GROUP = originalData['GROUP'] ?? '';
      rowData.MKTGROUP = originalData['MKTGROUP'] ?? '';
      rowData.FRE = originalData['FRE'] ?? '';
      rowData.REPORTITEMS = originalData['REPORTITEMS'] ?? '';

      // Also restore for related rows with same sample
      for (var item in data.MasterTS) {
        if (item.SampleNo == rowData.SampleNo && item.Id != rowId) {
          item.GroupNameTS = originalData['GroupNameTS'] ?? '';
          item.SampleGroup = originalData['SampleGroup'] ?? '';
          item.SampleType = originalData['SampleType'] ?? '';
          item.SampleTank = originalData['SampleTank'] ?? '';
          item.SampleName = originalData['SampleName'] ?? '';
          item.ProcessReportName = originalData['ProcessReportName'] ?? '';
        }
        item.Incharge = originalData['Incharge'] ?? '';
        item.SubLeader = originalData['SubLeader'] ?? '';
        item.GL = originalData['GL'] ?? '';
        item.JP = originalData['JP'] ?? '';
        item.DGM = originalData['DGM'] ?? '';
        item.PatternReport = originalData['PatternReport'] ?? '';
        item.TYPE = originalData['TYPE'] ?? '';
        item.GROUP = originalData['GROUP'] ?? '';
        item.MKTGROUP = originalData['MKTGROUP'] ?? '';
        item.FRE = originalData['FRE'] ?? '';
        item.REPORTITEMS = originalData['REPORTITEMS'] ?? '';
      }
    } else if (rowData is MasterLabclass) {
      rowData.Branch = originalData['Branch'] ?? '';
      rowData.Code = originalData['Code'] ?? '';
      rowData.Incharge = originalData['Incharge'] ?? '';
      rowData.FrequencyRequest = originalData['FrequencyRequest'] ?? '';
      rowData.SampleNo = originalData['SampleNo'] ?? '';
      rowData.SampleGroup = originalData['SampleGroup'] ?? '';
      rowData.SampleType = originalData['SampleType'] ?? '';
      rowData.SampleTank = originalData['SampleTank'] ?? '';
      rowData.SampleName = originalData['SampleName'] ?? '';
      rowData.SampleAmount = originalData['SampleAmount'] ?? '';
      rowData.ProcessReportName = originalData['ProcessReportName'] ?? '';
      rowData.Frequency = originalData['Frequency'] ?? '';
      rowData.ItemNo = originalData['ItemNo'] ?? '';
      rowData.InstrumentName = originalData['InstrumentName'] ?? '';
      rowData.ItemName = originalData['ItemName'] ?? '';
      rowData.ItemReportName = originalData['ItemReportName'] ?? '';
      rowData.Position = originalData['Position'] ?? '';
      rowData.Mag = originalData['Mag'] ?? '';
      rowData.Temp = originalData['Temp'] ?? '';
      rowData.StdMinL = originalData['StdMinL'] ?? '';
      rowData.StdMaxL = originalData['StdMaxL'] ?? '';
      rowData.StdFactor = originalData['StdFactor'] ?? '';
      rowData.Std1 = originalData['Std1'] ?? '';
      rowData.Std2 = originalData['Std2'] ?? '';
      rowData.Std3 = originalData['Std3'] ?? '';
      rowData.Std4 = originalData['Std4'] ?? '';
      rowData.Std5 = originalData['Std5'] ?? '';
      rowData.Std6 = originalData['Std6'] ?? '';
      rowData.Std7 = originalData['Std7'] ?? '';
      rowData.Std8 = originalData['Std8'] ?? '';
      rowData.Std9 = originalData['Std9'] ?? '';
      rowData.StdMin = originalData['StdMin'] ?? '';
      rowData.StdSymbol = originalData['StdSymbol'] ?? '';
      rowData.StdMax = originalData['StdMax'] ?? '';
      rowData.ControlRange = originalData['ControlRange'] ?? '';
      rowData.ReportOrder = originalData['ReportOrder'] ?? '';

      // Also restore for related rows with same sample
      for (var item in data.MasterLab) {
        if (item.SampleNo == rowData.SampleNo && item.Id != rowId) {
          item.SampleGroup = originalData['SampleGroup'] ?? '';
          item.SampleType = originalData['SampleType'] ?? '';
          item.SampleTank = originalData['SampleTank'] ?? '';
          item.SampleName = originalData['SampleName'] ?? '';
          item.SampleAmount = originalData['SampleAmount'] ?? '';
          item.ProcessReportName = originalData['ProcessReportName'] ?? '';
        }
        item.Branch = originalData['Branch'] ?? '';
        item.Code = originalData['Code'] ?? '';
        item.Incharge = originalData['Incharge'] ?? '';
        item.FrequencyRequest = originalData['FrequencyRequest'] ?? '';
      }
    }

    // Remove changed cells for this row
    changedCells.removeWhere((cellId) => cellId.startsWith('${rowId}_'));

    // Also remove for related rows
    if (rowData is MasterTSclass) {
      for (var item in data.MasterTS) {
        if (item.SampleNo == rowData.SampleNo) {
          changedCells.removeWhere((cellId) => cellId.startsWith('${item.Id}_'));
        }
      }
    } else if (rowData is MasterLabclass) {
      for (var item in data.MasterLab) {
        if (item.SampleNo == rowData.SampleNo) {
          changedCells.removeWhere((cellId) => cellId.startsWith('${item.Id}_'));
        }
      }
    }
  }

  // Add method to check if value has changed from original
  bool _hasValueChanged(String rowId, String fieldName, String currentValue) {
    final originalData = originalRowData[rowId];
    // print("Row: $rowId | field: $fieldName | original: ${originalData?[fieldName]} | current: $currentValue");
    if (originalData == null) return false;
    return originalData[fieldName] != currentValue;
  }

  // Modified Actions DataCell for MasterTS table
  DataCell _buildMasterTSActionsCell(MasterTSclass e, P02MASTERDETAILGETDATAclass data) {
    final isEditing = editingRows.contains(e.Id);

    return DataCell(
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
                  originalRowData.remove(e.Id); // Clean up original data
                } else {
                  // _storeOriginalRowData(e.Id, e); // Store original data
                  if (isInitialLoadTS) {
                    for (var row in data.MasterTS) {
                      _storeOriginalRowData(row.Id, row);
                    }
                    isInitialLoadTS = false;
                  }
                  editingRows.add(e.Id);
                }
              });
            },
          ),
          // Cancel edit button (only show when editing and not a new row)
          if (isEditing && !e.isNewRow) ...[
            IconButton(
              icon: Icon(Icons.cancel, color: Colors.orange),
              tooltip: 'Cancel Edit',
              onPressed: () {
                setState(() {
                  _restoreOriginalRowData(e.Id, e, data);
                  editingRows.remove(e.Id);
                  originalRowData.remove(e.Id);
                });
              },
            ),
          ],
          if (!e.isNewRow) ...[
            IconButton(
              icon: deletingRows.contains(e.Id)
                  ? Icon(Icons.undo, color: Colors.black)
                  : Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  if (deletingRows.contains(e.Id)) {
                    deletingRows.remove(e.Id);
                  } else {
                    ConfirmationDialog.show(
                      context,
                      icon: Icons.delete_forever_rounded,
                      iconColor: Colors.red,
                      title: 'Delete data',
                      content:
                          'When deleting data, please edit the new ReportOrder.\nAre you sure you want to delete?',
                      confirmText: 'Confirm',
                      confirmButtonColor: Colors.red,
                      cancelText: 'Cancel',
                      cancelButtonColor: Colors.red,
                      onConfirm: () async {
                        setState(() {
                          deletingRows.add(e.Id);
                        });
                      },
                    );
                  }
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  // Modified Actions DataCell for MasterLab table
  DataCell _buildMasterLabActionsCell(MasterLabclass e, P02MASTERDETAILGETDATAclass data) {
    final isEditing = editingRows.contains(e.Id);

    return DataCell(
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
                  originalRowData.remove(e.Id); // Clean up original data
                } else {
                  // _storeOriginalRowData(e.Id, e); // Store original data
                  if (isInitialLoadLab) {
                    for (var row in data.MasterLab) {
                      _storeOriginalRowData(row.Id, row);
                    }
                    isInitialLoadLab = false;
                  }

                  editingRows.add(e.Id);
                }
              });
            },
          ),
          // Cancel edit button (only show when editing and not a new row)
          if (isEditing && !e.isNewRow) ...[
            IconButton(
              icon: Icon(Icons.cancel, color: Colors.orange),
              tooltip: 'Cancel Edit',
              onPressed: () {
                setState(() {
                  _restoreOriginalRowData(e.Id, e, data);
                  editingRows.remove(e.Id);
                  originalRowData.remove(e.Id);
                });
              },
            ),
          ],
          if (!e.isNewRow) ...[
            IconButton(
              icon: deletingRows.contains(e.Id)
                  ? Icon(Icons.undo, color: Colors.black)
                  : Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  if (deletingRows.contains(e.Id)) {
                    deletingRows.remove(e.Id);
                  } else {
                    ConfirmationDialog.show(
                      context,
                      icon: Icons.delete_forever_rounded,
                      iconColor: Colors.red,
                      title: 'Delete data',
                      content:
                          'When deleting data, please edit the new ReportOrder.\nAre you sure you want to delete?',
                      confirmText: 'Confirm',
                      confirmButtonColor: Colors.red,
                      cancelText: 'Cancel',
                      cancelButtonColor: Colors.red,
                      onConfirm: () async {
                        setState(() {
                          deletingRows.add(e.Id);
                        });
                      },
                    );
                  }
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  // Example of how to modify the Container color logic for a field
  Container _buildEditableCell(String rowId, String fieldName, String currentValue, Widget child) {
    bool showHighlight = _hasValueChanged(rowId, fieldName, currentValue);
    // print(changedCells);
    return Container(
      color: showHighlight ? Colors.yellow.withOpacity(0.5) : Colors.transparent,
      child: child,
    );
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
                        return Colors.redAccent.withOpacity(0.5);
                      }
                      if (e.isNewRow) {
                        return Colors.greenAccent.withOpacity(0.3); // Green for new rows
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
                                    data.MasterTS.remove(e);
                                    editingRows.remove(e.Id);
                                  });
                                },
                              ),
                            ] else ...[
                              IconButton(
                                icon: Icon(Icons.add_to_photos_rounded, color: Colors.grey),
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
                        _buildEditableCell(
                          e.Id,
                          'Incharge',
                          e.Incharge,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'SampleNo',
                          e.SampleNo,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'GroupNameTS',
                          e.GroupNameTS,
                          isEditing
                              ? dataInputCell(
                                  value: e.GroupNameTS,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownGroupName,
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
                        _buildEditableCell(
                          e.Id,
                          'SampleGroup',
                          e.SampleGroup,
                          isEditing
                              ? dataInputCell(
                                  value: e.SampleGroup,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleGroup,
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
                        _buildEditableCell(
                          e.Id,
                          'SampleType',
                          e.SampleType,
                          isEditing
                              ? dataInputCell(
                                  value: e.SampleType,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleType,
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
                        _buildEditableCell(
                          e.Id,
                          'SampleTank',
                          e.SampleTank,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'SampleName',
                          e.SampleName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ProcessReportName',
                          e.ProcessReportName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ItemNo',
                          e.ItemNo,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ItemName',
                          e.ItemName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ItemReportName',
                          e.ItemReportName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'StdFactor',
                          e.StdFactor,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'StdMin',
                          e.StdMin,
                          isEditing
                              ? dataInputCell(
                                  value: e.StdMin,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMin = value;
                                      e.ControlRange = buildControlRange(e.StdMin, e.StdSymbol, e.StdMax);
                                      changedCells.add('${e.Id}_StdMin');
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.StdMin),
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'StdSymbol',
                          e.StdSymbol,
                          isEditing
                              ? dataInputCell(
                                  value: e.StdSymbol,
                                  dropdownItems: ['-', '<', '>'],
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdSymbol = value;
                                      e.ControlRange = buildControlRange(e.StdMin, e.StdSymbol, e.StdMax);
                                      changedCells.add('${e.Id}_StdSymbol');
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.StdSymbol),
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'StdMax',
                          e.StdMax,
                          isEditing
                              ? dataInputCell(
                                  value: e.StdMax,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMax = value;
                                      e.ControlRange = buildControlRange(e.StdMin, e.StdSymbol, e.StdMax);
                                      changedCells.add('${e.Id}_StdMax');
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.StdMax),
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'ControlRange',
                          e.ControlRange,
                          dataText(e.ControlRange), // ไม่ต้องแก้ตรงนี้ ให้โชว์ค่าที่ถูก build แล้ว
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'SubLeader',
                          e.SubLeader,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'GL',
                          e.GL,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'JP',
                          e.JP,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'DGM',
                          e.DGM,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'PatternReport',
                          e.PatternReport,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ReportOrder',
                          e.ReportOrder,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'TYPE',
                          e.TYPE,
                          isEditing
                              ? dataInputCell(
                                  value: e.TYPE,
                                  dropdownItems: ['-', 'A', 'B'],
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
                        _buildEditableCell(
                          e.Id,
                          'GROUP',
                          e.GROUP,
                          isEditing
                              ? dataInputCell(
                                  value: e.GROUP,
                                  dropdownItems: ['-', 'KAC', 'MEDIUM'],
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
                        _buildEditableCell(
                          e.Id,
                          'MKTGROUP',
                          e.MKTGROUP,
                          isEditing
                              ? dataInputCell(
                                  value: e.MKTGROUP,
                                  dropdownItems: ['-', '1', '2', '5', '6'],
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
                        _buildEditableCell(
                          e.Id,
                          'FRE',
                          e.FRE,
                          isEditing
                              ? dataInputCell(
                                  value: e.FRE,
                                  dropdownItems: ['-', '1<', '1', '2', '3', '4'],
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
                        _buildEditableCell(
                          e.Id,
                          'REPORTITEMS',
                          e.REPORTITEMS,
                          isEditing
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
                      _buildMasterTSActionsCell(e, data),
                      // DataCell(
                      //   Row(
                      //     children: [
                      //       IconButton(
                      //         icon: Icon(
                      //           isEditing ? Icons.check : Icons.edit,
                      //           color: Colors.blueAccent,
                      //         ),
                      //         onPressed: () {
                      //           setState(() {
                      //             if (isEditing) {
                      //               editingRows.remove(e.Id);
                      //             } else {
                      //               editingRows.add(e.Id);
                      //             }
                      //           });
                      //         },
                      //       ),
                      //       if (!e.isNewRow) ...[
                      //         IconButton(
                      //           icon: deletingRows.contains(e.Id)
                      //               ? Icon(Icons.undo, color: Colors.black)
                      //               : Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
                      //           onPressed: () {
                      //             setState(() {
                      //               if (deletingRows.contains(e.Id)) {
                      //                 deletingRows.remove(e.Id);
                      //               } else {
                      //                 ConfirmationDialog.show(
                      //                   context,
                      //                   icon: Icons.delete_forever_rounded,
                      //                   iconColor: Colors.red,
                      //                   title: 'Delete data',
                      //                   content:
                      //                       'When deleting data, please edit the new ReportOrder.\nAre you sure you want to delete?',
                      //                   confirmText: 'Confirm',
                      //                   confirmButtonColor: Colors.red,
                      //                   cancelText: 'Cancel',
                      //                   cancelButtonColor: Colors.red,
                      //                   onConfirm: () async {
                      //                     setState(() {
                      //                       deletingRows.add(e.Id);
                      //                       // data.MasterTS.remove(e);
                      //                     });
                      //                   },
                      //                 );
                      //               }
                      //             });
                      //           },
                      //         ),
                      //       ],
                      //     ],
                      //   ),
                      // ),
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
                      if (e.isNewRow) {
                        return Colors.greenAccent.withOpacity(0.3); // Green for new rows
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
                                icon: Icon(Icons.add_to_photos_rounded, color: Colors.grey),
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
                        _buildEditableCell(
                          e.Id,
                          'Branch',
                          e.Branch,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Code',
                          e.Code,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Incharge',
                          e.Incharge,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'FrequencyRequest',
                          e.FrequencyRequest,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'SampleNo',
                          e.SampleNo,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'SampleGroup',
                          e.SampleGroup,
                          isEditing
                              ? dataInputCell(
                                  value: e.SampleGroup,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleGroup,
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
                        _buildEditableCell(
                          e.Id,
                          'SampleType',
                          e.SampleType,
                          isEditing
                              ? dataInputCell(
                                  value: e.SampleType,
                                  dropdownItems: P02MASTERDETAILVAR.dropdownSampleType,
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
                        _buildEditableCell(
                          e.Id,
                          'SampleTank',
                          e.SampleTank,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'SampleName',
                          e.SampleName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'SampleAmount',
                          e.SampleAmount,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ProcessReportName',
                          e.ProcessReportName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Frequency',
                          e.Frequency,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ItemNo',
                          e.ItemNo,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ItemName',
                          e.ItemName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'ItemReportName',
                          e.ItemReportName,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Position',
                          e.Position,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Mag',
                          e.Mag,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Temp',
                          e.Temp,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'StdMinL',
                          e.StdMinL,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'StdMaxL',
                          e.StdMaxL,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'StdFactor',
                          e.StdFactor,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std1',
                          e.Std1,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std2',
                          e.Std2,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std3',
                          e.Std3,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std4',
                          e.Std4,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std5',
                          e.Std5,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std6',
                          e.Std6,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std7',
                          e.Std7,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std8',
                          e.Std8,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'Std9',
                          e.Std9,
                          isEditing
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
                        _buildEditableCell(
                          e.Id,
                          'StdMin',
                          e.StdMin,
                          isEditing
                              ? dataInputCell(
                                  value: e.StdMin,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMin = value;
                                      e.ControlRange = buildControlRange(e.StdMin, e.StdSymbol, e.StdMax);
                                      changedCells.add('${e.Id}_StdMin');
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.StdMin),
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'StdSymbol',
                          e.StdSymbol,
                          isEditing
                              ? dataInputCell(
                                  value: e.StdSymbol,
                                  dropdownItems: ['-', '<', '>'],
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdSymbol = value;
                                      e.ControlRange = buildControlRange(e.StdMin, e.StdSymbol, e.StdMax);
                                      changedCells.add('${e.Id}_StdSymbol');
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.StdSymbol),
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'StdMax',
                          e.StdMax,
                          isEditing
                              ? dataInputCell(
                                  value: e.StdMax,
                                  onChanged: (value) {
                                    setState(() {
                                      e.StdMax = value;
                                      e.ControlRange = buildControlRange(e.StdMin, e.StdSymbol, e.StdMax);
                                      changedCells.add('${e.Id}_StdMax');
                                      changedCells.add('${e.Id}_ControlRange');
                                    });
                                  },
                                )
                              : dataText(e.StdMax),
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'ControlRange',
                          e.ControlRange,
                          dataText(e.ControlRange), // ไม่ต้องแก้ตรงนี้ ให้โชว์ค่าที่ถูก build แล้ว
                        ),
                      ),

                      DataCell(
                        _buildEditableCell(
                          e.Id,
                          'ReportOrder',
                          e.ReportOrder,
                          isEditing
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
                      _buildMasterLabActionsCell(e, data)
                      // DataCell(
                      //   Row(
                      //     children: [
                      //       IconButton(
                      //         icon: Icon(
                      //           isEditing ? Icons.check : Icons.edit,
                      //           color: Colors.blueAccent,
                      //         ),
                      //         onPressed: () {
                      //           setState(() {
                      //             if (isEditing) {
                      //               editingRows.remove(e.Id);
                      //             } else {
                      //               editingRows.add(e.Id);
                      //             }
                      //           });
                      //         },
                      //       ),
                      //       if (!e.isNewRow) ...[
                      //         IconButton(
                      //           icon: deletingRows.contains(e.Id)
                      //               ? Icon(Icons.undo, color: Colors.black)
                      //               : Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
                      //           onPressed: () {
                      //             setState(() {
                      //               if (deletingRows.contains(e.Id)) {
                      //                 deletingRows.remove(e.Id);
                      //               } else {
                      //                 ConfirmationDialog.show(
                      //                   context,
                      //                   icon: Icons.delete_forever_rounded,
                      //                   iconColor: Colors.red,
                      //                   title: 'Delete data',
                      //                   content:
                      //                       'When deleting data, please edit the new ReportOrder.\nAre you sure you want to delete?',
                      //                   confirmText: 'Confirm',
                      //                   confirmButtonColor: Colors.red,
                      //                   cancelText: 'Cancel',
                      //                   cancelButtonColor: Colors.red,
                      //                   onConfirm: () async {
                      //                     setState(() {
                      //                       deletingRows.add(e.Id);
                      //                       // data.MasterTS.remove(e);
                      //                     });
                      //                   },
                      //                 );
                      //               }
                      //             });
                      //           },
                      //         ),
                      //       ],
                      //     ],
                      //   ),
                      // ),
                    ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
