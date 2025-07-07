import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/global.dart';
import '../cubit/NotificationEvent.dart';

//-------------------------------------------------

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<String> tokenSP;

abstract class LoginEvent {}

class LoginPage extends LoginEvent {}

class ReLogin extends LoginEvent {}

class Logout extends LoginEvent {}

class Login_Bloc extends Bloc<LoginEvent, String> {
  Login_Bloc() : super('') {
    on<LoginPage>((event, emit) {
      return _LoginPage_Function(state, emit);
    });
    on<ReLogin>((event, emit) {
      return _ReLogin_Function(state, emit);
    });
    on<Logout>((event, emit) {
      return _Logout_Function(state, emit);
    });
  }

  Future<void> _LoginPage_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    // token = (prefs.getString('token') ?? '');
    // token = 'test';
    // USERDATA.UserLV = 2;

    // tokenSP = prefs.setString("tokenSP", token).then((bool success) {
    //   return state;
    // });

    // if (token != '') {
    //   BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
    //       "Success", "Login OK", enumNotificationlist.Success);
    // } else {
    //   BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Error",
    //       "user or password have some problem", enumNotificationlist.Error);
    // }
    final response = await Dio().post(
      "$ToServer/02SALTSPRAY/Login",
      data: {
        "UserName": logindata.userID,
        "Password": logindata.userPASS,
      },
    );

    if (response.statusCode == 200) {
      var databuff = response.data;
      print(databuff);
      if (databuff['return'] == 'OK') {
        token =
            '{"ID":"${databuff['UserName'].toString()}","NAME":"${databuff['NAME'].toString()}","LV":"${databuff['Roleid'].toString()}","Section":"${databuff['Section'].toString()}","Branch":"${databuff['Branch'].toString()}","Permission":"${databuff['Permission'].toString()}"}';
        USERDATA.ID = databuff['UserName'].toString();
        USERDATA.NAME = databuff['NAME'].toString();
        USERDATA.UserLV = int.parse(databuff['Roleid'].toString());
        USERDATA.Section = databuff['Section'].toString();
        USERDATA.Branch = databuff['Branch'].toString();
        USERDATA.Permission = databuff['Permission'].toString();
      } else {
        token = (prefs.getString('tokenSP') ?? '');
        USERDATA.UserLV = 0;
      }
    } else {
      token = (prefs.getString('tokenSP') ?? '');
      USERDATA.UserLV = 0;
    }

    tokenSP = prefs.setString("tokenSP", token).then((bool success) {
      return state;
    });

    if (token != '') {
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Good to see you, ${USERDATA.NAME}!",
          "Let's check on your progress today.", enumNotificationlist.Success);
    } else {
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Oops!",
          "The username or password you entered is incorrect. Please try again.", enumNotificationlist.Error);
    }

    emit(token);
  }

  Future<void> _ReLogin_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    token = (prefs.getString('tokenSP') ?? '');
    USERDATA.UserLV = 2;
    if (token != '') {
      print(token);
      var databuff = jsonDecode(token);

      USERDATA.ID = databuff['ID'].toString();
      USERDATA.UserLV = int.parse(databuff['LV'].toString());
      USERDATA.NAME = databuff['NAME'].toString();
      USERDATA.Section = databuff['Section'].toString();
      USERDATA.Branch = databuff['Branch'].toString();
    } else {
      USERDATA.ID = '';
      USERDATA.UserLV = 0;
      USERDATA.NAME = '';
      USERDATA.Section = '';
      USERDATA.Branch = '';
    }
    emit(token);
  }

  Future<void> _Logout_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    token = '';
    USERDATA.ID = '';
    USERDATA.UserLV = 0;
    USERDATA.NAME = '';
    USERDATA.Section = '';
    USERDATA.Branch = '';

    tokenSP = prefs.setString("tokenSP", token).then((bool success) {
      return state;
    });

    if (token == '') {
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
          "You have been logged out successfully.", "See you next time!", enumNotificationlist.Success);
    }

    emit('');
  }
}
