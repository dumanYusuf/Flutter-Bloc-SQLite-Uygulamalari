import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigatorBarIndexCubbit  extends Cubit<int>{
  BottomNavigatorBarIndexCubbit():super(0);

  Future<void> changecurrrentIndex(int valu)async{
    emit(valu);
  }
}