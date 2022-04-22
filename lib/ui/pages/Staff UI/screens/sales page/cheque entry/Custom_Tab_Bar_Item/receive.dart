// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/payment_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/cheque_entry_update_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
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
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;

  VoucherType selectVoucherType1;
  PaymentType selectPaymentType;
  ItemCostCenter selectItemCostCenter;
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
  void onDataChange3(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter = state;
    });
  }
  @override
  void initState() {
    chequeReceivingDateInput.text = "";
    departmentNameDropdownBloc = DepartmentNameDropdownBloc();
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    paymentTypeDropdownBloc = PaymentTypeDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
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
  verifyDetail(){
      if(selectVoucherType!=null && selectPaymentType!=null && selectDepartmentName!=null && selectItemCostCenter!=null && receiveFormKey.currentState.validate()){
        sendData();
      }
      else{
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
  }

  Future<dynamic> sendData() async{
    try {
      await http.post(Uri.parse(ApiService.mockDataPostChequeReceive),
          body: json.encode({
            "VoucherType": selectVoucherType.V_Type,
            "ChequeReceivingDate": chequeReceivingDateInput.text,
            "PaymentType": selectPaymentType.Name,
            "CreditAmount": selectDepartmentName.strSubCode,
            "DrawnBank": selectItemCostCenter.strSubCode,
            "ChequeNo" : chequeNoInput.text,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      RaisedButton(
                        onPressed: () {
                          chequeReceivingDateInput.clear();
                        },
                        elevation: 0.0,
                        color: Colors.white,
                        child: raisedButtonText("Clear all"),
                      ),

                    ]
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 45)),

                  formsHeadText("Voucher Type"),

                  Padding(
                    padding: padding1,
                    child: Container(
                      height: 55, width: 343,
                      decoration: decorationForms(),
                      child: FutureBuilder<List<VoucherType>>(
                          future: voucherTypeDropdownBloc.voucherTypeChequeReceiveDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<VoucherType>(
                                stream: voucherTypeDropdownBloc.selectedChequeReceiveState,
                                builder: (context, item) {
                                  return SearchChoices<VoucherType>.single(
                                    icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                    padding: selectVoucherType!=null ? 2 : 11,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectVoucherType,
                                    displayClearIcon: false,
                                    onChanged: onDataChange2,
                                    items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>((e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Text(e.V_Type),
                                      );
                                    })?.toList() ??[],
                                  );
                                }
                            );
                          }
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  formsHeadText("Cheque Receiving Date"),

                  Container(
                    padding: dateFieldPadding,
                    height: dateFieldHeight,
                    child: TextFormField(
                      validator: (val){
                        if(val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if(val != chequeReceivingDateInput.text) {
                          return 'Enter Correct Detail';
                        }
                        return null;
                      },
                      controller: chequeReceivingDateInput,
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
                            chequeReceivingDateInput.text = formattedDate;
                          });
                        } else {
                        }
                      },
                    ),
                  ),

                  formsHeadText("Payment Type"),

                  Padding(
                    padding: padding1,
                    child: Container(
                      height: 52, width: 343,
                      decoration: decorationForms(),
                      child: FutureBuilder<List<PaymentType>>(
                          future: paymentTypeDropdownBloc.paymentTypeDropdownData,
                          builder: (context, snapshot) {
                            return StreamBuilder<PaymentType>(
                                stream: paymentTypeDropdownBloc.selectedPaymentTypeState,
                                builder: (context, item) {
                                  return SearchChoices<PaymentType>.single(
                                    icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                    padding: selectPaymentType!=null ? 2 : 11,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectPaymentType,
                                    displayClearIcon: false,
                                    onChanged: onDataChange1,
                                    items: snapshot?.data
                                        ?.map<DropdownMenuItem<PaymentType>>((e) {
                                      return DropdownMenuItem<PaymentType>(
                                        value: e,
                                        child: Text(e.Name),
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

                  formsHeadText("Credit Account (customer name)"),

                  Padding(
                    padding: padding1,
                    child: Container(
                      height: 52, width: 343,
                      decoration: decorationForms(),
                      child: FutureBuilder<List<DepartmentName>>(
                          future: departmentNameDropdownBloc.departmentNameData,
                          builder: (context, snapshot) {
                            return StreamBuilder<DepartmentName>(
                                stream: departmentNameDropdownBloc.selectedState,
                                builder: (context, item) {
                                  return SearchChoices<DepartmentName>.single(
                                    icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                    padding: selectDepartmentName!=null ? 2 : 11,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectDepartmentName,
                                    displayClearIcon: false,
                                    onChanged: onDataChange1,
                                    items: snapshot?.data
                                        ?.map<DropdownMenuItem<DepartmentName>>((e) {
                                      return DropdownMenuItem<DepartmentName>(
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

                  formsHeadText("Debit Account (company):"),

                  Padding(padding: paddingFormsVertical),

                  formsHeadText("Drawn Bank"),

                  Padding(
                    padding: padding1,
                    child: Container(
                      height: 52, width: 343,
                      decoration: decorationForms(),
                      child: FutureBuilder<List<ItemCostCenter>>(
                          future: itemCostCenterDropdownBloc.itemCostCenterData,
                          builder: (context, snapshot) {
                            return StreamBuilder<ItemCostCenter>(
                                stream: itemCostCenterDropdownBloc.selectedState,
                                builder: (context, item) {
                                  return SearchChoices<ItemCostCenter>.single(
                                    icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                    padding: selectItemCostCenter!=null ? 2 : 11,
                                    isExpanded: true,
                                    hint: "Search here",
                                    value: selectItemCostCenter,
                                    displayClearIcon: false,
                                    onChanged: onDataChange3,
                                    items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>((e) {
                                      return DropdownMenuItem<ItemCostCenter>(
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

                  formsHeadText("Customer Info:"),

                  Padding(padding: paddingFormsVertical),

                  formsHeadText("Cheque No."),

                  Container(
                    height: 70,
                    padding: padding1,
                    decoration: decoration1(),
                    child: SizedBox(
                      width: 320,
                      child: StreamBuilder<String>(
                        stream: bloc.outtextField2,
                        builder: (context, snapshot) => TextFormField(
                          validator: (val) {
                            if(val.isEmpty) {
                              return 'Enter Detail';
                            }
                            if(val != chequeNoInput.text) {
                              return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val) ? null
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
                              errorText: snapshot.error
                          ),
                          keyboardType: TextInputType.text,
                          style: simpleTextStyle7(),
                        ),
                      ),
                    ),
                  ),



                  formsHeadText("Amount"),

                  Container(
                    height: 70,
                    padding: padding1,
                    decoration: decoration1(),
                    child: SizedBox(
                      width: 320,
                      child: StreamBuilder<String>(
                        stream: bloc.outtextField3,
                        builder: (context, snapshot) => TextFormField(
                          validator: (val) {
                            if(val.isEmpty) {
                              return 'Enter Detail';
                            }
                            if(val != amountInput.text) {
                              return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val) ? null
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
                              errorText: snapshot.error
                          ),
                          keyboardType: TextInputType.text,
                          style: simpleTextStyle7(),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 40),
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