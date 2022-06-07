// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/booking_id_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/change_applicable_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/unit_cancellation_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/Tax_oh_model.dart';
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

import '../../../../../../Application/Bloc/Dropdown_Bloc/taxoh_dropdown_bloc.dart';

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
  TAXOHDropdownBloc taxohDropdownBloc;
  final unitCancellationFormKey = GlobalKey<FormState>();
  BookingIdDropdownBloc bookingIdDropdownBloc3;
  ChangeApplicableDropdownBloc changeApplicableDropdownBloc4;

  DepartmentName selectDepartmentName;
  VoucherType selectVoucherType1;
  VoucherType selectVoucherType2;
  BookingIdModel selectBookingNo;
  TAXOH selectTAX;
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

  void onDataChange3(TAXOH state) {
    setState(() {
      selectTAX = state;
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
    taxohDropdownBloc = TAXOHDropdownBloc();
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

  Future<void> _refresh() {
    selectDepartmentName = null;
    selectVoucherType1 = null;
    selectVoucherType2 = null;
    selectBookingNo = null;
    selectTAX = null;
    selectChangeApplicable = null;
    dateinput.clear();
    dueDate.clear();
    baseAmount.clear();
    remarks.clear();
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (/*selectDepartmentName != null &&
          selectVoucherType1 != null &&*/
          selectBookingNo != null &&
              selectChangeApplicable != null &&
              // selectTAX != null &&
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
      var baseUrl =
          "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostUnitCancellation";
      var url = Uri.parse(baseUrl +
          "?" +
          "StrRecord=${'{"StrVType":"UCANC","StrSiteCode":"AD","StrCancelDate":"${dateinput.text}","StrBookingNo":"${selectBookingNo.DocId}",'
              '"StrChangeApplicable":"${selectChangeApplicable.strSubCode}","StrDueDate":"${dueDate.text}","DblBaseAmt":"${baseAmount.text}","DblTaxAmt":"450",StrTaxGrid:[{"StrOH":"${selectTAX.ExpCode}",'
              '"StrTaxOHCode":"${selectTAX.SubExpCode}","DblTaxPer":"${selectTAX.TaxPer}","DblRC_TaxPer":"${selectTAX.RC_TaxPer}","StrROff":"H","DblAmt":450,"StrSubCode":"${selectTAX.Account}"}],"DblNetAmt":"10450",'
              '"StrRemark":"${remarks.text}","StrBookingDate":"2022-06-07","StrPreparedBy":"SA","StrCustomer":"AD22","StrCostCenter":"AD1"}'}");
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
                        _refresh();
                      },
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadTextNew("Cancellation Date", width * .045),
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
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              formsHeadTextNew("Booking Id", width * .045),
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
                                padding: selectBookingNo != null
                                    ? height * .002
                                    : height * .015,
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            e.DocId ?? '',
                                          ),
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
              formsHeadTextNew("Change Applicable", width * .045),
              Padding(
                padding: padding1,
                child: Container(
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
                                padding: selectChangeApplicable != null
                                    ? height * .002
                                    : height * .015,
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.strName ?? ''),
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
              formsHeadTextNew("Due Date", width * .045),
              Container(
                padding: dateFieldPadding,
                height: height * .077,
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
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dueDate.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              sizedbox1,
              formsHeadTextNew("Base Amount (deduction amount)", width * .045),
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
              sizedbox1,
              formsHeadTextNew("Tax", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<TAXOH>>(
                      future:
                          taxohDropdownBloc.taxOHUnitCancelationDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<TAXOH>(
                            stream: taxohDropdownBloc
                                .selectedTAXOHUniCancelationState,
                            builder: (context, item) {
                              return SearchChoices<TAXOH>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectTAX != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectTAX,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<TAXOH>>((e) {
                                      return DropdownMenuItem<TAXOH>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Code),
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
              formsHeadTextNew("Remarks", width * .045),
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
