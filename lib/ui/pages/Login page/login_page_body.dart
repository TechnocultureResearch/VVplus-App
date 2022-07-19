// Login page Ui
// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:vvplus_app/Application/Bloc/Login_Bloc/login_page_bloc.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/screens/homepage/home_page.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Login%20page/auth_service.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/home%20page/staff_homepage.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({Key key}) : super(key: key);
  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final _phoneNumberFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode;

  @override
  void initState() {
    _phoneNumberFocusNode.addListener(() {
      if (!_phoneNumberFocusNode.hasFocus) {
        context.read<LoginBloc>().add(PhoneNumberUnfocused());
        FocusScope.of(context).requestFocus(_otpFocusNode);
      }
    });
    // Calling OTP validation with BLoc
    _otpFocusNode.addListener(() {
      if (!_otpFocusNode.hasFocus) {
        context.read<LoginBloc>().add(OtpUnfocused());
      }
    });
    super.initState();
  }

  @override
  //dispose
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

//Widgets
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text(text01)),
              );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text(text01)),
              );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset(
                    imageLogo,
                  ),
                ),
                Text(
                  text1,
                  style: t1Style(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text2,
                  style: simpleTextStyle2(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  color: primaryColor3,
                  height: textFeildHeight,
                  child: PhoneNoInput(),
                  //child: PhoneNumberInput(focusNode: _phoneNumberFocusNode),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  text3,
                  style: t2Style(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  text4,
                  style: t2Style(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in ",
                      style: TextStyle(fontSize: 16, color: textColor4),
                    ),
                    TextSpan(
                      text: "00:$start",
                      style: TextStyle(fontSize: 16, color: stepperColor1),
                    ),
                    TextSpan(
                      text: " sec ",
                      style: TextStyle(fontSize: 16, color: textColor4),
                    ),
                  ],
                )),
                // Text(
                //   text5,
                //   textAlign: TextAlign.center,
                //   style: simpleTextStyle2(),
                // ),
                const SizedBox(height: 30),
                Container(
                  height: textFeildHeight,
                  decoration: decoration1(),
                  child: Center(
                    //child: OtpInput(focusNode: _otpFocusNode),
                    child: otpField(),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('vastu')
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        print("wah....${doc["contact"]}");
                        if (doc['contact'].contains(phoneController.text)) {
                          print("yaya");
                          authClass.signInwithPhoneNumber(
                              verificationIdFinal, smsCode, context);
                        } else {
                          showSnackBar(
                              context, "Sorry! You have not authorized no.");
                        }
                      });
                    });

                    // otp 10 no count limit
                    // authClass.signInwithPhoneNumber(
                    //     verificationIdFinal, smsCode, context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomePageStaff()));
                  },
                  child: Container(
                    height: height * .06,
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                        color: primaryColor1,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 17,
                            color: primaryColor8,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget PhoneNoInput() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      //height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: textColor4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextFormField(
          controller: phoneController,
          style: TextStyle(color: Colors.black, fontSize: 19),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            //isDense: true,
            border: InputBorder.none,
            hintText: "Enter your phone Number",
            hintStyle: TextStyle(color: Colors.black, fontSize: 17),
            // contentPadding:
            //     const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                " (+91) ",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : () async {
                      if (mounted)
                        setState(() {
                          start = 60;
                          wait = true;
                          buttonName = "Resend";
                        });
                      await authClass.verifyPhoneNumber(
                          "+91 ${phoneController.text}", context, setData);
                    },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Text(
                  buttonName,
                  style: TextStyle(
                    color: wait ? Colors.grey : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 45,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 16, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  void setData(String verificationId) {
    if (mounted)
      setState(() {
        verificationIdFinal = verificationId;
      });
    startTimer();
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        if (mounted)
          setState(() {
            timer.cancel();
            wait = false;
          });
      } else {
        if (mounted)
          setState(() {
            start--;
          });
      }
    });
  }
}

//Phone number text field class
class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({Key key, this.focusNode}) : super(key: key);
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: phoneTextStyle(),
          initialValue: state.phoneNumber.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: phoneTextFieldPadding,
            prefixIcon: phoneTextFieldPicker(),
            focusColor: textColor4,
            enabledBorder: outlineBorder(),
            focusedBorder:
                outlineBorder(), //floatingLabelBehavior: FloatingLabelBehavior.never,
            prefix: Padding(padding: phoneTextFieldPadding1),
            hintText: text02,
            //helperText:
            hintStyle: const TextStyle(
              color: primaryColor2,
            ),
            errorText: state.phoneNumber.invalid ? text03 : null,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            context.read<LoginBloc>().add(PhoneNumberChanged(phone: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

//OTP text field class
class OtpInput extends StatefulWidget {
  final FocusNode focusNode;
  const OtpInput({Key key, this.focusNode}) : super(key: key);
  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  var focusNode;
  bool _obscureText;

  @override
  void initState() {
    _obscureText = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.otp.value,
          focusNode: focusNode,
          obscureText: !_obscureText,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black45,
              ),
              onPressed: () {
                if (mounted)
                  setState(() {
                    _obscureText = !_obscureText;
                  });
              },
            ),
            labelStyle: const TextStyle(
              color: primaryColor4,
            ),
            hintText: hintText2,
            hintStyle: const TextStyle(
              color: primaryColor4,
            ),
            fillColor: primaryColor3,
            filled: true,
            enabledBorder: outlineBorder(),
            focusedBorder: outlineBorder(),
            prefix: Padding(
              padding: phoneTextFieldPadding1,
            ),
            errorText: state.otp.invalid ? text04 : null,
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(OtpChanged(otp: value));
          },
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton2 extends StatelessWidget {
  const SubmitButton2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RoundedButtonInput(
          color1: primaryColor1,
          fontsize1: 14,
          size1: 0.4,
          horizontal1: 30,
          vertical1: 17,
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePageStaff()));
          },
          text: text06,
        );
      },
    );
  }
}
