// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:newmaster/bloc/BlocEvent/01-01-P01GETALLCUSTOMER.dart';

import '../../../widget/function/ShowDialog.dart';
import '../P01ALLCUSTOMERVAR.dart';
import 'api.dart';

final _formKey = GlobalKey<FormState>();

void showAddDialog(BuildContext context) {
  P01ALLCUSTOMERGETDATAclass newData = P01ALLCUSTOMERGETDATAclass();

  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (BuildContext context) {
      bool isNotMKTDepartment = false;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        const Center(
                          child: Text(
                            'New Customer',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          buildCustomField(
                            labelText: "Customer Full Name",
                            icon: Icons.business,
                            hintText: 'THAIPARKERIZING.CO.,LTD',
                            value: newData.CustFull,
                            onChanged: (value) {
                              newData.CustFull = value;
                            },
                          ),
                          buildCustomField(
                            labelText: "Customer Short Name",
                            icon: Icons.badge,
                            hintText: 'TP#1',
                            value: newData.CustShort,
                            onChanged: (value) {
                              newData.CustShort = value;
                            },
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isNotMKTDepartment,
                                activeColor: Colors.blue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isNotMKTDepartment = value ?? false;
                                    if (isNotMKTDepartment) {
                                      newData.TYPE = "-";
                                      newData.GROUP = "-";
                                      newData.MKTGROUP = "-";
                                      newData.FRE = "-";
                                      newData.REPORTITEMS = "-";
                                    }
                                  });
                                },
                              ),
                              const Text(
                                "I'm not a MKT department.",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          if (!isNotMKTDepartment) ...[
                            buildCustomField(
                              labelText: "Type",
                              icon: Icons.category,
                              value: newData.TYPE,
                              dropdownItems: ["-", "A", "B"],
                              onChanged: (value) {
                                newData.TYPE = value;
                              },
                            ),
                            buildCustomField(
                              labelText: "Group",
                              icon: Icons.group_work,
                              value: newData.GROUP,
                              dropdownItems: ["-", "KAC", "MEDIUM"],
                              onChanged: (value) {
                                newData.GROUP = value;
                              },
                            ),
                            buildCustomField(
                              labelText: "MKT Group",
                              icon: Icons.campaign,
                              value: newData.MKTGROUP,
                              dropdownItems: ["-", "1", "2", "5", "6"],
                              onChanged: (value) {
                                newData.MKTGROUP = value;
                              },
                            ),
                            buildCustomField(
                              labelText: "Frequency",
                              icon: Icons.schedule,
                              value: newData.FRE,
                              dropdownItems: ["-", "<1", "1", "2", "3", "4"],
                              onChanged: (value) {
                                newData.FRE = value;
                              },
                            ),
                            buildCustomField(
                              labelText: "Report Items",
                              icon: Icons.description,
                              value: newData.REPORTITEMS,
                              onChanged: (value) {
                                newData.REPORTITEMS = value;
                              },
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ConfirmationDialog.show(
                                    context,
                                    icon: Icons.person_add_alt_rounded,
                                    iconColor: Colors.blue,
                                    title: 'Add new customer',
                                    content: 'Did you add new customer?',
                                    confirmText: 'Confirm',
                                    confirmButtonColor: Colors.blue,
                                    cancelText: 'Cancel',
                                    cancelButtonColor: Colors.blue,
                                    onConfirm: () async {
                                      P01ALLCUSTOMERVAR.SendEditDataToAPI = newData.toJson();
                                      await addNewCustomer(context);
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.green,
                                shadowColor: Colors.greenAccent,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.green, width: 2),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: [
                                  Text(
                                    'Add Customer',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.person_add_alt_rounded,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Widget buildCustomField({
  required String labelText,
  required String value,
  required IconData icon,
  String? hintText,
  List<String>? dropdownItems,
  void Function(String)? onChanged,
}) {
  if ((labelText == "Type" || labelText == "Group" || labelText == "MKT Group" || labelText == "Frequency") &&
      dropdownItems != null) {
    return DropdownSearch<String>(
      items: dropdownItems,
      selectedItem: dropdownItems.contains(value) ? value : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          labelText: labelText,
          labelStyle: buildTextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        menuProps: const MenuProps(
          backgroundColor: Colors.white,
        ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        fit: FlexFit.loose,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? '',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        );
      },
      onChanged: (v) {
        if (v != null) {
          value = v;
          if (onChanged != null) onChanged(v);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill $labelText';
        }
        return null;
      },
    );
  }

  return TextFormField(
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blue),
      labelText: labelText,
      hintText: hintText,
      hintStyle: buildHintStyle(),
      labelStyle: buildTextStyle(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    onChanged: onChanged,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill $labelText';
      }
      return null;
    },
  );
}

TextStyle buildTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

TextStyle buildHintStyle() {
  return TextStyle(
    color: Colors.grey.shade400,
    fontSize: 14,
  );
}

Future<String?> showSelectionDialog(BuildContext context, String title) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 16,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 700,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blue.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.purple.shade400],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.settings_applications,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue.shade600, Colors.purple.shade600],
                  ).createShader(bounds),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'Select type',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),

                // Options
                Row(
                  children: [
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop('MasterKPI');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.brown.shade200,
                                  Colors.brown.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.data_thresholding_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'MasterKPI',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // const SizedBox(height: 4),
                                // Text(
                                //   'TypeScript',
                                //   style: TextStyle(
                                //     color: Colors.white.withOpacity(0.8),
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // MasterTS Option
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop('MasterTS');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.blue.shade200,
                                  Colors.blue.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.terminal,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'MasterTS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // const SizedBox(height: 4),
                                // Text(
                                //   'TypeScript',
                                //   style: TextStyle(
                                //     color: Colors.white.withOpacity(0.8),
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Masterlabs Option
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop('MasterLab');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.green.shade200,
                                  Colors.teal.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.science,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Masterlabs',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // const SizedBox(height: 4),
                                // Text(
                                //   'Laboratory',
                                //   style: TextStyle(
                                //     color: Colors.white.withOpacity(0.8),
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Cancel Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
