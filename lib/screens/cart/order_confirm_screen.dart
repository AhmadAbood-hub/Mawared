import 'package:flutter/material.dart';
import 'package:mawared_app/utilties/constants.dart';

import '../chose_signup_login_screen.dart';

class OrderConfirmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNearlyBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 200.0,
                  child: Image.asset('assets/images/order_confermd.png')),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'تم تأكيد الطلب',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'شكرا لك',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40.0,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30.0,
            ),
            RoundedButton(
              title: 'العودة',
              colour: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              textColor: kNearlyBlue,
            ),
          ],
        ),
      ),
    );
  }
}
