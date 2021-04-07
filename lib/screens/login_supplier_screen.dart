import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/login_data.dart';
import 'package:mawared_app/screens/signup_supplier_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'home_bottom_navigation_screen.dart';

class LoginSupplierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffEFEFEF),
        body: ChangeNotifierProvider(
            create: (context) => LoginSupplierData(),
            child: LoginSupplierBody()),
      ),
    );
  }
}

class LoginSupplierBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<LoginSupplierData>(context).loginSpinner,
      progressIndicator: SpinKitChasingDots(
        color: kNearlyBlue,
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/login_shape.png'),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 75,
                      height: 75,
                      child: Image.asset('assets/images/mawared-logo.png')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Mawared',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'مرحباَ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'سجل الدخول لحسابك',
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade800),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          password: false,
                          text: 'اسم المستخدم',
                          errorText: Provider.of<LoginSupplierData>(context)
                              .userNameError,
                          onChange: (text) {
                            Provider.of<LoginSupplierData>(context,
                                    listen: false)
                                .setUserName(text);
                          },
                          icon: FontAwesomeIcons.user,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          password: false,
                          text: 'رقم الهاتف',
                          errorText: Provider.of<LoginSupplierData>(context)
                              .phoneNumberError,
                          onChange: (text) {
                            Provider.of<LoginSupplierData>(context,
                                    listen: false)
                                .setPhoneNumber(text);
                          },
                          icon: Icons.phone_android,
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          password: true,
                          text: 'كلمة السر',
                          icon: Icons.vpn_key,
                          onChange: (text) {
                            Provider.of<LoginSupplierData>(context,
                                    listen: false)
                                .setPassword(text);
                          },
                          errorText: Provider.of<LoginSupplierData>(context)
                              .passwordError,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            //Todo open forget password workflow
                          },
                          child: Text(
                            'نسيت كلمة السر',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                                color: Colors.grey.shade800),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RoundedButton(
                          onPressed: () async {
                            Provider.of<LoginSupplierData>(context,
                                    listen: false)
                                .setLoginSpinner(true);
                            bool result = await Provider.of<LoginSupplierData>(
                                    context,
                                    listen: false)
                                .login();
                            Provider.of<LoginSupplierData>(context,
                                    listen: false)
                                .setLoginSpinner(false);
                            if (result) {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        new HomeBottomNavigationScreen()),
                              );
                            }
                          },
                          title: 'تسجيل الدخول',
                          colour: kNearlyGreen,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.grey.shade600),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignupSupplierScreen()));
                        },
                        child: Text(
                          'أنشاء حساب',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: kNearlyBlue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final bool password;
  final IconData icon;
  final String text;
  final TextInputType textInputType;
  final String errorText;
  final Function onChange;

  const CustomTextFormField({
    Key key,
    this.password,
    this.icon,
    this.text,
    this.textInputType,
    this.errorText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return TextFormField(
      onEditingComplete: () => node.nextFocus(),
      onChanged: onChange,
      obscureText: password,
      decoration: InputDecoration(
        border: InputBorder.none,
        errorText: errorText,
        labelText: text,
        icon: Icon(
          icon,
          color: kNearlyBlue,
        ),
        labelStyle: TextStyle(
            fontSize: 15.0,
            fontFamily: 'TheSansArabic',
            letterSpacing: 0.3,
            color: Colors.black38,
            fontWeight: FontWeight.w600),
      ),
      style: TextStyle(fontFamily: 'TheSansArabic'),
      keyboardType: textInputType,
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
