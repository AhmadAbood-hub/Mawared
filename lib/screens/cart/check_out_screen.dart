import 'package:flutter/material.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chose_signup_login_screen.dart';
import 'order_confirm_screen.dart';

class CheckOutScreen extends StatelessWidget {
  final int sum;

  const CheckOutScreen({Key key, this.sum}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('الدفع'),
        ),
        body: CheckOutBody(sum: sum),
      ),
    );
  }
}

class CheckOutBody extends StatefulWidget {
  final int sum;

  const CheckOutBody({Key key, this.sum}) : super(key: key);
  @override
  _CheckOutBodyState createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  int _radioGropeValue = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        Text(
          'ملخص الطلبية',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Text(
              'المجموع الاولي : ',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Text(
              '${widget.sum}',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Text(
              'الضرائب : ',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Text(
              '100',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 2.0,
          child: Divider(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Text(
              'المجموع : ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Text(
              '${widget.sum + 100}',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.green),
            ),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        SizedBox(
          height: 25.0,
        ),
        Text(
          'عنوان التوصيل',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'سوريا - حلب - الفرقان',
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
        Text(
          'طريقة الدفع',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            Radio<int>(
              value: 1,
              groupValue: _radioGropeValue,
              onChanged: (value) {
                setState(() {
                  _radioGropeValue = value;
                  print(_radioGropeValue);
                });
              },
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              'نقدي عند التوصيل',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            Radio<int>(
              value: 2,
              groupValue: _radioGropeValue,
              onChanged: (value) {
                setState(() {
                  _radioGropeValue = value;
                  print(_radioGropeValue);
                });
              },
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              'الدفع عن طريق البطاقة الأتمانية',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        RoundedButton(
            onPressed: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OrderConfirmScreen();
                  },
                ),
              );
              String key = 'OrderList';
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              List<String> orderList = [];
              preferences.setStringList(key, orderList);
            },
            title: 'أكمال الطلب',
            colour: kNearlyBlue)
      ],
    );
  }
}
