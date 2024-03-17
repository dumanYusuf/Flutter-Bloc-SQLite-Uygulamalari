
import '../data/model/notlar.dart';
import '../veritabani/dataHelper.dart';
class NotlarDao {
  /*Future<List<Notes>>notlariYukle()async{
    var notlarListesi=<Notes>[];
    var n1=Notes(baslik: "Spor", icerik: "spora basladım");
    var n2=Notes(baslik: "Genel", icerik: "genel sıkıntı");
    var n3=Notes(baslik: "Aile", icerik: "Ailemi severim");
    var n4=Notes(baslik: "Arkadaş", icerik: "arkadaş candır");
    var n5=Notes(baslik: "Ev", icerik: "ev güzel");
    var n6=Notes(baslik: "Araba", icerik: "bu sene mezun oolunca araba alıcam");
    var n7=Notes(baslik: "Arkadaş", icerik: "arkadaş candır");
    var n8=Notes(baslik: "Ev", icerik: "ev güzel");
    var n9=Notes(baslik: "Araba", icerik: "bu sene mezun oolunca araba alıcam");

    notlarListesi.add(n1);
    notlarListesi.add(n2);
    notlarListesi.add(n3);
    notlarListesi.add(n4);
    notlarListesi.add(n5);
    notlarListesi.add(n6);
    notlarListesi.add(n7);
    notlarListesi.add(n8);
    notlarListesi.add(n9);

    return notlarListesi; bu normal statik olarak veri ekledigimiz ve body kısmında
    future.builder ile ekranda gosterdigimiz kısım
  }*/

  Future<List<Notes>> notlariYukle() async {//bu fonksiyon ise artık veritabanındaki verileri getiriyor
  var db = await VeritabaniYardimcisi.veritabaniErisim();
  List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notdefteri");

  return List.generate(maps.length, (i) {
  var satir = maps[i];
  return Notes(id: satir["id"],baslik: satir["baslik"], icerik: satir["icerik"]);
       });
         }

   Future<void>kaydet(String baslik,String icerik)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    var yeniNot=Map<String,dynamic>();
    yeniNot["baslik"]=baslik;
    yeniNot["icerik"]=icerik;

    await db.insert("notdefteri", yeniNot);
   }


  Future<void>guncelle(int id,String baslik,String icerik)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    var guncelNot=Map<String,dynamic>();
    guncelNot["baslik"]=baslik;
    guncelNot["icerik"]=icerik;

    await db.update("notdefteri", guncelNot,where:"id= ?",whereArgs: [id] );
  }

  Future<void>sil(int? id)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
   await db.delete("notdefteri",where: "id= ?",whereArgs: [id]);
  }


  Future<List<Notes>> ara(String aramakelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notdefteri WHERE baslik like '%$aramakelimesi%' ");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Notes(baslik: satir["baslik"], icerik: satir["icerik"]);
    });
  }



  }




