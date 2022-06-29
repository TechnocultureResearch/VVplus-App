import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/staff_provider.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/place%20purchase%20order/purchase_dialog.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

BoxDecoration decorationForms() {
  return BoxDecoration(
    color: primaryColor8,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: primaryColor9,
      width: 0,
    ),
  );
}

BoxDecoration containerDecorationForms() {
  return BoxDecoration(
    color: primaryColor3,
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: primaryColor9, width: 1),
  );
}

class InformationBoxContainer1 extends StatefulWidget {
  const InformationBoxContainer1({Key key}) : super(key: key);

  @override
  _InformationBoxContainer1State createState() =>
      _InformationBoxContainer1State();
}

class _InformationBoxContainer1State extends State<InformationBoxContainer1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
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
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ball Valve UPVC\n1’’x1/2’’",
                      style: containerTextStyle1(),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Order Qty.:",
                          style: containerTextStyle2(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            "20 Pc",
                            style: containerTextStyle2(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 13),
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
                              "Dept: Store",
                              style: containerTextStyle3(),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Image.asset(icon15)),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Req Date: 27 Sept, 2021",
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Req Date: 27 Sept, 2021",
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Indent No.: 203",
                          style: containerTextStyle2(),
                        ),
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
}

class InformationBoxContainer2 extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;

  const InformationBoxContainer2({
    Key key,
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.text5,
    this.text6,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 11),
      child: Container(
        //alignment: Alignment.center,
        height: SizeConfig.getHeight(context) * .13,
        width: SizeConfig.getWidth(context) * .95,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("$text1",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: textColor2,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Qty: $text2",
                            style: containerTextStyle2(),
                          ),
                          const SizedBox(
                            width: 23,
                          ),
                          Text(
                            "Rate: $text3",
                            style: containerTextStyle2(),
                          ),
                          const SizedBox(
                            width: 23,
                          ),
                          Text(
                            "Amount: $text4",
                            style: containerTextStyle2(),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Indent No: $text5",
                            style: containerTextStyle4(),
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          Text(
                            "GHSN/SAC: $text6",
                            style: containerTextStyle4(),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (BuildContext ctx) {
                          return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: PurchaseDialog());
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InformationBoxContainer6 extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;
  final String text8;
  const InformationBoxContainer6(
      {Key key,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.text5,
      this.text6,
      this.text7,
      this.text8})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 5, right: 5, bottom: 10),
      child: Container(
        //alignment: Alignment.center,
        height: height * .19,
        // height: SizeConfig.getHeight(context) * .143,
        width: width * 2,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15, right: 5),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("$text1",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GHSN/SAC: $text2",
                            style: containerTextStyle4(),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Order no.: $text3",
                            style: containerTextStyle3(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Order Qty.:\nReceive Qty.:\nRate:\nAmount:",
                        style: containerTextStyle2(),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "$text4\n$text5\n$text6\n$text7",
                        style: containerTextStyle2(),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(icon15),
                              const SizedBox(
                                height: 12.5,
                              ),
                              Text(
                                "Edit",
                                style: containerTextStyle5(),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Inc.Tax",
                                style: containerTextStyle3(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InformationBoxContainer3 extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;
  final String text8;
  const InformationBoxContainer3(
      {Key key,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.text5,
      this.text6,
      this.text7,
      this.text8})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        //alignment: Alignment.center,
        height: SizeConfig.getHeight(context) * .2,
        // width: SizeConfig.getWidth(context) * .95,
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
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name: $text8",
                      maxLines: 2,
                      style: textStyle1(
                          boxDecorationTextColor2, 14, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.getWidth(context) * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Booking ID: $text1",
                                style: containerTextStyle3(),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Unit: $text2",
                                style: containerTextStyle3(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Booking Date:",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("Unit Category:",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("Floor:",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("Unit Area:",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("UnitCost:",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$text3",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("$text4",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("$text5",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("$text6",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                            Text("$text7",
                                style: textStyle1(boxDecorationTextColor1, 14,
                                    FontWeight.w500)),
                          ],
                        ),
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
}

class InformationBoxContainer4 extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;
  final String text8;
  final String text9;
  const InformationBoxContainer4(
      {Key key,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.text5,
      this.text6,
      this.text7,
      this.text8,
      this.text9})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.getHeight(context) * .21,
        // width: SizeConfig.getWidth(context) * .93,
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
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name: $text1",
                      maxLines: 2,
                      style: containerTextStyle6(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Booking ID: $text2",
                              maxLines: 2,
                              style: containerTextStyle3(),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Unit: $text3",
                              maxLines: 2,
                              style: containerTextStyle3(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Booking Date: $text4\nUnit Category: $text5\nFloor: $text6\nPhase: $text7\nUnit Area: $text8\nNet Unit Cost: $text9",
                          style: containerTextStyle2(),
                        ),
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
}

class FormsContainer extends StatefulWidget {
  const FormsContainer({Key key}) : super(key: key);

  @override
  State<FormsContainer> createState() => MyFormsContainer();
}

class MyFormsContainer extends State<FormsContainer> {
  TextEditingController reqQty = TextEditingController();
  TextEditingController rate = TextEditingController();

  //final GlobalKey<FormState> _formKey = GlobalKey();
  int valueChoose = 4;

  @override
  Widget build(BuildContext context) {
    final bloc = MaterialProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
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
            const ContainerSearchDropDown(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            formsHeadText("Request Qty. "),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
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
                              controller: reqQty,
                              decoration: InputDecoration(
                                errorText: snapshot.error,
                              ),
                              onChanged: bloc.changerequestQty,
                              keyboardType: TextInputType.number,
                              style: simpleTextStyle7(),
                            );
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text(" "),
                        dropdownColor: primaryColor3,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        iconSize: 20,
                        isExpanded: true,
                        iconEnabledColor: primaryColor4,
                        style:
                            const TextStyle(color: primaryColor2, fontSize: 12),
                        value: valueChoose,
                        items: const <DropdownMenuItem<int>>[
                          DropdownMenuItem(
                            child: Text('\tTon'),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text('\tKG'),
                            value: 4,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            valueChoose = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              children: [
                formsHeadText("Rate"),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                formsHeadText("Amount:"),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: 50,
                    padding: padding1,
                    decoration: decoration1(),
                    child: SizedBox(
                      width: 100,
                      child: StreamBuilder<double>(
                          stream: bloc.ratefield,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: rate,
                              decoration: InputDecoration(
                                errorText: snapshot.error,
                              ),
                              onChanged: bloc.changeratefield,
                              keyboardType: TextInputType.number,
                              style: simpleTextStyle7(),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    reqQty.clear();
                    rate.clear();
                  },
                  elevation: 0.0,
                  color: storeContainerColor,
                  child: raisedButtonText("Clear This Item"),
                ),

                StreamBuilder<bool>(
                    stream: bloc.submitCheck,
                    builder: (context, snapshot) {
                      return RoundedButtonInput(
                        text: "Add Item to List",
                        press: !snapshot.hasData ? null : () {},
                        fontsize1: 12,
                        size1: 0.5,
                        horizontal1: 30,
                        vertical1: 10,
                        color1: Colors.orange,
                        textColor1: textColor1,
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

BoxDecoration decorationFormsCont() {
  return BoxDecoration(
    color: primaryColor3,
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: primaryColor9, width: 1),
  );
}
