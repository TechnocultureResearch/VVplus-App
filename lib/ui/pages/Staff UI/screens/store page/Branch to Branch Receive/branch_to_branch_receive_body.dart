// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/Supplier_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/fill_transfer_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/godown_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/branch_to_branch_receive_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/fill_transfer_model.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/supplier_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/infrastructure/Repository/supplier_repository.dart';
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
  SupplierDropdownBloc supplierDropdownBloc;
  GodownDropdownBloc godownDropdownBloc;
  IndentorNameDropdownBloc indentorNameDropdownBloc;
  FillTransferDropdownBloc fillTransferDropdownBloc;

  VoucherType selectVoucherType;
  Supplier selectSupplier;
  Godown selectGodown;
  IndentorName selectIndentorName;
  FillTransferModel selectFillTransfer;

  var subscription;
  var connectionStatus;
  String formatted;
  @override
  void initState() {
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    supplierDropdownBloc = SupplierDropdownBloc();
    godownDropdownBloc = GodownDropdownBloc();
    indentorNameDropdownBloc = IndentorNameDropdownBloc();
    fillTransferDropdownBloc = FillTransferDropdownBloc();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    formatted = formatter.format(now);
    super.initState();
  }

  void clearData() {
    setState(() {
      selectVoucherType = null;
      selectSupplier = null;
      selectGodown = null;
      selectIndentorName = null;
      selectFillTransfer = null;
      _vehicleNo.clear();
      _gateEntryNo.clear();
      _remarks.clear();
    });
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

  void onDataChange2(Supplier state) {
    setState(() {
      selectSupplier = state;
    });
  }

  void onDataChange3(Godown state) {
    setState(() {
      selectGodown = state;
    });
  }

  void onDataChange4(FillTransferModel state) {
    setState(() {
      selectFillTransfer = state;
    });
  }

  Future<dynamic> FillTransfer() async {
    try {
      var url = Uri.parse(
          'http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkIntransit?StrRecord=${'{"StrFilter":"FillTransfer","StrSiteCode":"AA","StrPartyCode":"${selectSupplier.SubCode}","StrStkTrnManID":""}'}');
      final response = await http.get(url);
      final items = (jsonDecode(response.body) as List)
          .map((e) => FillTransferModel.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
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
          selectSupplier != null &&
          selectGodown != null &&
          selectFillTransfer != null &&
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
      var baseUrl =
          "http://techno-alb-1780774514.ap-south-1.elb.amazonaws.com:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostStkIntransit";
      var url = Uri.parse(baseUrl +
          "?" +
          'StrRecord=${'{"StrVType":"${selectVoucherType.V_Type}","StrVDate":"2022-05-14","StrRefNo":"101","StrRefDate":"2022-05-14","StrSupplier":"${selectSupplier.SubCode}","StrFrmGodown":"${selectGodown.GodCode}","StrSiteCode":"AA","StrVehicleNo":"${_vehicleNo.text}","DblGAmount":"0","StrPreparedBy":"SA",'
              '"StrRemark":"${_remarks.text}",StrIndGrid:[{"StrItemCode":"PN25","StrPONo":"DADSTKML 2022       2","DblPOQuantity":"5","DblQuantity":"5","StrOUnit":"PIECE","DblRate":"10","DblAmt":"50","StrCostCenterCode":"AA504",'
              '"StrHSNSACCode":"","StrGoodsServices":"","StrTransferNo":"${selectFillTransfer.DocId}","DblItemValueRate":"10","DblItemValueAmt":"50","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"0","DblAVAmt":"50","DblSGSTRate":"9","DblSGSTAmt":"4.5","DblCGSTRate":"9","DblCGSTAmt":"4.5","DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0",'
              '"DblUGSTAmt":"0","DblNetValueRate":"0","DblNetValueAmt":"59"}],"DblGrossRate":"0","DblGrossAmt":"0","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"0","DblAVAmt":"50","DblSGSTRate":"0","DblSGSTAmt":"4.5","DblCGSTRate":"0","DblCGSTAmt":"4.5","DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0","DblUGSTAmt":"0",'
              '"DblOtherAddRate":"0","DblOtherAddAmt":"0","DblOtherDedRate":"0","DblOtherDedAmt":"0","DblBillRate":"0","DblBillAmt":"59",'
              '"DblRoundOffRate":"0","DblRoundOffAmt":"0","DblNetValueRate":"0","DblNetValueAmt":"59"}'}');
      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      //Scaffold.of(context).showSnackBar(snackBar(sendDataText));
      if (response.statusCode == 200) {
        final String responseString = response.body;
        return Scaffold.of(context).showSnackBar(snackBar(responseString));
      } else {
        return Scaffold.of(context).showSnackBar(snackBar("Not Succeed"));
      }
    } catch (e) {
      rethrow;
    }
    //   await http.post(Uri.parse(ApiService.mockDataPostBranchToBranchReceive),
    //       body: json.encode({
    //         "VoucherType": selectVoucherType.strSubCode,
    //         "ReceivingGoodsFromBranch": selectSupplier.Name,
    //         "ReceivingInGodown": selectGodown.GodCode,
    //         "TransferEntrySelection": selectFillTransfer.DocId,
    //         "GateEntryNo": _gateEntryNo.text,
    //         "VehicleNo": _vehicleNo.text,
    //         "Remarks": _remarks.text
    //       }));
    //   Scaffold.of(context).showSnackBar(snackBar(sendDataText));
    // } on SocketException {
    //   Scaffold.of(context).showSnackBar(snackBar(socketExceptionText));
    // } on HttpException {
    //   Scaffold.of(context).showSnackBar(snackBar(httpExceptionText));
    // } on FormatException {
    //   Scaffold.of(context).showSnackBar(snackBar(formatExceptionText));
    // }
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
                      future: voucherTypeDropdownBloc
                          .voucherTypeBToBReceiveDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc
                                .selectedBToBReceiveState,
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
                  child: FutureBuilder<List<Supplier>>(
                      future:
                          supplierDropdownBloc.supplierBToBReceiveDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Supplier>(
                            stream: supplierDropdownBloc.selectedSupplierState,
                            builder: (context, item) {
                              return SearchChoices<Supplier>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectSupplier != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectSupplier,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<Supplier>>((e) {
                                      return DropdownMenuItem<Supplier>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Name ?? ''),
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
                  child: FutureBuilder<List<Godown>>(
                      future: godownDropdownBloc.godownDropDownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Godown>(
                            stream: godownDropdownBloc
                                .selectedBranchToBranchReceiveState,
                            builder: (context, item) {
                              return SearchChoices<Godown>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectGodown != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectGodown,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<Godown>>((e) {
                                      return DropdownMenuItem<Godown>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.GodName ?? ''),
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
                  child: FutureBuilder<List<FillTransferModel>>(
                      future: fillTransferDropdownBloc.fillTransferDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<FillTransferModel>(
                            stream: fillTransferDropdownBloc
                                .selectedFillTransferState,
                            builder: (context, item) {
                              return SearchChoices<FillTransferModel>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectFillTransfer != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectFillTransfer,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data?.map<
                                        DropdownMenuItem<
                                            FillTransferModel>>((e) {
                                      return DropdownMenuItem<
                                          FillTransferModel>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.DocId ?? ''),
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
                    clearData();
                  }, roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}
