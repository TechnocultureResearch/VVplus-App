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
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:connectivity/connectivity.dart';
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
  var subscription;
  var connectionStatus;

  void onDataChange(VoucherType state) {
    setState(() {
      selectVoucherType = state;
    });
  }
  @override
  void initState() {
    chequeUpToDateInput.text = "";
    depositDateInput.text = "";
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => connectionStatus = result );
    });
    super.initState();
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }

  verifyDetail(){
    if(connectionStatus == ConnectivityResult.wifi || connectionStatus == ConnectivityResult.mobile){
      if(chequeUpToDateInput.text!=null && selectVoucherType!=null && depositDateInput.text!=null){
        sendData();
      }
      else{
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
    }
    else{
      Scaffold.of(context).showSnackBar(snackBar(internetFailedConnectionText));
    }
  }

  Future<dynamic> sendData() async{
    try {
      await http.post(Uri.parse(ApiService.mockDataPostChequeDeposit),
          body: json.encode({
            "ChequeUpTo": chequeUpToDateInput.text,
            "ChooseCheque": selectVoucherType.strSubCode,
            "DepositDate": depositDateInput.text
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(padding: EdgeInsets.symmetric(vertical: 70)),
                formsHeadText("Cheque Up To"),
                Container(
                  padding: dateFieldPadding,
                  height: dateFieldHeight,
                  child: Center(
                    child: TextFormField(
                      controller: chequeUpToDateInput,
                      decoration: dateFieldDecoration(),
                      readOnly: true,
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101)
                        );
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            chequeUpToDateInput.text = formattedDate;
                          });
                        } else {
                        }
                      },
                    ),
                  ),
                ),

                Padding(padding: paddingForms),

                formsHeadText("Choose Cheque"),

                Padding(
                  padding: padding1,
                  child: Container(
                    height: 50, width: 343,
                    decoration: decorationForms(),
                    child: FutureBuilder<List<VoucherType>>(
                        future: voucherTypeDropdownBloc.voucherTypeDropdownData,
                        builder: (context, snapshot) {
                          return StreamBuilder<VoucherType>(
                              stream: voucherTypeDropdownBloc.selectedState,
                              builder: (context, item) {
                                return SearchChoices<VoucherType>.single(
                                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                                  underline: "",
                                  padding: 1,
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

                Padding(padding: paddingForms),

                formsDetailText("Bank:"),

                Padding(padding: paddingForms),

                formsDetailText("Name of Customer:"),

                Padding(padding: paddingForms),

                formsDetailText("Cheque Date:"),

                Padding(padding: paddingForms),

                formsDetailText("Bank:"),

                Padding(padding: paddingForms),

                formsDetailText("Amount:"),

                Padding(padding: paddingForms),

                formsDetailText("Size:"),

                Padding(padding: paddingForms),

                formsHeadText("Desposit Date"),

                Container(
                  padding: dateFieldPadding,
                  height: dateFieldHeight,
                  child: Center(
                    child: TextFormField(
                      controller: depositDateInput,
                      decoration: dateFieldDecoration(),
                      readOnly: true,
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101)
                        );
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            depositDateInput.text = formattedDate;
                          });
                        } else {
                        }
                      },
                    ),
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
    );
  }
}