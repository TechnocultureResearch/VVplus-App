import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/material_request_entry_page_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/Material_request_entry/material_request_entry_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class MaterialReqEntry extends StatelessWidget{
  const MaterialReqEntry({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialRequestEntryProvider(
      child:Scaffold(
        appBar: appBarSatff("Material Request Entry"),
        body:   const MaterialEntryBody(),
        // bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );

  }

}