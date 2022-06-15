// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, prefer_null_aware_operators

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ChequeEntryDepositBody extends StatefulWidget {
  const ChequeEntryDepositBody({Key key}) : super(key: key);
  @override
  State<ChequeEntryDepositBody> createState() => _ChequeEntryReceiveBody();
}

class _ChequeEntryReceiveBody extends State<ChequeEntryDepositBody> {
  TextEditingController chequeUpToDateInput = TextEditingController();
  TextEditingController depositDateInput = TextEditingController();
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  VoucherType selectVoucherType;
  final depositFormKey = GlobalKey<FormState>();

  Future<String> gridList;
  List fillgridlist = [];
  String StrBank;
  String NameofCust;
  String ChequeDate;
  String amount;
  String StrSite;
  String selectFillGrid;
  String V_date;
  bool showdetail = false;
  void onDataChange(VoucherType state) {
    setState(() {
      selectVoucherType = state;
    });
  }

  String formatted;

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(now);
    print("current date...$formatted");

    gridList = fetchFillGridData();
    chequeUpToDateInput.text = "";
    depositDateInput.text = "";
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 8), () {
      setState(() {});
    });
  }

  verifyDetail() {
    if (selectFillGrid != null && depositFormKey.currentState.validate()) {
      sendData();
    } else {
      Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
    }
  }

  Future<dynamic> sendData() async {
    try {
      var baseUrl =
          "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostChqDeposit";
      var url = Uri.parse(baseUrl +
          "?" +
          'StrRecord=${'{"StrSiteCode":"RN","StrChequeDate":"${depositDateInput.text}",'
              '"StrLoginDate":"${formatted}",StrChqGrid:[{"StrChequeDate":"2022/06/14",'
              '"StrDeposit_Date":"${chequeUpToDateInput.text}","StrDocID":"${selectFillGrid}"}]}'}');

      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final String responseString = response.body;
        return Scaffold.of(context).showSnackBar(snackBar(responseString));
      } else {
        return Scaffold.of(context).showSnackBar(snackBar("Not Succeed"));
      }
    } catch (e) {
      rethrow;
    } on SocketException {
      Scaffold.of(context).showSnackBar(snackBar(socketExceptionText));
    } on HttpException {
      Scaffold.of(context).showSnackBar(snackBar(httpExceptionText));
    } on FormatException {
      Scaffold.of(context).showSnackBar(snackBar(formatExceptionText));
    }
  }

  Future<String> fetchFillGridData() async {
    if (depositDateInput.text != null) {
      final String uri =
          "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetChequeDeposit?StrRecord= ${'{"StrFilter":"FillGrid",'
              '"StrSiteCode":"RN","StrChq_Date":"${depositDateInput.text}"}'}";

      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = await http.get(
          Uri.parse(uri),
        );
        var resBody = json.decode(res.body);
        setState(() {
          fillgridlist = resBody;
        });
      }
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Widget fillGridDropdown() {
    return StreamBuilder<String>(
        stream: fetchFillGridData().asStream(),
        builder: (context, snapshot) {
          return DropdownButton(
            hint: Text("  Search here                      "),
            icon: Padding(
              padding: EdgeInsets.only(left: 65),
              child: const Icon(Icons.keyboard_arrow_down_sharp, size: 30),
            ),
            items: fillgridlist.map((griditem) {
              StrBank = griditem['Bank'];
              NameofCust = griditem['CustomerName'];
              ChequeDate = griditem['cheque_date'];
              amount = griditem['cheque_amt'];
              StrSite = griditem['site_name'];
              V_date = griditem['v_date'];
              return DropdownMenuItem(
                value: griditem['docid'],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(griditem['docid'] ?? ''),
                ),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                selectFillGrid = newVal;
                showdetail = true;
              });
            },
            value: selectFillGrid != null ? selectFillGrid : null,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
          key: depositFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    RaisedButton(
                      onPressed: () {
                        depositDateInput.clear();
                        chequeUpToDateInput.clear();
                      },
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 45)),
                  formsHeadTextNew("Cheque Up To", width * .045),
                  Container(
                    padding: dateFieldPadding,
                    height: height * .099,
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if (val != chequeUpToDateInput.text) {
                          return 'Enter Correct Detail';
                        }
                        return null;
                      },
                      controller: chequeUpToDateInput,
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
                            chequeUpToDateInput.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                  formsHeadTextNew("Choose Cheque", width * .045),
                  Padding(
                    padding: padding1,
                    child: Container(
                      decoration: decorationForms(),
                      child: FutureBuilder<List<VoucherType>>(
                          future:
                              voucherTypeDropdownBloc.voucherTypeDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<VoucherType>(
                                stream: voucherTypeDropdownBloc.selectedState,
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
                                    onChanged: onDataChange,
                                    items: snapshot?.data?.map<
                                            DropdownMenuItem<VoucherType>>((e) {
                                          return DropdownMenuItem<VoucherType>(
                                            value: e,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                  formsHeadText(
                      "Desposit Date ${selectVoucherType != null ? selectVoucherType.StrSubCode : ""}"),
                  Container(
                    padding: dateFieldPadding,
                    height: height * .099,
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if (val != depositDateInput.text) {
                          return 'Enter Correct Detail';
                        }
                        return null;
                      },
                      controller: depositDateInput,
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
                            depositDateInput.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                  formsHeadTextNew("Fill Grid", width * .045),
                  Padding(
                    padding: padding1,
                    child: Container(
                      height: height * .073,
                      width: width * 3,
                      decoration: decorationForms(),
                      child: fillGridDropdown(),
                    ),
                  ),
                  Padding(padding: paddingFormsVertical),
                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        formsDetailTextNew("Bank: "),
                        StrBank != null && showdetail == true
                            ? Expanded(
                                child: Text(
                                  "$StrBank",
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                  Padding(padding: paddingFormsVertical),
                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        formsDetailTextNew("Name of Customer: "),
                        NameofCust != null && showdetail == true
                            ? Expanded(
                                child: Text(
                                  "$NameofCust",
                                  style: TextStyle(),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                  Padding(padding: paddingFormsVertical),
                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 10),
                    child: Row(
                      children: [
                        formsDetailTextNew("Cheque Date: "),
                        ChequeDate != null && showdetail == true
                            ? Expanded(
                                child: Text(
                                  "$ChequeDate",
                                  style: TextStyle(),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                  Padding(padding: paddingFormsVertical),
                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 10),
                    child: Row(
                      children: [
                        formsDetailTextNew("Amount: "),
                        amount != null && showdetail == true
                            ? Expanded(
                                child: Text(
                                  "$amount",
                                  style: TextStyle(),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                  Padding(padding: paddingFormsVertical),
                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 10),
                    child: Row(
                      children: [
                        formsDetailTextNew("Site: "),
                        StrSite != null && showdetail == true
                            ? Expanded(
                                child: Text(
                                  "$StrSite",
                                  style: TextStyle(),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                  Padding(padding: paddingFormsVertical),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      child: roundedButtonHome("Submit", () {
                        verifyDetail();
                      })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
