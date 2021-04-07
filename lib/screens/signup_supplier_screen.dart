import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/login_data.dart';
import 'package:mawared_app/screens/phone_vertified_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'login_supplier_screen.dart';
import 'package:mawared_app/utilties/constants.dart';

import 'login_normal_screen.dart';

class SignupSupplierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffebebeb),
        body: ChangeNotifierProvider(
            create: (context) => SignupSupplierData(),
            child: SignupSupplierBody()),
      ),
    );
  }
}

class SignupSupplierBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<SignupSupplierData>(context).signupSpinner,
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
              padding: const EdgeInsets.only(top: 150.0),
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
                          'انشاء حساب جديد',
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade800),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          password: false,
                          text: 'الاسم الثلاثي',
                          errorText: Provider.of<SignupSupplierData>(context)
                              .fullNameError,
                          onChange: (text) {
                            Provider.of<SignupSupplierData>(context,
                                    listen: false)
                                .fullName = text;
                          },
                          icon: FontAwesomeIcons.user,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          password: false,
                          text: 'اسم المستخدم',
                          errorText: Provider.of<SignupSupplierData>(context)
                              .userNameError,
                          onChange: (text) {
                            Provider.of<SignupSupplierData>(context,
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
                          icon: Icons.phone_android,
                          errorText: Provider.of<SignupSupplierData>(context)
                              .phoneNumberError,
                          onChange: (text) {
                            Provider.of<SignupSupplierData>(context,
                                    listen: false)
                                .setPhoneNumber(text);
                          },
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          password: true,
                          text: 'كلمة السر',
                          errorText: Provider.of<SignupSupplierData>(context)
                              .passwordError,
                          onChange: (text) {
                            Provider.of<SignupSupplierData>(context,
                                    listen: false)
                                .setPassword(text);
                          },
                          icon: Icons.vpn_key,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          password: true,
                          text: 'تأكيد كلمة السر',
                          errorText: Provider.of<SignupSupplierData>(context)
                              .passwordConfirmError,
                          onChange: (text) {
                            Provider.of<SignupSupplierData>(context,
                                    listen: false)
                                .passwordConfirm = text;
                          },
                          icon: Icons.vpn_key,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RoundedButton(
                          onPressed: () async {
                            Provider.of<SignupSupplierData>(context,
                                    listen: false)
                                .setSignupSpinnerSpinner(true);
                            bool sucsess =
                                await Provider.of<SignupSupplierData>(context,
                                        listen: false)
                                    .signup();

                            Provider.of<SignupSupplierData>(context,
                                    listen: false)
                                .setSignupSpinnerSpinner(false);

                            if (sucsess) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PhoneVertifiedScreen(),
                                ),
                              );
                            }
                          },
                          title: 'انشاء حساب',
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
                        'لديك حساب؟',
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
                                  LoginSupplierScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: kNearlyBlue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
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

/*class SignupSupplierBody extends StatefulWidget {
  @override
  _SignupSupplierBodyState createState() => _SignupSupplierBodyState();
}

class _SignupSupplierBodyState extends State<SignupSupplierBody> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          padding: const EdgeInsets.only(top: 150.0),
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
              Flexible(
                fit: FlexFit.tight,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    FirstTab(),
                    SignupNormalUserScreen(),
                    LoginNormalScreen(),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                },
                child: Text('Next'),
              ),
              MaterialButton(
                onPressed: () {
                  pageController.previousPage(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeOut);
                },
                child: Text('back'),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
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
                'انشاء حساب جديد',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                password: true,
                text: 'الاسم الثلاثي',
                icon: Icons.person,
                textInputType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                password: false,
                text: 'رقم الهاتف',
                icon: Icons.phone_android,
                textInputType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
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
                'انشاء حساب جديد',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                password: true,
                text: 'الاسم الثلاثي',
                icon: Icons.person,
                textInputType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                password: false,
                text: 'رقم الهاتف',
                icon: Icons.phone_android,
                textInputType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final bool password;
  final IconData icon;
  final String text;
  final TextInputType textInputType;

  const CustomTextFormField({
    Key key,
    this.password,
    this.icon,
    this.text,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
        print(text);
      },
      obscureText: password,
      decoration: InputDecoration(
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
}*/
