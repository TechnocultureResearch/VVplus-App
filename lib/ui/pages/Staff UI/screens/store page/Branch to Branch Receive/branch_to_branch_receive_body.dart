// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/branch_to_branch_receive_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
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

class BranchtoBranchReceiveBody extends StatefulWidget {
  const BranchtoBranchReceiveBody({Key key}) : super(key: key);
  @override
  State<BranchtoBranchReceiveBody> createState() =>
      MyBranchtoBranchReceiveBody();
}

class MyBranchtoBranchReceiveBody extends State<BranchtoBranchReceiveBody> {
  final TextEditingController _vehicleNo = TextEditingController();
  final TextEditingController _gateEntryNo = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final branchToBranchReceiveFormKey = GlobalKey<FormState>();

  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc2;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc3;
  IndentorNameDropdownBloc indentorNameDropdownBloc;

  VoucherType selectVoucherType;
  VoucherType selectVoucherType2;
  VoucherType selectVoucherType3;
  IndentorName selectIndentorName;

  var subscription;
  var connectionStatus;

  @override
  void initState() {
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc2 = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc3 = VoucherTypeDropdownBloc();
    indentorNameDropdownBloc = IndentorNameDropdownBloc();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    super.initState();
  }

  void clearData() {
    selectVoucherType = null;
    selectVoucherType2 = null;
    selectVoucherType3 = null;
    selectIndentorName = null;

    _vehicleNo.clear();
    _gateEntryNo.clear();
    _remarks.clear();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void onDataChange1(VoucherType state) {
    setState(() {
      selectVoucherType = state;
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

  void onDataChange4(IndentorName state) {
    setState(() {
      selectIndentorName = state;
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
      if (selectVoucherType != null &&
          selectVoucherType2 != null &&
          selectVoucherType3 != null &&
          selectIndentorName != null &&
          branchToBranchReceiveFormKey.currentState.validate()) {
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
      await http.post(Uri.parse(ApiService.mockDataPostBranchToBranchReceive),
          body: json.encode({
            "VoucherType": selectVoucherType.strSubCode,
            "ReceivingGoodsFromBranch": selectVoucherType2.strSubCode,
            "ReceivingInGodown": selectVoucherType3.strSubCode,
            "TransferEntrySelection": selectIndentorName.strSubCode,
            "GateEntryNo": _gateEntryNo.text,
            "VehicleNo": _vehicleNo.text,
            "Remarks": _remarks.text
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
    final bloc = BranchToBranchReceiveProvider.of(context);
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
          key: branchToBranchReceiveFormKey,
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
              formsHeadTextNew("Voucher Type", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc.voucherTypeBToBReceiveDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc.selectedBToBReceiveState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectVoucherType != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Description ?? ''),
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
              formsHeadTextNew("Receiving goods from branch ", width * .045),
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
                                    size: 30),
                                padding: selectVoucherType2 != null
                                    ? height * .002
                                    : height * .015,
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.strName ?? ''),
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
              formsHeadTextNew("Receiving in Godown", width * .045),
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
                                padding: selectVoucherType3 != null
                                    ? height * .002
                                    : height * .015,
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.strName ?? ''),
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
              formsHeadTextNew("Transfer Entry Selection", width * .045),
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
                                padding: selectIndentorName != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentorName,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<IndentorName>>(
                                            (e) {
                                      return DropdownMenuItem<IndentorName>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.strSubCode ?? ''),
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
              formsHeadText("Gate Entry No."),
              Container(
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if (val != _gateEntryNo.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                              ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: _gateEntryNo,
                      onChanged: bloc.intextField,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColor8,
                          enabledBorder: textFieldBorder(),
                          focusedBorder: textFieldBorder(),
                          isDense: true,
                          errorBorder: textFieldBorder(),
                          errorText: snapshot.error),
                      keyboardType: TextInputType.text,
                      style: simpleTextStyle7(),
                    ),
                  ),
                ),
              ),
              sizedbox1,
              formsHeadTextNew("Vehicle No.", width * .045),
              Container(
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if (val != _vehicleNo.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                              ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: _vehicleNo,
                      onChanged: bloc.intextField,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColor8,
                          enabledBorder: textFieldBorder(),
                          focusedBorder: textFieldBorder(),
                          isDense: true,
                          errorBorder: textFieldBorder(),
                          errorText: snapshot.error),
                      keyboardType: TextInputType.text,
                      style: simpleTextStyle7(),
                    ),
                  ),
                ),
              ),
              sizedbox1,
              formsHeadTextNew("Remarks", width * .045),
              Container(
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField,
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
                      onChanged: bloc.intextField,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColor8,
                          enabledBorder: textFieldBorder(),
                          focusedBorder: textFieldBorder(),
                          isDense: true,
                          errorBorder: textFieldBorder(),
                          errorText: snapshot.error),
                      keyboardType: TextInputType.text,
                      style: simpleTextStyle7(),
                    ),
                  ),
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
                  child: roundedButtonHome2("Confirm Receiving", () {
                    verifyDetail();
                  }, roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}
