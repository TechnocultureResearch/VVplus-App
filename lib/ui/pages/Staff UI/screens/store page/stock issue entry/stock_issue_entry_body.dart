// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/stock_issue_entry_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
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
  VoucherTypeDropdownBloc voucherTypeDropdownBloc2;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc3;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;
  ItemCurrentStatusDropdownBloc dropdownBlocItemCurrentStatus;

  VoucherType selectVoucherType1;
  VoucherType selectVoucherType2;
  VoucherType selectVoucherType3;
  ItemCostCenter selectItemCostCenter;
  ItemCurrentStatus selectItemCurrentStatus;

  double _amount;
  var subscription;
  var connectionStatus;
  String StringAmount;

  void clearData(){
    reqQty.clear();
  }

  _calculation() {
    setState(() {
      //value1 = double.parse(reqQty.text);
      _amount = (double.parse(reqQty.text)*double.parse(selectItemCurrentStatus.dblQty));
      StringAmount= _amount.toStringAsFixed(3);
    },);
    print(_amount);
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
    voucherTypeDropdownBloc2 = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc3 = VoucherTypeDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    dropdownBlocItemCurrentStatus = ItemCurrentStatusDropdownBloc();
    _amount = 0;
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

  void onDataChange1(VoucherType state) {
    setState(() {
      selectVoucherType1 = state;
    });
  }

  void onDataChange2(VoucherType state) {
    setState(() {
      selectVoucherType2 = state;
    });
  }

  void onDataChange3(VoucherType state) {
    setState(() {
      selectVoucherType3 = state;
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

  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }
  verifyDetail(){
    if(connectionStatus == ConnectivityResult.wifi || connectionStatus == ConnectivityResult.mobile){
      if(selectVoucherType1!=null && selectVoucherType2!=null && selectVoucherType3!=null && selectItemCostCenter!=null && stockIssueEntryFormKey.currentState.validate()){
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
      await http.post(Uri.parse(ApiService.mockDataPostStockIssueEntry),
          body: json.encode({
            "Voucher Type": selectVoucherType1.strName,
            "Issue By": selectVoucherType2.strName,
            "Godown": selectVoucherType3.strName,
            "Cost Center":selectItemCostCenter.strName,
            "Item": selectItemCurrentStatus.strItemName,
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
                      onPressed: () {reqQty.clear();},
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadText("Voucher Type"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52,
                  width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc1.voucherTypeStockIssueDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc1.selecteddState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectVoucherType1!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType1,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<VoucherType>>((e) {
                                  return DropdownMenuItem<VoucherType>(
                                    value: e,
                                    child: Text(e.V_Type),
                                  );
                                })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("Issue By"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52,
                  width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc1.voucherTypeDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc1.selectedState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectVoucherType2!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType2,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<VoucherType>>((e) {
                                  return DropdownMenuItem<VoucherType>(
                                    value: e,
                                    child: Text(e.strName),
                                  );
                                })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("Godown"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52,
                  width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc1.voucherTypeDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc1.selectedState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectVoucherType3!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType3,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<VoucherType>>((e) {
                                  return DropdownMenuItem<VoucherType>(
                                    value: e,
                                    child: Text(e.strName),
                                  );
                                })?.toList() ??
                                    [],
                              );
                            });
                      }),
                ),
              ),
              sizedbox1,
              formsHeadText("Choose your phase (Cost Centre"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52,
                  width: 343,
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
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<ItemCostCenter>>(
                                        (e) {
                                      return DropdownMenuItem<ItemCostCenter>(
                                        value: e,
                                        child: Text(e.strName),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 378,
                    width: SizeConfig.getWidth(context),
                    decoration: BoxDecoration(
                      color: storeContainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.all(10)),
                        formsHeadText("Item "),
                        Padding(
                          padding: padding1,
                          child: Container(
                            height: 52,
                            width: 343,
                            decoration: decorationForms(),
                            child: FutureBuilder<List<ItemCurrentStatus>>(
                                future: dropdownBlocItemCurrentStatus
                                    .itemCurrentStatusDropdowndata,
                                builder: (context, snapshot) {
                                  return StreamBuilder<ItemCurrentStatus>(
                                      stream:
                                      dropdownBlocItemCurrentStatus.selectedState,
                                      builder: (context, item) {
                                        return SearchChoices<
                                            ItemCurrentStatus>.single(
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down_sharp,size:30),
                                          padding: selectItemCurrentStatus!=null ? 2 : 11,
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
                                              child: Text(e.strItemName),
                                            );
                                          })?.toList() ??
                                              [],
                                        );
                                      });
                                }),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        formsHeadText("Request Qty. "),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35),
                              child: Container(
                                height: 50,
                                padding: padding1,
                                decoration: decoration1(),
                                child: SizedBox(
                                  width: 130,
                                  child: StreamBuilder<String>(
                                      stream: bloc.requestQty,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          onEditingComplete: (){
                                            _calculation();
                                          },
                                          // initialValue: "no",
                                          controller: reqQty,
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
                                ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                                  child: Container(
                                  height: 50,
                                  padding: padding1,
                                  decoration: decoration1(),
                                  child: Center(
                                      child: Text(selectItemCurrentStatus.strUnit))),
                                )
                                : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  height: 50,
                                  padding: padding1,
                                  decoration: decoration1(),
                                  child: const Center(child: Text("No"))),
                                ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Row(
                          children: [
                            formsHeadText("Rate"),
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30)),
                            formsHeadText("Amount:"),
                          ],
                        ),
                        Row(
                          children: [
                            selectItemCurrentStatus != null
                                ? Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 40),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    height: 50,
                                    padding: padding1,
                                    decoration: decoration1(),
                                    child: Center(
                                        child: Text(
                                            selectItemCurrentStatus.dblQty))),
                              ),
                            )
                                : Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 40),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    height: 50,
                                    padding: padding1,
                                    decoration: decoration1(),
                                    child: const Center(child: Text("No"))),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child:Text("$StringAmount",
                                style: containerTextStyle1(),),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            RaisedButton(
                              onPressed: () {},
                              elevation: 0.0,
                              color: storeContainerColor,
                              child: raisedButtonText("Clear This Item"),
                            ),

                            /* StreamBuilder<bool>(
                                stream: bloc.submitCheck,
                                builder: (context, snapshot) {
                                  return*/
                            RoundedButtonInput(
                              text: "Add Item to List",
                              press: (selectItemCurrentStatus !=null)&&(isActive) ? () {
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
                              size1: 0.5,
                              horizontal1: 30,
                              vertical1: 10,
                              color1: Colors.orange,
                              textColor1: textColor1,
                            ),
                            //}
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //-----------------------------------------------------------
              pressed? AddItemContainer(
                itemNameText: selectItemCurrentStatus.strItemName,
                orderQtyText: reqQty.text,
                rateText: selectItemCurrentStatus.dblQty,
                amountText: StringAmount.toString(),
              ) : const SizedBox(),

              sizedbox1,
              formsHeadText("Total Amount:"),
              sizedbox1,
              Padding(
                  padding: padding4,
                  child:
                  roundedButtonHome2("Submit", () {
                    verifyDetail();
                  }, roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}