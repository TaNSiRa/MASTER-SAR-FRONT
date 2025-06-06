// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/06-01-P06EDITCUSTOMERGETDATA.dart';
import 'P6EDITCUSTOMER/P06EDITCUSTOMERMAIN.dart';

//---------------------------------------------------------

class Page6 extends StatelessWidget {
  const Page6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page6blockget();
  }
}

class Page6blockget extends StatelessWidget {
  const Page6blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P06EDITCUSTOMERGETDATA_Bloc(),
        child: BlocBuilder<P06EDITCUSTOMERGETDATA_Bloc, List<P06EDITCUSTOMERGETDATAclass>>(
          builder: (context, data) {
            return Page6Body(
              data: data,
            );
          },
        ));
  }
}

class Page6Body extends StatelessWidget {
  Page6Body({
    super.key,
    this.data,
  });
  List<P06EDITCUSTOMERGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P06EDITCUSTOMERMAIN(
      data: data,
    );
  }
}
