import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/Contractors%20%20page/contractors_home_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/purchase.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/sales_home_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/store_home.dart';
import 'package:vvplus_app/ui/widgets/Utilities/homepage_logo.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';

class HomeBody extends StatelessWidget{
  final Widget child;

  const HomeBody({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const HomePageLogo(),
          Container(
            alignment: Alignment.center,
            height: 130,
            width: 300,
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(10)),
                  const Text(
                    "You have 3 approval \nrequests.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
                  ),
                 roundedButton6("View Approval Requests ",
                         (){}
                         ),

                ]
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              roundedButtonHome(
                text52,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PurchasePage()));
                },
              ),
              roundedButtonHome(
                text53,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StorePage()));
                },
              ),
              roundedButtonHome(
                text54,
                    () {Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SalesPage()));},
              ),
              roundedButtonHome(
                text55,
                    () {
                 Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  const ContractorsPage()));
                },
              ),
              roundedButtonHome(
                text56,
                    () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseInformation()));*/
                },
              ),
              roundedButtonHome2(
                text57,
                    () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseInformation()));*/
                },roundedButtonHomeColor1
              ),
              roundedButtonHome2(
                "Approval and Request not a Dataman",
                    () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseInformation()));*/
                },roundedButtonHomeColor1
              ),
            ],
          ),
          roundedButtonHome(
            text56,
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContractorsPage()));
            },
          ),
        ],
      ),
    );
  }

}