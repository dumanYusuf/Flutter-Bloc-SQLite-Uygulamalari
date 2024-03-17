import 'package:e_ticaret/cubbit/elektronikCubit.dart';
import 'package:e_ticaret/cubbit/favoriCubit.dart';
import 'package:e_ticaret/cubbit/sepet_cubit.dart';
import 'package:e_ticaret/cubbit/urunlerCubit.dart';
import 'package:e_ticaret/cubbit/yeniSayfaCubbit.dart';
import 'package:e_ticaret/model/kategori.dart';
import 'package:e_ticaret/views/yeniSayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubbit/kategoriler_cubit.dart';
import '../model/urunler.dart';
import 'detaySayfa.dart';


class UrunlerSayfa extends StatefulWidget {

  @override
  State<UrunlerSayfa> createState() => _UrunlerSayfaState();
}

class _UrunlerSayfaState extends State<UrunlerSayfa> {


  @override
  void initState() {
    super.initState();
    context.read<UrunlerCubit>().urunleriYukle();
    context.read<KategorilerCubit>().kategorileriGetir();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex:1,child: BlocBuilder<KategorilerCubit, List<Kategori>>(
            builder: (context, kategoriler) {
          if (kategoriler.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: kategoriler.length,
                itemBuilder: (context, index) {
                  var oAnkiKategori = kategoriler[index];
                  return _buildListItem(oAnkiKategori);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })),
        Expanded(
          flex: 6,
          child: BlocBuilder<UrunlerCubit, List<Urun>>(
            builder: (context, urunlerListesi) {
              if (urunlerListesi.isNotEmpty) {
                // List<Urun> urunlerListesi=snapshot.data!;
                return GridView.builder(
                    itemCount: urunlerListesi.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 350,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      var oankiUrun = urunlerListesi[index];
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetaySayfa(urun: oankiUrun,)));
                        },
                        child: Card(
                          elevation: 2,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 100,child: Image.network("${oankiUrun.resim_adresi}",fit: BoxFit.contain,)),
                                    Text("${oankiUrun.urun_adi}",style: TextStyle(fontSize: 20),),
                                    Text("${oankiUrun.urun_fiyat} TL",style: TextStyle(fontSize: 20),),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: (){
                                              context.read<SepetCubit>().SepeturunEkle(oankiUrun.urun_id, 1, 1, DateTime.now());
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      elevation: 4,
                                                      backgroundColor: Colors.grey,
                                                      duration: Duration(seconds: 2),
                                                      content: Text(oankiUrun.urun_adi+" sepet sayfasına eklendi",
                                                        style: TextStyle(fontSize: 24),
                                                      )
                                                  )
                                              );
                                            },
                                            child: Text("Sepete Ekle",style: TextStyle(fontSize: 18),)),
                                        IconButton(onPressed: (){
                                          context.read<FavoriCubit>().favoriEkle(oankiUrun.urun_id,1);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              elevation: 4,
                                              backgroundColor: Colors.grey,
                                              duration: Duration(seconds: 2),
                                                content: Text(oankiUrun.urun_adi+" favoriler sayfasına eklendi",
                                                  style: TextStyle(fontSize: 24),
                                                )
                                            )
                                          );
                                        },
                                            icon: Icon(Icons.favorite_outline
                                        )
                                        )
                                      ],
                                    )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildListItem(Kategori oAnkiKategori) {
    return BlocBuilder<ElektronikCubit,List<Urun>>(
      builder: (context, state) {
        return TextButton(
            onPressed: (){
              setState(() {
                int kategoriId=oAnkiKategori.kategori_id;
            //  context.read<ElektronikCubit>().ayir(oAnkiKategori.kategori_id);
                context.read<YeniSayfaCubbit>().urunleriYukle();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>YeniSayfa(kategoriID: kategoriId)));
              });
            },
            child: Text(oAnkiKategori.kategori_adi ?? "a"),

        );
      },
    );
  }
}
