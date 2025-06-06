import 'dart:convert';

import 'package:flutter/widgets.dart';

void convertPrintMap(List<Map<String, String>> data) {
  const encoder = JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(data);
  debugPrint(pretty);
}
