// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../bloc/BlocEvent/09-01-P09GRAPHINSTRUMENTGETDATA.dart';
import '../../data/global.dart';
import '../../widget/function/ForUseAllPage.dart';
import 'P09GRAPHINSTRUMENTVAR.dart';

late BuildContext P09GRAPHINSTRUMENTMAINcontext;

class P09GRAPHINSTRUMENTMAIN extends StatefulWidget {
  P09GRAPHINSTRUMENTMAIN({
    super.key,
    this.data,
  });
  List<P09GRAPHINSTRUMENTGETDATAclass>? data;

  @override
  State<P09GRAPHINSTRUMENTMAIN> createState() => _P09GRAPHINSTRUMENTMAINState();
}

class _P09GRAPHINSTRUMENTMAINState extends State<P09GRAPHINSTRUMENTMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P09GRAPHINSTRUMENTGETDATA_Bloc>().add(P09GRAPHINSTRUMENTGETDATA_GET());
    PageName = 'INSTRUMENT ANALYTICS';
  }

  Map<String, List<double>> calculateMonthlyData(List<P09GRAPHINSTRUMENTGETDATAclass> data) {
    Map<String, List<double>> instrumentData = {
      'SST No.1': [],
      'SST No.2': [],
      'SST No.3': [],
      'SST No.4': [],
    };

    final daysInMonth = DateTime(
      P09GRAPHINSTRUMENTVAR.dateTimeSelect.year,
      P09GRAPHINSTRUMENTVAR.dateTimeSelect.month + 1,
      0,
    ).day;

    // Initialize all days with 0%
    for (String instrument in instrumentData.keys) {
      instrumentData[instrument] = List<double>.filled(daysInMonth, 0.0);
    }

    // Calculate capacity for each day
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime targetDate = DateTime(
        P09GRAPHINSTRUMENTVAR.dateTimeSelect.year,
        P09GRAPHINSTRUMENTVAR.dateTimeSelect.month,
        day,
      );

      Map<String, double> dayCapacity = calculateDayCapacity(targetDate, data);

      for (String instrument in instrumentData.keys) {
        instrumentData[instrument]![day - 1] = dayCapacity[instrument] ?? 0.0;
      }
    }

    return instrumentData;
  }

  Map<String, double> calculateDayCapacity(DateTime targetDate, List<P09GRAPHINSTRUMENTGETDATAclass> data) {
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

      DateTime targetDateOnly = DateTime(targetDate.year, targetDate.month, targetDate.day);
      DateTime startDateOnly = DateTime(startDate.year, startDate.month, startDate.day);
      DateTime finishDateOnly = DateTime(finishDate.year, finishDate.month, finishDate.day);

      if (targetDateOnly.isAtSameMomentAs(startDateOnly) ||
          targetDateOnly.isAtSameMomentAs(finishDateOnly) ||
          (targetDateOnly.isAfter(startDateOnly) && targetDateOnly.isBefore(finishDateOnly))) {
        double actualUsedMinutes = 0;

        if (targetDateOnly.isAtSameMomentAs(startDateOnly)) {
          DateTime endOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59);
          actualUsedMinutes = endOfDay.difference(startDate).inMinutes.toDouble() + 1;
        } else if (targetDateOnly.isAtSameMomentAs(finishDateOnly)) {
          DateTime startOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day, 0, 0, 0);
          actualUsedMinutes = finishDate.difference(startOfDay).inMinutes.toDouble();
        } else {
          actualUsedMinutes = 1440;
        }

        if (actualUsedMinutes > 1440) actualUsedMinutes = 1440;
        if (actualUsedMinutes < 0) actualUsedMinutes = 0;

        List<String> checkboxList = item.CHECKBOX.split(',');
        int checkboxSlotsUsed = 0;

        for (String checkboxStr in checkboxList) {
          if (checkboxStr.trim().isNotEmpty) {
            try {
              int.parse(checkboxStr.trim());
              checkboxSlotsUsed += 1;
            } catch (e) {
              print("Error parsing checkbox: $e");
            }
          }
        }

        double totalCapacityForDay = 1440 * totalCheckboxSlots;
        double usedCapacity = actualUsedMinutes * checkboxSlotsUsed;
        double percentage = (usedCapacity / totalCapacityForDay) * 100;

        if (capacityMap.containsKey(item.INSTRUMENT)) {
          capacityMap[item.INSTRUMENT] = capacityMap[item.INSTRUMENT]! + percentage;
        }
      }
    }

    capacityMap.forEach((key, value) {
      if (value > 100.0) {
        capacityMap[key] = 100.0;
      }
    });

    return capacityMap;
  }

  Map<String, double> calculateMonthlyAverage(Map<String, List<double>> monthlyData) {
    Map<String, double> averages = {};

    for (String instrument in monthlyData.keys) {
      double total = monthlyData[instrument]!.fold(0.0, (sum, value) => sum + value);
      averages[instrument] = total / monthlyData[instrument]!.length;
    }

    return averages;
  }

  @override
  Widget build(BuildContext context) {
    P09GRAPHINSTRUMENTMAINcontext = context;
    List<P09GRAPHINSTRUMENTGETDATAclass> _datain = widget.data ?? [];

    List<P09GRAPHINSTRUMENTGETDATAclass> monthData = _datain.where((data) {
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

      DateTime monthStart =
          DateTime(P09GRAPHINSTRUMENTVAR.dateTimeSelect.year, P09GRAPHINSTRUMENTVAR.dateTimeSelect.month, 1);
      DateTime monthEnd = DateTime(P09GRAPHINSTRUMENTVAR.dateTimeSelect.year,
          P09GRAPHINSTRUMENTVAR.dateTimeSelect.month + 1, 0, 23, 59, 59);

      return !(finish.isBefore(monthStart) || start.isAfter(monthEnd));
    }).toList();

    Map<String, List<double>> instrumentData = calculateMonthlyData(monthData);
    Map<String, double> averages = calculateMonthlyAverage(instrumentData);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFF), Color(0xFFEEF4FF)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Month/Year Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(P09GRAPHINSTRUMENTVAR.dateTimeSelect),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () async => await _selectMonthYear(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Color(0xFF667EEA),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Charts Grid
              Expanded(
                child: Column(
                  children: [
                    // Top Row
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 4, bottom: 4),
                              child: _buildInstrumentChart('SST No.1', instrumentData['SST No.1']!,
                                  averages['SST No.1']!, Colors.blue),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 4, bottom: 4),
                              child: _buildInstrumentChart('SST No.2', instrumentData['SST No.2']!,
                                  averages['SST No.2']!, Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bottom Row
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 4, top: 4),
                              child: _buildInstrumentChart('SST No.3', instrumentData['SST No.3']!,
                                  averages['SST No.3']!, Colors.orange),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 4, top: 4),
                              child: _buildInstrumentChart('SST No.4', instrumentData['SST No.4']!,
                                  averages['SST No.4']!, Colors.purple),
                            ),
                          ),
                        ],
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
  }

  Widget _buildInstrumentChart(String instrumentName, List<double> data, double average, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                instrumentName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Used ${average.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Average Circle
          // Center(
          //   child: CircularPercentIndicator(
          //     radius: 35.0,
          //     lineWidth: 6.0,
          //     percent: average / 100,
          //     center: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           '${average.toStringAsFixed(1)}%',
          //           style: const TextStyle(
          //             fontSize: 12,
          //             fontWeight: FontWeight.bold,
          //             color: Color(0xFF2D3748),
          //           ),
          //         ),
          //         Text(
          //           'Used',
          //           style: TextStyle(
          //             fontSize: 10,
          //             color: Colors.grey[600],
          //           ),
          //         ),
          //       ],
          //     ),
          //     backgroundColor: Colors.grey[200]!,
          //     progressColor: color,
          //     circularStrokeCap: CircularStrokeCap.round,
          //   ),
          // ),

          const SizedBox(height: 16),

          // Bar Chart
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.black87,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        'Day ${group.x.toInt()}\n${rod.toY.toStringAsFixed(1)}%',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() % 5 == 1 || value.toInt() == data.length) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        if (value % 25 == 0) {
                          return Text(
                            '${value.toInt()}%',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300]!,
                      strokeWidth: 0.5,
                    );
                  },
                  drawVerticalLine: false,
                ),
                barGroups: data.asMap().entries.map((entry) {
                  int index = entry.key;
                  double value = entry.value;
                  return BarChartGroupData(
                    x: index + 1,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        color: color,
                        width: 4,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          // Usage Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${(100 - average).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Peak',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${data.reduce((a, b) => a > b ? a : b).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectMonthYear(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: P09GRAPHINSTRUMENTVAR.dateTimeSelect,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'เลือกเดือนและปี',
    );

    if (picked != null) {
      // ใช้ addPostFrameCallback เพื่อหลีกเลี่ยง setState ตอน Flutter render อยู่
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          P09GRAPHINSTRUMENTVAR.dateTimeSelect = picked;
          context.read<P09GRAPHINSTRUMENTGETDATA_Bloc>().add(P09GRAPHINSTRUMENTGETDATA_GET());
        });
      });
    }
  }
}
