import 'package:flutter/material.dart';
import 'package:mawared_app/utilties/constants.dart';

import 'LoginAnimation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  var tap = 0;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  Future<Null> _PlayAnimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/SliderLogin3.png"),
          fit: BoxFit.cover,
        )),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.0),
                Color.fromRGBO(0, 0, 0, 0.3)
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 40.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          "assets/images/mawared-logo.png"),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0)),

                                /// Animation text treva shop accept from signup layout (Click to open code)
                                Hero(
                                  //todo change hero tag
                                  tag: "Treva",
                                  child: Text(
                                    "Mawared",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.6,
                                        color: Colors.white,
                                        fontFamily: "Sans",
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),

                            /*  /// ButtonCustomFacebook
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 30.0)),
                            buttonCustomFacebook(),

                            /// ButtonCustomGoogle
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 7.0)),
                            buttonCustomGoogle(),

                            /// Set Text
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0)),
                            Text(
                              "OR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                  fontFamily: 'Sans',
                                  fontSize: 17.0),
                            ),*/

                            /// TextFromField Email
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 125.0)),
                            TextFromField(
                              icon: Icons.email,
                              password: false,
                              hintText: "البريد الألكتروني",
                              inputType: TextInputType.emailAddress,
                            ),

                            /// TextFromField Password
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0)),
                            TextFromField(
                              icon: Icons.vpn_key,
                              password: true,
                              hintText: "كلمة السر",
                              inputType: TextInputType.text,
                            ),
                            FlatButton(
                                padding: EdgeInsets.only(top: 20.0),
                                onPressed: () {
                                  /*Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new Signup()));*/
                                },
                                child: Text(
                                  "ليس لديك حساب؟ انشاء حساب",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 100.0,
                                  bottom: 0.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// Set Animaion after user click buttonLogin
                  tap == 0
                      ? InkWell(
                          splashColor: Colors.yellow,
                          onTap: () {
                            setState(() {
                              tap = 1;
                            });
                            new LoginAnimation(
                              animationController: animationController.view,
                            );
                            _PlayAnimation();
                            return tap;
                          },
                          child: buttonBlackBottom(),
                        )
                      : new LoginAnimation(
                          animationController: animationController.view,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// textfromfield custom class
class TextFromField extends StatelessWidget {
  final bool password;
  final String hintText;
  final IconData icon;
  final TextInputType inputType;

  TextFromField({this.hintText, this.icon, this.inputType, this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10.0, color: Colors.black12),
          ],
        ),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            obscureText: password,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: hintText,
              icon: Icon(
                icon,
                color: Colors.black38,
              ),
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'TheSansArabic',
                  letterSpacing: 0.3,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600),
            ),
            style: TextStyle(fontFamily: 'TheSansArabic'),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

///buttonCustomFacebook class
class buttonCustomFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(107, 112, 248, 1.0),
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15.0)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/icon_facebook.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Facebook",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            ),
          ],
        ),
      ),
    );
  }
}

///buttonCustomGoogle class
class buttonCustomGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/google.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Google",
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            )
          ],
        ),
      ),
    );
  }
}

///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Login",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
      ),
    );
  }
}
