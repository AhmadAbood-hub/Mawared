import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/screens/login_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id;
  String name;
  String image;

  User(this.id, this.name, this.image);
}

class ProfileData extends ChangeNotifier {
  User user;

  ProfileData() {
    getData();
    user = User(1, 'james bond',
        'https://cdn.dnaindia.com/sites/default/files/styles/full/public/2020/10/07/929670-daniel-craig-no-time-to-die.jpg');
  }

  void getData() async {
    String key = 'Customer';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user2 = await preferences.get(key);
    Customer customer = Customer.fromJson(jsonDecode(user2));
    user.name = customer.userName;
    //todo set local image
    notifyListeners();
  }
}

class NotificationData extends ChangeNotifier {
  List<Notification> notifications;

  NotificationData() {
    notifications = [
      Notification(
          1,
          'https://i.pinimg.com/originals/33/b8/69/33b869f90619e81763dbf1fccc896d8d.jpg',
          'name',
          'desc'),
      Notification(
          1, 'https://cdn.logo.com/hotlink-ok/logo-social.png', 'name', 'desc'),
      Notification(
          1,
          'https://logos-world.net/wp-content/uploads/2020/04/Huawei-Logo.png',
          'name',
          'desc'),
      Notification(
          1,
          'https://codesign.com.bd/conversations/content/images/2020/03/Sprint-logo-design-Codesign-agency.png',
          'name',
          'desc'),
      Notification(
          1,
          'https://codesign.com.bd/conversations/content/images/2020/03/Sprint-logo-design-Codesign-agency.png',
          'name',
          'desc'),
    ];
  }

  void deleteNotification(index) {
    notifications.removeAt(index);
    notifyListeners();
  }
}

class Notification {
  int id;
  String image;
  String title;
  String desc;

  Notification(this.id, this.image, this.title, this.desc);
}
