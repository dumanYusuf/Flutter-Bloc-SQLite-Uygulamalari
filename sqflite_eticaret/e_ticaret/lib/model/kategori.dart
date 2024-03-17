class Kategori{
  int kategori_id;
  String? kategori_adi;

  Kategori({required this.kategori_id,  this.kategori_adi});

  factory Kategori.withID(int kategoriID){
    return Kategori(kategori_id: kategoriID);
  }
}