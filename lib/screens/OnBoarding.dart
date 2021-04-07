import 'package:flutter/material.dart';
import 'package:mawared_app/library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:mawared_app/library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:mawared_app/screens/chose_login_signup.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Popins",
    fontSize: 21.0,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
    letterSpacing: 1.5);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Sans",
    fontSize: 15.0,
    color: Colors.black26,
    fontWeight: FontWeight.w400);

///
/// Page View Model for on boarding
///
final pages = [
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        //Todo CHange Txt
        'تطبيق تسوق الكتروني', style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            //Todo
            '',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),
      ),
      mainImage: Image.asset(
        'assets/images/IlustrasiOnBoarding1.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        //Todo
        'أختر منتج',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            //TODO
            '',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),
      ),
      mainImage: Image.asset(
        'assets/images/IlustrasiOnBoarding2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'ابدأ',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            'Shop from thousand brands in the world \n in one application at throwaway \nprices ',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),
      ),
      mainImage: Image.asset(
        'assets/images/IlustrasiOnBoarding3.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
];

class _onBoardingState extends State<onBoarding> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntroViewsFlutter(
        pages,
        pageButtonsColor: Colors.black45,
        skipText: Text(
          "تخطي",
          style: _fontDescriptionStyle.copyWith(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0),
        ),
        doneText: Text(
          "انهاء",
          style: _fontDescriptionStyle.copyWith(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0),
        ),
        onTapDoneButton: () {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => ChoseLoginSignup(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget widget) {
              return Opacity(
                opacity: animation.value,
                child: widget,
              );
            },
            transitionDuration: Duration(milliseconds: 1500),
          ));
        },
      ),
    );
  }
}
