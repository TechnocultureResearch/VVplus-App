import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';

class HomePageLogo extends StatelessWidget{
  const HomePageLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 190,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 39,
            ),
            child: Image.asset(
              imageLogo,
              scale: 1.5,
              height: 241,
              width: 286,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 220,
              top: 20,
            ),
            child: Image.asset(
              image2,
              scale: 1.5,
              height: 134,
              width: 68,
            ),
          ),
        ],
      ),
    );
  }

}