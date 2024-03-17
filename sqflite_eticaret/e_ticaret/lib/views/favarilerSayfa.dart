import 'package:e_ticaret/cubbit/favoriCubit.dart';
import 'package:e_ticaret/model/favoriler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FavarilerSayfa extends StatefulWidget {

  @override
  State<FavarilerSayfa> createState() => _FavarilerSayfaState();
}

class _FavarilerSayfaState extends State<FavarilerSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriCubit>().favoriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriCubit,List<Favori>>(
        builder: (context, favoriuzunluk) {
          if(favoriuzunluk.isNotEmpty){
            return ListView.builder(
              itemCount: favoriuzunluk.length,
                itemBuilder: (context, index) {
                var currentElement = favoriuzunluk[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                       title: Text(currentElement.name.toString() ?? "A",),
                    leading: Image.network(currentElement.resim_adresi ?? "aa"),
                    trailing: IconButton(onPressed: (){
                      context.read<FavoriCubit>().favoriSil(currentElement.favori_id).then((value) {
                        context.read<FavoriCubit>().favoriYukle();
                        print("silme işlemi gerceklesti }");
                      });
                    },
                        icon: Icon(CupertinoIcons.clear)),
                  ),
                );
                },
            );
          }else{
            return Center(child: Text("favori Sayfanız bos",style: TextStyle(fontSize: 24),),);
          }
        },
    );
  }

}
