import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawared_app/screens/OnBoarding.dart';
import 'package:mawared_app/screens/chose_login_signup.dart';
import 'package:mawared_app/screens/home/product_detalis_screen.dart';
import 'package:mawared_app/screens/home_bottom_navigation_screen.dart';
import 'package:mawared_app/screens/login_normal_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Future<bool> isLogedin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.get('Customer');
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Mawared',
      theme: ThemeData(
        fontFamily: 'TheSansArabic',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder(
            future: isLogedin(),
            builder: (buildContext, snapShot) {
              return snapShot.data
                  ? HomeBottomNavigationScreen()
                  : onBoarding();
            },
          )),
    );
  }
}
