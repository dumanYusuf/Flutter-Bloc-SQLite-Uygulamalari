
import '../data/model/filimler.dart';
import '../sqflite/veritabani_yardimcisi.dart';

class FilimlerDaoRepository{

  Future<List<Filimler>> filmleriYukle() async {
    var db=await VeritabaniYardimcisi.veritabaniErisim();//burda veritabanına erişiyor
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT*FROM filim");//burda veritabanındaki filmlere ulasıyoruz

    return List.generate(maps.length, (index) {
      var satir=maps[index];//indekse göre getirecek sırayla,satır,satır
      return Filimler(filmID: satir["filmID"], filmAdi: satir["filmAdi"], filmResim: satir["filmResim"], filmFiyat: satir["filmFiyat"]);
    });
  }


 Future<int> kaydet(String filmAd,filmFiyat) async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    var yenikisi=Map<String,dynamic>();

    yenikisi["filmAdi"]=filmAd;
    yenikisi["filmFiyat"]=filmFiyat;

   var satir= await db.insert("filim", yenikisi);
   return satir;

  }

  Future<void> sil(int filmid)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("filim",where: "filmid =?",whereArgs: [filmid]);

  }


  Future<List<Filimler>> ara(String arama) async {
    var db=await VeritabaniYardimcisi.veritabaniErisim();//burda veritabanına erişiyor
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT*FROM filim WHERE filmAdi like '%$arama%'");//burda veritabanındaki filmlere ulasıyoruz

    return List.generate(maps.length, (index) {
      var satir=maps[index];//indekse göre getirecek sırayla,satır,satır
      return Filimler(filmID: satir["filmID"], filmAdi: satir["filmAdi"], filmResim: satir["filmResim"], filmFiyat: satir["filmFiyat"]);
    });
  }





}