import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';

class menu_normal extends StatelessWidget {
  menu_normal({Key? key, this.name, this.icon, required this.page, required this.Lv}) : super(key: key);
  String? name;
  Widget page;
  IconData? icon;
  int Lv;
  String? pagename;

  @override
  Widget build(BuildContext context) {
    String _name = name ?? "";

    return InkWell(
      onTap: () {
        CuPageLV = Lv;
        MainBodyContext.read<ChangePage_Bloc>().ChangePage(pagename ?? '', page);
      },
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                icon ?? Icons.chevron_right_rounded,
                size: 20,
                color: const Color.fromARGB(255, 28, 23, 99),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "  $_name",
                style: const TextStyle(
                  fontFamily: 'Mitr',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class menu_normal_sm extends StatelessWidget {
//   menu_normal_sm({
//     Key? key,
//     this.name,
//     required this.page,
//     required this.Lv,
//     this.icon_s,
//     this.icon_ns,
//     this.select,
//     this.pagename,
//     this.size,
//   }) : super(key: key);
//   String? name;
//   Widget page;
//   // String? icon;
//   int Lv;
//   bool? select;
//   bool? size;

//   String? icon_s;
//   String? icon_ns;
//   String? pagename;

//   @override
//   Widget build(BuildContext context) {
//     String _name = name ?? "";
//     bool _select = select ?? false;

//     return InkWell(
//       onTap: () {
//         // BlocProvider.of<SwPageCubit>(context).togglePage(page);
//         // CuPage = page;
//         CuPageLV = Lv;

//         MainBodyContext.read<ChangePage_Bloc>()
//             .ChangePage_nodrower(pagename ?? '', page);
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(left: 15, right: 15),
//         child: Container(
//           decoration: BoxDecoration(
//             color: _select ? const Color(0xff0057F1) : const Color(0xFFF7F7F7),
//             //
//             borderRadius:
//                 _select ? BorderRadius.circular(8) : BorderRadius.circular(0),
//           ),
//           height: 40,
//           child: Row(
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 15),
//                   child: Container(
//                     height: 24,
//                     width: 24,
//                     decoration: BoxDecoration(
//                       // color: Colors.redAccent.shade400,
//                       image: DecorationImage(
//                         image: AssetImage((_select ? icon_s : icon_ns) ??
//                             "assets/icons/icon-caution@3x.png"),
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if ((size ?? false) == false) ...[
//                 Padding(
//                   padding: const EdgeInsets.only(left: 4),
//                   child: SizedBox(
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         _name,
//                         style: TextStyle(
//                           //   fontFamily: 'Mitr',
//                           color: _select ? Colors.white : Colors.black,
//                           //   fontSize: 14,
//                           //   fontWeight: FontWeight.w300,
//                           //   fontStyle: FontStyle.normal,
//                           //   letterSpacing: 0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
