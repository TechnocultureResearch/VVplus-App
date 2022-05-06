// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class BranchtoBranchSendBody extends StatefulWidget {
  const BranchtoBranchSendBody({Key key}) : super(key: key);
  @override
  State<BranchtoBranchSendBody> createState() => MyBranchtoBranchSendBody();
}

class MyBranchtoBranchSendBody extends State<BranchtoBranchSendBody> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController reqQty = TextEditingController();
  final branchToBranchSendFormKey = GlobalKey<FormState>();

  VoucherTypeDropdownBloc voucherTypeDropdownBloc1;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc2;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc3;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc4;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc1;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc2;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc3;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc4;
  IndentorNameDropdownBloc indentorNameDropdownBloc;

  VoucherType selectVoucherType1;
  VoucherType selectVoucherType2;
  VoucherType selectVoucherType3;
  VoucherType selectVoucherType4;
  ItemCostCenter selectItemCostCenter1;
  ItemCostCenter selectItemCostCenter2;
  ItemCostCenter selectItemCostCenter3;
  ItemCostCenter selectItemCostCenter4;
  IndentorName selectIndentorName;

  var subscription;
  var connectionStatus;

  @override
  void initState() {
    voucherTypeDropdownBloc1 = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc2 = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc3 = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc4 = VoucherTypeDropdownBloc();
    itemCostCenterDropdownBloc1 = ItemCostCenterDropdownBloc();
    itemCostCenterDropdownBloc2 = ItemCostCenterDropdownBloc();
    itemCostCenterDropdownBloc3 = ItemCostCenterDropdownBloc();
    itemCostCenterDropdownBloc4 = ItemCostCenterDropdownBloc();
    indentorNameDropdownBloc = IndentorNameDropdownBloc();
    dateinput.text = "";
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void onDataChange1(VoucherType state) {
    setState(() {
      selectVoucherType1 = state;
    });
  }

  void onDataChange2(VoucherType state) {
    setState(() {
      selectVoucherType2 = state;
    });
  }

  void onDataChange3(VoucherType state) {
    setState(() {
      selectVoucherType3 = state;
    });
  }

  void onDataChange4(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter1 = state;
    });
  }

  void onDataChange5(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter2 = state;
    });
  }

  void onDataChange6(IndentorName state) {
    setState(() {
      selectIndentorName = state;
    });
  }

  void onDataChange7(VoucherType state) {
    setState(() {
      selectVoucherType4 = state;
    });
  }

  void onDataChange8(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter3 = state;
    });
  }

  void onDataChange9(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter4 = state;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (selectVoucherType1 != null &&
          selectItemCostCenter1 != null &&
          selectItemCostCenter2 != null &&
          selectVoucherType2 != null &&
          selectItemCostCenter3 != null &&
          selectItemCostCenter4 != null &&
          selectVoucherType3 != null &&
          selectIndentorName != null &&
          selectVoucherType4 != null &&
          branchToBranchSendFormKey.currentState.validate()) {
        sendData();
      } else {
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
    } else {
      Scaffold.of(context).showSnackBar(snackBar(internetFailedConnectionText));
    }
  }

  Future<dynamic> sendData() async {
    try {
      await http.post(Uri.parse(ApiService.mockDataPostBranchToBranchSend),
          body: json.encode({
            "Voucher Type": selectVoucherType1.strSubCode,
            "VoucherNoDate": dateinput.text,
            "FromBranch": selectItemCostCenter1.strSubCode,
            "FromPhase": selectItemCostCenter2.strSubCode,
            "FromGodown": selectVoucherType2.strSubCode,
            "ToBranch": selectItemCostCenter3.strSubCode,
            "ToPhase": selectItemCostCenter4.strSubCode,
            "ToGodown": selectVoucherType3.strSubCode,
            "VehicleNo": selectVoucherType4.strSubCode,
            "IndentSelection": selectIndentorName.strSubCode
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
          key: branchToBranchSendFormKey,
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
                        dateinput.clear();
                      },
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadText("Voucher Type"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc1.voucherTypeDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc1.selectedState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectVoucherType1 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType1,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("Voucher No. Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if (val != dateinput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dateinput,
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
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              formsHeadText("From Branch"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc1.itemCostCenterData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc1.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectItemCostCenter1 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter1,
                                displayClearIcon: false,
                                onChanged: onDataChange5,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("From Phase"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc2.itemCostCenterData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc2.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectItemCostCenter2 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter2,
                                displayClearIcon: false,
                                onChanged: onDataChange6,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("From Godown"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc2.voucherTypeDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc2.selectedState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                ),
                                padding: selectVoucherType2 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType2,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("To Branch"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc3.itemCostCenterData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc3.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectItemCostCenter3 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter3,
                                displayClearIcon: false,
                                onChanged: onDataChange8,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("To Phase"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc4.itemCostCenterData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc4.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectItemCostCenter4 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter4,
                                displayClearIcon: false,
                                onChanged: onDataChange9,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("To Godown"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc3.voucherTypeDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc3.selectedState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectVoucherType3 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType3,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("Vehicle No."),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc4.voucherTypeDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc4.selectedState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectVoucherType4 != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType4,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("Indent Selection"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IndentorName>>(
                      future: indentorNameDropdownBloc.indentorNameDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<IndentorName>(
                            stream: indentorNameDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<IndentorName>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectIndentorName != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentorName,
                                displayClearIcon: false,
                                onChanged: onDataChange6,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<IndentorName>>(
                                            (e) {
                                      return DropdownMenuItem<IndentorName>(
                                        value: e,
                                        child: Text(e.strName ?? ""),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              selectIndentorName != null
                  ? InformationBoxContainer6(
                      text1: selectIndentorName.strName,
                      text2: selectIndentorName.strSubCode,
                      text3: selectIndentorName.strSubCode,
                      text4: selectIndentorName.strSubCode,
                      text5: selectIndentorName.strSubCode,
                      text6: selectIndentorName.strSubCode,
                      text7: selectIndentorName.strSubCode,
                      //text8: selectIndentorName.strSubCode,
                    )
                  : const SizedBox(),
              sizedbox1,
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Submit", () {
                    verifyDetail();
                  }, roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}
