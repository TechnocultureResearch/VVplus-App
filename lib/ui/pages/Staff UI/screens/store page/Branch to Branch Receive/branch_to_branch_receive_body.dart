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
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/supplier_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
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
  List filltransferdata = [];
  Future<String> myFuture;
  var subscription;
  var connectionStatus;
  String formatted;
  String selectFillTransfer;

  Future<String> fetchFillTransferData() async {
    if (selectSupplier != null) {
      final String uri =
          "http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkIntransit?StrRecord=${'{"StrFilter":"FillTransfer",'
              '"StrSiteCode":"AA","StrPartyCode":"${selectSupplier.SubCode}","StrStkTrnManID":""}'}";

      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = await http.get(
          Uri.parse(uri),
        );
        var resBody = json.decode(res.body);
        setState(() {
          filltransferdata = resBody;
          print("body:$resBody");
        });
        return "Loaded Successfully";
      }
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Future<List<dynamic>> FillSelectedTransferNo() async {
    if (selectFillTransfer != null) {
      try {
        var url = Uri.parse(
            "http://103.205.66.207:888/"
            "Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkIntransit?StrRecord=${'{"StrFilter":"FillSelectedTransferNo",'
                '"StrSiteCode":"AA","StrPartyCode":"${selectSupplier.SubCode}","StrStkTrnManID":"${selectFillTransfer}"}'}");
        final response = await http.get(url);
        final List<dynamic> items = json.decode(response.body);
        return items;
      } catch (e) {
        rethrow;
      }
    }
  }
  @override
  void initState() {
    myFuture = fetchFillTransferData();
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
      selectFillTransfer = null;
    });
  }

  void onDataChange3(Godown state) {
    setState(() {
      selectGodown = state;
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
              '"StrHSNSACCode":"","StrGoodsServices":"","StrTransferNo":"${selectFillTransfer}","DblItemValueRate":"10","DblItemValueAmt":"50","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"0","DblAVAmt":"50","DblSGSTRate":"9","DblSGSTAmt":"4.5","DblCGSTRate":"9","DblCGSTAmt":"4.5","DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0",'
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
              formsHeadTextNew(
                  "Receiving goods from branch(Supplier) ", width * .045),
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
              formsHeadTextNew("Fill Transfer Entry", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  width: width * .85,
                  height: height * .066,
                  decoration: decorationForms(),
                  child: StreamBuilder<String>(
                      stream: fetchFillTransferData().asStream(),
                      builder: (context, snapshot) {
                        return DropdownButton(
                          hint: Text("  Search here                    "),
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            // padding: EdgeInsets.symmetric(horizontal: 0.15),
                            child: const Icon(Icons.keyboard_arrow_down_sharp,
                                size: 30),
                          ),
                          isExpanded: true,
                          items: filltransferdata.map((item) {
                            return DropdownMenuItem(
                              value: item['DocId'],
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(item['DocId'] ?? ''),
                              ),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              selectFillTransfer = newVal;
                              print("selectFillPo: $selectFillTransfer");
                            });
                          },
                          value: selectFillTransfer != null
                              ? selectFillTransfer
                              : null,
                        );
                      }),
                ),
              ),
              StreamBuilder(
                  stream: FillSelectedTransferNo().asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: height * 0.15,
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * .12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: primaryColor3,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: primaryColor4,
                                          offset: Offset(0.0, 2.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: height * .04,
                                                width: width * .3,
                                                child: Text(
                                                    snapshot.data[index]
                                                        ['Item'],
                                                    maxLines: 2,
                                                    style:
                                                        containerTextStyle1()),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Item Code: " +
                                                    snapshot.data[index]
                                                        ['ItemCode'],
                                                style: TextStyle(
                                                    color: boxDecorationColor1,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Order no: " +
                                                    snapshot.data[index]
                                                        ['POrdNo'],
                                                style: TextStyle(
                                                    color:
                                                        boxDecorationTextColor2,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text("Order Qty.: ",
                                                style: containerTextStyle2()),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text("Receive Qty.: ",
                                                style: containerTextStyle2()),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text("Rate: ",
                                                style: containerTextStyle2()),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text("Amount: ",
                                                style: containerTextStyle2()),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                snapshot.data[index]['OrdQty']
                                                        .toString() +
                                                    " " +
                                                    snapshot.data[index]
                                                        ['Unit'],
                                                style: containerTextStyle2()),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                                snapshot.data[index]
                                                            ['RecievedQty']
                                                        .toString() +
                                                    "  " +
                                                    snapshot.data[index]
                                                        ['Unit'],
                                                style: containerTextStyle2()),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                                snapshot.data[index]['Rate']
                                                    .toString(),
                                                style: containerTextStyle2()),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                                snapshot.data[index]['Amount']
                                                    .toString(),
                                                style: containerTextStyle2()),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 23,
                                        ),
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Image.asset(icon15),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  //  isEdit = true;
                                                  snapshot.data[index]
                                                      ['PendingQty'] = null;
                                                });
                                              },
                                              child: Text(
                                                "Edit",
                                                style: containerTextStyle5(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Inc.Tax",
                                              style: containerTextStyle3(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
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
