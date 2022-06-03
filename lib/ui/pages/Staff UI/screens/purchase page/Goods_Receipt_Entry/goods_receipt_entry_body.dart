// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/Supplier_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/goods_receipt_entry_page_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/supplier_model.dart';
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

class GoodsRecepitEntryBody extends StatefulWidget {
  const GoodsRecepitEntryBody({Key key}) : super(key: key);
  @override
  State<GoodsRecepitEntryBody> createState() => MyGoodsRecepitEntryBody();
}

class MyGoodsRecepitEntryBody extends State<GoodsRecepitEntryBody> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinput1 = TextEditingController();
  TextEditingController partyBillNo = TextEditingController();
  TextEditingController vechileNo = TextEditingController();
  final goodsReceiptEntryFormKey = GlobalKey<FormState>();
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  SupplierDropdownBloc supplierDropdownBloc;

  VoucherTypeDropdownBloc voucherTypeDropdownBloc3;
  IndentorNameDropdownBloc dropdownBlocIndentorName;
  VoucherType selectVoucherType;
  Supplier selectSupplier;

  VoucherType selectVoucherType3;
  IndentorName selectIndentName;
  bool loading = false;
  var subscription;
  var connectionStatus;
  //var futureList;
  List fillPO = List();
  bool _selected = false;
  List data = [];
  List dataa = [];
  String fillSelectPoDoc;
  final TextEditingController _remarks = TextEditingController();
  String selectFillPo;
  Future<String> futureList;
  Future<String> myFuture;

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

  void onDataChange5(VoucherType state) {
    setState(() {
      selectVoucherType3 = state;
    });
  }

  Future<String> fetchFillPoData() async {
    final String uri =
        "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetGRN?StrRecord=${'{"StrFilter":"FillPO",'
            '"StrSiteCode":"AD",'
            '"StrStateCode":"","StrPartyCode":"${selectSupplier.subCode}","StrPOValDate":"",'
            '"StrPODocID":"","Strv_type":"PCHLN"}'}";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var res = await http.get(
        Uri.parse(uri),
      );
      var resBody = json.decode(res.body);
      setState(() {
        data = resBody;
        print("body:$data");
      });
      print('Loaded Successfully');
      return "Loaded Successfully";
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Future<String> fetchFillselectPoData() async {
    // if (selectFillPo != null) {
    final String uri =
        "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetGRN?StrRecord=${'{"StrFilter":"FillSelectedPO","StrSiteCode":"AD","StrStateCode":"",'
            //  '"StrPartyCode":"${selectSupplier.subCode}","StrPOValDate":"","StrPODocID":"$selectFillPo"}'}";
            '"StrPartyCode":"AD59","StrPOValDate":"","StrPODocID":"DADGORD  2022       2"}'}";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var res = await http.get(
        Uri.parse(uri),
      );
      var respBody = json.decode(res.body);
      setState(() {
        dataa = respBody;
        print("body:$dataa");
      });
      print('Loaded Successfully');
      return "Loaded Successfully";
      //  }
    } else {
      throw Exception('Failed to load data.');
    }
  }
