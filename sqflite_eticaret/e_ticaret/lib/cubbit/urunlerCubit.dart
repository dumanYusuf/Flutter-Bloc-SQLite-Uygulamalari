import 'package:e_ticaret/repo/eticaretRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/urunler.dart';


class UrunlerCubit extends Cubit<List<Urun>>{
  UrunlerCubit():super(<Urun>[]);

  var repoEris=ticaretRepo();
  Future<void>urunleriYukle()async{
    var liste=await repoEris.urunleriYukle();
    emit(liste);

  }
}