import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/screens/home/product_details.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNormalData extends ChangeNotifier {
  bool loginSpinner = false;
  String phoneNumber;
  String password;
  String phoneNumberError;
  String passwordError;

  Future<bool> login() async {
    if (checkIfOkToGo()) {
      NetworkHelper networkHelper = NetworkHelper(
          '${kBaseApiUrl}api/ClientAuth/LoginendClient?phonenumber=$phoneNumber&password=$password');
      var brandDataJson =
          await networkHelper.loginNormall(phoneNumber, password);

      if (brandDataJson != null) {
        storeLocal(brandDataJson);
        return true;
      } else {
        print('error');
        return false;
      }
    } else {
      return false;
    }
  }

  void storeLocal(String data) async {
    String key = 'Customer';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  void setLoginSpinner(bool value) {
    loginSpinner = value;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  bool checkIfOkToGo() {
    bool result = true;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      phoneNumberError = 'الرجاء ادخال رقم الهاتف';
      result = false;
    } else {
      phoneNumberError = '';
    }
    if (password == null || password.isEmpty) {
      passwordError = 'الرجاء ادخال كلمة السر';
      result = false;
    } else {
      passwordError = '';
    }

    return result;
  }
}

class LoginSupplierData extends ChangeNotifier {
  bool loginSpinner = false;
  String userName;
  String userNameError;
  String phoneNumber;
  String password;
  String phoneNumberError;
  String passwordError;

  Future<bool> login() async {
    if (checkIfOkToGo()) {
      NetworkHelper networkHelper = NetworkHelper(
          '${kBaseApiUrl}api/ClientAuth/LoginendClient?phonenumber=$phoneNumber&password=$password');
      var brandDataJson =
          await networkHelper.loginNormall(phoneNumber, password);

      if (brandDataJson != null) {
        storeLocal(brandDataJson);
        return true;
      } else {
        print('error');
        return false;
      }
    } else {
      return false;
    }
  }

  void storeLocal(String data) async {
    String key = 'Customer';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  void setLoginSpinner(bool value) {
    loginSpinner = value;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setUserName(String userName) {
    this.userName = userName;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  bool checkIfOkToGo() {
    bool result = true;
    if (userName == null || userName.isEmpty) {
      userNameError = 'الرجاء ادخال اسم المستخدم';
      result = false;
    } else {
      userNameError = '';
    }
    if (password == null || password.isEmpty) {
      passwordError = 'الرجاء ادخال كلمة السر';
      result = false;
    } else {
      passwordError = '';
    }

    return result;
  }
}

class SignupNormalData extends ChangeNotifier {
  bool signupSpinner = false;

  String userName;
  String name;
  String nickname;
  String phoneNumber;
  String password;
  String passwordConfirm;
  Country country;
  City city;
  String area;
  String userNameError;
  String nameError;
  String nicknameError;
  String phoneNumberError;
  String passwordError;
  String passwordConfirmError;

  List<Country> countries = [];
  List<City> cities = [];
  List<String> areas = ['12 street'];

  SignupNormalData() {
    getCounties();
  }

  Future<bool> signup() async {
    if (checkIfOkToGo()) {
      Customer customer = Customer(
        id: 0,
        firstName: name,
        lastName: nickname,
        userName: userName,
        primaryPhoneNum: phoneNumber,
        password: password,
        confirmerGuid: '00000000-0000-0000-0000-000000000000',
        cityGuid: city.cityGuid,
        customerGuid: '00000000-0000-0000-0000-000000000000',
        affiliateGuid: '00000000-0000-0000-0000-000000000000',
        countryGuid: country.countryGuid,
        isphoneConfirmed: false,
        isIdentiyConfirmed: false,
        requireReLogin: false,
        active: false,
        deleted: false,
        failedLoginAttempts: 0,
      );
      NetworkHelper networkHelper = NetworkHelper(
          '${kBaseApiUrl}api/ClientAuth/RegisterendClient?customer=${jsonEncode(customer.toJson())}');

      var customerJson =
          await networkHelper.signupNormall(jsonEncode(customer.toJson()));

      print(customerJson);

      if (customerJson != null) {
        print(customerJson);
        storeLocal(jsonEncode(customer.toJson()));
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void getCounties() async {
    NetworkHelper networkHelper =
        NetworkHelper('${kBaseApiUrl}api/ClientAuth/getCountries');

    var countriesResponse = await networkHelper.getData();

    if (countriesResponse != null) {
      var countriesJson = jsonDecode(countriesResponse) as List;
      countries = countriesJson.map((e) => Country.fromJson(e)).toList();
      notifyListeners();
    } else {
      print('error');
    }
  }

  void storeLocal(String data) async {
    String key = 'Customer';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  void getCities(String guide) async {
    NetworkHelper networkHelper = NetworkHelper(
        '${kBaseApiUrl}api/ClientAuth/getCities?countryguid=$guide');

    var citesResponse = await networkHelper.getData();

    if (citesResponse != null) {
      var citiesJson = jsonDecode(citesResponse) as List;
      print(citiesJson);
      cities = citiesJson.map((e) => City.fromJson(e)).toList();
      notifyListeners();
    } else {
      print('error');
    }
  }

  void setSignupSpinnerSpinner(bool value) {
    print(value);
    signupSpinner = value;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setUserName(String userName) {
    this.userName = userName;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setNickname(String nickname) {
    this.nickname = nickname;
    notifyListeners();
  }

  void setCountry(Country country) {
    this.country = country;
    getCities(country.countryGuid);
    notifyListeners();
  }

  void setCity(City city) {
    this.city = city;
    notifyListeners();
  }

  void setArea(String area) {
    this.area = area;
    notifyListeners();
  }

  bool checkIfOkToGo() {
    bool result = true;
    print(userName);
    if (userName == null || userName.isEmpty) {
      userNameError = 'الرجاء ادخال اسم المستخدم';
      result = false;
    } else {
      userNameError = '';
    }

    if (phoneNumber == null || phoneNumber.isEmpty) {
      phoneNumberError = 'الرجاء ادخال رقم الهاتف';
      result = false;
    } else {
      phoneNumberError = '';
    }

    if (password == null || password.isEmpty) {
      passwordError = 'الرجاء ادخال كلمة السر';
      result = false;
    } else {
      passwordError = '';
    }

    if (name == null || name.isEmpty) {
      nameError = 'الرجاء الاسم';
      result = false;
    } else {
      nameError = '';
    }

    if (nickname == null || nickname.isEmpty) {
      nicknameError = 'الرجاء ادخال الكنية';
      result = false;
    } else {
      nicknameError = '';
    }

    if (passwordConfirm == null ||
        passwordConfirm.isEmpty ||
        password != passwordConfirm) {
      passwordConfirmError = 'كلمة السر غير متطابقة';
      result = false;
    } else {
      passwordConfirmError = '';
    }

    return result;
  }
}

class SignupSupplierData extends ChangeNotifier {
  bool signupSpinner = false;

  String userName;
  String fullName;
  String phoneNumber;
  String password;
  String passwordConfirm;

  String userNameError;
  String fullNameError;
  String phoneNumberError;
  String passwordError;
  String passwordConfirmError;

  Future<bool> signup() async {
    if (checkIfOkToGo()) {
      Customer customer = Customer(
        id: 0,
        firstName: fullName,
        userName: userName,
        primaryPhoneNum: phoneNumber,
        password: password,
        confirmerGuid: '00000000-0000-0000-0000-000000000000',
        cityGuid: '00000000-0000-0000-0000-000000000000',
        customerGuid: '00000000-0000-0000-0000-000000000000',
        affiliateGuid: '00000000-0000-0000-0000-000000000000',
        countryGuid: '00000000-0000-0000-0000-000000000000',
        isphoneConfirmed: false,
        isIdentiyConfirmed: false,
        requireReLogin: false,
        active: false,
        deleted: false,
        failedLoginAttempts: 0,
      );
      NetworkHelper networkHelper = NetworkHelper(
          '${kBaseApiUrl}api/ClientAuth/RegisterendClient?customer=${jsonEncode(customer.toJson())}');

      var customerJson =
          await networkHelper.signupNormall(jsonEncode(customer.toJson()));

      if (customerJson != null) {
        print(customerJson);
        storeLocal(jsonEncode(customer.toJson()));
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void storeLocal(String data) async {
    String key = 'Customer';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  void setSignupSpinnerSpinner(bool value) {
    signupSpinner = value;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setUserName(String userName) {
    this.userName = userName;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  bool checkIfOkToGo() {
    bool result = true;
    print(userName);
    if (userName == null || userName.isEmpty) {
      userNameError = 'الرجاء ادخال اسم المستخدم';
      result = false;
    } else {
      userNameError = '';
    }

    if (fullName == null || fullName.isEmpty) {
      fullNameError = 'الرجاء ادخال الاسم الثلاثي';
      result = false;
    } else {
      fullNameError = '';
    }

    if (phoneNumber == null || phoneNumber.isEmpty) {
      phoneNumberError = 'الرجاء ادخال رقم الهاتف';
      result = false;
    } else {
      phoneNumberError = '';
    }

    if (password == null || password.isEmpty) {
      passwordError = 'الرجاء ادخال كلمة السر';
      result = false;
    } else {
      passwordError = '';
    }

    if (passwordConfirm == null ||
        passwordConfirm.isEmpty ||
        password != passwordConfirm) {
      passwordConfirmError = 'كلمة السر غير متطابقة';
      result = false;
    } else {
      passwordConfirmError = '';
    }

    return result;
  }
}

class Customer {
  int id;
  String customerGuid;
  String firstName;
  String lastName;
  String userName;
  String password;
  String primaryPhoneNum;
  String secondPhoneNum;
  String admincomment;
  String countryGuid;
  String cityGuid;
  bool isphoneConfirmed;
  bool isIdentiyConfirmed;
  String registerAt;
  String confirmerGuid;
  String userCode;
  String affiliateGuid;
  Null shippingAddress;
  Null userAddress;
  bool requireReLogin;
  bool active;
  bool deleted;
  int failedLoginAttempts;
  String cannotLoginUntilDateUtc;
  String lastLoginDateUtc;
  String lastActivityDateUtc;
  Null cannotLoginUntilDateUtcstr;

  Customer(
      {this.id,
      this.customerGuid,
      this.firstName,
      this.lastName,
      this.userName,
      this.password,
      this.primaryPhoneNum,
      this.secondPhoneNum,
      this.admincomment,
      this.countryGuid,
      this.cityGuid,
      this.isphoneConfirmed,
      this.isIdentiyConfirmed,
      this.registerAt,
      this.confirmerGuid,
      this.userCode,
      this.affiliateGuid,
      this.shippingAddress,
      this.userAddress,
      this.requireReLogin,
      this.active,
      this.deleted,
      this.failedLoginAttempts,
      this.cannotLoginUntilDateUtc,
      this.lastLoginDateUtc,
      this.lastActivityDateUtc,
      this.cannotLoginUntilDateUtcstr});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerGuid = json['CustomerGuid'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    password = json['Password'];
    primaryPhoneNum = json['PrimaryPhoneNum'];
    secondPhoneNum = json['secondPhoneNum'];
    admincomment = json['admincomment'];
    countryGuid = json['CountryGuid'];
    cityGuid = json['CityGuid'];
    isphoneConfirmed = json['IsphoneConfirmed'];
    isIdentiyConfirmed = json['IsIdentiyConfirmed'];
    registerAt = json['Register_at'];
    confirmerGuid = json['ConfirmerGuid'];
    userCode = json['UserCode'];
    affiliateGuid = json['AffiliateGuid'];
    shippingAddress = json['ShippingAddress'];
    userAddress = json['userAddress'];
    requireReLogin = json['RequireReLogin'];
    active = json['Active'];
    deleted = json['Deleted'];
    failedLoginAttempts = json['FailedLoginAttempts'];
    cannotLoginUntilDateUtc = json['CannotLoginUntilDateUtc'];
    lastLoginDateUtc = json['LastLoginDateUtc'];
    lastActivityDateUtc = json['LastActivityDateUtc'];
    cannotLoginUntilDateUtcstr = json['CannotLoginUntilDateUtcstr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CustomerGuid'] = this.customerGuid;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['PrimaryPhoneNum'] = this.primaryPhoneNum;
    data['secondPhoneNum'] = this.secondPhoneNum;
    data['admincomment'] = this.admincomment;
    data['CountryGuid'] = this.countryGuid;
    data['CityGuid'] = this.cityGuid;
    data['IsphoneConfirmed'] = this.isphoneConfirmed;
    data['IsIdentiyConfirmed'] = this.isIdentiyConfirmed;
    data['Register_at'] = this.registerAt;
    data['ConfirmerGuid'] = this.confirmerGuid;
    data['UserCode'] = this.userCode;
    data['AffiliateGuid'] = this.affiliateGuid;
    data['ShippingAddress'] = this.shippingAddress;
    data['userAddress'] = this.userAddress;
    data['RequireReLogin'] = this.requireReLogin;
    data['Active'] = this.active;
    data['Deleted'] = this.deleted;
    data['FailedLoginAttempts'] = this.failedLoginAttempts;
    data['CannotLoginUntilDateUtc'] = this.cannotLoginUntilDateUtc;
    data['LastLoginDateUtc'] = this.lastLoginDateUtc;
    data['LastActivityDateUtc'] = this.lastActivityDateUtc;
    data['CannotLoginUntilDateUtcstr'] = this.cannotLoginUntilDateUtcstr;
    return data;
  }
}

class Coutries {
  int id;
  String countryGuid;
  String name;
  bool countryAvalible;

  Coutries({this.id, this.countryGuid, this.name, this.countryAvalible});

  Coutries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryGuid = json['CountryGuid'];
    name = json['Name'];
    countryAvalible = json['CountryAvalible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CountryGuid'] = this.countryGuid;
    data['Name'] = this.name;
    data['CountryAvalible'] = this.countryAvalible;
    return data;
  }
}

class Country {
  int id;
  String countryGuid;
  String name;
  bool countryAvalible;

  Country({this.id, this.countryGuid, this.name, this.countryAvalible});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryGuid = json['CountryGuid'];
    name = json['Name'];
    countryAvalible = json['CountryAvalible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CountryGuid'] = this.countryGuid;
    data['Name'] = this.name;
    data['CountryAvalible'] = this.countryAvalible;
    return data;
  }
}

class City {
  int id;
  String cityGuid;
  String name;
  bool cityAvalible;
  String countryGuid;
  Null cityCountry;

  City(
      {this.id,
      this.cityGuid,
      this.name,
      this.cityAvalible,
      this.countryGuid,
      this.cityCountry});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityGuid = json['CityGuid'];
    name = json['Name'];
    cityAvalible = json['CityAvalible'];
    countryGuid = json['CountryGuid'];
    cityCountry = json['cityCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CityGuid'] = this.cityGuid;
    data['Name'] = this.name;
    data['CityAvalible'] = this.cityAvalible;
    data['CountryGuid'] = this.countryGuid;
    data['cityCountry'] = this.cityCountry;
    return data;
  }
}
