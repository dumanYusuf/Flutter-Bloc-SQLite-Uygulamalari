import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notdefteri_flutter/cubbit/anaSayfaCubbit.dart';
import 'package:notdefteri_flutter/data/model/notlar.dart';
import 'package:notdefteri_flutter/views/guncelleSayfa.dart';

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

   bool aramaYapiliyormu=false;

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubbit>().notlariYukle();

  }

  @override
  Widget build(BuildContext context) {
    var titleController=TextEditingController();
    var contentController=TextEditingController();

    Future<void>kaydet(String baslik,String icerik)async{
      print("not kaydedildi $baslik");
    }

    return Scaffold(
      appBar: AppBar(title: aramaYapiliyormu ?
      TextField(
        decoration: InputDecoration(hintText: "ara"),
        onChanged: (aramasonucu){
          context.read<AnaSayfaCubbit>().ara(aramasonucu).then((value) {
           // print("arama sonucu $value");
          });
        },
      ):
       Text("Notlar"),
        actions: [
          aramaYapiliyormu ?
          IconButton(
            onPressed: (){
              setState(() {
                aramaYapiliyormu=false;
              });
              context.read<AnaSayfaCubbit>().notlariYukle();
            },

            icon: Icon(Icons.clear,size: 30,),
          ):
          IconButton(
            onPressed: (){
              setState(() {
                aramaYapiliyormu=true;
              });
            },
            icon: Icon(Icons.search,size: 30,),
          )
        ],),
     body: BlocBuilder<AnaSayfaCubbit,List<Notes>>(
       builder: (context,notlarListesi){
         if(notlarListesi.isNotEmpty){
           return ListView.builder(
             itemCount: notlarListesi.length,
               itemBuilder: (context,index){
                var notum=notlarListesi[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GuncelleSayfa(notes: notum,))).then((value) {
                      context.read<AnaSayfaCubbit>().notlariYukle();
                    });
                  },
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(notum.baslik,style: TextStyle(fontSize: 24),),
                      subtitle: Text(notum.icerik),
                      trailing: IconButton(
                          onPressed: (){
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 duration: Duration(seconds: 2),
                                   content:Text("${notum.baslik} notunuz silinsin mi?"),
                                 action: SnackBarAction(
                                   label: "Evet",
                                   onPressed: (){
                                     context.read<AnaSayfaCubbit>().sil(notum.id);
                                     context.read<AnaSayfaCubbit>().notlariYukle();

                                   },
                                 ),
                               )
                           );
                          },
                          icon: Icon(Icons.delete)
                      ),
                    ),
                  ),
                );
               }
           );
         }
         else{
           return const Center(child: Text("veri yok"),);
         }
       },
     ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          buildEkle(context, titleController, contentController, kaydet);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void buildEkle(BuildContext context, TextEditingController titleController, TextEditingController contentController, Future<void> kaydet(String baslik, String icerik)) {
      showDialog(
      context:context ,
      builder:(contex){
        return AlertDialog(
          title: Text('Not Ekle'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Başlık'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'İçerik'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                    kaydet(titleController.text, contentController.text);
                    context.read<AnaSayfaCubbit>().kaydet(titleController.text, contentController.text);
                    Navigator.pop(context);
                    context.read<AnaSayfaCubbit>().notlariYukle();//.THENİ KULLANDIK ARAYÜüzü güncellemeden eklediğimiz not direk kaydoldu


        },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }
}



