// ignore_for_file: non_constant_identifier_names, avoid_print, unrelated_type_equality_checks, use_build_context_synchronously, file_names, library_prefixes

// import 'dart:io' as IO;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../data/global.dart';
import '../../page/page2.dart';

// late IO.Socket socket;

void updateMultipleDates(Map<TextEditingController, void Function(String)> updates) {
  updates.forEach((controller, setValue) {
    DateTime? date = convertStringToDateTime(controller.text);
    if (date != null) {
      setValue(date.toString());
    } else {
      print("Invalid date: ${controller.text}");
    }
  });
}

Widget buildCustomFieldforEditData({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String labelText,
  required IconData icon,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  List<String>? dropdownItems,
}) {
  if ((labelText == "Status") && dropdownItems != null) {
    return DropdownSearch<String>(
      items: dropdownItems,
      enabled: false,
      selectedItem: controller.text.isNotEmpty ? controller.text : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          labelText: labelText,
          labelStyle: buildTextStyleGrey(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.grey[300],
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
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
      onChanged: (value) {
        if (value != null) {
          controller.text = value;
          if (onChanged != null) onChanged(value);
        }
      },
    );
  }

  return TextField(
    controller: controller,
    focusNode: focusNode,
    readOnly: true,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.grey),
      labelText: labelText,
      labelStyle: buildTextStyleGrey(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      filled: true,
      fillColor: Colors.grey[300],
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    style: const TextStyle(color: Colors.black54),
    onChanged: onChanged,
    onSubmitted: onSubmitted,
  );
}

Widget buildCustomField({
  required BuildContext context,
  required TextEditingController controller,
  required FocusNode focusNode,
  required String labelText,
  required IconData icon,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  VoidCallback? ontap,
  List<String>? dropdownItems,
}) {
  // ถ้าเป็น Section Request ให้แสดง Dropdown
  if ((labelText == "Section Request" ||
          labelText == "Customer Name" ||
          labelText == "Instrument" ||
          labelText == "Method" ||
          labelText == "Incharge" ||
          labelText == "Approved By") &&
      dropdownItems != null) {
    return DropdownSearch<String>(
      items: dropdownItems,
      selectedItem: controller.text.isNotEmpty ? controller.text : null,
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
      onChanged: (value) {
        if (value != null) {
          controller.text = value;
          if (onChanged != null) onChanged(value);
        }
      },
    );
  }

  if (labelText == "Received Date" || labelText == "Approved Date") {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            String formattedDate =
                "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year.toString().substring(2)}";
            controller.text = formattedDate;
            onChanged?.call(formattedDate);
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blue),
              labelText: labelText,
              labelStyle: buildTextStyle(),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }

  if (labelText == "Start Date") {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
            );

            if (pickedTime != null) {
              final DateTime fullDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );

              String formattedDateTime = "${fullDateTime.day.toString().padLeft(2, '0')}-"
                  "${fullDateTime.month.toString().padLeft(2, '0')}-"
                  "${fullDateTime.year.toString().substring(2)} "
                  "${fullDateTime.hour.toString().padLeft(2, '0')}:"
                  "${fullDateTime.minute.toString().padLeft(2, '0')}";

              controller.text = formattedDateTime;
              onChanged?.call(formattedDateTime);
            }
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blue),
              labelText: labelText,
              labelStyle: buildTextStyle(),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }

  if (labelText == "Finish Date 1" ||
      labelText == "Finish Date 2" ||
      labelText == "Finish Date 3" ||
      labelText == "Finish Date 4" ||
      labelText == "Finish Date 5" ||
      labelText == "Finish Date 6" ||
      labelText == "Finish Date 7" ||
      labelText == "Finish Date 8" ||
      labelText == "Finish Date 9" ||
      labelText == "Finish Date 10" ||
      labelText == "Temp Date 1" ||
      labelText == "Temp Date 2" ||
      labelText == "Temp Date 3" ||
      labelText == "Temp Date 4" ||
      labelText == "Temp Date 5" ||
      labelText == "Temp Date 6" ||
      labelText == "Temp Date 7" ||
      labelText == "Temp Date 8" ||
      labelText == "Temp Date 9" ||
      labelText == "Temp Date 10" ||
      labelText == "Due Date 1" ||
      labelText == "Due Date 2" ||
      labelText == "Due Date 3" ||
      labelText == "Due Date 4" ||
      labelText == "Due Date 5" ||
      labelText == "Due Date 6" ||
      labelText == "Due Date 7" ||
      labelText == "Due Date 8" ||
      labelText == "Due Date 9" ||
      labelText == "Due Date 10" ||
      labelText == 'Report No.') {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: labelText,
        labelStyle: buildTextStyleGrey(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.grey[300],
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: const TextStyle(color: Colors.black54),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
  if (labelText == "Time 1 (Hrs.)" ||
      labelText == "Time 2 (Hrs.)" ||
      labelText == "Time 3 (Hrs.)" ||
      labelText == "Time 4 (Hrs.)" ||
      labelText == "Time 5 (Hrs.)" ||
      labelText == "Time 6 (Hrs.)" ||
      labelText == "Time 7 (Hrs.)" ||
      labelText == "Time 8 (Hrs.)" ||
      labelText == "Time 9 (Hrs.)" ||
      labelText == "Time 10 (Hrs.)" ||
      labelText == "Amount of Sample (Pcs)" ||
      labelText == "Take photo (Pcs)") {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number, // แสดงคีย์บอร์ดตัวเลข
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // รับเฉพาะตัวเลขเท่านั้น
      ],
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: labelText,
        labelStyle: buildTextStyle(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
  if (labelText == "Select Slot") {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: ontap,
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blue),
              labelText: labelText,
              labelStyle: buildTextStyle(),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }

  return TextField(
    controller: controller,
    focusNode: focusNode,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blue),
      labelText: labelText,
      labelStyle: buildTextStyle(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    onChanged: onChanged,
    onSubmitted: onSubmitted,
  );
}

void EditTextController({
  required TextEditingController controller,
  required String value,
}) {
  final oldValue = controller.value;
  controller.value = TextEditingValue(
    text: value,
    selection: oldValue.selection,
  );
}

void calculateFinishDate({
  required TextEditingController startDateController,
  required TextEditingController timeController,
  required TextEditingController finishDateController,
}) {
  try {
    // print(timeController);
    // print(timeController.text);
    if (timeController.text == '') {
      finishDateController.text = "";
      return;
    }
    DateTime startDate = convertStringToDateTime(startDateController.text)!;
    int addedHours = int.parse(timeController.text);

    DateTime finishDate = startDate.add(Duration(hours: addedHours));
    finishDateController.text = formatDate(finishDate.toString());
    if (finishDateController.text == startDateController.text || addedHours == 0 || addedHours == '') {
      finishDateController.text = "";
    }
  } catch (e) {
    debugPrint("Error in calculateFinishDate: $e");
    finishDateController.text = "";
  }
}

String formatDate(String? date) {
  if (date == null || date.isEmpty) return '';
  try {
    DateTime parsedDate = DateTime.parse(date);
    if (parsedDate.hour == 0 && parsedDate.minute == 0 && parsedDate.second == 0) {
      return DateFormat('dd-MM-yy').format(parsedDate);
    } else {
      return DateFormat('dd-MM-yy HH:mm').format(parsedDate);
    }
  } catch (e) {
    return '';
  }
}

DateTime? convertStringToDateTime(String input) {
  try {
    if (input == '') {
      return null;
    }
    final formatter = input.contains(' ') ? DateFormat("dd-MM-yy HH:mm") : DateFormat("dd-MM-yy");
    return formatter.parseStrict(input);
  } catch (e) {
    print("Error parsing date: $e");
    return null;
  }
}

Future<String> calculateRepDue({
  required DateTime? startDate,
  required int addDays,
}) async {
  if (startDate == null) return '';
  // เริ่มต้นวันที่ใหม่โดยเซ็ตเวลาเป็น 00:00:00
  DateTime currentDate = DateTime(startDate.year, startDate.month, startDate.day);
  int addedDays = 0;
  // print('currentDate $currentDate');
  // แปลง holidays ให้เป็น Set ของ yyyy-MM-dd
  final Set<String> holidaySet =
      holidays.map((h) => DateFormat('yyyy-MM-dd').format(DateTime.parse(h))).toSet();
  // print('holidaySet $holidaySet');
  while (addedDays < addDays) {
    final currentDateStr = DateFormat('yyyy-MM-dd').format(currentDate);
    // print('currentDateStr $currentDateStr');
    if (!holidaySet.contains(currentDateStr)) {
      addedDays++;
    }

    if (addedDays < addDays) {
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  // ข้ามวันหยุดถ้าวันที่ได้ตรงกับวันหยุด
  while (holidaySet.contains(DateFormat('yyyy-MM-dd').format(currentDate))) {
    currentDate = currentDate.add(const Duration(days: 1));
  }

  return DateFormat('dd-MM-yy').format(currentDate);
}

Future<void> calculateAndSetTempDate({
  required TextEditingController finishDateController,
  required TextEditingController DateController,
  required int addDays,
}) async {
  if (finishDateController.text == '') {
    DateController.text = "";
    return;
  }
  DateTime? finishDate = convertStringToDateTime(finishDateController.text);

  if (finishDate != null) {
    String result = await calculateRepDue(
      startDate: DateTime(finishDate.year, finishDate.month, finishDate.day),
      addDays: addDays,
    );

    DateController.text = result;
  }
}

TextStyle buildTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

TextStyle buildTextStyleGrey() {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

Future<void> showStartConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Row(
          children: [
            Icon(Icons.start_rounded, color: Colors.pink),
            SizedBox(width: 8),
            Text('ยืนยันการเริ่มงาน?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะเริ่มงานหรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

Future<void> showEditConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Row(
          children: [
            Icon(Icons.edit_note_rounded, color: Colors.amber),
            SizedBox(width: 8),
            Text('ยืนยันการแก้ไข?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะแก้ไขข้อมูลหรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

Future<void> showCancelConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Row(
          children: [
            Icon(Icons.cancel, color: Colors.red),
            SizedBox(width: 8),
            Text('ยืนยันการยกเลิกงาน?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะยกเลิกงานนี้หรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

Future<void> showFinishConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Row(
          children: [
            Icon(Icons.done_outline_rounded, color: Colors.green),
            SizedBox(width: 8),
            Text('ยืนยันการเสร็จสิ้นงาน?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะเสร็จสิ้นงานหรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

void showChooseSlot(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 800,
          width: 1700,
          color: Colors.white,
          child: const Page2(),
        ),
      );
    },
  );
}

Future<void> showAddConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: const [
            Icon(Icons.note_add_rounded, color: Colors.green),
            SizedBox(width: 8),
            Text('ยืนยันการเพิ่มงาน?'),
          ],
        ),
        content: const Text(
          'คุณต้องการที่จะเพิ่มงานนี้หรือไม่?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ยกเลิก', style: TextStyle(color: Colors.green)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog ก่อน
              onConfirm(); // เรียก function ที่ส่งมา
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

String savenull(input) {
  String output = '';
  if (input != null) {
    output = input.toString();
  }
  return output;
}

int savenullint(input) {
  int output = 0;
  if (input != null) {
    output = input;
  }
  return output;
}
