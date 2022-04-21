// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ChequeEntryClearedBody extends StatefulWidget {
  const ChequeEntryClearedBody({Key key}) : super(key: key);
  @override
  State<ChequeEntryClearedBody> createState() => _ChequeEntryReceiveBody();
}
class _ChequeEntryReceiveBody extends State<ChequeEntryClearedBody> {

  TextEditingController depositUpToDateInput = TextEditingController();
  TextEditingController clearedDateInput = TextEditingController();
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  VoucherType selectVoucherType;
  final clearedFormKey = GlobalKey<FormState>();


  void onDataChange(VoucherType state) {
    setState(() {
      selectVoucherType = state;
    });
  }
  @override
  void initState() {
    depositUpToDateInput.text = "";
    clearedDateInput.text = "";
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }
  verifyDetail() {
    if (selectVoucherType != null && clearedFormKey.currentState.validate()) {
      sendData();
    }
    else {
      Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
    }
  }

  Future<dynamic> sendData() async{
    try {
      await http.post(Uri.parse(ApiService.mockDataPostChequeCleared),
          body: json.encode({
            "DepositUpTo": depositUpToDateInput.text,
            "ChooseCheque": selectVoucherType.strSubCode,
            "ClearedtDate": clearedDateInput.text
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
          key: clearedFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      RaisedButton(
                      onPressed: () {
                        depositUpToDateInput.clear();
                        clearedDateInput.clear();
                      },
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                    ]
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 45)),

                  formsHeadText("Deposit Up To"),

                  Container(
                    padding: dateFieldPadding,
                    height: dateFieldHeight,
                    child: TextFormField(
                      validator: (val){
                        if(val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if(val != depositUpToDateInput.text) {
                          return 'Enter Correct Detail';
                        }
                        return null;
                      },
                      controller: depositUpToDateInput,
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
                            depositUpToDateInput.text = formattedDate;
                          });
                        } else {
                        }
                      },
                    ),
                  ),

                  formsHeadText("Choose Cheque"),

                  Padding(
                    padding: padding1,
                    child: Container(
                      height: 52, width: 343,
                      decoration: decorationForms(),
                      child: FutureBuilder<List<VoucherType>>(
                          future: voucherTypeDropdownBloc.voucherTypeDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<VoucherType>(
                                stream: voucherTypeDropdownBloc.selectedState,
                                builder: (context, item) {
                                  return SearchChoices<VoucherType>.single(
                                    icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                    padding: selectVoucherType!=null ? 2 : 11,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectVoucherType,
                                    displayClearIcon: false,
                                    onChanged: onDataChange,
                                    items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>((e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Text(e.strName),
                                      );
                                    })?.toList() ??[],
                                  );
                                }
                            );
                          }
                      ),
                    ),
                  ),

                  Padding(padding: paddingFormsVertical),

                  formsDetailText("Bank: ${selectVoucherType!=null ? selectVoucherType.strSubCode : ""}"),

                  Padding(padding: paddingFormsVertical),

                  formsDetailText("Name of Customer: ${selectVoucherType!=null ? selectVoucherType.strSubCode : ""}"),

                  Padding(padding: paddingFormsVertical),

                  formsDetailText("Cheque Date: ${selectVoucherType!=null ? selectVoucherType.strSubCode : ""}"),

                  Padding(padding: paddingFormsVertical),

                  formsDetailText("Bank: ${selectVoucherType!=null ? selectVoucherType.strSubCode : ""}"),

                  Padding(padding: paddingFormsVertical),

                  formsDetailText("Amount: ${selectVoucherType!=null ? selectVoucherType.strSubCode : ""}"),

                  Padding(padding: paddingFormsVertical),

                  formsDetailText("Size: ${selectVoucherType!=null ? selectVoucherType.strSubCode : ""}"),

                  Padding(padding: paddingFormsVertical),

                  formsHeadText("Cleared Date: ${selectVoucherType!=null ? selectVoucherType.strSubCode : ""}"),

                  Padding(padding: paddingFormsVertical),
                  Container(
                    padding: dateFieldPadding,
                    height: dateFieldHeight,
                    child: TextFormField(
                      validator: (val){
                        if(val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if(val != clearedDateInput.text) {
                          return 'Enter Correct Detail';
                        }
                        return null;
                      },
                      controller: clearedDateInput,
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
                            clearedDateInput.text = formattedDate;
                          });
                        } else {
                        }
                      },
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      child: roundedButtonHome("Submit", () {verifyDetail();})),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}