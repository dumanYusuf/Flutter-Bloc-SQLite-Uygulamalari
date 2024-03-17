import 'package:e_ticaret/repo/eticaretRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/urunler.dart';

  class ElektronikCubit extends Cubit<List<Urun>>{
    ElektronikCubit():super(<Urun>[]);

    var repoEris=ticaretRepo();

    Future<void>ayir(int kategoriID)async{
      var liste=await repoEris.UrunKategori(kategoriID);
      emit(liste);
    }
  }