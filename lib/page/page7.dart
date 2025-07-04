// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/07-01-P07CHANGEPASSWORDGETDATA.dart';
import 'P7CHANGEPASSWORD/P07CHANGEPASSWORDMAIN.dart';

//---------------------------------------------------------

class Page7 extends StatelessWidget {
  const Page7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page7blockget();
  }
}

class Page7blockget extends StatelessWidget {
  const Page7blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P07CHANGEPASSWORDGETDATA_Bloc(),
        child: BlocBuilder<P07CHANGEPASSWORDGETDATA_Bloc, List<P07CHANGEPASSWORDGETDATAclass>>(
          builder: (context, data) {
            return Page7Body(
              data: data,
            );
          },
        ));
  }
}

class Page7Body extends StatelessWidget {
  Page7Body({
    super.key,
    this.data,
  });
  List<P07CHANGEPASSWORDGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P07CHANGEPASSWORDMAIN(
      data: data,
    );
  }
}
