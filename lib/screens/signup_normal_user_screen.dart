import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/phone_vertified_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'login_data.dart';
import 'login_normal_screen.dart';
import 'package:mawared_app/utilties/constants.dart';

class SignupNormalUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffEFEFEF),
        body: ChangeNotifierProvider(
            create: (context) => SignupNormalData(),
            child: SignupNormalUserBody()),
      ),
    );
  }
}

class SignupNormalUserBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<SignupNormalData>(context).signupSpinner,
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
                          text: 'الاسم',
                          errorText:
                              Provider.of<SignupNormalData>(context).nameError,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .setName(text);
                          },
                          icon: FontAwesomeIcons.user,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          password: false,
                          text: 'الكنية',
                          errorText: Provider.of<SignupNormalData>(context)
                              .nicknameError,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .setNickname(text);
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
                          errorText: Provider.of<SignupNormalData>(context)
                              .userNameError,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
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
                          errorText: Provider.of<SignupNormalData>(context)
                              .phoneNumberError,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
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
                          errorText: Provider.of<SignupNormalData>(context)
                              .passwordError,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
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
                          errorText: Provider.of<SignupNormalData>(context)
                              .passwordConfirmError,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .passwordConfirm = text;
                          },
                          icon: Icons.vpn_key,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomDropDownCountry(
                          icon: FontAwesomeIcons.globe,
                          value: Provider.of<SignupNormalData>(context).country,
                          items:
                              Provider.of<SignupNormalData>(context).countries,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .setCountry(text);
                          },
                          hint: 'اختر الدولة',
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomDropDownCity(
                          icon: FontAwesomeIcons.city,
                          value: Provider.of<SignupNormalData>(context).city,
                          items: Provider.of<SignupNormalData>(context).cities,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .setCity(text);
                          },
                          hint: 'اختر المدينة',
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomDropDown(
                          icon: FontAwesomeIcons.building,
                          value: Provider.of<SignupNormalData>(context).area,
                          items: Provider.of<SignupNormalData>(context).areas,
                          onChange: (text) {
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .setArea(text);
                          },
                          hint: 'اختر المنطقة',
                        ),
                        RoundedButton(
                          onPressed: () async {
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .setSignupSpinnerSpinner(true);

                            bool result = await Provider.of<SignupNormalData>(
                                    context,
                                    listen: false)
                                .signup();
                            Provider.of<SignupNormalData>(context,
                                    listen: false)
                                .setSignupSpinnerSpinner(false);
                            if (result) {
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
                                      LoginNormalScreen()));
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

class CustomDropDownCountry extends StatelessWidget {
  final IconData icon;
  final List<Country> items;
  final Country value;
  final Function onChange;
  final String hint;

  const CustomDropDownCountry({
    Key key,
    this.icon,
    this.items,
    this.value,
    this.onChange,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: kNearlyBlue,
        ),
        SizedBox(
          width: 20,
        ),
        DropdownButton<Country>(
          hint: Text(hint),
          style: TextStyle(
              fontFamily: 'TheSansArabic',
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          value: value,
          items: items.map((Country value) {
            return DropdownMenuItem<Country>(
              child: Text(value.name),
              value: value,
            );
          }).toList(),
          onChanged: onChange,
        ),
      ],
    );
  }
}

class CustomDropDownCity extends StatelessWidget {
  final IconData icon;
  final List<City> items;
  final City value;
  final Function onChange;
  final String hint;

  const CustomDropDownCity({
    Key key,
    this.icon,
    this.items,
    this.value,
    this.onChange,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: kNearlyBlue,
        ),
        SizedBox(
          width: 20,
        ),
        DropdownButton<City>(
          hint: Text(hint),
          style: TextStyle(
              fontFamily: 'TheSansArabic',
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          value: value,
          items: items.map((City value) {
            return DropdownMenuItem<City>(
              child: Text(value.name),
              value: value,
            );
          }).toList(),
          onChanged: onChange,
        ),
      ],
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final IconData icon;
  final List<String> items;
  final String value;
  final Function onChange;
  final String hint;

  const CustomDropDown({
    Key key,
    this.icon,
    this.items,
    this.value,
    this.onChange,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: kNearlyBlue,
        ),
        SizedBox(
          width: 20,
        ),
        DropdownButton<String>(
          hint: Text(hint),
          style: TextStyle(
              fontFamily: 'TheSansArabic',
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          value: value,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: onChange,
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
