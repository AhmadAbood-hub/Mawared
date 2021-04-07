import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mawared_app/screens/login_data.dart';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future loginNormall(String phoneNum, String password) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.statusCode);
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future signupNormall(dynamic user) async {
    print(user);
    print(url);
    http.Response response = await http.post(url);

    if (response.statusCode == 200) {
      print(response.statusCode);
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
