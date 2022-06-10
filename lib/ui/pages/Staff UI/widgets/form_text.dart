import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';

Padding formsHeadText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    ),
  );
}

Padding formsHeadTextNew(String text, double fsize) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: fsize),
    ),
  );
}

Padding formsDetailText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    ),
  );
}

Padding formsDetailTextNew(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 30),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  );
}

Padding clearButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: () {},
          elevation: 0.0,
          color: Colors.white,
          child: raisedButtonText("Clear all"),
        ),
      ],
    ),
  );
}
