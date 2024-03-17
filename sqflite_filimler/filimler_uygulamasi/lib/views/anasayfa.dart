import 'package:filimler_uygulamasi/cubbit/anasayfaCubit.dart';
import 'package:filimler_uygulamasi/views/detaySayfa.dart';
import 'package:filimler_uygulamasi/views/ekleSayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/filimler.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().filimleriYukle();
  }

  bool aramaYapiliyormu=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(title: aramaYapiliyormu ?
           TextField(
             decoration: InputDecoration(hintText: "ara"),
             onChanged: (aramasonucu){
               context.read<AnaSayfaCubit>().ara(aramasonucu);
             },
           ):
             Text("Filimler"),
         actions: [
           aramaYapiliyormu ?
           IconButton(
               onPressed: (){
                setState(() {
                  aramaYapiliyormu=false;
                });
                context.read<AnaSayfaCubit>().filimleriYukle();
               },

               icon: Icon(Icons.clear),
           ):
               IconButton(
                   onPressed: (){
                    setState(() {
                      aramaYapiliyormu=true;
                    });

                   },
                   icon: Icon(Icons.search),
               )
         ],),
      body: BlocBuilder<AnaSayfaCubit,List<Filimler>>(
       // future: filmleriYukle(),
        builder: (context,filmlerListesi){
            if(filmlerListesi.isNotEmpty){
              return ListView.builder(
                itemCount: filmlerListesi.length,
                  itemBuilder: (context,index){
                    var film=filmlerListesi[index];
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetaySayfa(filmler:film)));
                      },
                      child: Card(
                        elevation: 3,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                                height: 100,
                                child: Image.asset("assets/${film.filmResim}")),
                            Column(
                              children: [
                                Text(film.filmAdi,style: TextStyle(fontSize: 24),),
                                Row(
                                  children: [
                                    Text("${film.filmFiyat} tl",style: TextStyle(fontSize: 24),),
                                    IconButton(
                                        onPressed: (){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("${film.filmID} silinsin mi?"),
                                                action: SnackBarAction(
                                                  label:"Evet",
                                                  onPressed: (){
                                                    context.read<AnaSayfaCubit>().sil(film.filmID);
                                                    print("silindi");
                                                  },
                                                ),
                                              )
                                          );
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                                  ],
                                ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
            else{
            return const Center(child: Text("Aradığınız Film Bulunamadı",style: TextStyle(fontSize: 24),),);
            }
        },
      ),

    /*  floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Ekle()));
          }
      ),
*/
    );
  }
}
