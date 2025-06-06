// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/04-01-P04CALENDARINSTRUMENTGETDATA.dart';
import 'P4CALENDARINSTRUMENT/P04CALENDARINSTRUMENTMAIN.dart';

//---------------------------------------------------------

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page4blockget();
  }
}

class Page4blockget extends StatelessWidget {
  const Page4blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P04CALENDARINSTRUMENTGETDATA_Bloc(),
        child: BlocBuilder<P04CALENDARINSTRUMENTGETDATA_Bloc, List<P04CALENDARINSTRUMENTGETDATAclass>>(
          builder: (context, data) {
            return Page4Body(
              data: data,
            );
          },
        ));
  }
}

class Page4Body extends StatelessWidget {
  Page4Body({
    super.key,
    this.data,
  });
  List<P04CALENDARINSTRUMENTGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P04CALENDARINSTRUMENTMAIN(
      data: data,
    );
  }
}
