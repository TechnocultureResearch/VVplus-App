import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/Contractors%20%20page/contractors_home_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/purchase.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/sales_home_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/store_home.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
// import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';

class HomeBody extends StatelessWidget {
  final Widget child;

  const HomeBody({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(75, 75, 75, 25),
            child: Image.asset(imageLogo),
          ),
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
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SalesPage()));
            },
          ),
          roundedButtonHome(
            text55,
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContractorsPage()));
            },
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
