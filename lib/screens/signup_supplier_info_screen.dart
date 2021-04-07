import 'package:flutter/material.dart';
import 'package:mawared_app/utilties/constants.dart';

class SignupSupplierInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SignupSupplierInfoBody extends StatefulWidget {
  @override
  _SignupSupplierInfoBodyState createState() => _SignupSupplierInfoBodyState();
}

class _SignupSupplierInfoBodyState extends State<SignupSupplierInfoBody> {
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
}
