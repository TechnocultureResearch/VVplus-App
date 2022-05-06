import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

TextStyle textStyle1(var color1, double size1, var fontWeightValue) {
  return TextStyle(
    color: color1,
    fontSize: size1,
    fontWeight: fontWeightValue,
  );
}

TextStyle containerTextStyle1() {
  return textStyle1(
    boxDecorationTextColor1,
    18,
    FontWeight.bold,
  );
}

TextStyle containerTextStyle2() {
  return textStyle1(boxDecorationTextColor1, 14, FontWeight.w500);
}

TextStyle containerTextStyle3() {
  return textStyle1(boxDecorationTextColor2, 12, FontWeight.w500);
}

TextStyle containerTextStyle4() {
  return textStyle1(boxDecorationTextColor3, 12, FontWeight.w500);
}

TextStyle containerTextStyle5() {
  return textStyle1(boxDecorationTextColor4, 12, FontWeight.w500);
}

TextStyle containerTextStyle6() {
  return textStyle1(boxDecorationTextColor2, 20, FontWeight.w500);
}

TextStyle containerTextStyle7() {
  return textStyle1(boxDecorationTextColor2, 12, FontWeight.w500);
}

TextStyle containerTextStyle8() {
  return textStyle1(boxDecorationTextColor5, 12, FontWeight.w500);
}

TextStyle containerTextStyle9() {
  return textStyle1(boxDecorationTextColor6, 12, FontWeight.w500);
}

TextStyle containerTextStyle10() {
  return textStyle1(boxDecorationTextColor1, 12, FontWeight.w500);
}
