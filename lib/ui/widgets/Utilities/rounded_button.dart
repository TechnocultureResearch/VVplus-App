import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

class RoundedButtonInput extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color1, textColor1;
  final double size1;
  final double horizontal1;
  final double vertical1;
  final double fontsize1;

  const RoundedButtonInput({
    Key key,
    this.text,
    this.press,
    this.color1,
    this.textColor1,
    this.size1,
    this.horizontal1, this.vertical1,
    this.fontsize1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * size1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor1),

        ),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color1,
          padding: EdgeInsets.symmetric(horizontal: horizontal1, vertical: vertical1),
          textStyle: TextStyle(
              color: textColor1, fontSize: fontsize1, fontWeight: FontWeight.bold)),
    );
  }
}

// use for login button
RoundedButtonInput RoundedButton1(String text1,var press1) {
  return RoundedButtonInput(
    text: text1,
    press: press1,
    fontsize1: 14,
    size1: 0.8,
    horizontal1: 40,
    vertical1: 15,
    color1: PrimaryColor1,
    textColor1: PrimaryColor3,
  );
}

// use in home page
RoundedButtonInput RoundedButton2(String text1,var press1) {
  return RoundedButtonInput(
    text: text1,
    press: press1,
    fontsize1: 28,
    size1: 0.8,
    horizontal1: 40,
    vertical1: 23,
    color1: PrimaryColor1,
    textColor1: PrimaryColor3,
  );
}

// use for next and skip button
RoundedButtonInput RoundedButton3(String text1,var press1) {
  return RoundedButtonInput(
    text: text1,
    press: press1,
    fontsize1: 14,
    size1: 0.37,
    horizontal1: 30,
    vertical1: 17,
    color1: PrimaryColor1,
    textColor1: PrimaryColor3,
  );
}

RoundedButtonInput RoundedButton4(String text1,var press1) {
  return RoundedButtonInput(
    text: text1,
    press: press1,
    fontsize1: 12,
    size1: 0.8,
    horizontal1: 20,
    vertical1: 10,
    color1: PrimaryColor6,
    textColor1: TextColor1,
  );
}
RoundedButtonInput RoundedButton5(String text1,var press1) {
  return RoundedButtonInput(
    text: text1,
    press: press1,
    fontsize1: 12,
    size1: 0.8,
    horizontal1: 30,
    vertical1: 10,
    color1: PrimaryColor7,
    textColor1: TextColor1,
  );
}