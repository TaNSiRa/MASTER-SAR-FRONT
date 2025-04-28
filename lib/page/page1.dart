// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';
import 'P1DASHBOARD/P01DASHBOARDMAIN.dart';

//---------------------------------------------------------

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page1blockget();
  }
}

class Page1blockget extends StatelessWidget {
  const Page1blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P01DASHBOARDGETDATA_Bloc(),
        child: BlocBuilder<P01DASHBOARDGETDATA_Bloc,
            List<P01DASHBOARDGETDATAclass>>(
          builder: (context, data) {
            return Page1Body(
              data: data,
            );
          },
        ));
  }
}

class Page1Body extends StatelessWidget {
  Page1Body({
    super.key,
    this.data,
  });
  List<P01DASHBOARDGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P01DASHBOARDMAIN(
      data: data,
    );
  }
}
