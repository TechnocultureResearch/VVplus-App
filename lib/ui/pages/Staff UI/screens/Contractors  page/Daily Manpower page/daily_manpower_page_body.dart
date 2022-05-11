// ignore_for_file: deprecated_member_use, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/resource_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Contractors_page_bloc/daily_manpower_page_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/resource_type_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/Dropdown/material_request_entry_data_dropdown.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class DailyManpowerBody extends StatefulWidget {
  const DailyManpowerBody({Key key}) : super(key: key);
  @override
  State<DailyManpowerBody> createState() => MyDailyManpowerBody();
}
class MyDailyManpowerBody extends State<DailyManpowerBody> {

  TextEditingController dateInput = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final dailyManPowerFormKey = GlobalKey<FormState>();

  DepartmentNameDropdownBloc departmentNameDropdownBloc;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;
  // VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  ResourceTypeDropdownBloc resourceTypeDropdownBloc;

  ItemCostCenter selectItemCostCenter;
  // VoucherType selectVoucherType;
  ResourceType selectResourceType;
  DepartmentName selectDepartmentName;

  var subscription;
  var connectionStatus;

  void onDataChange1(ResourceType state) {
    setState(() {
      selectResourceType = state;
    });
  }
  void onDataChange2(DepartmentName state) {
    setState(() {
      selectDepartmentName = state;
    });
  }
  void onDataChange3(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter = state;
    });
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  void initState() {
    dateInput.text = "";
    departmentNameDropdownBloc = DepartmentNameDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    // voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    resourceTypeDropdownBloc = ResourceTypeDropdownBloc();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => connectionStatus = result );
    });
    super.initState();
  }
  void clearData(){
   selectItemCostCenter = null;
   selectResourceType = null;
   selectDepartmentName = null;
    dateInput.clear();
    _qty.clear();
    _remarks.clear();
  }
  verifyDetail(){
    if(connectionStatus == ConnectivityResult.wifi || connectionStatus == ConnectivityResult.mobile){
      if(selectDepartmentName!=null && selectItemCostCenter!=null && selectResourceType!=null && dailyManPowerFormKey.currentState.validate()){
        sendData(dateInput.text,selectDepartmentName.strSubCode,selectItemCostCenter.strSubCode,selectResourceType.Name,_qty.text,_remarks.text);
      }
      else{
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
    }
    else{
      Scaffold.of(context).showSnackBar(snackBar(internetFailedConnectionText));
    }
    }

  Future<dynamic> sendData(String intendDate, String partyNameSubCode, String costCenterSubCode, String resourceTypeSubCode, String reqQty, String remarks) async{
    try {
      await http.post(Uri.parse(ApiService.mockDataPostDailyManPowerURL),
          body: json.encode({
            "IntendDate": intendDate,
            "PartyNameSubCode": partyNameSubCode,
            "CostCenterSubCode": costCenterSubCode,
            "ResourceTypeSubCode": resourceTypeSubCode,
            "ReqQty": reqQty,
            "Remarks": remarks
          }));
      Scaffold.of(context).showSnackBar(snackBar(sendDataText));
    } on SocketException {
      Scaffold.of(context).showSnackBar(snackBar(socketExceptionText));
    } on HttpException {
      Scaffold.of(context).showSnackBar(snackBar(httpExceptionText));
    } on FormatException {
      Scaffold.of(context).showSnackBar(snackBar(formatExceptionText));
    }
  }

  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ContractorProvider.of(context);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Form(
          key: dailyManPowerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: paddingForms2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () {clearData();},
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadText("Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if(val != dateInput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dateInput,
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
                        dateInput.text = formattedDate;
                      });
                    } else {
                    }
                  },
                ),
              ),
              //sizedbox1,
              formsHeadText("Party Name"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<DepartmentName>>(
                      future: departmentNameDropdownBloc.departmentNameData,
                      builder: (context, snapshot) {
                        return StreamBuilder<DepartmentName>(
                            stream: departmentNameDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<DepartmentName>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size: 30,),
                                padding: selectDepartmentName!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                isCaseSensitiveSearch: true,
                                value: selectDepartmentName,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<DepartmentName>>((e) {
                                  return DropdownMenuItem<DepartmentName>(
                                    value: e,
                                    child: Text(e.Name),
                                  );
                                })?.toList() ??[],
                              );
                            }
                        );
                      }
                  ),
                ),
              ),
              sizedbox1,
              formsHeadText("Phase (cost center)"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc.costCenterDailyManpowerData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc.selectedCostCenterDailyManpowerState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size: 30,),
                                padding: selectItemCostCenter!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<ItemCostCenter>>((e) {
                                  return DropdownMenuItem<ItemCostCenter>(
                                    value: e,
                                    child: Text(e.Name),
                                  );
                                })?.toList() ??[],
                              );
                            }
                        );
                      }
                  ),
                ),
              ),
              sizedbox1,
              formsHeadText("Resource Type"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ResourceType>>(
                      future: resourceTypeDropdownBloc.resourceTypeData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ResourceType>(
                            stream: resourceTypeDropdownBloc.selectedResourceTypeState,
                            builder: (context, item) {
                              return SearchChoices<ResourceType>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size: 30,),
                                padding: selectResourceType!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectResourceType,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<ResourceType>>((e) {
                                  return DropdownMenuItem<ResourceType>(
                                    value: e,
                                    child: Text(e.Name),
                                  );
                                })?.toList() ??[],
                              );
                            }
                        );
                      }
                  ),
                ),
              ),
              sizedbox1,
              formsHeadText("Qty."),
              Container(
                height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  width: 320,
                  child: StreamBuilder<String>(
                    stream: bloc.outTextField1,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if(val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if(val != _qty.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val) ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: _qty,
                      onChanged: bloc.inTextField1,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColor8,
                          enabledBorder: textFieldBorder(),
                          focusedBorder: textFieldBorder(),
                          errorText: snapshot.error,
                        errorBorder: textFieldBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      style: simpleTextStyle7(),
                    ),
                  ),
                ),
              ),
              //sizedbox1,
              formsHeadText("Remarks"),
              Container(
                height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  width: 320,
                  child: StreamBuilder<String>(
                    stream: bloc.outTextField2,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if(val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if(val != _remarks.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val) ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: _remarks,
                      onChanged: bloc.inTextField2,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColor8,
                          enabledBorder: textFieldBorder(),
                          focusedBorder: textFieldBorder(),
                          errorText: snapshot.error,
                          errorBorder: textFieldBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      style: simpleTextStyle7(),
                    ),
                  ),
                ),
              ),
              //sizedbox1,
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Submit",(){
                    verifyDetail();
                    },roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}