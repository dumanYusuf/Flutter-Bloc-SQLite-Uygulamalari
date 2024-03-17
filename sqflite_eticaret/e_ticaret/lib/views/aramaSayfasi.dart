import 'package:e_ticaret/cubbit/aramaSayfaCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubbit/favoriCubit.dart';
import '../cubbit/sepet_cubit.dart';
import '../cubbit/urunlerCubit.dart';
import '../model/urunler.dart';
import 'detaySayfa.dart';

class AramaSayfasi extends StatefulWidget {
  const AramaSayfasi({super.key});

  @override
  State<AramaSayfasi> createState() => _AramaSayfasiState();
}



class _AramaSayfasiState extends State<AramaSayfasi> {

 final _controller=TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<AramaSayfaCubit>().aramaSayfa(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:TextField(
          controller: _controller,
          onChanged: (aramasonucu) {
            context.read<AramaSayfaCubit>().aramaSayfa(aramasonucu);
          },

          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Ürün arayın",
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        //bottom: PreferredSize(child: PreferredSizeWidget(),),
      ),
      body:  BlocBuilder<AramaSayfaCubit, List<Urun>>(
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
                            Text("${oankiUrun.urun_stok} TL",style: TextStyle(fontSize: 20),),
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
            return Center(child: Text("Aradığınız ürün bulunamadı",style: TextStyle(fontSize: 24),),);
          }
        },
      ),
    );
  }
}
