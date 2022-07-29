// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, deprecated_member_use

import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/material_request_entry_page_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'dart:io';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

import '../../../../../../Application/Bloc/Dropdown_Bloc/item_name_dropdown_bloc.dart';
import '../../../../../../infrastructure/Models/voucher_type_materialreqEntry.dart';

class MaterialEntryBody extends StatefulWidget {
  const MaterialEntryBody({Key key}) : super(key: key);
  @override
  State<MaterialEntryBody> createState() => MyMaterialEntryBody();
}

class MyMaterialEntryBody extends State<MaterialEntryBody> {
  bool isActive = false;
  bool pressed = false;
  bool showAmount = false;
  bool itemres = false;
  var subscription;
  var connectionStatus;
  double value1 = 0, value2 = 46.599;
  double _amount;
  String order = '';
  List<Widget> _itemContainer = [];
  List<Map<String, String>> params = [];
// List<dynamic> params = [] ;
  // var params;
  // List itemStatus = ['ItemName','CostCenterName','DblQty','Unit'];
  double Dblq;
  String Unit;

  bool isdelet = true;
  void clearData() {
    setState(() {
      selectVoucherType = null;
      selectIndentorName = null;
      selectItemCurrentStatus = null;
      selectItemCostCenter = null;
      selectDepartment = null;
      Dblq = null;
      Unit = null;
      reqQty.clear();
      remarks.clear();
      intendDateInput.clear();
      reqDateInput.clear();
      selectItemName = null;
    });
  }

  TextEditingController intendDateInput = TextEditingController();
  TextEditingController reqDateInput = TextEditingController();
  TextEditingController indentType = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController reqQty = TextEditingController(text: '0');
  TextEditingController itemContReqQty = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController costCenter = TextEditingController();
  TextEditingController remarks = TextEditingController();

  final materialRequestEntryFormKey = GlobalKey<FormState>();

  String dropdownValue = 'Choose an option';
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;
  ItemNameDropdownBloc itemNameDropdownBloc;
  IndentorNameDropdownBloc indentorNameDropdownBloc;
  DepartmentNameDropdownBloc departmentNameDropdownBloc;
  ItemCurrentStatusDropdownBloc dropdownBlocItemCurrentStatus;
  ItemCostCenterDropdownBloc dropdownBlocItemCostCenter;

