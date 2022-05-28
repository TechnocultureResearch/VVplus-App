import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indent_no_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indent_selection_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/indent_selection_model.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/material_request_approval/forms_container_data.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:http/http.dart' as http;

import '../../../../../../domain/common/snackbar_widget.dart';
import '../../../../../../infrastructure/Models/indent_no_model.dart';
import '../../../../../widgets/Utilities/rounded_button.dart';
import '../../../../../widgets/constants/colors.dart';

class MaterialRequestApprovalBody extends StatefulWidget{
  const MaterialRequestApprovalBody({Key key}) : super(key: key);
  @override
  State<MaterialRequestApprovalBody> createState() => MyMaterialRequestApprovalBody();
}
class MyMaterialRequestApprovalBody extends State<MaterialRequestApprovalBody> {
  bool isActive = false;
  bool pressed = false;
  TextEditingController dateinput = TextEditingController();
  final materialRequestApprovalFormKey = GlobalKey<FormState>();
  IndentorNameDropdownBloc _dropdownBloc;
  IndentNoDropdownBloc indentNoDropdownBloc;
  bool pressAttention = false;
  Future<List<dynamic>> futureList;
  List<String> itemList = [];

  @override
  void initState() {
    futureList =  getIndentItemData();
    dateinput.text = "";
    // _dropdownBloc = IndentorNameDropdownBloc();
    indentNoDropdownBloc = IndentNoDropdownBloc();
    super.initState();
  }


  Future<List<dynamic>> getIndentItemData() async{
    if(selectIndentNo!= null){
      try{
        var url = Uri.parse('http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndentApproval?StrRecord=${'{"StrFilter":"FillGrid","StrSiteCode":"AD","StrV_Date":"2022-05-27",StrIndDocID:[{"StrDocID":""},{"StrDocID":""}]}'}');
        final response = await http.get(url);
        final List<dynamic> items = json.decode(response.body);
        // final items = (jsonDecode(response.body) as List)
        // .map((e) => IndentorName.fromJson(e))
        //     .toList();
        print('Response Status: ${response.statusCode}');
        print('Response Body: $items');
        return items ;
      }catch(e){
        rethrow;
      }
    }
    // else{
    //    print("Please select indent No");
    // }
  }
  // IndentorName selectIndentorName;
  IndentNo selectIndentNo;
  void onDataChange1(IndentNo state) {
    setState(() {
      futureList = getIndentItemData();
      selectIndentNo = state;
    });
  }
  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Form(
          key: materialRequestApprovalFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              sizedbox1,
              formsHeadText("Indant Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if(val != dateinput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dateinput,
                  decoration: dateFieldDecoration(),
                  readOnly: true,
                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {
                    }
                  },
                ),
              ),
              formsHeadText("Indant No"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IndentNo>>(
                      future: indentNoDropdownBloc.indentNoMaterialRequestApproveDropdowndata,
                      builder: (context, snapshot) {
                        return StreamBuilder<IndentNo>(
                            stream: indentNoDropdownBloc.selectedIndentNoMaterialReqApprovState,
                            builder: (context, item) {
                              return SearchChoices<IndentNo>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectIndentNo!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentNo,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<IndentNo>>((e) {
                                  return DropdownMenuItem<IndentNo>(
                                    value: e,
                                    child: Text(e.StrDocID ?? ''),
                                  );
                                })?.toList() ??[],
                              );
                            }
                        );
                      }
                  ),
                ),
              ),
              SizedBox(height: 10,),
              StreamBuilder(
                stream: getIndentItemData().asStream(),
    builder: (context, snapshot){
    if(snapshot.hasData){
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder:(context, index){
          return Card(
child: ListTile(
  leading: Text(snapshot.data[index]['Item']),
),
          );
          }
        ),
      );
//         return Column(
//           children:<Widget>[
//               ListView.builder(
//                 shrinkWrap: true,
//                  itemExtent: snapshot.data.length,
//       itemBuilder: (context, index) =>
//                 SingleChildScrollView( scrollDirection: Axis.vertical,
//                   child: Card(elevation:5.0,margin:  EdgeInsets.symmetric(vertical: 1,horizontal: 6),
//   child: ListTile(
//   leading: Text(snapshot.data[index]['Item']),
//
// ),
//                   ),
//                 )
//
//                ),
//           ]
//         );
    }
    else{
      return
      Center(child: CircularProgressIndicator());}
    }
              ),
              // const InformationBoxContainer1(),
              //SizedBox(height: 10,),
              //const InformationBoxContainer1(),
              // const MaterialApprovalPageContainerData(),
              sizedbox1,
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Approve",(){

                  },roundedButtonHomeColor1)),
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Deny",(){},roundedButtonHomeColor2)),
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Wait",(){},roundedButtonHomeColor3)),
            ],
          ),
        ),
      ),
    );
  }
}