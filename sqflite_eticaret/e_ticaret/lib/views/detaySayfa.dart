import 'package:e_ticaret/model/urunler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetaySayfa extends StatefulWidget {

  Urun urun;
  DetaySayfa({required this.urun});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.urun.urun_adi),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 200,
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Image.network("${widget.urun.resim_adresi}",fit: BoxFit.contain,),
                  Column(
                    children: [
                      Text("${widget.urun.urun_adi}",style: TextStyle(fontSize: 20),),
                      SizedBox(height: 0,),
                      Text("${widget.urun.urun_fiyat} TL",style: TextStyle(fontSize: 20),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
