// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable, non_constant_identifier_names, file_names, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/10-01-P10EDITREQUESTERGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/ErrorPopup.dart';
import 'P10EDITREQUESTERVAR.dart';

late BuildContext P10EDITREQUESTERMAINcontext;

class P10EDITREQUESTERMAIN extends StatefulWidget {
  P10EDITREQUESTERMAIN({
    super.key,
    this.data,
  });
  List<P10EDITREQUESTERGETDATAclass>? data;

  @override
  State<P10EDITREQUESTERMAIN> createState() => _P10EDITREQUESTERMAINState();
}

class _P10EDITREQUESTERMAINState extends State<P10EDITREQUESTERMAIN> {
  final TextEditingController _requesterNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? _selectedRequesterId;
  bool _isEditing = false;
  List<P10EDITREQUESTERGETDATAclass> _filteredData = [];

  @override
  void initState() {
    super.initState();
    context.read<P10EDITREQUESTERGETDATA_Bloc>().add(P10EDITREQUESTERGETDATA_GET());
    _searchController.addListener(_filterRequesters);
    PageName = 'EDIT REQUESTER';
  }

  @override
  void dispose() {
    _requesterNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterRequesters() {
    setState(() {
      List<P10EDITREQUESTERGETDATAclass> _datain = widget.data ?? [];
      if (_searchController.text.isEmpty) {
        _filteredData = _datain;
      } else {
        _filteredData = _datain.where((requester) {
          final requesterName = requester.REQUESTER.toLowerCase();
          final requesterId = requester.ID.toString();
          final searchTerm = _searchController.text.toLowerCase();

          return requesterName.contains(searchTerm) || requesterId.contains(searchTerm);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterRequesters();
  }

  void _onEditRequester(P10EDITREQUESTERGETDATAclass requester) {
    setState(() {
      _selectedRequesterId = requester.ID;
      _requesterNameController.text = requester.REQUESTER;
      _isEditing = true;
    });
  }

  Future<void> _editRequester() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await Dio().post(
          "$ToServer/02SALTSPRAY/EditRequester",
          data: {
            'dataRow': P10EDITREQUESTERVAR.SendAddDataToAPI,
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
          context.read<P10EDITREQUESTERGETDATA_Bloc>().add(P10EDITREQUESTERGETDATA_GET());
        } else {
          showErrorPopup(P10EDITREQUESTERMAINcontext, response.toString());
        }
      } on DioException catch (e) {
        Navigator.pop(P10EDITREQUESTERMAINcontext);
        if (e.type == DioExceptionType.sendTimeout) {
          showErrorPopup(P10EDITREQUESTERMAINcontext, "Send timeout");
        } else if (e.type == DioExceptionType.receiveTimeout) {
          showErrorPopup(P10EDITREQUESTERMAINcontext, "Receive timeout");
        } else {
          showErrorPopup(P10EDITREQUESTERMAINcontext, e.message ?? "Unknown Dio error");
        }
      } catch (e) {
        print("Error: $e");
        showErrorPopup(P10EDITREQUESTERMAINcontext, e.toString());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('บันทึกข้อมูล Requester ${_requesterNameController.text} สำเร็จ'),
          backgroundColor: Colors.green,
        ),
      );

      _clearForm();
    }
  }

  Future<void> _addRequester() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await Dio().post(
          "$ToServer/02SALTSPRAY/AddRequester",
          data: {
            'dataRow': P10EDITREQUESTERVAR.SendAddDataToAPI,
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
          context.read<P10EDITREQUESTERGETDATA_Bloc>().add(P10EDITREQUESTERGETDATA_GET());
        } else {
          showErrorPopup(P10EDITREQUESTERMAINcontext, response.toString());
        }
      } catch (e) {
        print("Error: $e");
        showErrorPopup(P10EDITREQUESTERMAINcontext, e.toString());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('บันทึกข้อมูล Requester ${_requesterNameController.text} สำเร็จ'),
          backgroundColor: Colors.green,
        ),
      );

      _clearForm();
    }
  }

  void _clearForm() {
    setState(() {
      _requesterNameController.clear();
      _selectedRequesterId = null;
      _isEditing = false;
    });
  }

