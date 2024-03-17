import 'package:e_ticaret/cubbit/anaSayfaCubit.dart';
import 'package:e_ticaret/cubbit/bottomNavigatorBarindexCubbit.dart';
import 'package:e_ticaret/views/favarilerSayfa.dart';
import 'package:e_ticaret/views/sapetSayfa.dart';
import 'package:e_ticaret/views/urunlerSayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'aramaSayfasi.dart';


class AnaSayfa extends StatefulWidget {
  // const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  int secilenmenuitem = 0;
  late List<Widget>tumsayfalar;
  late UrunlerSayfa urunlerSayfa;
  late FavarilerSayfa favarilerSayfa;
  late SepetSayfa sepetSayfa;

  @override
  void initState() {
    super.initState();
    urunlerSayfa = UrunlerSayfa();
    favarilerSayfa = FavarilerSayfa();
    sepetSayfa = const SepetSayfa();

    tumsayfalar = [urunlerSayfa, favarilerSayfa, sepetSayfa];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<BottomNavigatorBarIndexCubbit, int>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AramaSayfasi()));
                    },
                    icon: Icon(Icons.search,size: 30,)
                ),
                FlutterLogo(size: 30,)
              ],
            );
          },
        ),
        //bottom: PreferredSize(child: PreferredSizeWidget(),),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigatorBarIndexCubbit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "AnaSayfa",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: "Favoriler",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket), label: "Sepet",
              )
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: state,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              context.read<BottomNavigatorBarIndexCubbit>()
                  .changecurrrentIndex(index);
            },
          );
        },
      ),
      body: BlocBuilder<BottomNavigatorBarIndexCubbit, int>(
          builder: (context, index) {
            return tumsayfalar[index];
          }

      ),
    );
  }
}
