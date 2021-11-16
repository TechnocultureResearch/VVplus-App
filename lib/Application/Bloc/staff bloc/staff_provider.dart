import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/staff_bloc.dart';

class MaterialProvider extends InheritedWidget{
  final StaffBloc bloc;

  MaterialProvider({Key key, Widget child})
      :bloc = StaffBloc(),
        super(key : key, child : child);

  bool updateShouldNotify(_) => true;

  static StaffBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<MaterialProvider>() as MaterialProvider)
        .bloc;
  }

}