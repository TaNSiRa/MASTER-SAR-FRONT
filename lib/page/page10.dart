// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/BlocEvent/10-01-P10EDITREQUESTERGETDATA.dart';
// import 'P10EDITREQUESTER/P10EDITREQUESTERMAIN.dart';

// //---------------------------------------------------------

// class Page10 extends StatelessWidget {
//   const Page10({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Page10blockget();
//   }
// }

// class Page10blockget extends StatelessWidget {
//   const Page10blockget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => P10EDITREQUESTERGETDATA_Bloc(),
//         child: BlocBuilder<P10EDITREQUESTERGETDATA_Bloc, List<P10EDITREQUESTERGETDATAclass>>(
//           builder: (context, data) {
//             return Page10Body(
//               data: data,
//             );
//           },
//         ));
//   }
// }

// class Page10Body extends StatelessWidget {
//   Page10Body({
//     super.key,
//     this.data,
//   });
//   List<P10EDITREQUESTERGETDATAclass>? data;
//   @override
//   Widget build(BuildContext context) {
//     return P10EDITREQUESTERMAIN(
//       data: data,
//     );
//   }
// }
