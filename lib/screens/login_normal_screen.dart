import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mawared_app/screens/home_bottom_navigation_screen.dart';
import 'package:mawared_app/screens/signup_normal_user_screen.dart';
import '../screens/login_data.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginNormalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffEFEFEF),
        body: ChangeNotifierProvider(
            create: (context) => LoginNormalData(), child: LoginNormalBody()),
      ),
    );
  }
}

class LoginNormalBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<LoginNormalData>(context).loginSpinner,
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
                    child: Image.asset('assets/images/mawared-logo.png'),
                  ),
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
                          text: 'رقم الهاتف',
                          onChange: (text) {
                            Provider.of<LoginNormalData>(context, listen: false)
                                .setPhoneNumber(text);
                          },
                          icon: Icons.phone_android,
                          errorText: Provider.of<LoginNormalData>(context)
                              .phoneNumberError,
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          password: true,
                          text: 'كلمة السر',
                          onChange: (text) {
                            Provider.of<LoginNormalData>(context, listen: false)
                                .setPassword(text);
                          },
                          errorText: Provider.of<LoginNormalData>(context)
                              .passwordError,
                          icon: Icons.vpn_key,
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
                            Provider.of<LoginNormalData>(context, listen: false)
                                .setLoginSpinner(true);
                            bool result = await Provider.of<LoginNormalData>(
                                    context,
                                    listen: false)
                                .login();
                            Provider.of<LoginNormalData>(context, listen: false)
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
                                      SignupNormalUserScreen()));
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
        errorText: errorText,
        border: InputBorder.none,
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
