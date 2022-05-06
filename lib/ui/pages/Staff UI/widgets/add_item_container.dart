import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/material_request_entry_page_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class AddItemContainer extends StatefulWidget {
  final String itemNameText;
  final String orderQtyText;
  final String rateText;
  final String amountText;
  const AddItemContainer({
    Key key,
    this.itemNameText,
    this.orderQtyText,
    this.rateText,
    this.amountText,
  }) : super(key: key);

  @override
  State<AddItemContainer> createState() => _AddItemContainerState();
}

class _AddItemContainerState extends State<AddItemContainer> {
  bool isEdit = false;
  TextEditingController reqQtynew = TextEditingController();
  Text ordertx;
  final node = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    node.addListener(() {
      if (!node.hasFocus && reqQtynew.text == widget.orderQtyText) {
        reqQtynew.text = "Sike!";
      }
    });
    super.initState();
    reqQtynew.text = widget.orderQtyText;

    print("order: $reqQtynew");
    print("last: ${widget.orderQtyText}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        alignment: Alignment.center,
        height: 92,
        width: SizeConfig.getWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: primaryColor3,
          boxShadow: const [
            BoxShadow(
              color: primaryColor5,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        //color: Colors.yellow,
                        height: 76,
                        width: 120,
                        child: Text(
                          widget.itemNameText,
                          style: containerTextStyle1(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Qty.:",
                              style: containerTextStyle2(),
                            ),
                            const Text("" //reqQty,
                                )
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Rate:",
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Amount:",
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        // donebtn()
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 0,
                        ),
                        isEdit == false
                            ? Text(
                                //  order,
                                isEdit == false
                                    ? widget.orderQtyText
                                    : reqQtynew,
                                style: containerTextStyle2(),
                              )
                            : editTextfield(),
                        // editTextfield(),
                        const SizedBox(
                          height: 0,
                        ),
                        Text(
                          widget.rateText,
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          widget.amountText,
                          style: containerTextStyle2(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(icon15),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            //editTextfield();

                            setState(() {
                              isEdit = true;
                              reqQtynew.clear();
                            });
                          },
                          child: Text('Edit', style: containerTextStyle8()),
                        ),
                        const SizedBox(height: 8),
                        Text('Inc. Tax', style: containerTextStyle7()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var numberInputFormatters = [
    new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
  ];

  Widget editTextfield() {
    return Container(
      width: 50,
      height: 24,
      color: Colors.yellow,
      child: Center(
        child: TextFormField(
          focusNode: node,
          // autofocus: false,
          decoration: InputDecoration.collapsed(
            border: InputBorder.none,
          ),
          controller: reqQtynew,
          style: TextStyle(fontSize: 15.0, color: Colors.black),
          inputFormatters: numberInputFormatters,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Widget donebtn() {
    return GestureDetector(
        onTap: () {
          setState(() {
            //  reqQty = TextEditingController(text: order);
            //reqQtynew = TextEditingController(text: widget.orderQtyText);
          });
        },
        child: Container(
            color: Colors.grey.shade400, height: 19, child: Text("done")));
  }
}
