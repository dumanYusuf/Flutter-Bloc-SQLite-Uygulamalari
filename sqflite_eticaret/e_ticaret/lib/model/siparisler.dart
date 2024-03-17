class Siparis{
  int siparis_id;
  int urun_id;
  int musteri_id;
  int siparis_adeti;
  String siparis_tarihi;
  String? isim;
  String? resim_yolu;

  Siparis({required this.siparis_id, required this.urun_id, required this.musteri_id, required this.siparis_adeti,
      required this.siparis_tarihi,this.isim,this.resim_yolu});
}