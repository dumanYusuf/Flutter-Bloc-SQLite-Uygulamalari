import 'package:e_ticaret/cubbit/sepet_cubit.dart';
import 'package:e_ticaret/model/siparisler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  
  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().siparisleriYukle();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SepetCubit,List<Siparis>>(builder: (context,siparisler){
     if(siparisler.isNotEmpty){
       return ListView.builder(itemCount:  siparisler.length,itemBuilder: (context,index){
         var currentOrder = siparisler[index];
         return Card(
           elevation: 2,
           child: ListTile(
             title: Text("${currentOrder.isim}"),
             leading: Image.network(currentOrder.resim_yolu ?? "aa"),
             subtitle: Text(currentOrder.siparis_tarihi),
             trailing: IconButton(onPressed: (){
               context.read<SepetCubit>().sepetUrunSil(currentOrder.siparis_id).then((value) {
                 context.read<SepetCubit>().siparisleriYukle();
                 print("silme işlemi gercekleşti");
               });
             }, icon: Icon(Icons.clear)),
           ),
         );
       });
     }
     else{
       return Center(child: Text("Sepet Sayfanız boş ",style: TextStyle(fontSize: 24),),);
     }
    });
  }
}
