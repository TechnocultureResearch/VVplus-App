import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/Customer_Bloc/NewComplaint_Bloc/new_complaint_bloc.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';

// new complaint page widget

OutlineInputBorder newComplaintTextFieldOutlineBorder() {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor2),
      borderRadius: BorderRadius.circular(10));
}

var newComplaintTextPadding = const EdgeInsets.symmetric(horizontal: 8);

class TextFieldDecoration extends StatefulWidget {
  //final String hintText;
  //final double borderRadiusValue;
  //const textFieldDecoration({this.hintText, this.borderRadiusValue});
  const TextFieldDecoration({Key key}) : super(key: key);

  @override
  _TextFieldDecorationState createState() => _TextFieldDecorationState();
}

class _TextFieldDecorationState extends State<TextFieldDecoration> {
  final bloc = NewComplaintPageBloc();
  @override
  Widget build(BuildContext context) {
    //String hintText;
    //double borderRadiusValue;
    return StreamBuilder<String>(
        stream: bloc.outTextField1,
        builder: (context, snapshot) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.inDropField1,
            style: simpleTextStyle7(),
            decoration: InputDecoration(
              fillColor: primaryColor3,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primaryColor2),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primaryColor2),
                  borderRadius: BorderRadius.circular(10)),
              prefix: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              hintText: "Enter Field",
              hintStyle: const TextStyle(
                color: primaryColor4,
              ),
              errorText: snapshot.error,
            ),
          );
        });
  }
}
/*
TextFormField textFieldInputDecoration(String hintText) {
  return textFieldDecoration(hintText,10);
}
TextFormField textFieldInputDecoration2(String hintText) {
  return textFieldDecoration(hintText,5);
}

 */

CountryCodePicker phoneTextFieldPicker() {
  return CountryCodePicker(
    initialSelection: '+91',
    favorite: const ['+91', 'IN'],
    textStyle: const TextStyle(color: textColor4),
    showFlag: true,
  );
}

OutlineInputBorder outlineBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: textColor4));
}

BoxDecoration decoration1() {
  return BoxDecoration(
    // color: primaryColor3,
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(12),
  );
}

BoxDecoration decoration2() {
  //Boxdecoration for containers
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    color: primaryColor3,
    boxShadow: const [
      BoxShadow(
        color: primaryColor5,
        offset: Offset(0.0, 1.0), //(x,y)
        blurRadius: 6.0,
      ),
    ],
  );
}

BoxDecoration decoration3() {
  return BoxDecoration(
    color: primaryColor3,
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: primaryColor2, width: 1),
  );
}

BoxDecoration decoration4(var colorof) {
  //Boxdecoration for containers
  return BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(50.0),
    color: colorof,
    boxShadow: const [
      BoxShadow(
        color: primaryColor5,
        offset: Offset(0.0, 1.0), //(x,y)
        blurRadius: 6.0,
      ),
    ],
  );
}
