import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'home_bottom_navigation_screen.dart';

class PhoneVertifiedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackground,
        body: PhoneVertifiedBody(),
      ),
    );
  }
}

class PhoneVertifiedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              height: 200.0,
              child: Image.asset('assets/images/Password_Two.png'),
            ),
          ),
          Text(
            'تأكيد رقم الهاتف',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'ادخل الكود الذي تم ارساله االى الرقم 09847223742354',
            style: TextStyle(fontSize: 15, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          PinCodeTextField(
            appContext: context,
            length: 4,
            onCompleted: (text) {
              print(text);
            },
            onChanged: (text) {
              //Todo verification
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'لم تستلم الكود',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  //todo resend the code
                },
                child: Text(
                  'إعادة الأرسال',
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          RoundedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomeBottomNavigationScreen()));
            },
            textColor: Colors.white,
            colour: kNearlyGreen,
            title: 'تأكيد',
          )
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.title, this.colour, @required this.onPressed, this.textColor});

  final Color colour;
  final String title;
  final Function onPressed;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
