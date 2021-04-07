import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawared_app/screens/home_bottom_navigation_screen.dart';
import 'package:mawared_app/screens/signup_normal_user_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/widget/chose_login_type_bottom_sheet.dart';
import 'package:mawared_app/widget/chose_signup_type_bottom_sheet.dart';

import 'login_normal_screen.dart';
import 'login_supplier_screen.dart';

class ChoseSignupLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kNearlyBlue, kNearlyGreen],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ChoseSignupLoginBody(),
      ),
    );
  }
}

class ChoseSignupLoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: SizedBox()),
        Container(
          width: 75,
          height: 75,
          child: Image.asset('assets/images/mawared-logo.png'),
        ),
        Text(
          'Mawared',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        Expanded(child: SizedBox()),
        RoundedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ChoseLoginTypeBottomSheet(
                    onNormalUserPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LoginNormalScreen()));
                    },
                    onSupplierPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LoginSupplierScreen()));
                    },
                    onCompanyPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LoginSupplierScreen()));
                    },
                  ),
                ),
              ),
            );
          },
          colour: Colors.white,
          title: 'تسجيل الدخول',
          textColor: kNearlyGreen,
        ),
        RoundedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ChoseSignupTypeBottomSheet(
                    onNormalUserPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SignupNormalUserScreen()));
                    },
                    onSupplierPressed: () {},
                  ),
                ),
              ),
            );
          },
          colour: Colors.white,
          title: 'أنشاء حساب',
          textColor: kNearlyGreen,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomeBottomNavigationScreen()));
          },
          child: Text(
            'متابعة كضيف',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 15, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(child: SizedBox()),
      ],
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
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
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
