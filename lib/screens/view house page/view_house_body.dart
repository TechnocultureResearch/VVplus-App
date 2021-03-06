import 'package:flutter/material.dart';
import 'package:vvplus_app/constants/assets.dart';
import 'package:vvplus_app/screens/Technical%20specs/technical_specs.dart';
import 'package:vvplus_app/screens/house_information/house_information.dart';
import 'package:vvplus_app/screens/view%20house%20page/caruosel_slider.dart';
import 'package:vvplus_app/utilities/rounded_button.dart';
import 'package:vvplus_app/widgets/decoration_widget.dart';
import 'package:vvplus_app/widgets/text_style_widget.dart';

class ViewHouseBody extends StatefulWidget {
  const ViewHouseBody({Key key}) : super(key: key);

  @override
  ViewHouseState createState() => ViewHouseState();
}

class ViewHouseState extends State<ViewHouseBody> {
  bool viewVisible = true ;


  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 313,
            width: 410,
            child: ViewCarouselSlider(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "House Detail",
                  style: simpleTextStyle10(Colors.black45),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        icon1,
                        scale: 0.8,
                      ),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                    Text("3 Bedrooms", style: simpleTextStyle10(Colors.black45)),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                    IconButton(
                      icon: Image.asset(
                        icon2,
                        scale: 0.1,
                      ),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                    Text("3 Bathrooms", style: simpleTextStyle10(Colors.black45)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        icon3,
                        scale: 0.8,
                      ),
                      color: Colors.grey,
                    ),
                    Text(
                      "1 Parking",
                      style: simpleTextStyle10(Colors.black45),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                    ),
                    IconButton(
                      icon: Image.asset(
                        icon4,
                        scale: 0.8,
                      ),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                    Text("2 Floors", style: simpleTextStyle10(Colors.black45)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  children: [
                    Text("Plot area: 777sqrt", style: simpleTextStyle10(Colors.black45)),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                    Text("Carpet area: 739sqrt", style: simpleTextStyle10(Colors.black45)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Closest Utilities",
                        style: simpleTextStyle10(Colors.black45),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.local_hospital,color: Colors.black),
                          ),
                          Text("Emergency", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 65)),
                          Text("3 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.apartment_sharp,color: Colors.black),
                          ),
                          Text("Schools", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 77)),
                          Text("2 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.school,color: Colors.black),
                          ),
                          Text("Colleges", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70)),
                          Text("1.7 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),

                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),


                    Visibility(
                       visible: viewVisible,
                      child: Column(
                        children:[

                          Container(
                          height: 59,
                          width: 359,
                          decoration: decoration2(),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.directions_bus,color: Colors.black),
                              ),
                              Text("Bus Stations", style: simpleTextStyle10(Colors.black45)),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 57)),
                              Text("0.5 Km Away", style: simpleTextStyle10(Colors.green))
                            ],
                          ),
                           ),

                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.directions_railway,color: Colors.black),
                          ),
                          Text("Railway Stations", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 45)),
                          Text("0.2 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.shopping_bag_outlined,color: Colors.black),
                          ),
                          Text("Shopping Hub", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 52)),
                          Text("0.2 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              icon10,
                              scale: 0.7,
                            ),
                          ),

                          Text("Petrol Station", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 53)),
                          Text("0.2 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              icon12,
                              scale: 0.8,
                            ),
                          ),

                          Text("LPG Station", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60)),
                          Text("0.2 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              icon13,
                              scale: 0.8,
                            ),
                          ),

                          Text("Post Office", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 63)),
                          Text("0.2 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      height: 59,
                      width: 359,
                      decoration: decoration2(),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              icon14,
                              scale: 0.8,
                            ),
                          ),

                          Text("Police Station", style: simpleTextStyle10(Colors.black45)),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 55)),
                          Text("0.2 Km Away", style: simpleTextStyle10(Colors.green))
                        ],
                      ),
                    ),


                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          onPressed: hideWidget,
                          color: Colors.white,
                          elevation: 0,
                          child:Column(
                            children: [
                              if (viewVisible) Text('Less',style: simpleTextStyle10(Colors.blueAccent),)
                              else
                                    RaisedButton(
                                      onPressed: showWidget,
                                      color: Colors.white,
                                      elevation: 0,
                                      child:
                                      Text("More",
                                        style: simpleTextStyle10(Colors.blueAccent),
                                      ),
                                    ),

                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:30,vertical: 10),
                      child: RoundedButton1(
                      "View Technical Specs of House",
                      () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TechnicalSpecs()));
                      },
                    ),
    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
