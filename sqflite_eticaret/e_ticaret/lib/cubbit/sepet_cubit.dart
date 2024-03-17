import 'package:e_ticaret/model/siparisler.dart';
import 'package:e_ticaret/repo/eticaretRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetCubit extends Cubit<List<Siparis>>{
  SepetCubit():super(<Siparis>[]);


  final repo = ticaretRepo();


  Future<void> siparisleriYukle() async{
    var liste = await repo.siparisleriYukle();
    emit(liste);
  }


  Future<void> SepeturunEkle(int urunId,int musteriId,int adet,DateTime siparisTarihi)async{
    await repo.urunEkle(urunId, musteriId, adet, siparisTarihi);
  }

  Future<void>sepetUrunSil(int id)async{

    await repo.siparisSilme(id);
  }



}