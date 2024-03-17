import 'package:e_ticaret/model/favoriler.dart';
import 'package:e_ticaret/repo/eticaretRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriCubit extends Cubit<List<Favori>>{
  FavoriCubit():super(<Favori>[]);

  var eris=ticaretRepo();

  Future<void>favoriYukle()async{
    var liste=await eris.favoriYukle();
    emit(liste);
  }

  Future<void> favoriEkle(int urunId,int musteriId) async{
    await eris.favoriEkle(urunId,musteriId);
  }

  Future<void>favoriSil(int id)async{
  await eris.favorisilme(id);
  }
}