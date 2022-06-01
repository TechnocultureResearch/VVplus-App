// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/godown_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indent_no_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indent_selection_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/site_To_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Models/indent_no_model.dart';
import 'package:vvplus_app/infrastructure/Models/indent_selection_model.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/site_to_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
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

class BranchtoBranchSendBody extends StatefulWidget {
  const BranchtoBranchSendBody({Key key}) : super(key: key);
  @override
  State<BranchtoBranchSendBody> createState() => MyBranchtoBranchSendBody();
}

class MyBranchtoBranchSendBody extends State<BranchtoBranchSendBody> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController reqQty = TextEditingController();
  final branchToBranchSendFormKey = GlobalKey<FormState>();

  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  SiteToDropdownBloc siteToDropdownBloc;
  IndentNoDropdownBloc indentNoDropdownBloc;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;
  GodownDropdownBloc godownDropdownBloc;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc2;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc4;
  IndentorNameDropdownBloc indentorNameDropdownBloc;
  IndentSelectionDropdownBloc indentSelectionBtoBDropdownBloc;

  VoucherType selectVoucherType;
  SiteTo selectSiteTo;
  IndentNo selectIndentNo;
  ItemCostCenter selectItemCostCenter;
  Godown selectGodown;
  ItemCostCenter selectItemCostCenter2;
  ItemCostCenter selectItemCostCenter4;
  IndentorName selectIndentorName;
  IndentSelection selectIndentSelection;

  var subscription;
  var connectionStatus;

  @override
  void initState() {
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    siteToDropdownBloc = SiteToDropdownBloc();
    indentNoDropdownBloc = IndentNoDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    godownDropdownBloc = GodownDropdownBloc();
    itemCostCenterDropdownBloc2 = ItemCostCenterDropdownBloc();
    itemCostCenterDropdownBloc4 = ItemCostCenterDropdownBloc();
    indentorNameDropdownBloc = IndentorNameDropdownBloc();
    indentSelectionBtoBDropdownBloc = IndentSelectionDropdownBloc();
    dateinput.text = "";
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    super.initState();
  }

  double _amount;
  String StringAmount;
  _calculation() {
    setState(
      () {
        //value1 = double.parse(reqQty.text);
        _amount = (double.parse(selectIndentNo.IndQty.toString()) *
            double.parse(selectIndentNo.Rate.toString()));
        StringAmount = _amount.toStringAsFixed(3);
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void onDataChange1(VoucherType state) {
    setState(() {
      selectVoucherType = state;
    });
  }

  void onDataChange3(SiteTo state) {
    setState(() {
      selectSiteTo = state;
    });
  }

  void onDataChange4(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter = state;
    });
  }

  void onDataChange2(Godown state) {
    setState(() {
      selectGodown = state;
    });
  }

  void onDataChange6(IndentorName state) {
    setState(() {
      selectIndentorName = state;
    });
  }

  void onDataChange7(IndentNo state) {
    setState(() {
      selectIndentNo = state;
    });
  }

  void onDataChange8(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter2 = state;
    });
  }

  void onDataChange9(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter4 = state;
    });
  }

  void onDataChange10(IndentSelection state) {
    setState(() {
      selectIndentSelection = state;
    });
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
          selectItemCostCenter != null &&
          selectItemCostCenter2 != null &&
          selectGodown != null &&
          selectSiteTo != null &&
          /* selectIndentorName != null &&
          selectIndentNo != null &&*/
          branchToBranchSendFormKey.currentState.validate()) {
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
      var baseurl =
          'http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostStkTransferMan';

      var url = Uri.parse(baseurl +
          "?" +
          'StrRecord=${'{"StrVType":"${selectVoucherType.V_Type}","StrVDate":"${dateinput.text}","StrFrmSite":"AA","StrFrmParty":"${selectSiteTo.SubCode}","StrFrmCC":"${selectItemCostCenter.Code}",'
              '"StrFrmGodown":"${selectGodown.GodCode}","StrToSite":"${selectSiteTo.Code}","StrToParty":"${selectSiteTo.SubCode}","StrToCC":"${selectItemCostCenter.Code}",'
              '"StrVehicleNo":"","StrIndent":"","StrSiteCode":"AD",StrIndGrid:[{"StrItemCode":"${selectIndentSelection.itemCode}",'
              '"DblQuantity":"${selectIndentNo.IndQty}","StrSKU":"${selectIndentNo.Unit}","DblRate":"${selectIndentNo.Rate}","DblAmt":"10",StrItemGrid:[{"StrIndDocID":"${selectIndentNo.RefDocId}","DblTrnQuantity":"${selectIndentNo.AdjQty}"}],'
              '"DblItemValueRate":"${selectIndentSelection.rate}","DblItemValueAmt":"0","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"100","DblAVAmt":"100",'
              '"DblSGSTRate":"9","DblSGSTAmt":"9","DblCGSTRate":"9","DblCGSTAmt":"9","DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0",'
              '"DblUGSTAmt":"0","DblNetValueRate":"118","DblNetValueAmt":"118"}],	'
              '"DblGrossRate":"0","DblGrossAmt":"118","DblDiscountRate":"0","DblDiscountAmt":"0","DblAVRate":"0","DblAVAmt":"100",'
              '"DblSGSTRate":"0","DblSGSTAmt":"9","DblCGSTRate":"0","DblCGSTAmt":"9","DblIGSTRate":"0","DblIGSTAmt":"0","DblUGSTRate":"0","DblUGSTAmt":"0",'
              '"DblOtherAddRate":"0","DblOtherAddAmt":"0","DblOtherDedRate":"0","DblOtherDedAmt":"0","DblBillRate":"0","DblBillAmt":"0","DblRoundOffRate":"0",'
              '"DblRoundOffAmt":"0","DblNetValueRate":"0","DblNetValueAmt":"118","StrPreparedBy":"SA","StrAgtForm":"HO3"}'}');
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
    //   await http.post(Uri.parse(ApiService.mockDataPostBranchToBranchSend),
    //       body: json.encode({
    //         "Voucher Type": selectVoucherType.strSubCode,
    //         "VoucherNoDate": dateinput.text,
    //         "FromBranch": selectItemCostCenter.Code,
    //         "FromPhase": selectItemCostCenter2.strSubCode,
    //         "FromGodown": selectGodown.GodCode,
    //         "ToBranch": selectItemCostCenter.Code,
    //         "ToPhase": selectItemCostCenter4.strSubCode,
    //         "ToGodown": selectGodown.GodCode,
    //         "VehicleNo": selectIndentNo.IndNo,
    //         "IndentSelection": selectIndentorName.strSubCode
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
          key: branchToBranchSendFormKey,
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
                        selectIndentNo = null;
                        selectSiteTo = null;
                        selectGodown = null;
                        selectIndentSelection = null;
                        selectVoucherType = null;
                        selectItemCostCenter = null;
                        selectIndentorName = null;
                        dateinput.clear();
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
                          .voucherTypeBToBSendDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream:
                                voucherTypeDropdownBloc.selectedBToBSendState,
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
                                          child: Text(e.description ?? ""),
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
              formsHeadTextNew("Voucher No. Date", width * .045),
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
              formsHeadTextNew("From CostCenter", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc
                          .fromcostCenterBranchToBranchSendData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc
                                .selectedFromBranchToBranchSendState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectItemCostCenter != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Name ?? ""),
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
              formsHeadTextNew("Godown", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<Godown>>(
                      future: godownDropdownBloc.godownDropDownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Godown>(
                            stream: godownDropdownBloc
                                .selectedBranchToBranchSendFromState,
                            builder: (context, item) {
                              return SearchChoices<Godown>.single(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                ),
                                padding: selectGodown != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectGodown,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<Godown>>((e) {
                                      return DropdownMenuItem<Godown>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.GodName ?? ""),
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
              formsHeadTextNew("To CostCenter", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc
                          .tocostCenterBranchToBranchSendData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc
                                .selectedToBranchToBranchSendState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectItemCostCenter2 != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter2,
                                displayClearIcon: false,
                                onChanged: onDataChange8,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Name ?? ""),
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
              formsHeadTextNew("Site To", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<SiteTo>>(
                      future: siteToDropdownBloc.siteToDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<SiteTo>(
                            stream: siteToDropdownBloc.selectedSiteToState,
                            builder: (context, item) {
                              return SearchChoices<SiteTo>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectSiteTo != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectSiteTo,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<SiteTo>>((e) {
                                      return DropdownMenuItem<SiteTo>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.Name ?? ""),
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
              formsHeadTextNew("Indent No.", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IndentNo>>(
                      future: indentNoDropdownBloc.indentNoDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<IndentNo>(
                            stream: indentNoDropdownBloc.selectedIndentNoState,
                            builder: (context, item) {
                              return SearchChoices<IndentNo>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectIndentNo != null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentNo,
                                displayClearIcon: false,
                                onChanged: onDataChange7,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<IndentNo>>((e) {
                                      return DropdownMenuItem<IndentNo>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.RefDocId ?? ""),
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
              formsHeadTextNew("Indent Selection", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IndentSelection>>(
                      future: indentSelectionBtoBDropdownBloc
                          .indentSelectionBtoBDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<IndentSelection>(
                            stream: indentSelectionBtoBDropdownBloc
                                .selectedIndentSelectionBtoBState,
                            builder: (context, item) {
                              return SearchChoices<IndentSelection>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectIndentSelection != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentSelection,
                                displayClearIcon: false,
                                onChanged: onDataChange10,
                                items: snapshot?.data?.map<
                                        DropdownMenuItem<IndentSelection>>((e) {
                                      return DropdownMenuItem<IndentSelection>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.itemName ?? ""),
                                        ),
                                      );
                                    })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              selectIndentorName != null
                  ? InformationBoxContainer6(
                      text1: selectIndentorName.strName,
                      text2: selectIndentorName.strSubCode,
                      text3: selectIndentorName.strSubCode,
                      text4: selectIndentorName.strSubCode,
                      text5: selectIndentorName.strSubCode,
                      text6: selectIndentorName.strSubCode,
                      text7: selectIndentorName.strSubCode,
                      //text8: selectIndentorName.strSubCode,
                    )
                  : const SizedBox(),
              //sizedbox1,
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
