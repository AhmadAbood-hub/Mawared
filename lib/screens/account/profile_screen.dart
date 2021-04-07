import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/account/account_data.dart';
import 'package:mawared_app/screens/account/notification_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:provider/provider.dart';

import 'CreditCardSetting.dart';
import 'MyOrders.dart';
import 'SettingAcount.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ChangeNotifierProvider(
          create: (context) => ProfileData(),
          child: Scaffold(
            backgroundColor: kBackground,
            body: ProfileBody(),
          ),
        ));
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Declare MediaQueryData
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    /// To Sett PhotoProfile,Name and Edit Profile
    var _profile = Padding(
      padding: EdgeInsets.only(
        top: 185.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.5),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: Provider.of<ProfileData>(context).user.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                            )),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        FontAwesomeIcons.image,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  Provider.of<ProfileData>(context).user.name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.0),
                ),
              ),
              InkWell(
                onTap: () {
                  //todo edit profile
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    "تعديل الملف الشخصي",
                    style: TextStyle(color: Colors.black26, fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 50),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            /// Setting Header Banner
            Container(
              height: 240.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/headerProfile.png"),
                      fit: BoxFit.cover)),
            ),

            /// Calling _profile variable
            _profile,
            Padding(
              padding: const EdgeInsets.only(top: 360.0),
              child: Column(
                /// Setting Category List
                children: <Widget>[
                  /// Call category class
                  category(
                    txt: "الأشعارات",
                    padding: 35.0,
                    image: "assets/icon/notification.png",
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => NotificationScreen()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 85.0, left: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "الدفع",
                    padding: 35.0,
                    image: "assets/icon/creditAcount.png",
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              new creditCardSetting()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 85.0, left: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "طلباتي",
                    padding: 23.0,
                    image: "assets/icon/truck.png",
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => order()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 85.0, left: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "اعدادات الحساب",
                    padding: 30.0,
                    image: "assets/icon/setting.png",
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => settingAcount()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 85.0, left: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    padding: 38.0,
                    txt: "حول التطبيق",
                    image: "assets/icon/aboutapp.png",
                    tap: () {
                      /*Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new aboutApps()));*/
                    },
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: padding),
                  child: Image.asset(
                    image,
                    height: 25.0,
                  ),
                ),
                Text(
                  txt,
                  style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
