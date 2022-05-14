// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/godown_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/issued_to_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/stock_issue_entry_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Models/issued_to_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/add_item_container.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'dart:io';

class StockIssueEntryBody extends StatefulWidget {
  const StockIssueEntryBody({Key key}) : super(key: key);

  @override
  State<StockIssueEntryBody> createState() => MyStockIssueEntryBody();
}

class MyStockIssueEntryBody extends State<StockIssueEntryBody> {
  bool isActive = false;
  bool pressed = false;
  TextEditingController reqQty = TextEditingController();
  final stockIssueEntryFormKey = GlobalKey<FormState>();

  VoucherTypeDropdownBloc voucherTypeDropdownBloc1;
  IssuedToDropdownBloc issuedToDropdownBloc;
  GodownDropdownBloc godownDropdownBloc;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;
  ItemCurrentStatusDropdownBloc dropdownBlocItemCurrentStatus;

  VoucherType selectVoucherType1;
  IssuedTo selectIssuedTo;
  Godown selectGodown;
  VoucherType selectVoucherType3;
  ItemCostCenter selectItemCostCenter;
  ItemCurrentStatus selectItemCurrentStatus;

  double _amount;
  var subscription;
  var connectionStatus;
  String StringAmount;

  void clearData() {
    selectVoucherType1 = null;
    selectIssuedTo = null;
    selectGodown = null;
    selectVoucherType3 = null;
    selectItemCostCenter = null;
    selectItemCurrentStatus = null;
    reqQty.clear();
  }

  _calculation() {
    setState(
      () {
        //value1 = double.parse(reqQty.text);
        _amount = (double.parse(reqQty.text) *
            double.parse(selectItemCurrentStatus.PurchaseRate));
        StringAmount = _amount.toStringAsFixed(3);
      },
    );
  }

  @override
  void initState() {
    _amount = 0;
    super.initState();
    reqQty = TextEditingController();
    reqQty.addListener(() {
      if (isActive = reqQty.text.isNotEmpty) {
        isActive = true;
      }
      setState(() => isActive = isActive);
    });
    voucherTypeDropdownBloc1 = VoucherTypeDropdownBloc();
    issuedToDropdownBloc = IssuedToDropdownBloc();
    godownDropdownBloc = GodownDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    dropdownBlocItemCurrentStatus = ItemCurrentStatusDropdownBloc();
    _amount = 0;
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

  void onDataChange1(VoucherType state) {
    setState(() {
      selectVoucherType1 = state;
    });
  }

  void onDataChange2(IssuedTo state) {
    setState(() {
      selectIssuedTo = state;
    });
  }

  void onDataChange3(Godown state) {
    setState(() {
      selectGodown = state;
    });
  }

  void onDataChange4(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter = state;
    });
  }

  void onDataChange5(ItemCurrentStatus state) {
    setState(() {
      selectItemCurrentStatus = state;
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
      if (selectVoucherType1 != null &&
          selectIssuedTo != null &&
          selectGodown != null &&
          selectItemCostCenter != null &&
          stockIssueEntryFormKey.currentState.validate()) {
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
      await http.post(Uri.parse(ApiService.mockDataPostStockIssueEntry),
          body: json.encode({
            "Voucher Type": selectVoucherType1.strName,
            "Issue By": selectIssuedTo.Name,
            "Godown": selectGodown.GodName,
            "Cost Center": selectItemCostCenter.Name,
            "Item": selectItemCurrentStatus.Name,
            "ReqQuantity": reqQty.text,
            "Unit": selectItemCurrentStatus.strUnit,
            "Rate": selectItemCurrentStatus.dblQty,
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
    final bloc = StockIssueEntryProvider.of(context);
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
          key: stockIssueEntryFormKey,
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
                        reqQty.clear();
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
                      future: voucherTypeDropdownBloc1
                          .voucherTypeStockIssueDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc1.selecteddState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectVoucherType1 != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType1,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                        ?.map<DropdownMenuItem<VoucherType>>(
                                            (e) {
                                      return DropdownMenuItem<VoucherType>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
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
              formsHeadTextNew("Issue By", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IssuedTo>>(
                      future: issuedToDropdownBloc.issuedToDropDownData,
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
              formsHeadTextNew("Godown", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<Godown>>(
                      future: godownDropdownBloc.godownDropDownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Godown>(
                            stream: godownDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<Godown>.single(
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30),
                                padding: selectGodown != null
                                    ? height * .002
                                    : height * .015,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectGodown,
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
              formsHeadTextNew("Choose your phase (Cost Centre)", width * .045),
              Padding(
                padding: padding1,
                child: Container(
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc
                          .itemCostCenterStockIssueEntryData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc
                                .selectedCostCenterState,
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
              //----------------------------------------
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
                          child: FutureBuilder<List<ItemCurrentStatus>>(
                              future: dropdownBlocItemCurrentStatus
                                  .itemCurrentStatusStockIssueEntryDropdownData,
                              builder: (context, snapshot) {
                                return StreamBuilder<ItemCurrentStatus>(
                                    stream: dropdownBlocItemCurrentStatus
                                        .selectedStateitemCurrentStatus,
                                    builder: (context, item) {
                                      return SearchChoices<
                                          ItemCurrentStatus>.single(
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 30),
                                        padding: selectItemCurrentStatus != null
                                            ? height * .002
                                            : height * .015,
                                        isExpanded: true,
                                        hint: "Search here",
                                        value: selectItemCurrentStatus,
                                        displayClearIcon: false,
                                        onChanged: onDataChange5,
                                        items: snapshot?.data?.map<
                                                DropdownMenuItem<
                                                    ItemCurrentStatus>>((e) {
                                              return DropdownMenuItem<
                                                  ItemCurrentStatus>(
                                                value: e,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(e.Name),
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
                                          FocusScope.of(context).requestFocus(FocusNode());
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
                          selectItemCurrentStatus != null
                              ? Container(
                                  height: height * .067,
                                  width: width * .18,
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 15.0),
                                  decoration: decoration1(),
                                  child: Center(
                                      child: Text(selectItemCurrentStatus.SKU)))
                              : Container(
                                  height: height * .067,
                                  width: width * .18,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  decoration: decoration1(),
                                  child: const Center(child: Text("No"))),
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
                              selectItemCurrentStatus != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: Container(
                                          height: height * .067,
                                          width: width * .28,
                                          decoration: decoration1(),
                                          child: Center(
                                              child: Text(
                                                  selectItemCurrentStatus
                                                      .PurchaseRate))),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: Container(
                                          height: height * .067,
                                          width: width * .28,
                                          decoration: decoration1(),
                                          child: const Center(
                                              child: Text("00.00"))),
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
                                      EdgeInsets.symmetric(horizontal: 10)),
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
                                press: (selectItemCurrentStatus != null) &&
                                        (isActive)
                                    ? () {
                                        _calculation();
                                        setState(() {
                                          pressed = true;
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
              //-----------------------------------------------------------
              pressed
                  ? AddItemContainer(
                      itemNameText: selectItemCurrentStatus.Name,
                      orderQtyText: reqQty.text,
                      rateText: selectItemCurrentStatus.PurchaseRate,
                      amountText: StringAmount.toString(),
                    )
                  : const SizedBox(),

              sizedbox1,
              formsHeadText("Total Amount:"),
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
