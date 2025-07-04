// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_to_list_in_spreads, avoid_web_libraries_in_flutter, avoid_print, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/BlocEvent/05-01-P05CALENDARJOBGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/function/ForUseAllPage.dart';
import 'P05CALENDARJOBVAR.dart';

late BuildContext P05CALENDARJOBMAINcontext;
List<Map<String, String>> SSTAllData = [];

class P05CALENDARJOBMAIN extends StatefulWidget {
  P05CALENDARJOBMAIN({
    super.key,
    this.data,
  });
  List<P05CALENDARJOBGETDATAclass>? data;

  @override
  State<P05CALENDARJOBMAIN> createState() => _P05CALENDARJOBMAINState();
}

class _P05CALENDARJOBMAINState extends State<P05CALENDARJOBMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P05CALENDARJOBGETDATA_Bloc>().add(P05CALENDARJOBGETDATA_GET());
    PageName = 'CALENDAR JOB';
  }

  List<Map<String, dynamic>> getJobsForDate(DateTime targetDate, List<P05CALENDARJOBGETDATAclass> data) {
    List<Map<String, dynamic>> jobsForDate = [];

    for (var item in data) {
      DateTime? startDate;
      List<DateTime?> finishDates = [];

      try {
        startDate = convertStringToDateTime(item.STARTDATE);

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

        for (var dateStr in finishDateStrings) {
          if (dateStr != null && dateStr.trim().isNotEmpty) {
            DateTime? finishDate = convertStringToDateTime(dateStr);
            if (finishDate != null) {
              finishDates.add(finishDate);
            }
          }
        }
      } catch (e) {
        print("Error parsing date: $e");
        continue;
      }

      if (startDate == null) continue;

      DateTime targetDateOnly = DateTime(targetDate.year, targetDate.month, targetDate.day);
      DateTime startDateOnly = DateTime(startDate.year, startDate.month, startDate.day);

      List<String> statusesForDay = [];

      if (targetDateOnly.isAtSameMomentAs(startDateOnly)) {
        statusesForDay.add('START');
      }

      for (int i = 0; i < finishDates.length; i++) {
        DateTime? finishDate = finishDates[i];
        if (finishDate != null) {
          DateTime finishDateOnly = DateTime(finishDate.year, finishDate.month, finishDate.day);
          if (targetDateOnly.isAtSameMomentAs(finishDateOnly)) {
            // ถ้าเป็น Finish_Date ตัวสุดท้าย
            if (i == finishDates.length - 1) {
              statusesForDay.add('FINISH');
            } else {
              statusesForDay.add('STOP');
            }
          }
        }
      }

      if (statusesForDay.isNotEmpty) {
        jobsForDate.add({
          'request_no': item.REQUESTNO,
          'statuses': statusesForDay,
        });
      }
    }
    // print(jobsForDate);
    return jobsForDate;
  }

  @override
  Widget build(BuildContext context) {
    P05CALENDARJOBMAINcontext = context;
    List<P05CALENDARJOBGETDATAclass> _datain = widget.data ?? [];
    List<P05CALENDARJOBGETDATAclass> monthData = _datain.where((data) {
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
      // print("start: $start, finish: $finish");
      if (start == null || finish == null) return false;

      DateTime monthStart =
          DateTime(P05CALENDARJOBVAR.dateTimeSelect.year, P05CALENDARJOBVAR.dateTimeSelect.month, 1);
      DateTime monthEnd = DateTime(
        P05CALENDARJOBVAR.dateTimeSelect.year,
        P05CALENDARJOBVAR.dateTimeSelect.month + 1,
        0,
        23,
        59,
        59,
      );
      // print(monthStart);
      // print(monthEnd);
      // print('-------------------------------------------');
      return !(finish.isBefore(monthStart) || start.isAfter(monthEnd));
    }).toList();

    // _fetchHolidays();
    // print(holidays);

    selectpage = '';
    selectstatus = '';
    selectslot.text = '';
    SSTAllData.clear();

    final firstDayOfMonth =
        DateTime(P05CALENDARJOBVAR.dateTimeSelect.year, P05CALENDARJOBVAR.dateTimeSelect.month, 1);
    final daysInMonth =
        DateTime(P05CALENDARJOBVAR.dateTimeSelect.year, P05CALENDARJOBVAR.dateTimeSelect.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday % 7;

    List<DateTime?> calendarDays = List<DateTime?>.filled(42, null);
    for (int i = 0; i < daysInMonth; i++) {
      calendarDays[firstWeekday + i] =
          DateTime(P05CALENDARJOBVAR.dateTimeSelect.year, P05CALENDARJOBVAR.dateTimeSelect.month, i + 1);
    }

    String formattedMonthYear = DateFormat('MMM yyyy').format(P05CALENDARJOBVAR.dateTimeSelect);

    // print(_datain.length);
    // print(monthData.length);

    // ฟังก์ชันตรวจสอบว่าเป็นวันหยุดหรือไม่
    bool isHoliday(DateTime date) {
      String dateString = DateFormat('yyyy-MM-dd').format(date);

      for (String holiday in holidays) {
        try {
          DateTime holidayDate = DateTime.parse(holiday);
          String holidayDateString = DateFormat('yyyy-MM-dd').format(holidayDate);
          if (dateString == holidayDateString) {
            return true;
          }
        } catch (e) {
          continue;
        }
      }
      return false;
    }

    // ฟังก์ชันเลือกสีพื้นหลังตามประเภทของวัน
    Color getBackgroundColor(DateTime? date, bool isToday) {
      if (date == null) return Colors.grey.shade50;

      if (isHoliday(date)) {
        return const Color(0xFFFFE4E1);
      } else if (isToday) {
        return Colors.grey.shade50;
      } else {
        return Colors.grey.shade50;
      }
    }

    // ฟังก์ชันเลือกสีขอบตามประเภทของวัน
    Color getBorderColor(DateTime? date, bool isToday) {
      if (date == null) return Colors.grey.shade200;

      if (isHoliday(date)) {
        return const Color(0xFFFF6B6B);
      } else if (isToday) {
        return const Color(0xFF667EEA);
      } else {
        return Colors.grey.shade200;
      }
    }

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
              Row(
                children: [
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
                            P05CALENDARJOBVAR.dateTimeSelect = DateTime(
                              P05CALENDARJOBVAR.dateTimeSelect.year,
                              P05CALENDARJOBVAR.dateTimeSelect.month - 1,
                            );
                            context.read<P05CALENDARJOBGETDATA_Bloc>().add(P05CALENDARJOBGETDATA_GET());
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Material(
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _buildStatusLegend('START', getStatusColor('START')),
                                        const SizedBox(width: 8),
                                        _buildStatusLegend('STOP', getStatusColor('STOP')),
                                        const SizedBox(width: 8),
                                        _buildStatusLegend('FINISH', getStatusColor('FINISH')),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            P05CALENDARJOBVAR.dateTimeSelect = DateTime(
                              P05CALENDARJOBVAR.dateTimeSelect.year,
                              P05CALENDARJOBVAR.dateTimeSelect.month + 1,
                            );
                            context.read<P05CALENDARJOBGETDATA_Bloc>().add(P05CALENDARJOBGETDATA_GET());
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
              Container(
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
                  children: P05CALENDARJOBVAR.weekDays.map((day) {
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

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: getBackgroundColor(date, isToday),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: getBorderColor(date, isToday),
                            width: (isToday || (date != null && isHoliday(date))) ? 2 : 1,
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
                              : (date != null && isHoliday(date))
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFFF6B6B).withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                        ),
                        child: Stack(
                          children: [
                            if (date != null)
                              Positioned(
                                top: 6,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: isToday
                                          ? const Color(0xFF2D3748)
                                          : isHoliday(date)
                                              ? const Color(0xFFD63384)
                                              : const Color(0xFF2D3748),
                                    ),
                                  ),
                                ),
                              ),
                            // เพิ่มไอคอนสำหรับวันหยุด
                            if (date != null && isHoliday(date))
                              Positioned(
                                top: 4,
                                left: 4,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF6B6B),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF6B6B).withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.event_busy,
                                    size: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            if (date != null)
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4, right: 4, top: 24, bottom: 4),
                                  child: Builder(
                                    builder: (context) {
                                      List<Map<String, dynamic>> jobsForDate =
                                          getJobsForDate(date, monthData);

                                      if (jobsForDate.isEmpty) {
                                        return const SizedBox.shrink();
                                      }

                                      return MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            _showJobDetailsDialog(context, date, jobsForDate, monthData);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: Colors.transparent,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: jobsForDate.map((job) {
                                                  return Container(
                                                    margin: const EdgeInsets.only(bottom: 2),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            job['request_no'],
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w600,
                                                              color: isToday
                                                                  ? const Color(0xFF374151)
                                                                  : isHoliday(date)
                                                                      ? const Color(0xFFD63384)
                                                                      : const Color(0xFF374151),
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 2),
                                                        ...job['statuses'].map<Widget>((status) {
                                                          return Container(
                                                            margin: const EdgeInsets.only(right: 1),
                                                            width: 6,
                                                            height: 6,
                                                            decoration: BoxDecoration(
                                                              color: getStatusColor(status),
                                                              shape: BoxShape.circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color:
                                                                      getStatusColor(status).withOpacity(0.3),
                                                                  spreadRadius: 0,
                                                                  blurRadius: 2,
                                                                  offset: const Offset(0, 1),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
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

  Future<void> _selectMonthYear(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: P05CALENDARJOBVAR.dateTimeSelect,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'เลือกเดือนและปี',
    );

    if (picked != null) {
      setState(() {
        P05CALENDARJOBVAR.dateTimeSelect = picked;
        context.read<P05CALENDARJOBGETDATA_Bloc>().add(P05CALENDARJOBGETDATA_GET());
      });
    }
  }
}

// ฟังก์ชันสำหรับได้สีของวงกลมตามสถานะ
Color getStatusColor(String status) {
  switch (status) {
    case 'START':
      return const Color(0xFF3B82F6);
    case 'STOP':
      return const Color(0xFFF59E0B);
    case 'FINISH':
      return const Color(0xFF10B981);
    default:
      return const Color(0xFF6B7280);
  }
}

// ฟังก์ชันสำหรับแสดง popup รายละเอียดงาน
void _showJobDetailsDialog(BuildContext context, DateTime date, List<Map<String, dynamic>> jobsForDate,
    List<P05CALENDARJOBGETDATAclass> monthData) {
  // หาข้อมูลเต็มของงานในวันนั้น
  List<P05CALENDARJOBGETDATAclass> fullJobDetails = [];

  for (var job in jobsForDate) {
    var fullData = monthData.firstWhere(
      (data) => data.REQUESTNO == job['request_no'],
      orElse: () => monthData.first,
    );
    fullJobDetails.add(fullData);
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF8FAFF), Color(0xFFEEF4FF)],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Job description - ${DateFormat('dd/MM/yyyy').format(date)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: fullJobDetails.map((job) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    job.REQUESTNO,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusBackgroundColor(job.STATUS),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    job.STATUS,
                                    style: TextStyle(
                                      color: _getStatusTextColor(job.STATUS),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow('Customer', job.CUSTOMERNAME),
                            _buildInfoRow(
                                'Part name',
                                [
                                  job.PARTNAME1,
                                  job.PARTNAME2,
                                  job.PARTNAME3,
                                  job.PARTNAME4,
                                  job.PARTNAME5,
                                  job.PARTNAME6,
                                  job.PARTNAME7,
                                  job.PARTNAME8,
                                  job.PARTNAME9,
                                  job.PARTNAME10,
                                ].where((e) => e.trim().isNotEmpty).join(', ')),
                            _buildInfoRow(
                                'Part No.',
                                [
                                  job.PARTNO1,
                                  job.PARTNO2,
                                  job.PARTNO3,
                                  job.PARTNO4,
                                  job.PARTNO5,
                                  job.PARTNO6,
                                  job.PARTNO7,
                                  job.PARTNO8,
                                  job.PARTNO9,
                                  job.PARTNO10
                                ].where((e) => e.trim().isNotEmpty).join(', ')),
                            _buildInfoRow('Instrument', job.INSTRUMENT),
                            _buildInfoRow('Method', job.METHOD),
                            _buildInfoRow('Incharge', job.INCHARGE),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Test period',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF374151),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildDateTimeRow('Start', job.STARTDATE),
                                  _buildFinishDatesInfo(job),
                                ],
                              ),
                            ),
                            if (job.REMARK.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              _buildInfoRow('Remark', job.REMARK),
                            ],
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
      );
    },
  );
}

// ฟังก์ชันช่วยสำหรับสร้างแถวข้อมูล
Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Text(
          ': ',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    ),
  );
}

// ฟังก์ชันสำหรับแสดงวันที่และเวลา
Widget _buildDateTimeRow(String label, String? dateTimeString) {
  if (dateTimeString == null || dateTimeString.isEmpty) {
    return const SizedBox.shrink();
  }

  try {
    DateTime? dateTime = convertStringToDateTime(dateTimeString);
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime!);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            size: 14,
            color: const Color(0xFF667EEA),
          ),
          const SizedBox(width: 8),
          Text(
            '$label: $formattedDateTime',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  } catch (e) {
    return const SizedBox.shrink();
  }
}

// ฟังก์ชันสำหรับแสดงข้อมูล Finish Dates
Widget _buildFinishDatesInfo(P05CALENDARJOBGETDATAclass job) {
  List<String?> finishDates = [
    job.FINISHDATE1,
    job.FINISHDATE2,
    job.FINISHDATE3,
    job.FINISHDATE4,
    job.FINISHDATE5,
    job.FINISHDATE6,
    job.FINISHDATE7,
    job.FINISHDATE8,
    job.FINISHDATE9,
    job.FINISHDATE10,
  ];

  // หา index ของตัวสุดท้ายที่มีค่า
  int lastIndex = finishDates.lastIndexWhere(
    (e) => e != null && e.trim().isNotEmpty,
  );

  List<Widget> finishDateWidgets = [];

  for (int i = 0; i < finishDates.length; i++) {
    if (finishDates[i] != null && finishDates[i]!.trim().isNotEmpty) {
      try {
        DateTime? finishDate = convertStringToDateTime(finishDates[i]!);
        String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(finishDate!);

        String label = (i == lastIndex) ? 'Finish' : 'Stop ${i + 1}';

        finishDateWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Icon(
                  Icons.flag,
                  size: 14,
                  color: const Color(0xFF10B981),
                ),
                const SizedBox(width: 8),
                Text(
                  '$label: $formattedDate',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        );
      } catch (e) {
        // Invalid date, skip
      }
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: finishDateWidgets,
  );
}

// ฟังก์ชันสำหรับได้สีพื้นหลังของสถานะ
Color _getStatusBackgroundColor(String status) {
  switch (status.toUpperCase()) {
    case 'RECEIVED':
      // return const Color(0xFF3B82F6).withOpacity(0.1);
      return Colors.blue.withOpacity(0.1);
    case 'START':
      // return const Color(0xFF3B82F6).withOpacity(0.1);
      return Colors.pink.withOpacity(0.1);
    case 'STOP':
      // return const Color(0xFFF59E0B).withOpacity(0.1);
      return Colors.orange.withOpacity(0.1);
    case 'FINISH':
      // return const Color(0xFF10B981).withOpacity(0.1);
      return Colors.green.withOpacity(0.1);
    case 'PM':
      // return const Color.fromARGB(255, 185, 16, 16).withOpacity(0.1);
      return Colors.red.withOpacity(0.1);
    default:
      return const Color(0xFF6B7280).withOpacity(0.1);
  }
}

// ฟังก์ชันสำหรับได้สีข้อความของสถานะ
Color _getStatusTextColor(String status) {
  switch (status.toUpperCase()) {
    case 'RECEIVED':
      // return const Color(0xFF3B82F6).withOpacity(0.1);
      return Colors.blue;
    case 'START':
      // return const Color(0xFF3B82F6).withOpacity(0.1);
      return Colors.pink;
    case 'STOP':
      // return const Color(0xFFF59E0B).withOpacity(0.1);
      return Colors.orange;
    case 'FINISH':
      // return const Color(0xFF10B981).withOpacity(0.1);
      return Colors.green;
    case 'PM':
      // return const Color.fromARGB(255, 185, 16, 16).withOpacity(0.1);
      return Colors.red;
    default:
      return const Color(0xFF6B7280);
  }
}

Future<void> fetchHolidays() async {
  try {
    // FreeLoadingTan(P05CALENDARJOBMAINcontext);

    final responseHolidays = await Dio().post(
      "$ToServer/02SALTSPRAY/Holidays",
      data: {},
      options: Options(
        validateStatus: (status) {
          return true;
        },
      ),
    );

    if (responseHolidays.statusCode == 200 && responseHolidays.data is List) {
      List data = responseHolidays.data;
      holidays = data.map((item) => item['HolidayDate'].toString()).where((name) => name.isNotEmpty).toList();
      // print("Holidays: " + holidays.toString());
    } else {
      print("SearchCustomer failed");
      // showErrorPopup(P03DATATABLEMAINcontext, responseHolidays.toString());
      // Navigator.pop(P05CALENDARJOBMAINcontext);
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(P05CALENDARJOBMAINcontext, e.toString());
  } finally {
    // Navigator.pop(P05CALENDARJOBMAINcontext);
  }
}

// เพิ่มฟังก์ชันสำหรับสร้าง Legend
Widget _buildStatusLegend(String status, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
      const SizedBox(width: 4),
      Text(
        status,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF64748B),
        ),
      ),
    ],
  );
}
