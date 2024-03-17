import 'package:filimler_uygulamasi/repo/filimlerDaorepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EkleSayfaCubit extends Cubit<void>{
  EkleSayfaCubit():super(0);

  var getir1=FilimlerDaoRepository();

  Future<void>kaydet(String filmAD,String filmFiyat) async{
    await getir1.kaydet(filmAD, filmFiyat);
  }

}