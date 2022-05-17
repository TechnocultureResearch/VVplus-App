// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/drawn_bank_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/payment_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/cheque_entry_update_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/credit_acc_model.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/drawn_bank_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/payment_type_model.dart';
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
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../../../../Application/Bloc/Dropdown_Bloc/credit_account_dropdown_bloc.dart';

class ChequeEntryReceiveBody extends StatefulWidget {
  const ChequeEntryReceiveBody({Key key}) : super(key: key);
  @override
  State<ChequeEntryReceiveBody> createState() => _ChequeEntryReceiveBody();
}

class _ChequeEntryReceiveBody extends State<ChequeEntryReceiveBody> {
  TextEditingController chequeReceivingDateInput = TextEditingController();
  final TextEditingController voucherTypeInput = TextEditingController();
  final TextEditingController chequeNoInput = TextEditingController();
  final TextEditingController amountInput = TextEditingController();
  DepartmentNameDropdownBloc departmentNameDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  PaymentTypeDropdownBloc paymentTypeDropdownBloc;
  CreditAccountDropdownBloc creditAccountDropdownBloc;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;
  DrawnBankDropdownBloc drawnBankDropdownBloc;

  VoucherType selectVoucherType1;
  CreditAccount selectCreditAccount;
  PaymentType selectPaymentType;
  ItemCostCenter selectItemCostCenter;
  DrawnBank selectDrawnBank;
  VoucherType selectVoucherType;
  DepartmentName selectDepartmentName;
  final receiveFormKey = GlobalKey<FormState>();

  void onDataChange1(PaymentType state) {
    setState(() {
      selectPaymentType = state;
    });
  }

  void onDataChange2(VoucherType state) {
    setState(() {
      selectVoucherType = state;
    });
  }

  void onDataChange3(CreditAccount state) {
    setState(() {
      selectCreditAccount = state;
    });
  }

  void onDataChange4(DrawnBank state) {
    setState(() {
      selectDrawnBank = state;
    });
  }

