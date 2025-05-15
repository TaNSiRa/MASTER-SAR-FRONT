// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';

// late IO.Socket socket;
// late BuildContext P01DASHBOARDMAINcontext;
// late P01DASHBOARDGETDATA_Bloc dashboardBloc;

// void initSocketConnection() {
//   socket = IO.io('http://127.0.0.1:14001', <String, dynamic>{
//     'transports': ['websocket'],
//     'autoConnect': false,
//   });

//   socket.connect();

//   // เมื่อเชื่อมต่อสำเร็จ
//   socket.on('connect', (_) {
//     print('Connected to socket.io server: ${socket.id}');
//   });

//   // รับข้อมูลเพื่อรีเฟรช UI
//   socket.on('refresh-ui', (data) {
//     print('Refresh UI with data: $data');
//     // P01DASHBOARDMAINcontext.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
//     dashboardBloc.add(P01DASHBOARDGETDATA_GET());
//   });

//   // disconnect
//   socket.on('disconnect', (_) {
//     print('Disconnected from socket.io');
//   });
// }
