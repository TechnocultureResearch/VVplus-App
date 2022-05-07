// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/booking_id_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/change_applicable_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/unit_cancellation_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/booking_id_model.dart';
import 'package:vvplus_app/infrastructure/Models/change_applicable_model.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
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

class UnitCancellationBody extends StatefulWidget {
  const UnitCancellationBody({Key key}) : super(key: key);
  @override
  State<UnitCancellationBody> createState() => MyUnitCancellationBody();
}

class MyUnitCancellationBody extends State<UnitCancellationBody> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController baseAmount = TextEditingController();
  TextEditingController remarks = TextEditingController();
  DepartmentNameDropdownBloc departmentNameDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc1;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc2;
  final unitCancellationFormKey = GlobalKey<FormState>();
  BookingIdDropdownBloc bookingIdDropdownBloc3;
  ChangeApplicableDropdownBloc changeApplicableDropdownBloc4;

  DepartmentName selectDepartmentName;
  VoucherType selectVoucherType1;
  VoucherType selectVoucherType2;
  BookingIdModel selectBookingNo;
  ChangeApplicable selectChangeApplicable;
  var subscription;
  var connectionStatus;

  void onDataChange1(DepartmentName state) {
    setState(() {
      selectDepartmentName = state;
    });
  }

  void onDataChange2(VoucherType state) {
    setState(() {
      selectVoucherType1 = state;
    });
  }

  void onDataChange3(VoucherType state) {
    setState(() {
      selectVoucherType2 = state;
    });
  }

  void onDataChange4(BookingIdModel state) {
    setState(() {
      selectBookingNo = state;
    });
  }

  void onDataChange5(ChangeApplicable state) {
    setState(() {
      selectChangeApplicable = state;
    });
  }

  @override
  void initState() {
    dateinput.text = "";
    departmentNameDropdownBloc = DepartmentNameDropdownBloc();
    voucherTypeDropdownBloc1 = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc2 = VoucherTypeDropdownBloc();
    bookingIdDropdownBloc3 = BookingIdDropdownBloc();
    changeApplicableDropdownBloc4 = ChangeApplicableDropdownBloc();
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

  int valueChoose = 4;

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (/*selectDepartmentName != null &&
          selectVoucherType1 != null &&*/
          selectBookingNo != null &&
              selectChangeApplicable != null &&
              unitCancellationFormKey.currentState.validate()) {
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
      var url = Uri.parse(
          "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostUnitCancellation?StrRecord=${'{"StrVType":"UCANC","StrSiteCode":"AD","StrCancelDate":"2022-04-22","StrBookingNo":"DADUBOOK 2016       1","StrChangeApplicable":"M","StrDueDate":"2022-04-22","DblBaseAmt":"10000","DblTaxAmt":"450",StrTaxGrid:[{"StrOH":"95","StrTaxOHCode":"59","DblTaxPer":"4.5","DblRC_TaxPer":"4.5","StrROff":"H","DblAmt":450,"StrSubCode":"GY1"}],"DblNetAmt":"10450","StrRemark":"Remarkkk","StrBookingDate":"2016-04-21","StrPreparedBy":"SA","StrCustomer":"AD22","StrCostCenter":"AD1"}'}");
      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      // await http.post(Uri.parse(ApiService.mockDataPostUnitCancellation),
      //     body: json.encode({
      //       "CancellationDate": dateinput.text,
      //       "BookingId": selectDepartmentName.strSubCode,
      //       "ChangeApplicable": selectVoucherType1.strSubCode,
      //       "DueDate": dueDate.text,
      //       "BaseAmmount": baseAmount.text,
      //       "Remarks": remarks.text
      //  }));
      //Scaffold.of(context).showSnackBar(snackBar(sendDataText));
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

  @override
  Widget build(BuildContext context) {
    final bloc = UnitCancellationProvider.of(context);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Form(
          key: unitCancellationFormKey,
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
                        dateinput.clear();
                        dueDate.clear();
                        baseAmount.clear();
                        remarks.clear();
                      },
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadText("Cancellation Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
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
              formsHeadText("Booking Id"),
              Padding(
                padding: padding1,
                child: Container(
                  // height: 52,
                  // width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<BookingIdModel>>(
                      future: bookingIdDropdownBloc3.bookingIdDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<BookingIdModel>(
                            stream:
                                bookingIdDropdownBloc3.selectedBookingIdState,
                            builder: (context, item) {
                              return SearchChoices<BookingIdModel>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 28),
                                padding: selectBookingNo != null ? 2 : 9,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectBookingNo,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<BookingIdModel>>(
                                            (e) {
                                      return DropdownMenuItem<BookingIdModel>(
                                        value: e,
                                        child: Text(
                                          e.DocId ?? '',
                                        ),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              selectDepartmentName != null
                  ? InformationBoxContainer4(
                      text1: selectDepartmentName.strName,
                      text2: selectDepartmentName.strSubCode,
                      text3: selectDepartmentName.strSubCode,
                      text4: selectDepartmentName.strSubCode,
                      text5: selectDepartmentName.strSubCode,
                      text6: selectDepartmentName.strSubCode,
                      text7: selectDepartmentName.strSubCode,
                      text8: selectDepartmentName.strSubCode,
                      text9: selectDepartmentName.strSubCode,
                    )
                  : const SizedBox(),
              sizedbox1,
              formsHeadText("Change Applicable"),
              Padding(
                padding: padding1,
                child: Container(
                  // height: 52,
                  // width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ChangeApplicable>>(
                      future:
                          changeApplicableDropdownBloc4.changeApplicableData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ChangeApplicable>(
                            stream: changeApplicableDropdownBloc4.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ChangeApplicable>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectChangeApplicable != null ? 2 : 9,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectChangeApplicable,
                                displayClearIcon: false,
                                onChanged: onDataChange5,
                                items: snapshot?.data?.map<
                                            DropdownMenuItem<ChangeApplicable>>(
                                        (e) {
                                      return DropdownMenuItem<ChangeApplicable>(
                                        value: e,
                                        child: Text(e.strName ?? ''),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("Due Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if (val != dueDate.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dueDate,
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
                        dueDate.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              formsHeadText("Base Amount (deduction amount)"),
              Container(
                height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  width: 320,
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField1,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if (val != baseAmount.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                              ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: baseAmount,
                      onChanged: bloc.intextField1,
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
              ),
              sizedbox1,
              formsHeadText("Tax:"),
              sizedbox1,
              formsHeadText("Remarks"),
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
