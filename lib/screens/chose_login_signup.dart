import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mawared_app/screens/home_bottom_navigation_screen.dart';
import 'package:mawared_app/screens/signup_normal_user_screen.dart';
import 'package:mawared_app/screens/signup_supplier_screen.dart';
import 'package:mawared_app/widget/chose_login_type_bottom_sheet.dart';
import 'package:mawared_app/widget/chose_signup_type_bottom_sheet.dart';

import 'login_normal_screen.dart';
import 'login_supplier_screen.dart';

enum UserType { Normal, Supplier, Company }

UserType userType;

class ChoseLoginSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChoseLoginSignupBody(),
    );
  }
}

class ChoseLoginSignupBody extends StatefulWidget {
  @override
  _ChoseLoginSignupBodyState createState() => _ChoseLoginSignupBodyState();
}

class _ChoseLoginSignupBodyState extends State<ChoseLoginSignupBody>
    with TickerProviderStateMixin {
  AnimationController animationController;
  var tapLogin = 0;
  var tapSignup = 0;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tapLogin = 0;
                tapSignup = 0;
              });
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<Null> _Playanimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    mediaQuery.size.height;
    mediaQuery.size.width;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Carousel(
            boxFit: BoxFit.cover,
            autoplay: true,
            animationDuration: Duration(microseconds: 300),
            dotSize: 0.0,
            dotSpacing: 16.0,
            dotBgColor: Colors.transparent,
            showIndicator: false,
            overlayShadow: false,
            images: [
              AssetImage('assets/images/SliderLogin1.png'),
              AssetImage("assets/images/SliderLogin2.png"),
              AssetImage('assets/images/SliderLogin3.png'),
              AssetImage("assets/images/SliderLogin4.png"),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.3),
                  Color.fromRGBO(0, 0, 0, 0.4)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter),
          ),
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: mediaQuery.padding.top + 50.0),
                        ),
                        Center(
                          child: Hero(
                            //Todo change hero tag
                            tag: "Treva",
                            child: Text(
                              "Mawared",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 32.0,
                                letterSpacing: 0.4,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 160.0,
                              right: 160.0,
                              top: mediaQuery.padding.top + 190.0,
                              bottom: 10.0),
                          child: Container(
                            color: Colors.white,
                            height: 0.5,
                          ),
                        ),

                        /// to set Text "get best product...." (Click to open code)
                        Text(
                          "احصل على افضل المنتجات في متجر موارد",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.3),
                        ),
                        Padding(padding: EdgeInsets.only(top: 250.0)),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      tapLogin == 0
                          ? Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: ChoseSignupTypeBottomSheet(
                                          onNormalUserPressed: () {
                                            setState(() {
                                              userType = UserType.Normal;
                                              tapLogin = 1;
                                              _Playanimation();
                                            });
                                          },
                                          onSupplierPressed: () {
                                            setState(() {
                                              userType = UserType.Supplier;
                                              tapLogin = 1;
                                              _Playanimation();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  );

                                  //return tapLogin;
                                },
                                child: ButtonCustom(txt: "تسجيل حساب جديد"),
                              ),
                            )
                          : AnimationSplashSignup(
                              animationController: animationController.view,
                            ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              height: 0.2,
                              width: 80.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 70.0)),
                    ],
                  ),

                  /// To create animation if user tap == animation play (Click to open code)
                  tapSignup == 0
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: ChoseLoginTypeBottomSheet(
                                      onNormalUserPressed: () {
                                        setState(() {
                                          debugPrint('normal user');
                                          userType = UserType.Normal;
                                          tapSignup = 1;
                                          _Playanimation();
                                        });
                                      },
                                      onSupplierPressed: () {
                                        setState(() {
                                          userType = UserType.Supplier;
                                          tapSignup = 1;
                                          _Playanimation();
                                        });
                                      },
                                      onCompanyPressed: () {
                                        setState(() {
                                          userType = UserType.Company;
                                          tapSignup = 1;
                                          _Playanimation();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ButtonCustom(txt: "تسجيل الدخول"),
                          ),
                        )
                      : AnimationSplashLogin(
                          animationController: animationController.view,
                        ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),

                  /// navigation to home screen if user click "OR SKIP" (Click to open code)
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new HomeBottomNavigationScreen()),
                      );
                    },
                    child: Text(
                      "متابعة كضيف",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ButtonCustom extends StatelessWidget {
  final String txt;

  ButtonCustom({this.txt});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white,
        child: LayoutBuilder(builder: (context, constraint) {
          return Container(
            width: 300.0,
            height: 52.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.transparent,
                border: Border.all(color: Colors.white)),
            child: Center(
                child: Text(
              txt,
              style: TextStyle(
                color: Colors.white,
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
              ),
            )),
          );
        }),
      ),
    );
  }
}

/// Set Animation Login if user click button login
class AnimationSplashLogin extends StatefulWidget {
  AnimationSplashLogin({Key key, this.animationController})
      : animation = new Tween(
          end: 900.0,
          begin: 70.0,
        ).animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashLoginState createState() => _AnimationSplashLoginState();
}

/// Set Animation Login if user click button login
class _AnimationSplashLoginState extends State<AnimationSplashLogin> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        if (userType == UserType.Normal) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginNormalScreen()));
        } else if (userType == UserType.Supplier) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginSupplierScreen()));
        } else if (userType == UserType.Company) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginSupplierScreen()));
        }
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}

/// Set Animation signup if user click button signup
class AnimationSplashSignup extends StatefulWidget {
  AnimationSplashSignup({Key key, this.animationController})
      : animation = new Tween(
          end: 900.0,
          begin: 70.0,
        ).animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashSignupState createState() => _AnimationSplashSignupState();
}

/// Set Animation signup if user click button signup
class _AnimationSplashSignupState extends State<AnimationSplashSignup> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        if (userType == UserType.Normal) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => SignupNormalUserScreen()));
        } else if (userType == UserType.Supplier) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => SignupSupplierScreen()));
        }
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}
