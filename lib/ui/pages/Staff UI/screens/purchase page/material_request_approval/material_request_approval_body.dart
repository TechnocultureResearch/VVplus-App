import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indent_no_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indent_selection_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/indent_selection_model.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/material_request_approval/forms_container_data.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:http/http.dart' as http;

import '../../../../../../domain/common/snackbar_widget.dart';
import '../../../../../../infrastructure/Models/indent_no_model.dart';
import '../../../../../widgets/Utilities/rounded_button.dart';
import '../../../../../widgets/constants/colors.dart';

class MaterialRequestApprovalBody extends StatefulWidget {
  const MaterialRequestApprovalBody({Key key}) : super(key: key);
  @override
  State<MaterialRequestApprovalBody> createState() =>
      MyMaterialRequestApprovalBody();
}

class MyMaterialRequestApprovalBody extends State<MaterialRequestApprovalBody> {
  bool isActive = false;
  bool pressed = false;
  TextEditingController dateinput = TextEditingController();
  final materialRequestApprovalFormKey = GlobalKey<FormState>();
  IndentorNameDropdownBloc _dropdownBloc;
  IndentNoDropdownBloc indentNoDropdownBloc;
  bool pressAttention = false;
  List<String> itemList = [];

  @override
  void initState() {
    dateinput.text = "";
    // _dropdownBloc = IndentorNameDropdownBloc();
    indentNoDropdownBloc = IndentNoDropdownBloc();
    super.initState();
  }

  Future<List<dynamic>> getIndentItemData() async {
    if (selectIndentNo != null) {
      try {
        var url = Uri.parse(
            'http://103.205.66.207:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndentApproval?StrRecord=${'{"StrFilter":"FillGrid","StrSiteCode":"AD","StrV_Date":"${selectIndentNo.StrV_Date}",StrIndDocID:[{"StrDocID":"${selectIndentNo.StrDocID}"},{"StrDocID":""}]}'}');
        final response = await http.get(url);
        final List<dynamic> items = json.decode(response.body);
        // final items = (jsonDecode(response.body) as List)
        // .map((e) => IndentorName.fromJson(e))
        //     .toList();
        print('Response Status: ${response.statusCode}');
        print('Response Body: $items');
        return items;
      } catch (e) {
        rethrow;
      }
    }
    // else{
    //    print("Please select indent No");
    // }
  }

  // IndentorName selectIndentorName;
  IndentNo selectIndentNo;
  void onDataChange1(IndentNo state) {
    setState(() {
      selectIndentNo = state;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        edgeOffset: 20,
        displacement: 200,
        strokeWidth: 5,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Form(
            key: materialRequestApprovalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedbox1,
                formsHeadText("Indent Date"),
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
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      } else {}
                    },
                  ),
                ),
                formsHeadText("Indent No"),
                Padding(
                  padding: padding1,
                  child: Container(
                    decoration: decorationForms(),
                    child: FutureBuilder<List<IndentNo>>(
                        future: indentNoDropdownBloc
                            .indentNoMaterialRequestApproveDropdowndata,
                        builder: (context, snapshot) {
                          return StreamBuilder<IndentNo>(
                              stream: indentNoDropdownBloc
                                  .selectedIndentNoMaterialReqApprovState,
                              builder: (context, item) {
                                return SearchChoices<IndentNo>.single(
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      size: 30),
                                  padding: selectIndentNo != null
                                      ? height * .002
                                      : height * .015,
                                  isExpanded: true,
                                  hint: "Search here",
                                  value: selectIndentNo,
                                  displayClearIcon: false,
                                  onChanged: onDataChange1,
                                  items: snapshot?.data
                                          ?.map<DropdownMenuItem<IndentNo>>(
                                              (e) {
                                        return DropdownMenuItem<IndentNo>(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(e.StrDocID ?? ''),
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
                StreamBuilder(
                    stream: getIndentItemData().asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Container(
                            height: height * 0.37,
                            child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * .15,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: primaryColor3,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: primaryColor4,
                                            offset: Offset(0.0, 2.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                height: height * .08,
                                                width: width * .3,
                                                //color: Colors.green,
                                                child: Text(
                                                    snapshot.data[index]
                                                        ['Item'],
                                                    maxLines: 2,
                                                    style:
                                                        containerTextStyle1()),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Order Qty: " +
                                                        snapshot.data[index]
                                                            ['indqty'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    "pc",
                                                    style:
                                                        containerTextStyle2(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "Dept: " +
                                                          snapshot.data[index]
                                                              ['Dept'],
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 13)),
                                                  const SizedBox(
                                                    width: 80,
                                                  ),
                                                  Image.asset(icon15),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Req Date: " +
                                                    snapshot.data[index]
                                                        ['inddt'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: width * .44,
                                                child: Text(
                                                  "Indentor: " +
                                                      snapshot.data[index]
                                                          ['Indentor'],
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Indent No: " +
                                                    snapshot.data[index]
                                                        ['IndSno'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                Padding(
                    padding: padding4,
                    child: roundedButtonHome2(
                        "Approve", () {}, roundedButtonHomeColor1)),
                Padding(
                    padding: padding4,
                    child: roundedButtonHome2(
                        "Deny", () {}, roundedButtonHomeColor2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
