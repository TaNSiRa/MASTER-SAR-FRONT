// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable, non_constant_identifier_names, file_names, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/06-01-P06EDITCUSTOMERGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/ErrorPopup.dart';
import 'P06EDITCUSTOMERVAR.dart';

late BuildContext P06EDITCUSTOMERMAINcontext;

class P06EDITCUSTOMERMAIN extends StatefulWidget {
  P06EDITCUSTOMERMAIN({
    super.key,
    this.data,
  });
  List<P06EDITCUSTOMERGETDATAclass>? data;

  @override
  State<P06EDITCUSTOMERMAIN> createState() => _P06EDITCUSTOMERMAINState();
}

class _P06EDITCUSTOMERMAINState extends State<P06EDITCUSTOMERMAIN> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? _selectedCustomerId;
  bool _isEditing = false;
  List<P06EDITCUSTOMERGETDATAclass> _filteredData = [];

  @override
  void initState() {
    super.initState();
    context.read<P06EDITCUSTOMERGETDATA_Bloc>().add(P06EDITCUSTOMERGETDATA_GET());
    _searchController.addListener(_filterCustomers);
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterCustomers() {
    setState(() {
      List<P06EDITCUSTOMERGETDATAclass> _datain = widget.data ?? [];
      if (_searchController.text.isEmpty) {
        _filteredData = _datain;
      } else {
        _filteredData = _datain.where((customer) {
          final customerName = customer.CUSTOMER.toLowerCase();
          final customerId = customer.ID.toString();
          final searchTerm = _searchController.text.toLowerCase();

          return customerName.contains(searchTerm) || customerId.contains(searchTerm);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterCustomers();
  }

  void _onEditCustomer(P06EDITCUSTOMERGETDATAclass customer) {
    setState(() {
      _selectedCustomerId = customer.ID;
      _customerNameController.text = customer.CUSTOMER;
      _isEditing = true;
    });
  }

  Future<void> _editCustomer() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await Dio().post(
          "$ToServer/02SALTSPRAY/EditCustomer",
          data: {
            'dataRow': P06EDITCUSTOMERVAR.SendAddDataToAPI,
          },
          options: Options(
            validateStatus: (status) {
              return true;
            },
          ),
        );

        if (response.statusCode == 200) {
          context.read<P06EDITCUSTOMERGETDATA_Bloc>().add(P06EDITCUSTOMERGETDATA_GET());
        } else {
          showErrorPopup(P06EDITCUSTOMERMAINcontext, response.toString());
        }
      } catch (e) {
        print("Error: $e");
        showErrorPopup(P06EDITCUSTOMERMAINcontext, e.toString());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('บันทึกข้อมูลลูกค้า ${_customerNameController.text} สำเร็จ'),
          backgroundColor: Colors.green,
        ),
      );

      _clearForm();
    }
  }

  Future<void> _addCustomer() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await Dio().post(
          "$ToServer/02SALTSPRAY/AddCustomer",
          data: {
            'dataRow': P06EDITCUSTOMERVAR.SendAddDataToAPI,
          },
          options: Options(
            validateStatus: (status) {
              return true;
            },
          ),
        );

        if (response.statusCode == 200) {
          context.read<P06EDITCUSTOMERGETDATA_Bloc>().add(P06EDITCUSTOMERGETDATA_GET());
        } else {
          showErrorPopup(P06EDITCUSTOMERMAINcontext, response.toString());
        }
      } catch (e) {
        print("Error: $e");
        showErrorPopup(P06EDITCUSTOMERMAINcontext, e.toString());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('บันทึกข้อมูลลูกค้า ${_customerNameController.text} สำเร็จ'),
          backgroundColor: Colors.green,
        ),
      );

      _clearForm();
    }
  }

  void _clearForm() {
    setState(() {
      _customerNameController.clear();
      _selectedCustomerId = null;
      _isEditing = false;
    });
  }

  void _deleteCustomer(int customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),
          content: const Text('คุณต้องการลบข้อมูลลูกค้านี้หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final response = await Dio().post(
                    "$ToServer/02SALTSPRAY/DeleteCustomer",
                    data: {
                      'dataRow': P06EDITCUSTOMERVAR.SendAddDataToAPI,
                    },
                    options: Options(
                      validateStatus: (status) {
                        return true;
                      },
                    ),
                  );

                  if (response.statusCode == 200) {
                    P06EDITCUSTOMERMAINcontext.read<P06EDITCUSTOMERGETDATA_Bloc>()
                        .add(P06EDITCUSTOMERGETDATA_GET());
                    Navigator.pop(P06EDITCUSTOMERMAINcontext);
                  } else {
                    showErrorPopup(P06EDITCUSTOMERMAINcontext, response.toString());
                  }
                } catch (e) {
                  print("Error: $e");
                  showErrorPopup(P06EDITCUSTOMERMAINcontext, e.toString());
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('ลบข้อมูลลูกค้า ID: $customerId สำเร็จ'),
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
    P06EDITCUSTOMERMAINcontext = context;
    List<P06EDITCUSTOMERGETDATAclass> _datain = widget.data ?? [];

    // Initialize filtered data if empty
    if (_filteredData.isEmpty && _datain.isNotEmpty && _searchController.text.isEmpty) {
      _filteredData = _datain;
    } else if (_datain.isNotEmpty) {
      _filterCustomers();
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Section
            Row(
              children: [
                // Search Section
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
                            'ค้นหาลูกค้า',
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
                                    hintText: 'ค้นหาด้วยชื่อลูกค้าหรือ ID',
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
                                    setState(() {}); // Refresh UI to show/hide clear button
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
                              _isEditing ? 'แก้ไขข้อมูลลูกค้า' : 'เพิ่มลูกค้าใหม่',
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
                            //           'กำลังแก้ไขลูกค้า ID: $_selectedCustomerId',
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
                              controller: _customerNameController,
                              decoration: InputDecoration(
                                labelText: 'ชื่อลูกค้า',
                                hintText: 'กรอกชื่อลูกค้า',
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
                                  return 'กรุณากรอกชื่อลูกค้า';
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
                                      P06EDITCUSTOMERVAR.CUSTOMER = _customerNameController.text;
                                      P06EDITCUSTOMERVAR.SendAddDataToAPI = jsonEncode(toJsonAddDate());
                                      if (_isEditing) {
                                        P06EDITCUSTOMERVAR.ID = _selectedCustomerId!;
                                        _editCustomer();
                                      } else {
                                        print('Add Customer');
                                        _addCustomer();
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
              ],
            ),

            const SizedBox(height: 24),

            // Customer List Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _searchController.text.isEmpty
                      ? 'รายการลูกค้าทั้งหมด (${_datain.length} รายการ)'
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
                            _searchController.text.isNotEmpty ? 'ไม่พบข้อมูลที่ค้นหา' : 'ไม่มีข้อมูลลูกค้า',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'ลองค้นหาด้วยคำค้นอื่น หรือ ล้างการค้นหา'
                                : 'กรุณาเพิ่มข้อมูลลูกค้าใหม่',
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
                        final customer = _filteredData[index];
                        final isSelected = customer.ID == _selectedCustomerId;

                        // Highlight search terms
                        String highlightedName = customer.CUSTOMER;
                        String highlightedId = customer.ID.toString();

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
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue[600],
                                    size: 20,
                                  ),
                                  onPressed: () => _onEditCustomer(customer),
                                  tooltip: 'แก้ไข',
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[600],
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    P06EDITCUSTOMERVAR.ID = customer.ID;
                                    P06EDITCUSTOMERVAR.SendAddDataToAPI = jsonEncode(toJsonAddDate());
                                    _deleteCustomer(customer.ID);
                                  },
                                  tooltip: 'ลบ',
                                ),
                              ],
                            ),
                            onTap: () => _onEditCustomer(customer),
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

  // Helper function to highlight search terms
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
      // Add text before the match
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: TextStyle(color: defaultColor),
        ));
      }

      // Add highlighted match
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

    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: TextStyle(color: defaultColor),
      ));
    }

    return spans.isEmpty ? [TextSpan(text: text, style: TextStyle(color: defaultColor))] : spans;
  }
}
