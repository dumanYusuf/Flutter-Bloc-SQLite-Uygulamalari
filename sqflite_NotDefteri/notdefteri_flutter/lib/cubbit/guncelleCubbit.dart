import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notdefteri_flutter/repo/notlarDaoRepo.dart';

class GuncelleCubit extends Cubit<void>{
  GuncelleCubit():super(0);
  
  var repoeris=NotlarDao();

  Future<void>guncelle(int id,String baslik,String icerik)async{
    await repoeris.guncelle(id, baslik, icerik);

  }
}