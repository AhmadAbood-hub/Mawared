import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/screens/home/product_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartData extends ChangeNotifier {
  List<OrderDetails> cartProduct = [];

  CartData() {
    /* cartProduct = [
      Cart(
          company: 'Nike',
          backgroundColor: '#b5179e',
          name: 'some thing',
          price: 130,
          size: 'XL',
          color: '#f72585',
          cartCount: 5,
          image:
              'https://www.freeiconspng.com/thumbs/shoes-png/women-shoes-png-downloads-image-32.png'),
      Cart(
          company: 'Nike',
          backgroundColor: '#f72585',
          name: 'some thing',
          price: 130,
          size: 'XL',
          color: '#f72585',
          cartCount: 5,
          image:
              'https://pngimg.com/uploads/running_shoes/running_shoes_PNG5816.png'),
      Cart(
          company: 'Nike',
          backgroundColor: '#b5179e',
          name: 'some thing',
          price: 130,
          size: 'XL',
          color: '#f72585',
          cartCount: 5,
          image:
              'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop'),
      Cart(
          company: 'Nike',
          backgroundColor: '#b5179e',
          name: 'some thing',
          price: 130,
          size: 'XL',
          color: '#f72585',
          cartCount: 5,
          image:
              'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop'),
    ];*/

    getData();
  }

  void getData() async {
    String key = 'OrderList';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> orderList = preferences.getStringList(key);
    if (orderList == null) orderList = [];

    cartProduct = new List<OrderDetails>();
    orderList.forEach((v) {
      cartProduct.add(new OrderDetails.fromJson(jsonDecode(v)));
    });
    print(orderList.length);
    notifyListeners();
  }

  void deleteListItem(int index) {
    cartProduct.removeAt(index);
    notifyListeners();
  }

  void subCartNumAt(int index) {
    cartProduct.elementAt(index).orderCount--;
    notifyListeners();
  }

  void addCartNumAt(int index) {
    cartProduct.elementAt(index).orderCount++;
    notifyListeners();
  }
}

class Cart {
  String id;
  String productId;
  String company;
  String backgroundColor;
  String name;
  String descreption;
  double price;
  String size;
  String color;
  String image;
  int cartCount;

  Cart(
      {this.id,
      this.productId,
      this.company,
      this.backgroundColor,
      this.name,
      this.descreption,
      this.price,
      this.size,
      this.color,
      this.image,
      this.cartCount});
}
