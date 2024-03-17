import 'package:filimler_uygulamasi/cubbit/anasayfaCubit.dart';
import 'package:filimler_uygulamasi/cubbit/ekleSayfaCubbit.dart';
import 'package:filimler_uygulamasi/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocProvider(create: (context)=>AnaSayfaCubit()),
        BlocProvider(create: (context)=>EkleSayfaCubit()),
      ],
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
        home: AnaSayfa(),
      ),
    );
  }
}
