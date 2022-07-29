// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/booking_id_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/stage_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/taxoh_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/extra_work_entry_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/booking_id_model.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/stage_model.dart';
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

import '../../../../../../infrastructure/Models/Tax_oh_model.dart';

class ExtraWorkEntryBody extends StatefulWidget {
  const ExtraWorkEntryBody({Key key}) : super(key: key);
  @override
  State<ExtraWorkEntryBody> createState() => MyExtraWorkEntryBody();
}

class MyExtraWorkEntryBody extends State<ExtraWorkEntryBody> {
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _baseAmount = TextEditingController();
  final _extraWorkEntryFormKey = GlobalKey<FormState>();
  DepartmentNameDropdownBloc departmentNameDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  StageDropdownBloc stageDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc2;
  TAXOHDropdownBloc taxohDropdownBloc;
  BookingIdDropdownBloc bookingIdDropdownBloc;

  DepartmentName selectDepartmentName;
  VoucherType selectVoucherType;
  Stage selectStage;
  BookingIdModel selectBookingId;
  TAXOH selectTaxOh;
  VoucherType selectVoucherType2;
  var subscription;
  var connectionStatus;

  void onDataChange1(DepartmentName state) {
    setState(() {
      selectDepartmentName = state;
    });
  }

  void onDataChange2(VoucherType state) {
    setState(() {
      selectVoucherType = state;
    });
  }

  void onDataChange4(Stage state) {
    setState(() {
      selectStage = state;
    });
  }

  void onDataChange3(TAXOH state) {
    setState(() {
      selectTaxOh = state;
    });
  }

  void onDataChange5(BookingIdModel state) {
    setState(() {
      selectBookingId = state;
    });
  }

