import 'package:e_ticaret/repo/eticaretRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/urunler.dart';

class YeniSayfaCubbit extends Cubit<List<Urun>> {

  YeniSayfaCubbit() :super(<Urun>[]);

  var repoEris = ticaretRepo();

  Future<void> urunleriYukle() async {
    var liste = await repoEris.urunleriYukle();
    emit(liste);
  }
}