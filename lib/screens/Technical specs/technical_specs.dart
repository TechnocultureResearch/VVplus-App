import 'package:flutter/material.dart';
import 'package:vvplus_app/constants/assets.dart';
import 'package:vvplus_app/widgets/appbar_widget.dart';
import 'package:vvplus_app/widgets/text_style_widget.dart';

class TechnicalSpecs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: appBarMain("Technical Specs"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
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
                Text("Plot area: 777sqrt",
                    style: simpleTextStyle10(Colors.black45)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                Text("Carpet area: 739sqrt",
                    style: simpleTextStyle10(Colors.black45)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
