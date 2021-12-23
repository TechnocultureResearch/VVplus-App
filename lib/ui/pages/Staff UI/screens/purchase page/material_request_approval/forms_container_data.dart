import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'dart:convert';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class Page1 extends StatefulWidget {
  const Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List data;

  fetchData1() async {

    http.Response response =
    await http.get(Uri.parse('https://vv-plus-app-default-rtdb.firebaseio.com/PostDataMaterialRequestEntry.json'));
    setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchData1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : SingleChildScrollView(
      physics: const ScrollPhysics(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){print("no");},
            child: Padding(
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
                            data[index]['IndentSubCode'],
                            style: containerTextStyle1(),
                          ),
                          const SizedBox(height: 13,),
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
                                  data[index]['ReqQty'],
                                  style: containerTextStyle2(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 13),
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
                                    "Dept:",
                                    style: containerTextStyle3(),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 2,),
                              Text(
                                "Req Date:",
                                style: containerTextStyle2(),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                "Indentor:",
                                style: containerTextStyle2(),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                "Indent No.:",
                                style: containerTextStyle2(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 13),
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
                                    "Store",
                                    style: containerTextStyle3(),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Image.asset(icon15)),
                                ],
                              ),

                              const SizedBox(height: 2,),
                              Text(
                                data[index]['ReqDate'],
                                style: containerTextStyle2(),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                data[index]['ItemName'],
                                style: containerTextStyle2(),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                data[index]['ItemSubCode'],
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
      },
      itemCount: data == null ? 0 : data.length,
    ),
        );
  }
}