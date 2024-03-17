import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notdefteri_flutter/cubbit/anaSayfaCubbit.dart';
import 'package:notdefteri_flutter/cubbit/guncelleCubbit.dart';
import 'package:notdefteri_flutter/views/anaSayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AnaSayfaCubbit()),
        BlocProvider(create: (context)=>GuncelleCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnaSayfa(),
      ),
    );
  }
}
