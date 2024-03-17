import 'package:e_ticaret/model/urunler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/eticaretRepo.dart';

class AramaSayfaCubit extends Cubit<List<Urun>> {
  AramaSayfaCubit() :super(<Urun>[]);

  var repoEris = ticaretRepo();

  Future<void> aramaSayfa(String arama) async {
    var liste = await repoEris.urunAramaSayfa(arama);
    emit(liste);
  }
}
