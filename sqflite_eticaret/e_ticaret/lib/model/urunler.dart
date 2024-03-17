import 'package:e_ticaret/model/kategori.dart';

class Urun{
  int urun_id;
  String urun_adi;
  dynamic urun_fiyat;
  int urun_stok;
  Kategori kategori_id;
  String resim_adresi;

  Urun({required this.urun_id, required this.urun_adi, required this.urun_fiyat, required this.urun_stok,
      required this.kategori_id, required this.resim_adresi});
}