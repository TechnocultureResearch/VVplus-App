import 'package:flutter/material.dart';

class PurchaseDialog extends StatefulWidget {
  @override
  _PurchaseDialogState createState() => _PurchaseDialogState();
}

class _PurchaseDialogState extends State<PurchaseDialog> {
  TextEditingController samount = TextEditingController();
  TextEditingController srate = TextEditingController();
  TextEditingController camount = TextEditingController();
  TextEditingController crate = TextEditingController();
  TextEditingController iamount = TextEditingController();
  TextEditingController irate = TextEditingController();
  TextEditingController urate = TextEditingController();
  TextEditingController uamount = TextEditingController();
  String text = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onDoubleTap: () {},
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: EdgeInsets.only(top: 00),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Center(
                child: Container(
                  width: double.infinity,
                  // height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7)),
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: height * .04,
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _headLayout(Colors.green, "Heads", Colors.white,
                                  FontWeight.w800),
                              _verticalDivider(),
                              _rateLayout(
                                  Colors.green, "At Rate", Colors.white),
                              _verticalDivider(),
                              _amountLayout(
                                  Colors.green, "Amount", Colors.white)
                            ],
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _headLayout(Colors.grey.withOpacity(.2), "Quantity:",
                              Colors.black, FontWeight.w600),
                          _verticalDivider(),
                          _rateLayout(Colors.white, "0.0000", Colors.black),
                          _verticalDivider(),
                          _amountLayout(Colors.white, "0.000", Colors.black)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: height * .04,
                              width: width * .45,
                              child: Center(
                                child: Text("Quantity is correct",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green),
                            ),
                            Container(
                              height: height * .04,
                              width: width * .3,
                              child: Center(
                                child: Text("Edit Quantity",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange),
                            )
                          ],
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _headLayout(Colors.grey.withOpacity(.2), "Item Value",
                              Colors.black, FontWeight.w600),
                          _verticalDivider(),
                          _rateLayout(Colors.grey.withOpacity(.2), "0.0000",
                              Colors.black),
                          _verticalDivider(),
                          _amountLayout(Colors.grey.withOpacity(.2), "0.000",
                              Colors.black)
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _headLayout(Colors.grey.withOpacity(.2), "SGST",
                              Colors.black, FontWeight.w600),
                          _verticalDivider(),
                          _rateTextfdLayout(Colors.white, srate),
                          _verticalDivider(),
                          _amountTextfdLayout(Colors.white, samount)
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _headLayout(Colors.grey.withOpacity(.2), "CGST",
                              Colors.black, FontWeight.w600),
                          _verticalDivider(),
                          _rateTextfdLayout(Colors.white, crate),
                          _verticalDivider(),
                          _amountTextfdLayout(Colors.white, camount)
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _headLayout(Colors.grey.withOpacity(.2), "IGST",
                              Colors.black, FontWeight.w600),
                          _verticalDivider(),
                          _rateTextfdLayout(Colors.white, irate),
                          _verticalDivider(),
                          _amountTextfdLayout(Colors.white, iamount)
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _headLayout(Colors.grey.withOpacity(.2), "UGST",
                              Colors.black, FontWeight.w600),
                          _verticalDivider(),
                          _rateTextfdLayout(Colors.white, urate),
                          _verticalDivider(),
                          _amountTextfdLayout(Colors.white, uamount)
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _headLayout(Colors.grey.withOpacity(.2),
                              "Item Net Value", Colors.black, FontWeight.w600),
                          _verticalDivider(),
                          _rateLayout(
                              Colors.grey.withOpacity(.2), "0%", Colors.black),
                          _verticalDivider(),
                          _amountLayout(Colors.grey.withOpacity(.2), "0.000",
                              Colors.black)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: height * .04,
                              width: width * .35,
                              child: Center(
                                child: Text("Apply to all",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange),
                            ),
                            Container(
                              height: height * .04,
                              width: width * .3,
                              child: Center(
                                child: Text("Apply",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headLayout(
      Color ContainerColor, String txt, Color fcolor, FontWeight fwt) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .047,
      width: width * .35,
      decoration: BoxDecoration(
          color: ContainerColor, borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(txt,
            style: TextStyle(fontSize: 15, fontWeight: fwt, color: fcolor),
            textAlign: TextAlign.left),
      ),
    );
  }

  Widget _rateLayout(Color ContainerColor, String txt, Color fcolor) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .047,
      width: width * .28,
      decoration: BoxDecoration(
          color: ContainerColor, borderRadius: BorderRadius.circular(0)),
      child: Center(
        child: Text(txt,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: fcolor),
            textAlign: TextAlign.right),
      ),
    );
  }

  Widget _rateTextfdLayout(
      Color ContainerColor, TextEditingController controller) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .047,
      width: width * .28,
      decoration: BoxDecoration(
          color: ContainerColor, borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: EdgeInsets.only(left: 3, right: 3),
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            focusColor: Colors.white,
            border: InputBorder.none,
            suffixText: "%  ",
            suffixStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 19, color: Colors.black),
          ),
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _amountTextfdLayout(
      Color ContainerColor, TextEditingController controller) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .047,
      width: width * .28,
      decoration: BoxDecoration(
          color: ContainerColor, borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: EdgeInsets.only(left: 3, right: 3),
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            focusColor: Colors.white,
            border: InputBorder.none,
          ),
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _amountLayout(Color ContainerColor, String txt, Color fcolor) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .047,
      width: width * .33,
      decoration: BoxDecoration(
          color: ContainerColor, borderRadius: BorderRadius.circular(2)),
      child: Center(
        child: Text(txt,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: fcolor),
            textAlign: TextAlign.right),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
        width: 1,
        height: 37,
        child: VerticalDivider(
          color: Colors.white,
          thickness: .99,
        ));
  }

  Widget _btnLayout() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .05,
      width: width * .55,
      child: Center(
        child: Text("Quantity is correct",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.center),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.green),
    );
  }
}
