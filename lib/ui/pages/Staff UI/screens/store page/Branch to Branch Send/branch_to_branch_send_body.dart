import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_decorations.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

class BranchtoBranchSendBody extends StatelessWidget{
  final Widget child;

  const BranchtoBranchSendBody({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {},
                  elevation: 0.0,
                  color: Colors.white,
                  child: RaisedButtonText("Clear all"),
                ),
              ],
            ),
          ),

          FormsHeadText("Voucher Type"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("Voucher No. Date"),

          const DateTextFormField(),

          const SizedBox(height: 15,),

          FormsHeadText("From Branch"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("From Phase"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("From Godown"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("To Branch"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("To Phase"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("To Godown"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("Vehicle No."),

          const DropdownForm(),

          const SizedBox(height: 15,),

          FormsHeadText("Indent Selection"),

          const DropdownForm(),

          const SizedBox(height: 15,),

          const FormsContainer(),

          const SizedBox(height: 15,),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),

              child: RoundedButtonHome2("Submit",(){},roundedButtonHomeColor1)),

        ],
      ),
    );
  }

}