import 'package:e_ticaret/cubbit/elektronikCubit.dart';
import 'package:e_ticaret/cubbit/favoriCubit.dart';
import 'package:e_ticaret/cubbit/sepet_cubit.dart';
import 'package:e_ticaret/cubbit/yeniSayfaCubbit.dart';
import 'package:e_ticaret/model/urunler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YeniSayfa extends StatefulWidget {

  final int kategoriID;
   YeniSayfa({required this.kategoriID});

  @override
  State<YeniSayfa> createState() => _YeniSayfaState();
}

class _YeniSayfaState extends State<YeniSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<ElektronikCubit>().ayir(widget.kategoriID);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElektronikCubit, List<Urun>>(
      builder: (context, urunlerListesi) {
        if (urunlerListesi.isNotEmpty) {
          return GridView.builder(
              itemCount: urunlerListesi.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 457,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                var oankiUrun = urunlerListesi[index];
                return Card(
                  elevation: 2,
                  child: Container(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 130,),
                        Image.network("${oankiUrun.resim_adresi}",fit: BoxFit.contain,),
                            Text("${oankiUrun.urun_adi}",style: TextStyle(fontSize: 20),),
                            Text("${oankiUrun.urun_fiyat} TL",style: TextStyle(fontSize: 20),),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      context.read<SepetCubit>().SepeturunEkle(oankiUrun.urun_id, 1, 1, DateTime.now());
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          duration: Duration(seconds: 4),
                                            content: Text("${oankiUrun.urun_adi} sepete eklendi")),
                                      );
                                    },
                                    child: Text("Sepete Ekle",style: TextStyle(fontSize: 18),)),
                                IconButton(onPressed: (){
                                  context.read<FavoriCubit>().favoriEkle(oankiUrun.urun_id, 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        duration: Duration(seconds: 4),
                                        content: Text("${oankiUrun.urun_adi} favorilere eklendi")),
                                  );
                                },
                                    icon: Icon(Icons.favorite_outline,size: 30,))
                              ],
                            )
                          ],
                    ),
                  ),
                );
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
