import 'package:filimler_uygulamasi/data/model/filimler.dart';
import 'package:filimler_uygulamasi/repo/filimlerDaorepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaSayfaCubit extends Cubit<List<Filimler>>{
  AnaSayfaCubit():super(<Filimler>[]);

  var getir=FilimlerDaoRepository();

  Future<void> filimleriYukle()async{

    var liste=await getir.filmleriYukle();
    emit(liste);

  }

  Future<void>sil(int kisid)async{
    await getir.sil(kisid);
    await filimleriYukle();
  }

  Future<void>ara(String arama)async{
    var liste=await getir.ara(arama);
    emit(liste);
  }


}