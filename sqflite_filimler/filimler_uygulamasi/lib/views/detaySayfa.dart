import 'package:filimler_uygulamasi/data/model/filimler.dart';
import 'package:flutter/material.dart';

class DetaySayfa extends StatefulWidget {

  Filimler filmler;
  DetaySayfa({required this.filmler});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.filmler.filmAdi),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Image.asset("assets/${widget.filmler.filmResim}"),
      SizedBox(height: 100,),
      Text(widget.filmler.filmAdi,style: TextStyle(fontSize: 24,color: Colors.black),),
        ],
      ),),
    );
  }
}
