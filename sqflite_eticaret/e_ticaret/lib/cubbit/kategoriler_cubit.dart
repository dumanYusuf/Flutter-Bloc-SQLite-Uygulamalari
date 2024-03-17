import 'package:e_ticaret/model/kategori.dart';
import 'package:e_ticaret/repo/eticaretRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KategorilerCubit extends Cubit<List<Kategori>>{
  KategorilerCubit():super(<Kategori>[]);


  final _eRepo = ticaretRepo();

  Future<void> kategorileriGetir() async{
    var kategoriler =  await _eRepo.kategorileriYukle();
    emit(kategoriler);
  }

}