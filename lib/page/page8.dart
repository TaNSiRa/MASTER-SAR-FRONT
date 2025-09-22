// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/BlocEvent/08-01-P08EDITUSERGETDATA.dart';
// import 'P8EDITUSER/P08EDITUSERMAIN.dart';

// //---------------------------------------------------------

// class Page8 extends StatelessWidget {
//   const Page8({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Page8blockget();
//   }
// }

// class Page8blockget extends StatelessWidget {
//   const Page8blockget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => P08EDITUSERGETDATA_Bloc(),
//         child: BlocBuilder<P08EDITUSERGETDATA_Bloc, List<P08EDITUSERGETDATAclass>>(
//           builder: (context, data) {
//             return Page8Body(
//               data: data,
//             );
//           },
//         ));
//   }
// }

// class Page8Body extends StatelessWidget {
//   Page8Body({
//     super.key,
//     this.data,
//   });
//   List<P08EDITUSERGETDATAclass>? data;
//   @override
//   Widget build(BuildContext context) {
//     return P08EDITUSERMAIN(
//       data: data,
//     );
//   }
// }