  String formatted;
  @override
  void initState() {
    dateinput.text = "";
    departmentNameDropdownBloc = DepartmentNameDropdownBloc();
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    stageDropdownBloc = StageDropdownBloc();
    taxohDropdownBloc = TAXOHDropdownBloc();
    voucherTypeDropdownBloc2 = VoucherTypeDropdownBloc();
    bookingIdDropdownBloc = BookingIdDropdownBloc();
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

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    selectDepartmentName = null;
    selectVoucherType = null;
    selectStage = null;
    selectBookingId = null;
    selectTaxOh = null;
    selectVoucherType2 = null;
    _remarks.clear();
    _baseAmount.clear();
    dateinput.clear();
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (
          //selectVoucherType != null &&
          selectBookingId != null &&
              selectStage != null &&
              selectTaxOh != null &&
              _extraWorkEntryFormKey.currentState.validate()) {
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
          'http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostOtherSchedule';
      var url = Uri.parse(baseUrl +
          "?" +
          'StrRecord=${'{"StrVType":"${selectVoucherType.V_Type}","StrSiteCode":"RN","StrEntryDate":"${dateinput.text}","StrBookingNo":"${selectBookingId.DocId}",'
              '"StrCustomer":"AD15","StrTax":"${selectTaxOh.Description}",StrIndGrid:[{"StrStage":"${selectStage.SearchCode}","StrOverhead":"8","StrDueDate":"${selectStage.DueDate}",'
              '"DblBaseAmt":"${_baseAmount.text}","DblTaxAmt":"10",'
              'StrTaxGrid:[{"StrOH":"8","StrTaxOHCode":"${selectTaxOh.SubExpCode}","DblTaxPer":"${selectTaxOh.TaxPer}","DblRC_TaxPer":"${selectTaxOh.RC_TaxPer}",'
              '"StrROff":"Y","DblAmt":"5","StrSubCode":"${selectTaxOh.Account}"},'
              '{"StrOH":"8","StrTaxOHCode":"${selectTaxOh.SubExpCode}","DblTaxPer":"${selectTaxOh.TaxPer}","DblRC_TaxPer":"${selectTaxOh.RC_TaxPer}",'
              '"StrROff":"Y","DblAmt":"5","StrSubCode":"${selectBookingId.SubCode}"}],"DblNetAmt":"1010"}],'
              '"StrRemark":"${_remarks.text}","StrPreparedBy":"SA"}'}');

      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      // final response = await http.post(Uri.parse(ApiService.postStockReceiveEntrynewURL),
      //      body:json.encode({
      //        "StrRecord":{"StrVType":selectVoucherType1.V_Type,"StrVDate":"2022-01-29",
      //          "StrSiteCode":"AD","StrReceiveFrom":selectReceivedBy.SubCode,
      //          "StrIndGrid":[{"StrItemCode":selectItemCurrentStatus.Code,
      //          "DblQuantity":reqQty.text,"DblAmt":_amount,"DblRate":selectItemCurrentStatus.PurchaseRate,
      //          "StrCostCenterCode":selectItemCostCenter.Code,"StrGodown":selectGodown.GodCode,
      //          "StrRemark":"Remark1"}],"StrPreparedBy":"SA"
      //        }
      //        // "Voucher Type": selectVoucherType1.strName,
      //        // "Received By": selectReceivedBy.Name,
      //        // "Godown": selectGodown.GodName,
      //        // "Cost Center":selectItemCostCenter.strName,
      //        // "Item": selectItemCurrentStatus.Name,
      //        // "ReqQuantity": reqQty.text,
      //        // "Unit": selectItemCurrentStatus.strUnit,
      //        // "Rate": selectItemCurrentStatus.PurchaseRate,
      //      })
      // );
      if (response.statusCode == 200) {
        clearData();

        final String code = response.statusCode.toString();
        Scaffold.of(context).showSnackBar(snackBar("Status code : $code"));
        final String responseString = response.body;
        return Scaffold.of(context).showSnackBar(snackBar(responseString));
      } else {
        return Scaffold.of(context).showSnackBar(snackBar("Not Succeed"));
      }
      Scaffold.of(context).showSnackBar(snackBar(sendDataText));
    } catch (e) {
      rethrow;
    }
    // on SocketException {
    //   Scaffold.of(context).showSnackBar(snackBar(socketExceptionText));
    // } on HttpException {
    //   Scaffold.of(context).showSnackBar(snackBar(httpExceptionText));
    // } on FormatException {
    //   Scaffold.of(context).showSnackBar(snackBar(formatExceptionText));
    // }
  }

  void clearData() {
    setState(() {
      selectDepartmentName = null;
      selectVoucherType = null;
      selectStage = null;
      selectBookingId = null;
      selectTaxOh = null;
      selectVoucherType2 = null;
      _remarks.clear();
      _baseAmount.clear();
      dateinput.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final bloc = SalesExtraWorkEntryProvider.of(context);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Form(
          key: _extraWorkEntryFormKey,
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
                        // _refresh();
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
                  //height: height * .076,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc
                          .voucherTypeExtraWorkEntryDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc
                                .selectedExtraEorkEntryState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectVoucherType != null
                                    ? height * .002
                                    : height * .014,
                                isExpanded: true,
                                hint: "Search here",
                                underline: "",
                                value: selectVoucherType,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
              formsHeadTextNew("Booking Id", width * .045),

              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<BookingIdModel>>(
                      future: bookingIdDropdownBloc.bookingIdDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<BookingIdModel>(
                            stream:
                                bookingIdDropdownBloc.selectedBookingIdState,
                            builder: (context, item) {
                              return SearchChoices<BookingIdModel>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 28),
                                padding: selectBookingId != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectBookingId,
                                displayClearIcon: false,
                                onChanged: onDataChange5,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<BookingIdModel>>(
                                            (e) {
                                      return DropdownMenuItem<BookingIdModel>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
              selectBookingId != null
                  ? InformationBoxContainer3(
                      text1: selectBookingId.DocId,
                      text2: selectBookingId.UnitName,
                      text3: selectBookingId.V_Date,
                      text4: selectBookingId.UnitCategoryname,
                      text5: selectBookingId.FloorName,
                      text6: selectBookingId.UnitArea,
                      text7: selectBookingId.UnitCost,
                      text8: selectBookingId.Customer,
                    )
                  : const SizedBox(),
              sizedbox1,
              formsHeadTextNew(
                  "Stage (purpose? extra work? extra land?)", width * .045),

              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<Stage>>(
                      future: stageDropdownBloc.stageDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Stage>(
                            stream: stageDropdownBloc.selectedStageState,
                            builder: (context, item) {
                              return SearchChoices<Stage>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectStage != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectStage,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<Stage>>((e) {
                                      return DropdownMenuItem<Stage>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
              formsHeadTextNew("Overhead", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<TAXOH>>(
                      future: taxohDropdownBloc.taxOHDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<TAXOH>(
                            stream: taxohDropdownBloc.selectedTAXOHState,
                            builder: (context, item) {
                              return SearchChoices<TAXOH>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectTaxOh != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectTaxOh,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<TAXOH>>((e) {
                                      return DropdownMenuItem<TAXOH>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
              formsHeadTextNew("Date of Estimate", width * .045),
              Container(
                padding: dateFieldPadding,
                height: height * .099,
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
              formsHeadTextNew("Base Amount", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  width: width * .8,
                  decoration: decoration1(),
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField2,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if (val != _baseAmount.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val)
                              ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: _baseAmount,
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
              formsHeadTextNew("Tax:", width * .045),
              sizedbox1,
              //formsHeadText("Net Amount:"),
              formsHeadTextNew("Net Amount:", width * .045),
              sizedbox1,
              //formsHeadText("Remarks"),
              formsHeadTextNew("Remarks", width * .045),
              Container(
                //height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outtextField3,
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
                    onChanged: bloc.intextField3,
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
