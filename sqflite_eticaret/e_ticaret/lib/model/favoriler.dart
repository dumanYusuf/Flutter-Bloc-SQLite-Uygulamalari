class Favori{
  int  favori_id ;
  int kullanici_id;
  int urun_id;
  String? name;
  String? resim_adresi;

  Favori({required this.favori_id, required this.kullanici_id, required this.urun_id, this.name,this.resim_adresi});
}