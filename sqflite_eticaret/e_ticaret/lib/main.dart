import 'package:e_ticaret/cubbit/anaSayfaCubit.dart';
import 'package:e_ticaret/cubbit/aramaSayfaCubit.dart';
import 'package:e_ticaret/cubbit/bottomNavigatorBarindexCubbit.dart';
import 'package:e_ticaret/cubbit/elektronikCubit.dart';
import 'package:e_ticaret/cubbit/favoriCubit.dart';
import 'package:e_ticaret/cubbit/sepet_cubit.dart';
import 'package:e_ticaret/cubbit/urunlerCubit.dart';
import 'package:e_ticaret/cubbit/yeniSayfaCubbit.dart';
import 'package:e_ticaret/views/anaSayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubbit/kategoriler_cubit.dart';

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
        BlocProvider(create: (context)=>BottomNavigatorBarIndexCubbit()),
        BlocProvider(create: (context)=>UrunlerCubit()),
        BlocProvider(create: (context)=> KategorilerCubit()),
        BlocProvider(create: (context)=>ElektronikCubit()),
        BlocProvider(create: (context)=>YeniSayfaCubbit()),
        BlocProvider(create: (context)=>AnaSayfaCubbit()),
        BlocProvider(create: (context)=>FavoriCubit()),
        BlocProvider(create: (context)=> SepetCubit()),
        BlocProvider(create: (context)=>AramaSayfaCubit()),      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnaSayfa(),
      ),
    );
  }
}
