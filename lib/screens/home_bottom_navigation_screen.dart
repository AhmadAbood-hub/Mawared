import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/Brands/brand_tap_screen.dart';
import 'package:mawared_app/screens/home/home_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/iconly_icons.dart';

import 'account/profile_screen.dart';
import 'cart/cart_screen.dart';

class HomeBottomNavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: kBackground,
          body: HomeBottomNavigationBody(),
        ),
      ),
    );
  }
}

class HomeBottomNavigationBody extends StatefulWidget {
  @override
  _HomeBottomNavigationBodyState createState() =>
      _HomeBottomNavigationBodyState();
}

class _HomeBottomNavigationBodyState extends State<HomeBottomNavigationBody>
    with TickerProviderStateMixin {
  AnimationController animationController;

  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    tabBody = HomeScreen();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  int bottomIndex = 0;

  void setTabBody(int index) {
    switch (index) {
      case 0:
        animationController.reverse().then<dynamic>((data) {
          setState(() {
            tabBody = HomeScreen();
            bottomIndex = 0;
          });
        });
        break;
      case 1:
        animationController.reverse().then<dynamic>((data) {
          setState(() {
            tabBody = BrandTapScreen();
            bottomIndex = 1;
          });
        });
        break;
      case 2:
        animationController.reverse().then<dynamic>((data) {
          setState(() {
            tabBody = CartScreen(
              animationController: animationController,
            );
            bottomIndex = 2;
          });
        });
        break;
      case 3:
        animationController.reverse().then<dynamic>((data) {
          setState(() {
            tabBody = ProfileScreen();
            bottomIndex = 3;
          });
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        tabBody,
        Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20.0),
                      topEnd: Radius.circular(20.0)),
                  color: Colors.white),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Iconly.home_1),
                    label: 'الرئيسية',
                    activeIcon: Icon(Iconly.home),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.briefcase),
                    //todo change icon
                    label: "الماركات",
                    activeIcon: Icon(FontAwesomeIcons.briefcase),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconly.buy_1),
                    label: "السلة",
                    activeIcon: Icon(Iconly.buy),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconly.profile_1),
                    label: "الحساب",
                    activeIcon: Icon(Iconly.profile),
                  ),
                ],
                onTap: (index) {
                  setTabBody(index);
                },
                selectedItemColor: kNearlyBlue,
                unselectedItemColor: Colors.grey,
                currentIndex: bottomIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
              ),
            )
          ],
        )
      ],
    );
  }
}


