import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notdefteri_flutter/repo/notlarDaoRepo.dart';

import '../data/model/notlar.dart';

class AnaSayfaCubbit extends Cubit<List<Notes>>{
  AnaSayfaCubbit():super(<Notes>[]);

  var repoeris=NotlarDao();

  Future<void>notlariYukle()async{
    var liste=await repoeris.notlariYukle();
    emit(liste);
  }


  Future<void> kaydet(String baslik,String icerik)async{//burda kaydetme işlemini yapıyoruz
    await repoeris.kaydet(baslik, icerik);
  }

  Future<void>sil(int? id)async{
    await repoeris.sil(id);
    await repoeris.notlariYukle();
  }

Future<void>ara(String arama)async{
 var liste=  await repoeris.ara(arama);
   emit(liste);
}

}