import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoseLoginTypeBottomSheet extends StatelessWidget {
  final Function onNormalUserPressed;
  final Function onSupplierPressed;
  final Function onCompanyPressed;

  const ChoseLoginTypeBottomSheet(
      {Key key,
      this.onNormalUserPressed,
      this.onSupplierPressed,
      this.onCompanyPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff292421),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
                onSupplierPressed();
              },
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(FontAwesomeIcons.userTie),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    'مورد',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                onNormalUserPressed();
              },
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(
                      FontAwesomeIcons.user,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    'مستخدم',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                onCompanyPressed();
              },
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(
                      FontAwesomeIcons.building,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    'شركة شحن',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundedButton(
                title: 'إلغاء',
                colour: Colors.red.shade400,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
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
      padding: EdgeInsets.symmetric(vertical: 16.0),
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