  @override
  void initState() {
    chequeReceivingDateInput.text = "";
    departmentNameDropdownBloc = DepartmentNameDropdownBloc();
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    paymentTypeDropdownBloc = PaymentTypeDropdownBloc();
    creditAccountDropdownBloc = CreditAccountDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    drawnBankDropdownBloc = DrawnBankDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  verifyDetail() {
    if (selectVoucherType != null &&
        selectDrawnBank != null &&
        selectPaymentType != null &&
        selectDepartmentName != null &&
        selectCreditAccount != null &&
        receiveFormKey.currentState.validate()) {
      sendData();
    } else {
      Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
    }
  }

  Future<dynamic> sendData() async {
    try {
      await http.post(Uri.parse(ApiService.mockDataPostChequeReceive),
          body: json.encode({
            "VoucherType": selectVoucherType.V_Type,
            "ChequeReceivingDate": chequeReceivingDateInput.text,
            "PaymentType": selectPaymentType.Name,
            "CreditAmount": selectCreditAccount.Name,
            "DrawnBank": selectDrawnBank.StrName,
            "ChequeNo": chequeNoInput.text,
            "Amount": amountInput.text
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
    final bloc = ChequeEntryUpdateProvider.of(context);
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
          key: receiveFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    RaisedButton(
                      onPressed: () {
                        chequeReceivingDateInput.clear();
                      },
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 45)),
                  formsHeadTextNew("Voucher Type", width * .045),
                  Padding(
                    padding: padding1,
                    child: Container(
                      decoration: decorationForms(),
                      child: FutureBuilder<List<VoucherType>>(
                          future: voucherTypeDropdownBloc
                              .voucherTypeChequeReceiveDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<VoucherType>(
                                stream: voucherTypeDropdownBloc
                                    .selectedChequeReceiveState,
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
                                    onChanged: onDataChange2,
                                    items: snapshot?.data?.map<
                                            DropdownMenuItem<VoucherType>>((e) {
                                          return DropdownMenuItem<VoucherType>(
                                            value: e,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(e.V_Type),
                                            ),
                                          );
                                        })?.toList() ??
                                        [],
                                  );
                                });
                          }),
                    ),
                  ),
                  const SizedBox(height: 15),
                  formsHeadTextNew("Cheque Receiving Date", width * .045),
                  Container(
                    padding: dateFieldPadding,
                    height: dateFieldHeight,
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if (val != chequeReceivingDateInput.text) {
                          return 'Enter Correct Detail';
                        }
                        return null;
                      },
                      controller: chequeReceivingDateInput,
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
                            chequeReceivingDateInput.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                  formsHeadTextNew("Payment Type", width * .045),
                  Padding(
                    padding: padding1,
                    child: Container(
                      decoration: decorationForms(),
                      child: FutureBuilder<List<PaymentType>>(
                          future:
                              paymentTypeDropdownBloc.paymentTypeDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<PaymentType>(
                                stream: paymentTypeDropdownBloc
                                    .selectedPaymentTypeState,
                                builder: (context, item) {
                                  return SearchChoices<PaymentType>.single(
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        size: 30),
                                    padding: selectPaymentType != null
                                        ? height * .002
                                        : height * .015,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectPaymentType,
                                    displayClearIcon: false,
                                    onChanged: onDataChange1,
                                    items: snapshot?.data?.map<
                                            DropdownMenuItem<PaymentType>>((e) {
                                          return DropdownMenuItem<PaymentType>(
                                            value: e,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                  Padding(padding: paddingFormsVertical),
                  formsHeadTextNew(
                      "Credit Account (customer name)", width * .045),
                  Padding(
                    padding: padding1,
                    child: Container(
                      decoration: decorationForms(),
                      child: FutureBuilder<List<CreditAccount>>(
                          future: creditAccountDropdownBloc
                              .creditAccountDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<CreditAccount>(
                                stream: creditAccountDropdownBloc
                                    .selectedCreditAccountState,
                                builder: (context, item) {
                                  return SearchChoices<CreditAccount>.single(
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        size: 30),
                                    padding: selectCreditAccount != null
                                        ? height * .002
                                        : height * .015,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectCreditAccount,
                                    displayClearIcon: false,
                                    onChanged: onDataChange3,
                                    items: snapshot?.data?.map<
                                            DropdownMenuItem<
                                                CreditAccount>>((e) {
                                          return DropdownMenuItem<
                                              CreditAccount>(
                                            value: e,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                  Padding(padding: paddingFormsVertical),
                  formsHeadTextNew("Debit Account (company):", width * .045),
                  Padding(padding: paddingFormsVertical),
                  formsHeadTextNew("Drawn Bank", width * .045),
                  Padding(
                    padding: padding1,
                    child: Container(
                      decoration: decorationForms(),
                      child: FutureBuilder<List<DrawnBank>>(
                          // future: itemCostCenterDropdownBloc.itemCostCenterData,
                          future: drawnBankDropdownBloc.drawnBankDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<DrawnBank>(
                                // stream: itemCostCenterDropdownBloc.selectedState,
                                stream: drawnBankDropdownBloc
                                    .selectedDrawnBankState,
                                builder: (context, item) {
                                  return SearchChoices<DrawnBank>.single(
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        size: 30),
                                    padding: selectDrawnBank != null
                                        ? height * .002
                                        : height * .015,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectDrawnBank,
                                    displayClearIcon: false,
                                    onChanged: onDataChange4,
                                    items: snapshot?.data
                                            ?.map<DropdownMenuItem<DrawnBank>>(
                                                (e) {
                                          return DropdownMenuItem<DrawnBank>(
                                            value: e,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(e.StrName),
                                            ),
                                          );
                                        })?.toList() ??
                                        [],
                                  );
                                });
                          }),
                    ),
                  ),
                  Padding(padding: paddingFormsVertical),
                  formsHeadTextNew("Customer Info:", width * .045),
                  Padding(padding: paddingFormsVertical),
                  formsHeadTextNew("Cheque No.", width * .045),
                  Container(
                    padding: padding1,
                    decoration: decoration1(),
                    child: StreamBuilder<String>(
                      stream: bloc.outtextField2,
                      builder: (context, snapshot) => TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Detail';
                          }
                          if (val != chequeNoInput.text) {
                            return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                                ? null
                                : "Enter valid detail";
                          }
                          return null;
                        },
                        controller: chequeNoInput,
                        onChanged: bloc.intextField2,
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
                  formsHeadTextNew("Amount", width * .045),
                  Container(
                    padding: padding1,
                    decoration: decoration1(),
                    child: StreamBuilder<String>(
                      stream: bloc.outtextField3,
                      builder: (context, snapshot) => TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Detail';
                          }
                          if (val != amountInput.text) {
                            return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                                ? null
                                : "Enter valid detail";
                          }
                          return null;
                        },
                        controller: amountInput,
                        onChanged: bloc.intextField3,
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
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 40),
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
