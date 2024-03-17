import 'package:e_ticaret/data/dataHelper.dart';
import 'package:e_ticaret/model/favoriler.dart';
import 'package:e_ticaret/model/kategori.dart';
import 'package:e_ticaret/model/siparisler.dart';
import 'package:e_ticaret/model/urunler.dart';

class ticaretRepo{

  Future<List<Kategori>> kategorileriYukle () async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kategoriler");

    return List<Kategori>.generate(maps.length, (index) {
      var row = maps[index];
      return Kategori(kategori_id: row["kategori_id"],kategori_adi: row["kategori_adi"]);
    } );

  }

  Future<List<Urun>>urunleriYukle ()async{

    var db= await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM urunler");

     return List.generate(maps.length, (i) {
       var satir=maps[i];
       return Urun(urun_id: satir["urun_id"], urun_adi: satir["urun_adi"], urun_fiyat: satir["urun_fiyati"], urun_stok: satir["urun_stok"], kategori_id: Kategori.withID(satir["kategori_id"]), resim_adresi: satir["resim_adresi"]);
     });

  }

  Future<List<Urun>>UrunKategori(int kategoriID)async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.query("urunler",where: "kategori_id= ?",whereArgs: [kategoriID]);


    return List.generate(maps.length, (i) {
      var satir=maps[i];
      return Urun(urun_id: satir["urun_id"], urun_adi: satir["urun_adi"], urun_fiyat: satir["urun_fiyati"], urun_stok: satir["urun_stok"], kategori_id: Kategori.withID(satir["kategori_id"]), resim_adresi: satir["resim_adresi"]);
    });

  }



  Future<List<Favori>> favoriYukle()async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT favoriler.favori_id, favoriler.kullanici_id, favoriler.urun_id, urunler.urun_adi, urunler.resim_adresi FROM favoriler JOIN urunler ON favoriler.urun_id = urunler.urun_id",);

    return List.generate(maps.length, (i) {
      var satir=maps[i];
      return Favori(favori_id: satir["favori_id"], kullanici_id: satir["kullanici_id"], urun_id: satir["urun_id"],name: satir["urun_adi"],resim_adresi: satir["resim_adresi"]);
    });
  }

  Future<void> favoriEkle(int urunId,int musteriId)async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    var yenifavori = <String, dynamic>{};
    yenifavori["kullanici_id"]=musteriId;
    yenifavori["urun_id"]=urunId;
    db.insert("favoriler", yenifavori);
  }

  Future<void>favorisilme(int id)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("favoriler",where: "favori_id= ?",whereArgs: [id]);
  }




  Future<List<Siparis>> siparisleriYukle()async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT siparisler.siparis_id, siparisler.urun_id, siparisler.musteri_id, siparisler.siparis_adeti, siparisler.siparis_tarihi, urunler.urun_adi, urunler.resim_adresi FROM siparisler JOIN urunler ON siparisler.urun_id = urunler.urun_id");

    return List.generate(maps.length, (i) {
      var satir=maps[i];
      return Siparis(siparis_id: satir["siparis_id"], urun_id: satir["urun_id"], musteri_id: satir["musteri_id"], siparis_adeti: satir["siparis_adeti"], siparis_tarihi: satir["siparis_tarihi"],isim: satir["urun_adi"],resim_yolu: satir["resim_adresi"]);
    });
  }


  Future<void> urunEkle(int urunId,int musteriId,int adet,DateTime siparisTarihi)async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    var yenisiparis = <String, dynamic>{};
    yenisiparis["urun_id"]=urunId;
    yenisiparis["musteri_id"]=musteriId;
    yenisiparis["siparis_adeti"]=adet;
    yenisiparis["siparis_tarihi"]=siparisTarihi.toString();


    db.insert("siparisler", yenisiparis);
  }


  Future<void>siparisSilme(int id)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("siparisler",where: "siparis_id= ?",whereArgs: [id]);
  }

 /* Future<List<Urun>>urunArama(String arama)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>>maps= await db.rawQuery("SELECT*FROM urunler WHERE urun_adi like '%$arama%'",);

    return List.generate(maps.length, (index){
      var satir=maps[index];
      return Urun(urun_id: satir["urun_id"], urun_adi: satir["urun_adi"], urun_fiyat: satir["urun_fiyat"], urun_stok: satir["urun_stok"], kategori_id: Kategori.withID(satir["kategori_id"]), resim_adresi: satir["resim_adresi"]);
    });
  }
*/


  Future<List<Urun>>urunAramaSayfa(String arama)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>>maps= await db.rawQuery("SELECT*FROM urunler WHERE urun_adi like '%$arama%'");

    return List.generate(maps.length, (index){
      var satir=maps[index];
      return Urun(urun_id: satir["urun_id"], urun_adi: satir["urun_adi"], urun_fiyat: satir["urun_fiyat"], urun_stok: satir["urun_stok"], kategori_id: Kategori.withID(satir["kategori_id"]), resim_adresi: satir["resim_adresi"]);

    });
  }

}