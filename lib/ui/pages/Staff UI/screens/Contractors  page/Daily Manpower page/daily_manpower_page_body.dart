// ignore_for_file: deprecated_member_use, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/resource_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Contractors_page_bloc/daily_manpower_page_bloc.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/resource_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
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
  ResourceTypeDropdownBloc resourceTypeDropdownBloc;

  ItemCostCenter selectItemCostCenter;
  ResourceType selectResourceType;
  DepartmentName selectDepartmentName;
  bool issucceed = false;
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
    resourceTypeDropdownBloc = ResourceTypeDropdownBloc();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    super.initState();
  }

  void clearData() {
    setState(() {
      selectItemCostCenter = null;
      selectResourceType = null;
      selectDepartmentName = null;
      dateInput.clear();
      _qty.clear();
      _remarks.clear();
    });
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (selectDepartmentName != null &&
          selectItemCostCenter != null &&
          selectResourceType != null &&
          dailyManPowerFormKey.currentState.validate()) {
        sendData(
            dateInput.text,
            selectDepartmentName.Name,
            selectItemCostCenter.strSubCode,
            selectResourceType.Name,
            _qty.text,
            _remarks.text);
      } else {
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
    } else {
      Scaffold.of(context).showSnackBar(snackBar(internetFailedConnectionText));
    }
  }

  Future<dynamic> sendData(
      String intendDate,
      String partyNameSubCode,
      String costCenterSubCode,
      String resourceTypeSubCode,
      String reqQty,
      String remarks) async {
    try {
      var url = Uri.parse(
          "http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostDRM?StrRecord=${'{"StrVType":"DRME",'
              '"StrVDate":"${dateInput.text}","StrSiteCode":"AD","StrRemark":"${_remarks.text}","StrPreparedBy":"SA",StrDRMGrid:[{"StrCostcenter":"${selectItemCostCenter.strSubCode}",'
              '"DblQty":"${_qty.text}","StrParty":"${selectDepartmentName.subCode}","StrItem":"${selectResourceType.SearchCode}","StrRemark":"${_remarks.text}"}]}'}");
      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        issucceed = true;
        final String responseString = response.body;
        print('Response Body: ${responseString}');
        return Scaffold.of(context).showSnackBar(snackBar(responseString));
      } else {
        return Scaffold.of(context).showSnackBar(snackBar("Not Succeed"));
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ContractorProvider.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                      onPressed: () {
                        clearData();
                      },
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadTextNew("Date", width * .045),
              Container(
                padding: dateFieldPadding,
                height: height * .09,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if (val != dateInput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dateInput,
                  decoration: dateFieldDecoration(),
                  readOnly: true,
                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat(/*'dd-MM-yyyy'*/ 'yyyy-MM-dd')
                              .format(pickedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              //sizedbox1,
              formsHeadTextNew("Party Name", width * .045),
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
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                ),
                                padding: selectDepartmentName != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectDepartmentName,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<DepartmentName>>(
                                            (e) {
                                      return DropdownMenuItem<DepartmentName>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Name ?? ""),
                                        ),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),

              sizedbox1,
              formsHeadTextNew("Phase (cost center)", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc
                          .costCenterDailyManpowerData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc
                                .selectedCostCenterDailyManpowerState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                ),
                                padding: selectItemCostCenter != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Name ?? ""),
                                        ),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadTextNew("Resource Type", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ResourceType>>(
                      future: resourceTypeDropdownBloc.resourceTypeData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ResourceType>(
                            stream: resourceTypeDropdownBloc
                                .selectedResourceTypeState,
                            builder: (context, item) {
                              return SearchChoices<ResourceType>.single(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                ),
                                padding: selectResourceType != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectResourceType,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ResourceType>>(
                                            (e) {
                                      return DropdownMenuItem<ResourceType>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Name),
                                        ),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadTextNew("Qty.", width * .045),
              Container(
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outTextField1,
                  builder: (context, snapshot) => TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Detail';
                      }
                      if (val != _qty.text) {
                        return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                            ? null
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
              sizedbox1,
              formsHeadTextNew("Remarks", width * .045),
              Container(
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outTextField2,
                  builder: (context, snapshot) => TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Detail';
                      }
                      if (val != _remarks.text) {
                        return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                            ? null
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
              //sizedbox1,
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Submit", () {
                    verifyDetail();
                    if(issucceed == true) {
                      clearData();
                    }else{}
                    issucceed = false;
                  }, roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}
