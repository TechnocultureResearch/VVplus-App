// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/Supplier_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indent_selection_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/place_purchase_order_page_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/indent_selection_model.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/supplier_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/place%20purchase%20order/purchase_dialog.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PlacePurchaseOrderBody extends StatefulWidget {
  const PlacePurchaseOrderBody({Key key}) : super(key: key);
  @override
  State<PlacePurchaseOrderBody> createState() => MyPlacePurchaseOrderBody();
}

class MyPlacePurchaseOrderBody extends State<PlacePurchaseOrderBody> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinput1 = TextEditingController();
  TextEditingController remarks = TextEditingController();
  final placePurchaseOrderFormKey = GlobalKey<FormState>();
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc1;
  SupplierDropdownBloc supplierDropdownBloc;
  IndentSelectionDropdownBloc indentSelectionPlacePoDropdownBloc;

  VoucherType selectVoucherType;
  Supplier selectSupplier;
  IndentSelection selectIndentSelection;
  var subscription;
  var connectionStatus;

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

  void onDataChange3(IndentSelection state) {
    setState(() {
      selectIndentSelection = state;
    });
  }

  @override
  void initState() {
    dateinput.text = "";
    dateinput1.text = "";
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    supplierDropdownBloc = SupplierDropdownBloc();
    indentSelectionPlacePoDropdownBloc = IndentSelectionDropdownBloc();
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

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (selectVoucherType != null &&
          selectSupplier != null &&
          selectIndentSelection != null &&
          placePurchaseOrderFormKey.currentState.validate()) {
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
      var baseurl =
          'http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostPO';

      var url = Uri.parse(baseurl +
          "?" +
          'StrRecord=${'{"StrVType":"${selectVoucherType.V_Type}","StrVDate":"${dateinput.text}","StrSiteCode":"AD",'
              '"StrSupplier":"${selectSupplier.SubCode}",StrIndGrid:[{"StrItemCode":"${selectIndentSelection.itemCode}",'
              '"DblQuantity":"${selectIndentSelection.indQty}",'
              '"DblAmt":"100","DblRate":"10","StrOUnit":"${selectIndentSelection.unit}","StrPOValDate":"${dateinput1.text}",'
              '"StrCostCenterCode":"${selectIndentSelection.rate}","StrHSNSACCode":"${selectIndentSelection.hsnSacCode}",'
              'StrIndGrid1:[{"StrDocID":"${selectIndentSelection.refDocId}","StrItemCode":"${selectIndentSelection.itemCode}",'
              '"DblQuantity":"10","StrCostCenterCode":"AD1"}],"DblItemValueRate":"10",'
              '"DblItemValueAmt":"100","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"100",'
              '"DblAVAmt":"100","DblSGSTRate":"9","DblSGSTAmt":"9","DblCGSTRate":"9","DblCGSTAmt":"9",'
              '"DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0","DblUGSTAmt":"0","DblNetValueRate":"118",'
              '"DblNetValueAmt":"118","StrRemark":"${remarks.text}","StrGoodsServices":"G"}],"DblGrossRate":"10",'
              '"DblGrossAmt":"100","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"100","DblAVAmt":"100",'
              '"DblSGSTRate":"9","DblSGSTAmt":"9","DblCGSTRate":"9","DblCGSTAmt":"9","DblIGSTRate":"0","DblIGSTAmt":"0",'
              '"DblUGSTRate":"0","DblUGSTAmt":"0","DblOtherAddRate":"0","DblOtherAddAmt":"0","DblOtherDedRate":"0",'
              '"DblOtherDedAmt":"0","DblBillRate":"0","DblBillAmt":"118","DblRoundOffRate":"0","DblRoundOffAmt":"118",'
              '"DblNetValueRate":"118","DblNetValueAmt":"118","StrPreparedBy":"sa","StrRemark":"${remarks.text}","StrAgtForm":"HO3"}'}');
      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final String responseString = response.body;
        return Scaffold.of(context).showSnackBar(snackBar(responseString));
      } else {
        return Scaffold.of(context).showSnackBar(snackBar("Not Succeed"));
      }
      Scaffold.of(context).showSnackBar(snackBar(sendDataText));
    } catch (e) {
      rethrow;
    }

    // try {
    //   await http.post(Uri.parse(ApiService.mockDataPostPlacePurchaseOrderURL),
    //       body: json.encode({
    //         "VoucherType": selectVoucherType.StrSubCode,
    //         "Date": dateinput.text,
    //         "Supplier": selectSupplier.Name,
    //         "IndentSelection": selectIndentName.strSubCode,
    //         "POValidDate": dateinput1.text,
    //         "Remarks": remarks.text
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

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = PlacePurchaseOrderProvider.of(context);
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
          key: placePurchaseOrderFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedbox1,
              sizedbox1,
              formsHeadTextNew("Voucher Type", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc.voucherTypePODropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc.selectedPOState,
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
              formsHeadTextNew("Date", width * .045),
              Container(
                padding: dateFieldPadding,
                height: height * .09,
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
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              formsHeadTextNew("Supplier", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<Supplier>>(
                      future: supplierDropdownBloc.supplierDropdownData,
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
              formsHeadTextNew("Indent Selection", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IndentSelection>>(
                      future: indentSelectionPlacePoDropdownBloc
                          .indentSelectionPlacePoDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<IndentSelection>(
                            stream: indentSelectionPlacePoDropdownBloc
                                .selectedIndentSelectionPlacePoState,
                            builder: (context, item) {
                              return SearchChoices<IndentSelection>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectIndentSelection != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentSelection,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data?.map<
                                        DropdownMenuItem<IndentSelection>>((e) {
                                      return DropdownMenuItem<IndentSelection>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.refDocId ?? ''),
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
              formsHeadTextNew("PO Valid Date", width * .045),
              Container(
                padding: dateFieldPadding,
                height: height * .08,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if (val != dateinput1.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dateinput1,
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
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateinput1.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              selectIndentSelection != null
                  ? InformationBoxContainer2(
                      text1: selectIndentSelection.itemName,
                      text2: selectIndentSelection.indQty.toString(),
                      text3: selectIndentSelection.rate.toString(),
                      text4: selectIndentSelection.rate.toString(),
                      text5: selectIndentSelection.indNo,
                      text6: selectIndentSelection.hsnSacName,
                    )
                  : const SizedBox(),
              selectIndentSelection != null ? sizedbox1 : const SizedBox(),
              formsHeadTextNew("Remarks:", width * .045),
              Container(
                //height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outtextField,
                  builder: (context, snapshot) => TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Detail';
                      }
                      if (val != remarks.text) {
                        return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                            ? null
                            : "Enter valid detail";
                      }
                      return null;
                    },
                    controller: remarks,
                    onChanged: bloc.intextField,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryColor8,
                      enabledBorder: textFieldBorder(),
                      focusedBorder: textFieldBorder(),
                      errorText: snapshot.error,
                      isDense: true,
                      errorBorder: textFieldBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    style: simpleTextStyle7(),
                  ),
                ),
              ),
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
