import 'package:flutter/material.dart';
import 'package:vvplus_app/Pages/Customer%20UI/screens/progress%20page/stepper.dart';
import 'package:vvplus_app/Pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/Pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/constants/text_feild.dart';


class ProgressBody extends StatefulWidget {
  const ProgressBody({Key key}) : super(key: key);

  @override
  ProgressBodyState createState() => ProgressBodyState();
}

class ProgressBodyState extends State<ProgressBody> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 160,
              width: 320,
              decoration: decoration2(),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          Boxheading1,
                          style: ContainerHeading2(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          BoxText1,
                          style: ContainerText2(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          BoxText2,
                          style: ContainerText2Bold(),
                        ),
                      ),
                      Text(
                        BoxText3,
                        style: ContainerText2(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: (){
                                                                                   //call customer care
                          },
                          child: Text(
                            BoxLink,
                            style: ContainerHeading1(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          StepperBody(),

        ],
      ),
    );
  }
}
