import 'package:filimler_uygulamasi/cubbit/ekleSayfaCubbit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Ekle extends StatefulWidget {
  const Ekle({super.key});

  @override
  State<Ekle> createState() => _EkleState();
}

  var filmad=TextEditingController();
  var filmfiyat=TextEditingController();
class _EkleState extends State<Ekle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ekle Sayya"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: filmad,
              decoration: InputDecoration(hintText: "film ad"),
            ),
            TextFormField(
              controller: filmfiyat,
              decoration: InputDecoration(hintText: "film fiyat"),
            ),
            ElevatedButton(
                onPressed: (){
                  context.read<EkleSayfaCubit>().kaydet(filmad.text,filmfiyat.text);
                },
                child: Text("Kaydet")
            )
          ],
        ),
      ),
    );
  }
}
