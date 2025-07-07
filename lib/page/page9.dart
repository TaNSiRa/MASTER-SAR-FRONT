// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/09-01-P09GRAPHINSTRUMENTGETDATA.dart';
import 'P9GRAPHINSTRUMENT/P09GRAPHINSTRUMENTMAIN.dart';

//---------------------------------------------------------

class Page9 extends StatelessWidget {
  const Page9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page9blockget();
  }
}

class Page9blockget extends StatelessWidget {
  const Page9blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P09GRAPHINSTRUMENTGETDATA_Bloc(),
        child: BlocBuilder<P09GRAPHINSTRUMENTGETDATA_Bloc, List<P09GRAPHINSTRUMENTGETDATAclass>>(
          builder: (context, data) {
            return Page9Body(
              data: data,
            );
          },
        ));
  }
}

class Page9Body extends StatelessWidget {
  Page9Body({
    super.key,
    this.data,
  });
  List<P09GRAPHINSTRUMENTGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P09GRAPHINSTRUMENTMAIN(
      data: data,
    );
  }
}
