// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

String token = '';
String selectpage = '';
String selectstatus = '';
TextEditingController selectslot = TextEditingController();
TextEditingController StartDateControllerGlobal = TextEditingController();
TextEditingController StartDateController = TextEditingController();
DateTime StartDateToDateTimeGlobal = DateTime.now();
FocusNode StartDateFocusNodeGlobal = FocusNode();
// Widget CuPage = const Page0();
int CuPageLV = 0;
String masterType = '';
String CustShort = '';
List<String> dropDownIncharge = [];
List<String> dropDownGroupNameTS = [];
List<String> dropDownSampleGroup = [];
List<String> dropDownSampleType = [];

class USERDATA {
  static int UserLV = 0;
  static String NAME = '';
  static String Password = '';
  static String ID = '';
  static String Section = '';
  static String Branch = '';
  static String Permission = '';
}

class logindata {
  static bool isControl = false;
  static String userID = '';
  static String userPASS = '';
}

String PageName = '';
// String serverG = 'http://127.0.0.1:15152';
String serverG = 'http://172.23.10.51:15152/';
// String ToServer = 'http://127.0.0.1:3300';
String ToServer = 'http://172.23.10.51:3300';
List<String> holidays = [];