  // _calculation() {
  //   setState(
  //     () {
  //       //value1 = double.parse(reqQty.text);
  //       _amount = (double.parse(reqQty.text) *
  //           double.parse(selectItemCurrentStatus.PurchaseRate));
  //       StringAmount = _amount.toStringAsFixed(3);
  //     },
  //   );
  //   print(_amount);
  // }
  StreamController<List<ItemNameModel>> listStream = StreamController();
  List<ItemNameModel> list1 = [];

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
      });
    }
  }

  @override
  initState() {
    _amount = 0;
    super.initState();
    reqQty = TextEditingController();
    reqQty.addListener(() {
      if (isActive = reqQty.text.isNotEmpty) {
        isActive = true;
      }
      setState(() => isActive = isActive);
    });
    intendDateInput.text = "";
    reqDateInput.text = "";
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    indentorNameDropdownBloc = IndentorNameDropdownBloc();
    itemNameDropdownBloc = ItemNameDropdownBloc();
    departmentNameDropdownBloc = DepartmentNameDropdownBloc();
    dropdownBlocItemCurrentStatus = ItemCurrentStatusDropdownBloc();
    dropdownBlocItemCostCenter = ItemCostCenterDropdownBloc();
    _amount = 0;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
    });
    super.initState();
  }

  verifyDetail() {
    if (connectionStatus == ConnectivityResult.wifi ||
        connectionStatus == ConnectivityResult.mobile) {
      if (selectItemName != null &&
          selectIndentorName != null &&
          selectItemCostCenter != null &&
          materialRequestEntryFormKey.currentState.validate()) {
        sendData();
      } else {
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
    } else {
      Scaffold.of(context).showSnackBar(snackBar(internetFailedConnectionText));
    }
  }

  var url;
  var newurl;
  // var newurl = 'http://techno-alb-1780774514.ap-south-1.elb.amazonaws.com:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostIndent?StrRecord=${'{"StrIndTypeCode":"IND","StrSiteCode":"AD","StrIndNo":"11","StrIndDate":"09/07/2022","StrDepartmentCode":"AD1","StrIndentorCode":"SG344","StrPreparedByCode":"SA",StrIndGrid:[]}'}';
  Future<dynamic> sendData() async {
    try {
      newurl =
          'http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostIndent?StrRecord=${'{"StrIndTypeCode":"${selectVoucherType.SubCode}","StrSiteCode":"AD","StrIndNo":"11","StrIndDate":"${intendDateInput.text}","StrDepartmentCode":"${selectDepartment.subCode}","StrIndentorCode":"${selectIndentorName.SubCode}","StrPreparedByCode":"SA",StrIndGrid:${params}}'}';
      url = Uri.parse(newurl);
      // params = '{"StrItemCode":"$
      // {selectItemName.Code}","DblQuantity":"10","StrCostCenterCode":"AD1","StrRequiredDate":"09/07/2022","StrRemark":"remark1"}' as List ;
      var response = await http.get(url);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        clearData();
        final String responseString = response.body;
        return Scaffold.of(context).showSnackBar(snackBar(responseString));
      } else {
        return Scaffold.of(context).showSnackBar(snackBar("Not Succeed"));
      }
    } catch (e) {
      rethrow;
    }
    //   Scaffold.of(context).showSnackBar(snackBar(sendDataText));
    //  on SocketException {
    //   Scaffold.of(context).showSnackBar(snackBar(socketExceptionText));
    // } on HttpException {
    //   Scaffold.of(context).showSnackBar(snackBar(httpExceptionText));
    // } on FormatException {
    //   Scaffold.of(context).showSnackBar(snackBar(formatExceptionText));
    // }
  }

  IndentorName selectIndentorName;
  ItemNameModel selectItemName;
  VoucherTypeMaterialReqEntryModel selectVoucherType;
  DepartmentName selectDepartment;
  ItemCurrentStatus selectItemCurrentStatus;
  ItemCostCenter selectItemCostCenter;
  void onDataChange1(VoucherTypeMaterialReqEntryModel state) {
    setState(() {
      selectVoucherType = state;
    });
  }

  void onDataChange2(ItemNameModel state) {
    setState(() {
      selectItemName = state;
      Dblq = null;
      Unit = null;
      if (itemres == true) {}
    });
  }

  void onDataChange3(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter = state;
    });
  }

  void onDataChange4(IndentorName state) {
    setState(() {
      selectIndentorName = state;
    });
  }

  void onDataChange5(DepartmentName state) {
    setState(() {
      selectDepartment = state;
    });
  }

  void removeServiceCard(index) {
    setState(() {
      _itemContainer.remove(index);
    });
  }

  Future<dynamic> itemCurrentStock() async {
    if (selectItemName != null && Dblq == null) {
      final String uri =
          "http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"ItemCurrentStatus","StrSiteCode":"","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"${selectItemName.Code}","StrCostCenterCode":"AD1","StrAllCostCenter":"",StrUPCostCenter:[{"StrCostCenterCode":"AD1"},{"StrCostCenterCode":"AD1"}]}'}";
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final res = await http.get(Uri.parse(uri));
        final resBody = jsonDecode(res.body);
        itemres = true;
        setState(() {
          Dblq = double.parse((resBody[0]['DblQty']).toStringAsFixed(4)) ?? '';
          Unit = resBody[0]['Unit'] ?? '';
          // print("Dblqty:  ${Dblq}");
        });
      }
      // itemres = false;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    reqQty.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MaterialRequestEntryProvider.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (selectItemName != null) {
      itemCurrentStock();
    }

    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: materialRequestEntryFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: paddingFormsVertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          clearData();
                        },
                        elevation: 2.0,
                        color: Colors.white,
                        child: raisedButtonText(text043),
                      ),
                    ],
                  ),
                ),
                formsHeadTextNew(text042, width * .045),
                Padding(
                  padding: padding1,
                  child: Container(
                    // height: 52, width: 343,
                    decoration: decorationForms(),
                    child:
                        FutureBuilder<List<VoucherTypeMaterialReqEntryModel>>(
                            future: voucherTypeDropdownBloc
                                .voucherTypeMaterialReqEntryDropdownData,
                            builder: (context, snapshot) {
                              return StreamBuilder<
                                      VoucherTypeMaterialReqEntryModel>(
                                  stream: voucherTypeDropdownBloc
                                      .selectedMaterialReqEntryState,
                                  builder: (context, item) {
                                    return SearchChoices<
                                        VoucherTypeMaterialReqEntryModel>.single(
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          size: 30),
                                      padding: selectVoucherType != null
                                          ? height * .002
                                          : height * .015,
                                      isExpanded: true,
                                      hint: textHint,
                                      value: selectVoucherType,
                                      displayClearIcon: false,
                                      onChanged: onDataChange1,
                                      items: snapshot?.data?.map<
                                                  DropdownMenuItem<
                                                      VoucherTypeMaterialReqEntryModel>>(
                                              (e) {
                                            return DropdownMenuItem<
                                                VoucherTypeMaterialReqEntryModel>(
                                              value: e,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
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
                formsHeadTextNew("Indentor Name", width * .045),
                Padding(
                  padding: padding1,
                  child: Container(
                    // height: 52, width: 343,
                    decoration: decorationForms(),
                    child: FutureBuilder<List<IndentorName>>(
                        future:
                            indentorNameDropdownBloc.indentorNameDropdownData,
                        builder: (context, snapshot) {
                          return StreamBuilder<IndentorName>(
                              stream: indentorNameDropdownBloc
                                  .selectedIndentorNameMaterialReqEntryState,
                              builder: (context, item) {
                                return SearchChoices<IndentorName>.single(
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      size: 30),
                                  padding: selectIndentorName != null
                                      ? height * .002
                                      : height * .015,
                                  isExpanded: true,
                                  hint: textHint,
                                  value: selectIndentorName,
                                  displayClearIcon: false,
                                  onChanged: onDataChange4,
                                  items: snapshot?.data
                                          ?.map<DropdownMenuItem<IndentorName>>(
                                              (e) {
                                        return DropdownMenuItem<IndentorName>(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
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
                formsHeadTextNew("Department Name", width * .045),
                Padding(
                  padding: padding1,
                  child: Container(
                    // height: 52, width: 343,
                    decoration: decorationForms(),
                    child: FutureBuilder<List<DepartmentName>>(
                        future: departmentNameDropdownBloc
                            .departmentMaterialReqEntryData,
                        builder: (context, snapshot) {
                          return StreamBuilder<DepartmentName>(
                              stream: departmentNameDropdownBloc
                                  .selectedDepartmentMaterialReqEntryState,
                              builder: (context, item) {
                                return SearchChoices<DepartmentName>.single(
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      size: 30),
                                  padding: selectDepartment != null
                                      ? height * .002
                                      : height * .015,
                                  isExpanded: true,
                                  hint: textHint,
                                  value: selectDepartment,
                                  displayClearIcon: false,
                                  onChanged: onDataChange5,
                                  items: snapshot?.data?.map<
                                              DropdownMenuItem<DepartmentName>>(
                                          (e) {
                                        return DropdownMenuItem<DepartmentName>(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
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

                const Padding(padding: EdgeInsets.all(10)),
                formsHeadTextNew(text045, width * .045),
                Container(
                  padding: dateFieldPadding,
                  height: height * .09,
                  child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Detail';
                      }
                      if (val != intendDateInput.text) {
                        return 'Enter Correct Detail';
                      }
                      return null;
                    },
                    controller: intendDateInput,
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
                            DateFormat("dd/MM/yyyy").format(pickedDate);
                        setState(() {
                          intendDateInput.text = formattedDate;
                        });
                      } else {}
                    },
                  ),
                ),
                formsHeadTextNew("Choose Phase (Cost Center)", width * .045),
                Padding(
                  padding: padding1,
                  child: Container(
                    decoration: decorationForms(),
                    child: FutureBuilder<List<ItemCostCenter>>(
                        future: dropdownBlocItemCostCenter.itemCostCenterData,
                        builder: (context, snapshot) {
                          return StreamBuilder<ItemCostCenter>(
                              stream: dropdownBlocItemCostCenter.selectedState,
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
                                  onChanged: onDataChange3,
                                  items: snapshot?.data?.map<
                                              DropdownMenuItem<ItemCostCenter>>(
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
                // ============================================================ FormsContainer
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
                                    .itemMaterialReqEntryDropdownData,
                                builder: (context, snapshot) {
                                  return StreamBuilder<ItemNameModel>(
                                      stream: itemNameDropdownBloc
                                          .selecteditemMaterialReqEntryState,
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
                                          onChanged: onDataChange2,
                                          items: snapshot?.data?.map<
                                                  DropdownMenuItem<
                                                      ItemNameModel>>((e) {
                                                return DropdownMenuItem<
                                                    ItemNameModel>(
                                                  value: e,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
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
                        SizedBox(
                          height: 10,
                        ),
                        formsHeadTextNew("Request Qty. ", width * .045),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
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
                                            // _calculation();
                                          },
                                          // initialValue: "no",
                                          controller: reqQty,
                                          textAlign: TextAlign.center,

                                          decoration: InputDecoration(
                                            errorText: snapshot.error,
                                          ),
                                          onChanged: bloc.changerequestQty,
                                          keyboardType: TextInputType.number,
                                          // onSaved: selectItemName.requestQty(),
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
                        // const Padding(
                        //     padding: EdgeInsets.symmetric(vertical: 10)),
                        sizedbox1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
                              child: Text(
                                "Current Stock : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.09),
                              child: Text(
                                '${Dblq} ' + ' ${Unit}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8)),
                                RoundedButtonInput(
                                  text: "Add Item to List",
                                  press: (selectItemName != null) && (isActive)
                                      ? () {
                                          materialRequestEntryFormKey
                                              .currentState
                                              .save();
                                          selectItemName.requestQty =
                                              reqQty.text;
                                          // _calculation();
                                          setState(() {
                                            pressed = true;
                                            list1.add(
                                              selectItemName,
                                            );
                                            listStream.add(list1);
                                            Map<String, String> localMap = {
                                              "StrItemCode":
                                                  "'${selectItemName.Code}'",
                                              "DblQuantity": "'${reqQty.text}'",
                                              "StrCostCenterCode":
                                                  "'${selectItemCostCenter.SubCode}'",
                                              "StrRequiredDate":
                                                  "'${reqDateInput.text}'",
                                              "StrRemark": "'${remarks.text}'"
                                            };
                                            params.add(localMap);
                                            //  //= '{,,,,}'as List<Map<String, String>> ;
                                            // if (params.isNotEmpty && newurl != null && newurl.contains("StrCostCenterCode")) {
                                            //   newurl =
                                            //   'http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostIndent?StrRecord=${'{"StrIndTypeCode":"IND","StrSiteCode":"AD","StrIndNo":"11","StrIndDate":"09/07/2022","StrDepartmentCode":"AD1","StrIndentorCode":"SG344","StrPreparedByCode":"SA",StrIndGrid:[${'${params}' +
                                            //       ',' + '${params}'}]}'}' as String;
                                            // }
                                            // else {
                                            //   newurl =
                                            //   'http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostIndent?StrRecord=${'{"StrIndTypeCode":"IND","StrSiteCode":"AD","StrIndNo":"11","StrIndDate":"09/07/2022","StrDepartmentCode":"AD1","StrIndentorCode":"SG344","StrPreparedByCode":"SA",StrIndGrid:[${params}]}'}' as String;
                                            // }
                                          });
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
                    ? SingleChildScrollView(
                        child: StreamBuilder<List<ItemNameModel>>(
                            stream: listStream.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  height: pressed == false
                                      ? height * .2
                                      : height * .4,
                                  child: Center(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: snapshot.data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: height * .12,
                                                  width: width * .95,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: primaryColor3,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: primaryColor5,
                                                        offset: Offset(
                                                            0.0, 1.0), //(x,y)
                                                        blurRadius: 6.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
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
                                                                  width: width *
                                                                      .35,
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .Name,
                                                                    maxLines: 3,
                                                                    style:
                                                                        containerTextStyle1(),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Text(
                                                                  'Order Qty: ${snapshot.data[index].requestQty}' +
                                                                      "  " +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .SKU,
                                                                  style:
                                                                      containerTextStyle2(),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Code: " +
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .Code,
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
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  list1.removeAt(index);
                                                  listStream.add(list1);
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
                            }),
                      )
                    : const SizedBox(),

//=============================================================================
                const Padding(padding: EdgeInsets.all(10)),

                const SizedBox(height: 15),
                formsHeadTextNew("Req. Date", width * .045),
                Container(
                  padding: dateFieldPadding,
                  height: height * .09,
                  child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Detail';
                      }
                      if (val != reqDateInput.text) {
                        return 'Enter Correct Detail';
                      }
                      return null;
                    },
                    controller: reqDateInput,
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
                            DateFormat("dd/MM/yyyy").format(pickedDate);
                        setState(() {
                          reqDateInput.text = formattedDate;
                        });
                      } else {}
                    },
                  ),
                ),
                formsHeadTextNew("Remarks", width * .045),
                Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: roundedButtonHome("Submit", () {
                      // sendData();
                      verifyDetail();
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
