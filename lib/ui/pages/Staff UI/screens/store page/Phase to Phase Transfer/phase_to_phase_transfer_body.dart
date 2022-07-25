// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/godown_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/issued_to_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/phase_to_phase_transfer_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/add_item_container.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
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

import '../../../../../../infrastructure/Models/issued_to_model.dart';

class PhaseToPhaseTransferBody extends StatefulWidget {
  const PhaseToPhaseTransferBody({Key key}) : super(key: key);
  @override
  State<PhaseToPhaseTransferBody> createState() => MyPhaseToPhaseTransferBody();
}

class MyPhaseToPhaseTransferBody extends State<PhaseToPhaseTransferBody> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController reqQty = TextEditingController();
  final phaseToPhaseTransferFormKey = GlobalKey<FormState>();

  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc2;
  IssuedToDropdownBloc issuedToDropdownBloc;
  GodownDropdownBloc godownDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc3;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;
  ItemNameDropdownBloc itemNameDropdownBloc;
  // ItemCurrentStatusDropdownBloc dropdownBlocItemCurrentStatus;

  VoucherType selectVoucherType;
  VoucherType selectVoucherType2;
  IssuedTo selectIssuedTo;
  Godown selectFromGodown;
  Godown selectToGodown;
  VoucherType selectVoucherType3;
  ItemCostCenter selectFromItemCostCenter;
  ItemCostCenter selectToItemCostCenter;
  ItemNameModel selectItemName;
  // ItemCurrentStatus selectItemCurrentStatus;
  var subscription;
  var connectionStatus;
  String purchase;
  String qun;
  double _amount;
  double netamt = 0;
  String StringAmount;
  bool isActive = false;
  bool pressed = false;
  _calculation() {
    setState(
      () {
        //value1 = double.parse(reqQty.text);
        _amount = (double.parse(reqQty.text) *
            double.parse(selectItemName.PurchaseRate));
        StringAmount = _amount.toStringAsFixed(3);
      },
    );
    print(_amount);
  }

  @override
  void initState() {
    _amount = 0;
    reqQty = TextEditingController();
    reqQty.addListener(() {
      if (isActive = reqQty.text.isNotEmpty) {
        isActive = true;
      }
      setState(() => isActive = isActive);
    });

    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc2 = VoucherTypeDropdownBloc();
    issuedToDropdownBloc = IssuedToDropdownBloc();
    godownDropdownBloc = GodownDropdownBloc();
    voucherTypeDropdownBloc3 = VoucherTypeDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    itemNameDropdownBloc = ItemNameDropdownBloc();
    // dropdownBlocItemCurrentStatus = ItemCurrentStatusDropdownBloc();
    dateinput.text = "";
    _amount = 0;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    super.initState();
  }

  void clearData() {
    setState(() {
      selectVoucherType = null;
      selectToGodown = null;
      selectIssuedTo = null;
      selectFromGodown = null;
      selectToItemCostCenter = null;
      selectFromItemCostCenter = null;
      selectItemName = null;
      reqQty.clear();
      dateinput.clear();
      remarks.clear();
    });
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

  void onDataChange2(IssuedTo state) {
    setState(() {
      selectIssuedTo = state;
    });
  }

  void onDataChange3(Godown state) {
    setState(() {
      selectFromGodown = state;
    });
  }

  void onDataChange4(ItemCostCenter state) {
    setState(() {
      selectFromItemCostCenter = state;
    });
  }

  void onDataChange5(Godown state) {
    setState(() {
      selectToGodown = state;
    });
  }

  void onDataChange6(ItemCostCenter state) {
    setState(() {
      selectToItemCostCenter = state;
    });
  }

  void onDataChange7(ItemNameModel state) {
    setState(() {
      selectItemName = state;
    });
  }

  Future<void> _refresh() {
    selectVoucherType = null;
    selectToGodown = null;
    selectIssuedTo = null;
    selectFromGodown = null;
    selectToItemCostCenter = null;
    selectFromItemCostCenter = null;
    selectItemName = null;
    reqQty.clear();
    remarks.clear();
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (selectVoucherType != null &&
          selectIssuedTo != null &&
          selectFromGodown != null &&
          selectFromItemCostCenter != null &&
          selectToGodown != null &&
          selectToItemCostCenter != null &&
          phaseToPhaseTransferFormKey.currentState.validate()) {
        sendData();
      } else {
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
    } else {
      Scaffold.of(context).showSnackBar(snackBar(internetFailedConnectionText));
    }
  }

  List<ItemNameModel> listContainer = [];
  StreamController<List<ItemNameModel>> listStream = StreamController();
  var url, newurl;
  List<Map<String, String>> params = [];
  Future<dynamic> sendData() async {
    try {
      newurl =
          'http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostPhaseTransfer?StrRecord=${'{"StrTypeCode":"STKTR","StrSiteCode":"AD","StrNo":"1","StrDate":"${dateinput.text}","StrIssuedTo":"AS495","StrPreparedByCode":"SA",StrIndGrid:${params},"StrRemark":""}'}';
      url = Uri.parse(newurl);
      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final String responseString = response.body;
        return Scaffold.of(context).showSnackBar(snackBar(responseString));
      } else {
        return Scaffold.of(context).showSnackBar(snackBar(response.body));
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
    final bloc = PhaseToPhaseTransferProvider.of(context);
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
          key: phaseToPhaseTransferFormKey,
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
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc
                          .voucherTypePhaseToPhaseDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc
                                .selectedPhaseToPhaseState,
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
                                          child: Text(e.Description ?? ''),
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
              formsHeadTextNew("Date", width * .045),
              Container(
                padding: dateFieldPadding,
                height: height * .09,
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

              formsHeadTextNew("Issue To Which Staff", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IssuedTo>>(
                      future:
                          issuedToDropdownBloc.issuedToPhaseToPhaseDropDownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<IssuedTo>(
                            stream: issuedToDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<IssuedTo>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectIssuedTo != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIssuedTo,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<IssuedTo>>((e) {
                                      return DropdownMenuItem<IssuedTo>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
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
              sizedbox1,
              formsHeadTextNew("From Which Phase", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<Godown>>(
                      future: godownDropdownBloc.godownPhaseToPhaseFromData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Godown>(
                            stream: godownDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<Godown>.single(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                ),
                                padding: selectFromGodown != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectFromGodown,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<Godown>>((e) {
                                      return DropdownMenuItem<Godown>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.GodName),
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
              formsHeadTextNew("Location [From]", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc
                          .fromCostCenterPhaseToPhaseData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc
                                .selectedFromCostCenterPhaseToPhaseState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectFromItemCostCenter != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectFromItemCostCenter,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
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
              sizedbox1,
              formsHeadTextNew("To Phase", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<Godown>>(
                      future: godownDropdownBloc.godownPhaseToPhaseToData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Godown>(
                            stream:
                                godownDropdownBloc.selectedPhaseToPhaseToState,
                            builder: (context, item) {
                              return SearchChoices<Godown>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectToGodown != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectToGodown,
                                displayClearIcon: false,
                                onChanged: onDataChange5,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<Godown>>((e) {
                                      return DropdownMenuItem<Godown>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(e.GodName),
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
              formsHeadText("Location [To]"),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc
                          .toCostCenterPhaseToPhaseData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc
                                .selectedToCostCenterPhaseToPhaseState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectToItemCostCenter != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectToItemCostCenter,
                                displayClearIcon: false,
                                onChanged: onDataChange6,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<ItemCostCenter>>(
                                            (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
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
              sizedbox1,
              //  -------------------------
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: SizeConfig.getWidth(context),
                  decoration: BoxDecoration(
                    color: storeContainerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      formsHeadTextNew("Item", width * .045),
                      Padding(
                        padding: padding1,
                        child: Container(
                          decoration: decorationForms(),
                          child: FutureBuilder<List<ItemNameModel>>(
                              future: itemNameDropdownBloc
                                  .itemNamePhaseToPhaseDropdownData,
                              builder: (context, snapshot) {
                                return StreamBuilder<ItemNameModel>(
                                    stream: itemNameDropdownBloc
                                        .selecteditemPhaseToPhaseTransferState,
                                    builder: (context, item) {
                                      return SearchChoices<
                                          ItemNameModel>.single(
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 30),
                                        padding: selectItemName != null
                                            ? height * .002
                                            : height * .015,
                                        isExpanded: true,
                                        hint: "Search here",
                                        value: selectItemName,
                                        displayClearIcon: false,
                                        onChanged: onDataChange7,
                                        items: snapshot?.data?.map<
                                                DropdownMenuItem<
                                                    ItemNameModel>>((e) {
                                              return DropdownMenuItem<
                                                  ItemNameModel>(
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
                      SizedBox(
                        height: 10,
                      ),
                      formsHeadTextNew("Request Qty. ", width * .045),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Container(
                              padding: padding1,
                              decoration: decoration1(),
                              child: Container(
                                width: width * .28,
                                child: StreamBuilder<String>(
                                    stream: bloc.requestQty,
                                    builder: (context, snapshot) {
                                      return TextFormField(
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          _calculation();
                                        },
                                        // initialValue: "no",
                                        controller: reqQty,
                                        textAlign: TextAlign.center,

                                        decoration: InputDecoration(
                                          errorText: snapshot.error,
                                        ),
                                        onChanged: bloc.changerequestQty,
                                        keyboardType: TextInputType.number,
                                        //onSaved: selectItemCurrentStatus.strItemName,
                                        style: simpleTextStyle7(),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          selectItemName != null
                              ? Container(
                                  height: height * .067,
                                  width: width * .18,
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 15.0),
                                  decoration: decoration1(),
                                  child:
                                      Center(child: Text(selectItemName.SKU)))
                              : Container(
                                  height: height * .067,
                                  width: width * .18,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  decoration: decoration1(),
                                  child: const Center(child: Text("Unit"))),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              formsHeadTextNew("Rate", width * .045),
                              SizedBox(
                                width: 70,
                              ),
                              Column(
                                children: [
                                  formsHeadTextNew("Amount:", width * .045),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              selectItemName != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: Container(
                                          height: height * .067,
                                          width: width * .28,
                                          decoration: decoration1(),
                                          child: Center(
                                              child: Text(selectItemName
                                                  .PurchaseRate.toString()))),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: Container(
                                          height: height * .067,
                                          width: width * .28,
                                          decoration: decoration1(),
                                          child:
                                              const Center(child: Text("100"))),
                                    ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "$StringAmount",
                                style: containerTextStyle1(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13)),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    reqQty.clear();
                                  });
                                },
                                elevation: 0.0,
                                color: storeContainerColor,
                                child: raisedButtonText("Clear This Item"),
                              ),

                              /* StreamBuilder<bool>(
                              stream: bloc.submitCheck,
                              builder: (context, snapshot) {
                                return*/
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8)),
                              RoundedButtonInput(
                                text: "Add Item to List",
                                press: (selectItemName != null) && (isActive)
                                    ? () {
                                        selectItemName.requestQty = reqQty.text;
                                        _calculation();
                                        setState(() {
                                          netamt = (netamt + _amount);
                                          pressed = true;
                                          listContainer.add(selectItemName);
                                          listStream.add(listContainer);
                                          Map<String, String> localMap = {
                                            "StrCostCenterCode":
                                                "'${selectFromItemCostCenter.Code}'",
                                            "StrGodownCode":
                                                "'${selectFromGodown.GodCode}'",
                                            "StrToCostCenterCode":
                                                "'${selectToItemCostCenter.Code}'",
                                            "StrToGodownCode":
                                                "'${selectToGodown.GodCode}'",
                                            "StrItemCode":
                                                "'${selectItemName.SearchCode}'",
                                            "DblQuantity":
                                                "'${selectItemName.requestQty}'",
                                            "StrSKU": "'${selectItemName.SKU}'",
                                            "DblRate": "10",
                                            "DblAmt": "100"
                                          };
                                          params.add(localMap);
                                        });
                                        //clearData();
                                      }
                                    : null,
                                /*press: !snapshot.hasData ? null: (){
                                  } ,*/
                                fontsize1: 12,
                                size1: 0.4,
                                horizontal1: 30,
                                vertical1: 15,
                                color1: Colors.orange,
                                textColor1: textColor1,
                              ),
                              //}
                              // ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              pressed
                  ? StreamBuilder<List<ItemNameModel>>(
                      // ? StreamBuilder<List<String>>(
                      stream: listStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            height:
                                pressed == false ? height * 0.2 : height * 0.4,
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  qun = snapshot.data[index].requestQty;
                                  purchase = snapshot.data[index].PurchaseRate;
                                  double itemamt = double.parse(purchase) *
                                      double.parse(qun);
                                  return Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: height * .14,
                                            width: width * .95,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: primaryColor3,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: primaryColor5,
                                                  offset:
                                                      Offset(0.0, 1.0), //(x,y)
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: width * .35,
                                                            child: Text(
                                                              snapshot
                                                                  .data[index]
                                                                  .Name,
                                                              maxLines: 3,
                                                              style:
                                                                  containerTextStyle1(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                            height: 13,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Transfer Qty:',
                                                                style:
                                                                    containerTextStyle2(),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Rate:',
                                                                style:
                                                                    containerTextStyle2(),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Amount:',
                                                                style:
                                                                    containerTextStyle2(),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${snapshot.data[index].requestQty}' +
                                                                    "  " +
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .SKU,
                                                                style:
                                                                    containerTextStyle2(),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .PurchaseRate,
                                                                style:
                                                                    containerTextStyle2(),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${itemamt.toStringAsFixed(2)}",
                                                                style:
                                                                    containerTextStyle2(),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "HSN/SAC: " +
                                                            snapshot.data[index]
                                                                .HSN_SAC,
                                                        style:
                                                            containerTextStyle3(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            listContainer.removeAt(index);
                                            listStream.add(listContainer);
                                            setState(() {
                                              netamt = (netamt - itemamt);
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        return Container();
                      })
                  : const SizedBox(),
              sizedbox1,
              formsHeadText("Total Amount:  ${netamt.toStringAsFixed(2)}"),
              sizedbox1,
              formsHeadTextNew("Remarks", width * .045),
              Container(
                //height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: StreamBuilder<String>(
                  stream: bloc.outtextField,
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
                    onChanged: bloc.intextField,
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
                  padding: padding4,
                  child: roundedButtonHome2("Submit", () {
                    verifyDetail();
                    clearData();
                  }, roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}