  void _deleteRequester(int requesterId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),
          content: const Text('คุณต้องการลบข้อมูล Requester นี้หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final response = await Dio().post(
                    "$ToServer/02SALTSPRAY/DeleteRequester",
                    data: {
                      'dataRow': P10EDITREQUESTERVAR.SendAddDataToAPI,
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
                    P10EDITREQUESTERMAINcontext.read<P10EDITREQUESTERGETDATA_Bloc>()
                        .add(P10EDITREQUESTERGETDATA_GET());
                    Navigator.pop(P10EDITREQUESTERMAINcontext);
                  } else {
                    showErrorPopup(P10EDITREQUESTERMAINcontext, response.toString());
                  }
                } catch (e) {
                  print("Error: $e");
                  showErrorPopup(P10EDITREQUESTERMAINcontext, e.toString());
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('ลบข้อมูล Requester ID: $requesterId สำเร็จ'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('ลบ', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    P10EDITREQUESTERMAINcontext = context;
    List<P10EDITREQUESTERGETDATAclass> _datain = widget.data ?? [];

    if (_filteredData.isEmpty && _datain.isNotEmpty && _searchController.text.isEmpty) {
      _filteredData = _datain;
    } else if (_datain.isNotEmpty) {
      _filterRequesters();
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.grey[200],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ค้นหา Requester',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'ค้นหาด้วยชื่อ Requester หรือ ID',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
                                    ),
                                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                                    suffixIcon: _searchController.text.isNotEmpty
                                        ? IconButton(
                                            icon: Icon(Icons.clear, color: Colors.grey[600]),
                                            onPressed: _clearSearch,
                                          )
                                        : null,
                                  ),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          if (_searchController.text.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Colors.blue[600], size: 14),
                                  const SizedBox(width: 6),
                                  Text(
                                    'ผลการค้นหา: ${_filteredData.length} รายการ',
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                if (USERDATA.UserLV >= 5) ...[
                  Expanded(
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isEditing ? 'แก้ไขข้อมูล Requester' : 'เพิ่ม Requester ใหม่',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 16),
                              // if (_isEditing)
                              //   Container(
                              //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              //     decoration: BoxDecoration(
                              //       color: Colors.blue[50],
                              //       borderRadius: BorderRadius.circular(6),
                              //       border: Border.all(color: Colors.blue[200]!),
                              //     ),
                              //     child: Row(
                              //       children: [
                              //         Icon(Icons.info, color: Colors.blue[600], size: 16),
                              //         SizedBox(width: 8),
                              //         Text(
                              //           'กำลังแก้ไขลูกค้า ID: $_selectedRequesterId',
                              //           style: TextStyle(
                              //             color: Colors.blue[700],
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // if (_isEditing) SizedBox(height: 16),
                              TextFormField(
                                controller: _requesterNameController,
                                decoration: InputDecoration(
                                  labelText: 'ชื่อ Requester',
                                  hintText: 'กรอกชื่อ Requester',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
                                  ),
                                  prefixIcon: Icon(Icons.business, color: Colors.grey[600]),
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'กรุณากรอกชื่อ Requester';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        P10EDITREQUESTERVAR.REQUESTER = _requesterNameController.text;
                                        P10EDITREQUESTERVAR.SendAddDataToAPI = jsonEncode(toJsonAddDate());
                                        if (_isEditing) {
                                          P10EDITREQUESTERVAR.ID = _selectedRequesterId!;
                                          _editRequester();
                                        } else {
                                          // print('Add Customer');
                                          _addRequester();
                                        }
                                      },
                                      icon: Icon(_isEditing ? Icons.save : Icons.add),
                                      label: Text(_isEditing ? 'บันทึก' : 'เพิ่ม'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[600],
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_isEditing) ...[
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: _clearForm,
                                        icon: const Icon(Icons.clear),
                                        label: const Text('ยกเลิก'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[600],
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _searchController.text.isEmpty
                      ? 'รายการ Requester ทั้งหมด (${_datain.length} รายการ)'
                      : 'ผลการค้นหา (${_filteredData.length} จาก ${_datain.length} รายการ)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  TextButton.icon(
                    onPressed: _clearSearch,
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text('ล้างการค้นหา'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _filteredData.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _searchController.text.isNotEmpty ? Icons.search_off : Icons.people_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'ไม่พบข้อมูลที่ค้นหา'
                                : 'ไม่มีข้อมูล Requester',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'ลองค้นหาด้วยคำค้นอื่น หรือ ล้างการค้นหา'
                                : 'กรุณาเพิ่มข้อมูล Requester ใหม่',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                          if (_searchController.text.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _clearSearch,
                              icon: const Icon(Icons.clear_all),
                              label: const Text('ล้างการค้นหา'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[600],
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredData.length,
                      itemBuilder: (context, index) {
                        final requester = _filteredData[index];
                        final isSelected = requester.ID == _selectedRequesterId;

                        String highlightedName = requester.REQUESTER;
                        String highlightedId = requester.ID.toString();

                        return Card(
                          color: Colors.grey[200],
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: isSelected ? 3 : 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isSelected ? Colors.blue : Colors.transparent,
                              width: isSelected ? 2 : 0,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue[100] : Colors.grey[100],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.blue[700] : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                            title: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: isSelected ? Colors.blue[800] : Colors.grey[800],
                                ),
                                children: _buildHighlightedText(
                                  highlightedName,
                                  _searchController.text,
                                  isSelected ? Colors.blue[800]! : Colors.grey[800]!,
                                ),
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                                children: [
                                  const TextSpan(text: 'ID: '),
                                  ..._buildHighlightedText(
                                    highlightedId,
                                    _searchController.text,
                                    Colors.grey[600]!,
                                  ),
                                ],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (USERDATA.UserLV >= 5) ...[
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue[600],
                                      size: 20,
                                    ),
                                    onPressed: () => _onEditRequester(requester),
                                    tooltip: 'แก้ไข',
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red[600],
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      P10EDITREQUESTERVAR.ID = requester.ID;
                                      P10EDITREQUESTERVAR.SendAddDataToAPI = jsonEncode(toJsonAddDate());
                                      _deleteRequester(requester.ID);
                                    },
                                    tooltip: 'ลบ',
                                  ),
                                ]
                              ],
                            ),
                            onTap: () => _onEditRequester(requester),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(String text, String searchTerm, Color defaultColor) {
    if (searchTerm.isEmpty) {
      return [TextSpan(text: text, style: TextStyle(color: defaultColor))];
    }

    List<TextSpan> spans = [];
    String lowerText = text.toLowerCase();
    String lowerSearchTerm = searchTerm.toLowerCase();

    int start = 0;
    int index = lowerText.indexOf(lowerSearchTerm);

    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: TextStyle(color: defaultColor),
        ));
      }

      spans.add(TextSpan(
        text: text.substring(index, index + searchTerm.length),
        style: TextStyle(
          color: defaultColor,
          backgroundColor: Colors.yellow[300],
          fontWeight: FontWeight.bold,
        ),
      ));

      start = index + searchTerm.length;
      index = lowerText.indexOf(lowerSearchTerm, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: TextStyle(color: defaultColor),
      ));
    }

    return spans.isEmpty ? [TextSpan(text: text, style: TextStyle(color: defaultColor))] : spans;
  }
}
