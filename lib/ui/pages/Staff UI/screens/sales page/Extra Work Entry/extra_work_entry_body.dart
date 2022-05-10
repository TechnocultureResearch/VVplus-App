// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/booking_id_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/stage_dropdown_bloc.dart';
//import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/stage_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/taxoh_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/extra_work_entry_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
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
  final TextEditingController _voucherType = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _baseAmount = TextEditingController();
  final extraWorkEntryFormKey = GlobalKey<FormState>();

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
  //var size, height, width;
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
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (selectVoucherType != null &&
          selectBookingId != null &&
          selectStage != null &&
          selectTaxOh != null &&
          extraWorkEntryFormKey.currentState.validate()) {
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
      await http.post(Uri.parse(ApiService.mockDataPostExtraWorkEntry),
          body: json.encode({
            "VoucherType": _voucherType.text,
            "BookingId": selectBookingId.DocId,
            "StagePurpose": selectStage.SearchCode,
            "Overhead": selectTaxOh.Code,
            "DateOfEstimate": dateinput.text,
            "BaseAmount": _baseAmount.text,
            "Remarks": _remarks.text
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
          key: extraWorkEntryFormKey,
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
                        _voucherType.clear();
                        _remarks.clear();
                        _baseAmount.clear();
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
                  // height: height * .076,
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
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
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
              selectDepartmentName != null
                  ? InformationBoxContainer3(
                      text1: selectDepartmentName.strSubCode,
                      text2: selectDepartmentName.strSubCode,
                      text3: selectDepartmentName.strSubCode,
                      text4: selectDepartmentName.strSubCode,
                      text5: selectDepartmentName.strSubCode,
                      text6: selectDepartmentName.strSubCode,
                      text7: selectDepartmentName.strSubCode,
                      text8: selectDepartmentName.strName,
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
                                          child: Text(e.SearchCode ?? ''),
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
              formsHeadTextNew("Base Amount", width * .045),
              Container(
                //height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  //width: 320,
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
                height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  width: 320,
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