//For text data
  // Future<List<dynamic>> getFillSelectedPOData() async {
  //   if (selectFillPo != null) {
  //     try {
  //       var url = Uri.parse(
  //           'http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetGRN?'
  //           'StrRecord=${'{"StrFilter":"FillSelectedPO","StrSiteCode":"AD","StrStateCode":"",'
  //               '"StrPartyCode":"${selectSupplier.subCode}","StrPOValDate":"","StrPODocID":"${selectFillPo}"}'}');
  //       //'"StrPartyCode":"AD59}","StrPOValDate":"","StrPODocID":"DADGORD  2022       2"}'}');
  //       final response = await http.get(url);
  //       final List<dynamic> items = json.decode(response.body);
  //       print("body: ${response.body}");
  //       print("status code: ${response.statusCode}");
  //       return items;
  //     } catch (e) {
  //       rethrow;
  //     }
  //   }
  // }

  @override
  void initState() {
    myFuture = fetchFillPoData();
    futureList = fetchFillselectPoData();
    dateinput.text = "";
    dateinput1.text = "";
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    supplierDropdownBloc = SupplierDropdownBloc();
    voucherTypeDropdownBloc3 = VoucherTypeDropdownBloc();
    dropdownBlocIndentorName = IndentorNameDropdownBloc();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    super.initState();
  }

  void clearData() {
    dateinput.clear();
    dateinput1.clear();
    partyBillNo.clear();
    vechileNo.clear();
    _remarks.clear();
    selectVoucherType = null;
    selectSupplier = null;
    selectVoucherType3 = null;
    selectIndentName = null;
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {});
    });
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (selectVoucherType != null &&
          selectSupplier != null &&
          // selectVoucherType3 != null &&
          goodsReceiptEntryFormKey.currentState.validate()) {
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
          "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostGRN";
      var url = Uri.parse(baseUrl +
          "?" +
          'StrRecord=${'{"StrVType":"${selectVoucherType.V_Type}","StrVDate":"${dateinput.text}","StrPtyChlNo":"11","StrPtyChlDate":"${dateinput1.text}",'
              '"StrSiteCode":"AD","StrSupplier":"${selectSupplier.subCode}","StrGodown":"AD1",StrIndGrid:[{"StrItemCode":"${fillSelectPoDoc}",'
              '"StrPONo":"${selectFillPo}","DblQuantity":"1000","DblPOQuantity":"100","DblAmt":"100","DblRate":"10",'
              '"StrCostCenterCode":"AD1","StrOUnit":"Mtr","StrHSNSACCode":"CG1","StrGoodsServices":"G","StrPODate":"",'
              '"StrRemark":"${_remarks.text}","DblItemValueRate":"10","DblItemValueAmt":"100","DblDiscountRate":"0","DblDiscountAmt":"0",'
              '"DblAVRate":"0","DblAVAmt":"100","DblSGSTRate":"9","DblSGSTAmt":"9","DblCGSTRate":"9","DblCGSTAmt":"9",'
              '"DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0","DblUGSTAmt":"0","DblNetValueRate":"0","DblNetValueAmt":"118"}],'
              '"DblGrossRate":"10","DblGrossAmt":"100","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"0","DblAVAmt":"100",'
              '"DblSGSTRate":"0","DblSGSTAmt":"9","DblCGSTRate":"0","DblCGSTAmt":"9","DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0",'
              '"DblUGSTAmt":"0","DblOtherAddRate":"0","DblOtherAddAmt":"0","DblOtherDedRate":"0","DblOtherDedAmt":"0","DblBillRate":"0",'
              '"DblBillAmt":"118","DblRoundOffRate":"0","DblRoundOffAmt":"0","DblNetValueRate":"0","DblNetValueAmt":"118",'
              '"StrPreparedBy":"SA","StrWarningDupChln":"S","StrWarningAbvTol":"S","StrVehicleNo":"${vechileNo.text}","DblGAmount":"100","StrAgtForm":"HO3"}'}');

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
    //   await http.post(Uri.parse(ApiService.mockDataPostGoodsReceiveEntryURL),
    //       body: json.encode({
    //         "VoucherType": selectVoucherType.StrSubCode,
    //         "Date": dateinput.text,
    //         "PartyBillNo": partyBillNo.text,
    //         "PartyBillDate": dateinput1.text,
    //         "Supplier": selectSupplier.Name,
    //         "PurchaseOrderSelect": "",
    //         "VehicleNo": vechileNo.text,
    //         "Godown": selectVoucherType3.StrSubCode
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
    final bloc = GoodsReceiptEntryProvider.of(context);
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
          key: goodsReceiptEntryFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: paddingForms2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ignore: deprecated_member_use
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
                          .voucherTypeGoodReceiptDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc
                                .selectedGoodReceiptState,
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
                                          child: Text(e.description ?? ''),
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
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              formsHeadTextNew("Voucher No:", width * .045),
              sizedbox1,
              formsHeadTextNew("Party Bill No", width * .045),
              Container(
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outtextField,
                  builder: (context, snapshot) => TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Detail';
                      }
                      if (val != partyBillNo.text) {
                        return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                            ? null
                            : "Enter valid detail";
                      }
                      return null;
                    },
                    controller: partyBillNo,
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
              sizedbox1,
              formsHeadTextNew("Party Bill Date", width * .045),
              Container(
                padding: dateFieldPadding,
                height: height * .09,
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
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        dateinput1.text = formattedDate;
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
                      future:
                          supplierDropdownBloc.supplierGoodReceiptDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Supplier>(
                            stream: supplierDropdownBloc
                                .selectedSupplierGoodReceiptState,
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
                                          child: Text(e.name ?? ''),
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
              formsHeadTextNew("Fill PO", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  width: 300,
                  height: height * .066,
                  decoration: decorationForms(),
                  child: dataFillPoText(),
                ),
              ),
              sizedbox1,
              formsHeadTextNew("Purchase Order Select", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                    width: 300,
                    height: height * .066,
                    decoration: decorationForms(),
                    //child: fillSelectedpoText()),
                    child: dataFillselectPoText()),
              ),
              sizedbox1,
              formsHeadTextNew("Vehicle No.", width * .045),
              Container(
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outtextField1,
                  builder: (context, snapshot) => TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Detail';
                      }
                      if (val != vechileNo.text) {
                        return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                            ? null
                            : "Enter valid detail";
                      }
                      return null;
                    },
                    controller: vechileNo,
                    onChanged: bloc.intextField1,
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
              sizedbox1,
              formsHeadTextNew("Godown", width * .045),
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
                                onChanged: onDataChange5,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.StrName ?? ''),
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
              selectVoucherType3 != null
                  ? InformationBoxContainer6(
                      text1: selectVoucherType3.StrName,
                      text2: selectVoucherType3.StrName,
                      text3: selectVoucherType3.StrName,
                      text4: selectVoucherType3.StrName,
                      text5: selectVoucherType3.StrName,
                      text6: selectVoucherType3.StrName,
                      text7: selectVoucherType3.StrName,
                      text8: selectVoucherType3.StrName,
                    )
                  : const SizedBox(),
              sizedbox1,
              formsHeadTextNew("Total Bill Value :", width * .045),
              sizedbox1,
              formsHeadTextNew("Remarks", width * .045),
              Container(
                //height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outDropField1,
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
                    onChanged: bloc.inDropField1,
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

  Widget dataFillPoText() {
    return StreamBuilder<String>(
        stream: fetchFillPoData().asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return DropdownButton(
            hint: Text("  Search here"),
            icon: Padding(
              padding: EdgeInsets.only(left: 85),
              child: const Icon(Icons.keyboard_arrow_down_sharp, size: 30),
            ),
            items: data.map((item) {
              return DropdownMenuItem(
                value: item['DocId'],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item['DocId'] ?? ''),
                ),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                selectFillPo = newVal;

                // print("selectFillPo$selectFillPo");
              });
            },
            value: selectFillPo != null ? selectFillPo : null,
          );
        });
  }

//dropdown
  Widget dataFillselectPoText() {
    return StreamBuilder<String>(
        stream: fetchFillselectPoData().asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return DropdownButton(
            hint: Text("  Search here"),
            icon: Padding(
              padding: EdgeInsets.only(left: 85),
              child: const Icon(Icons.keyboard_arrow_down_sharp, size: 30),
            ),
            items: dataa.map((itemm) {
              return DropdownMenuItem(
                value: itemm['ItemCode'],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(itemm['ItemCode'] ?? ""),
                ),
                // value: item['DocId'],
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                fillSelectPoDoc = newVal;
              });
            },
            value: fillSelectPoDoc != null ? fillSelectPoDoc : null,
          );
        });
  }

//text
//   Widget fillSelectedpoText() {
//     return StreamBuilder(
//         stream: getFillSelectedPOData().asStream(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                     leading: Text(
//                   snapshot.data[index]['DocID'] ?? '',
//                   //style: ContainerText2()
//                 ));
//               },
//             );
//           } else {
//             return Center(child: Text(""));
//           }
//         });
//   }
}
