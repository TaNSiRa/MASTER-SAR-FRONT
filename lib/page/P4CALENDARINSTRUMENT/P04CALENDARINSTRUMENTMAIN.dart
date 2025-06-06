// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, avoid_print
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../bloc/BlocEvent/04-01-P04CALENDARINSTRUMENTGETDATA.dart';
import '../../data/global.dart';
import '../../widget/function/ForUseAllPage.dart';
import 'P04CALENDARINSTRUMENTVAR.dart';

late BuildContext P04CALENDARINSTRUMENTMAINcontext;
List<Map<String, String>> SSTAllData = [];

class P04CALENDARINSTRUMENTMAIN extends StatefulWidget {
  P04CALENDARINSTRUMENTMAIN({
    super.key,
    this.data,
  });
  List<P04CALENDARINSTRUMENTGETDATAclass>? data;

  @override
  State<P04CALENDARINSTRUMENTMAIN> createState() => _P04CALENDARINSTRUMENTMAINState();
}

class _P04CALENDARINSTRUMENTMAINState extends State<P04CALENDARINSTRUMENTMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P04CALENDARINSTRUMENTGETDATA_Bloc>().add(P04CALENDARINSTRUMENTGETDATA_GET());
  }

  // ฟังก์ชันคำนวณเปอร์เซ็นต์ capacity ของแต่ละ instrument ในวันที่กำหนด
  Map<String, double> calculateDayCapacity(
      DateTime targetDate, List<P04CALENDARINSTRUMENTGETDATAclass> data) {
    Map<String, double> capacityMap = {
      'SST No.1': 0.0,
      'SST No.2': 0.0,
      'SST No.3': 0.0,
      'SST No.4': 0.0,
    };

    const double totalCheckboxSlots = 122;

    for (var item in data) {
      if (item.CHECKBOX.isEmpty) continue;

      DateTime? startDate;
      DateTime? finishDate;

      try {
        // แปลง Start_Date
        startDate = convertStringToDateTime(item.STARTDATE);

        // หา Finish_Date ตัวสุดท้ายที่มีค่า
        List<String?> finishDateStrings = [
          item.FINISHDATE1,
          item.FINISHDATE2,
          item.FINISHDATE3,
          item.FINISHDATE4,
          item.FINISHDATE5,
          item.FINISHDATE6,
          item.FINISHDATE7,
          item.FINISHDATE8,
          item.FINISHDATE9,
          item.FINISHDATE10,
        ];

        for (var dateStr in finishDateStrings.reversed) {
          if (dateStr != null && dateStr.trim().isNotEmpty) {
            finishDate = convertStringToDateTime(dateStr);
            break;
          }
        }
      } catch (e) {
        print("Error parsing date: $e");
        continue;
      }

      if (startDate == null || finishDate == null) continue;

      // เช็คว่า targetDate อยู่ในช่วง startDate ถึง finishDate
      DateTime targetDateOnly = DateTime(targetDate.year, targetDate.month, targetDate.day);
      DateTime startDateOnly = DateTime(startDate.year, startDate.month, startDate.day);
      DateTime finishDateOnly = DateTime(finishDate.year, finishDate.month, finishDate.day);

      if (targetDateOnly.isAtSameMomentAs(startDateOnly) ||
          targetDateOnly.isAtSameMomentAs(finishDateOnly) ||
          (targetDateOnly.isAfter(startDateOnly) && targetDateOnly.isBefore(finishDateOnly))) {
        // คำนวณจำนวนนาทีที่ใช้จริงในวันนี้
        double actualUsedMinutes = 0;

        if (targetDateOnly.isAtSameMomentAs(startDateOnly)) {
          // วันเริ่มต้น: คำนวณจากเวลาเริ่มต้นจนถึงเที่ยงคืน
          DateTime endOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59);
          actualUsedMinutes = endOfDay.difference(startDate).inMinutes.toDouble() + 1; // +1 สำหรับนาทีสุดท้าย
        } else if (targetDateOnly.isAtSameMomentAs(finishDateOnly)) {
          // วันสิ้นสุด: คำนวณจากเที่ยงคืนจนถึงเวลาสิ้นสุด
          DateTime startOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day, 0, 0, 0);
          actualUsedMinutes = finishDate.difference(startOfDay).inMinutes.toDouble();
        } else {
          // วันกลาง: ใช้เต็มวัน 1440 นาที
          actualUsedMinutes = 1440;
        }

        // จำกัดไม่ให้เกิน 1440 นาทีต่อวัน
        if (actualUsedMinutes > 1440) actualUsedMinutes = 1440;
        if (actualUsedMinutes < 0) actualUsedMinutes = 0;

        // นับจำนวน checkbox slots ที่ใช้
        List<String> checkboxList = item.CHECKBOX.split(',');
        int checkboxSlotsUsed = 0;

        for (String checkboxStr in checkboxList) {
          if (checkboxStr.trim().isNotEmpty) {
            try {
              int.parse(checkboxStr.trim()); // เช็คว่าเป็นตัวเลขที่ valid
              checkboxSlotsUsed += 1; // นับจำนวน slots ที่ใช้
            } catch (e) {
              print("Error parsing checkbox: $e");
            }
          }
        }

        // คำนวณเปอร์เซ็นต์ capacity
        // เปอร์เซ็นต์ = (นาทีที่ใช้จริง × จำนวน slots ที่ใช้) / (1440 × 122) × 100
        double totalCapacityForDay = 1440 * totalCheckboxSlots;
        double usedCapacity = actualUsedMinutes * checkboxSlotsUsed;
        double percentage = (usedCapacity / totalCapacityForDay) * 100;

        // เพิ่มเปอร์เซ็นต์ให้กับ instrument ที่เกี่ยวข้อง
        if (capacityMap.containsKey(item.INSTRUMENT)) {
          capacityMap[item.INSTRUMENT] = capacityMap[item.INSTRUMENT]! + percentage;
        }
      }
    }

    // จำกัดเปอร์เซ็นต์ไม่ให้เกิน 100%
    capacityMap.forEach((key, value) {
      if (value > 100.0) {
        capacityMap[key] = 100.0;
      }
    });

    return capacityMap;
  }

  @override
  Widget build(BuildContext context) {
    P04CALENDARINSTRUMENTMAINcontext = context;
    List<P04CALENDARINSTRUMENTGETDATAclass> _datain = widget.data ?? [];

    // Filter data สำหรับเดือนปัจจุบัน
    List<P04CALENDARINSTRUMENTGETDATAclass> monthData = _datain.where((data) {
      DateTime? start;
      DateTime? finish;

      try {
        start = convertStringToDateTime(data.STARTDATE);

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
      } catch (e) {
        print("Error parsing date: $e");
        return false;
      }

      if (start == null || finish == null) return false;

      // เช็คว่าข้อมูลนี้เกี่ยวข้องกับเดือนปัจจุบันหรือไม่
      DateTime monthStart = DateTime(
          P04CALENDARINSTRUMENTVAR.dateTimeSelect.year, P04CALENDARINSTRUMENTVAR.dateTimeSelect.month, 1);
      DateTime monthEnd = DateTime(
          P04CALENDARINSTRUMENTVAR.dateTimeSelect.year, P04CALENDARINSTRUMENTVAR.dateTimeSelect.month + 1, 0);

      return !(finish.isBefore(monthStart) || start.isAfter(monthEnd));
    }).toList();

    selectpage = '';
    selectstatus = '';
    selectslot.text = '';
    SSTAllData.clear();

    final firstDayOfMonth = DateTime(
        P04CALENDARINSTRUMENTVAR.dateTimeSelect.year, P04CALENDARINSTRUMENTVAR.dateTimeSelect.month, 1);
    final daysInMonth = DateTime(P04CALENDARINSTRUMENTVAR.dateTimeSelect.year,
            P04CALENDARINSTRUMENTVAR.dateTimeSelect.month + 1, 0)
        .day;
    final firstWeekday = firstDayOfMonth.weekday % 7;

    List<DateTime?> calendarDays = List<DateTime?>.filled(42, null);
    for (int i = 0; i < daysInMonth; i++) {
      calendarDays[firstWeekday + i] = DateTime(
          P04CALENDARINSTRUMENTVAR.dateTimeSelect.year, P04CALENDARINSTRUMENTVAR.dateTimeSelect.month, i + 1);
    }

    String formattedMonthYear = DateFormat('MMM yyyy').format(P04CALENDARINSTRUMENTVAR.dateTimeSelect);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFF),
              Color(0xFFEEF4FF),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              // Header with navigation and month/year selector
              Container(
                // margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    // Previous month button
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              P04CALENDARINSTRUMENTVAR.dateTimeSelect = DateTime(
                                P04CALENDARINSTRUMENTVAR.dateTimeSelect.year,
                                P04CALENDARINSTRUMENTVAR.dateTimeSelect.month - 1,
                              );
                              context
                                  .read<P04CALENDARINSTRUMENTGETDATA_Bloc>()
                                  .add(P04CALENDARINSTRUMENTGETDATA_GET());
                            });
                          },
                          child: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),

                    // Month/Year selector
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: const Color(0xFF667EEA).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              _selectMonthYear(context);
                            },
                            child: Center(
                              child: Text(
                                formattedMonthYear,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2D3748),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Next month button
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              P04CALENDARINSTRUMENTVAR.dateTimeSelect = DateTime(
                                P04CALENDARINSTRUMENTVAR.dateTimeSelect.year,
                                P04CALENDARINSTRUMENTVAR.dateTimeSelect.month + 1,
                              );
                              context
                                  .read<P04CALENDARINSTRUMENTGETDATA_Bloc>()
                                  .add(P04CALENDARINSTRUMENTGETDATA_GET());
                            });
                          },
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Weekdays header
              Container(
                // margin: const EdgeInsets.only(bottom: 16),
                // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: P04CALENDARINSTRUMENTVAR.weekDays.map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Calendar grid
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        spreadRadius: 0,
                        blurRadius: 25,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GridView.count(
                    crossAxisCount: 7,
                    childAspectRatio: 1.75,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    children: calendarDays.asMap().entries.map((entry) {
                      final date = entry.value;
                      final isToday = date != null &&
                          date.year == DateTime.now().year &&
                          date.month == DateTime.now().month &&
                          date.day == DateTime.now().day;

                      // คำนวณเปอร์เซ็นต์สำหรับวันนี้
                      Map<String, double> dayCapacity = date != null
                          ? calculateDayCapacity(date, monthData)
                          : {'SST No.1': 0.0, 'SST No.2': 0.0, 'SST No.3': 0.0, 'SST No.4': 0.0};

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isToday ? const Color(0xFF667EEA) : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isToday ? const Color(0xFF667EEA) : Colors.grey.shade200,
                            width: isToday ? 2 : 1,
                          ),
                          boxShadow: isToday
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF667EEA).withOpacity(0.3),
                                    spreadRadius: 0,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Stack(
                          children: [
                            // Date number
                            if (date != null)
                              Positioned(
                                top: 6,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isToday ? Colors.white.withOpacity(0.2) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: isToday ? Colors.white : const Color(0xFF2D3748),
                                    ),
                                  ),
                                ),
                              ),

                            // Capacity indicators
                            if (date != null)
                              Positioned.fill(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildPercentCircle(dayCapacity['SST No.1']!),
                                        buildPercentCircle(dayCapacity['SST No.2']!),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildPercentCircle(dayCapacity['SST No.3']!),
                                        buildPercentCircle(dayCapacity['SST No.4']!),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
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
    );
  }

  Widget buildPercentCircle(double percentage) {
    return CircularPercentIndicator(
      animation: true,
      animationDuration: 1200,
      radius: 28.0,
      lineWidth: 8.0,
      percent: percentage / 100,
      center: Text(
        "${percentage.toStringAsFixed(1)}%",
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: [
            Shadow(
              blurRadius: 4.0,
              color: Colors.black26,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange[100]!,
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: const LinearGradient(
        colors: [
          Color(0xFF2196F3),
          Color(0xFF21CBF3),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Future<void> _selectMonthYear(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: P04CALENDARINSTRUMENTVAR.dateTimeSelect,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'เลือกเดือนและปี',
    );

    if (picked != null) {
      setState(() {
        P04CALENDARINSTRUMENTVAR.dateTimeSelect = picked;
        context.read<P04CALENDARINSTRUMENTGETDATA_Bloc>().add(P04CALENDARINSTRUMENTGETDATA_GET());
      });
    }
  }
}
