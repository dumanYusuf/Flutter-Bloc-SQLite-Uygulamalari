
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notdefteri_flutter/cubbit/anaSayfaCubbit.dart';
import 'package:notdefteri_flutter/cubbit/guncelleCubbit.dart';
import 'package:notdefteri_flutter/data/model/notlar.dart';

class GuncelleSayfa extends StatefulWidget {

  Notes  notes;
  GuncelleSayfa({required this.notes});

  @override
  State<GuncelleSayfa> createState() => _GuncelleSayfaState();
}

class _GuncelleSayfaState extends State<GuncelleSayfa> {

  var notBaslik=TextEditingController();
  var notIcerik=TextEditingController();

  @override
  void initState() {
    super.initState();
    var notes=widget.notes;
    notBaslik.text=notes.baslik;
    notIcerik.text=notes.icerik;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guncelle"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(controller:notBaslik,decoration: InputDecoration(hintText: "başlık"),),
          TextField(controller:notIcerik,decoration: InputDecoration(hintText: "icerik"),),

          ElevatedButton(
              onPressed: (){
                    context.read<GuncelleCubit>().guncelle(widget.notes.id!,notBaslik.text ,notIcerik.text);
                    Navigator.pop(context);
                    context.read<AnaSayfaCubbit>().notlariYukle();
              },
              child: Text("Güncelle")
          )
        ],
      ),),
    );
  }
}
