import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/home/product_details.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/widget/animated_flip_counter.dart';
import 'package:provider/provider.dart';

import 'cart_data.dart';
import 'check_out_screen.dart';

class CartScreen extends StatefulWidget {
  final AnimationController animationController;

  const CartScreen({Key key, this.animationController}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Widget> items = [];

  List<Widget> getCartItems(BuildContext context, int num) {
    items = [];
    for (int i = 0; i < num; i++) {
      items.add(CardCart(
        animationController: widget.animationController,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / 20) * i, 1.0, curve: Curves.fastOutSlowIn))),
        orderDetalis: Provider.of<CartData>(context).cartProduct.elementAt(i),
        index: i,
        backgroundHeroTag: 'cartBackgroundHeroTag$i',
        imageHeroTag: 'cartImageHeroTag$i',
      ));
    }
    return items;
  }

  int getTotalSum(BuildContext context) {
    int sum = 0;
    if (Provider.of<CartData>(context).cartProduct != null &&
        Provider.of<CartData>(context).cartProduct.length != 0) {
      for (int i = 0;
          i < Provider.of<CartData>(context).cartProduct.length;
          i++) {
        if (Provider.of<CartData>(context).cartProduct[i].product.price !=
            null) {
          sum += double.parse(Provider.of<CartData>(context)
                      .cartProduct[i]
                      .product
                      .price)
                  .round() *
              Provider.of<CartData>(context).cartProduct[i].orderCount;
        }
      }
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => CartData(),
      builder: (context, child) {
        widget.animationController.forward();
        return Padding(
          padding: EdgeInsets.only(
            bottom: 55 + MediaQuery.of(context).padding.bottom,
          ),
          child: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: Provider.of<CartData>(context).cartProduct.length,
                padding: EdgeInsets.only(bottom: 150, top: 60),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return CardCart(
                    animationController: widget.animationController,
                    animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.animationController,
                            curve: Interval((1 / 20) * index, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    orderDetalis: Provider.of<CartData>(context)
                        .cartProduct
                        .elementAt(index),
                    index: index,
                    backgroundHeroTag: 'cartBackgroundHeroTag$index',
                    imageHeroTag: 'cartImageHeroTag$index',
                  );
                },
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          right: 20, left: 20, top: 20, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: kNearlyBlue.withOpacity(0.2),
                                offset: const Offset(4.0, 4.0),
                                blurRadius: 8.0),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'المجموع',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: AnimatedFlipCounter(
                                  duration: Duration(milliseconds: 500),
                                  value: getTotalSum(context),
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green,
                                    fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RoundedButton(
                            title: 'شراء',
                            colour: kNearlyBlue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (buildcontext) {
                                    return CheckOutScreen(
                                        sum: getTotalSum(context));
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                ],
              ),
              CustomAppbar(),
            ],
          ),
        );
      },
    ));
  }
}

class CardCart extends StatefulWidget {
  CardCart(
      {this.animationController,
      this.animation,
      this.orderDetalis,
      this.index,
      this.backgroundHeroTag,
      this.imageHeroTag});
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final OrderDetails orderDetalis;
  final int index;
  final String backgroundHeroTag;
  final String imageHeroTag;

  @override
  _CardCartState createState() => _CardCartState();
}

class _CardCartState extends State<CardCart> with TickerProviderStateMixin {
  AnimationController deleteAnimationController;
  Animation deleteAnimation;

  @override
  void initState() {
    deleteAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    deleteAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: deleteAnimationController, curve: Curves.fastOutSlowIn));

    deleteAnimationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    deleteAnimationController.dispose();
    super.dispose();
  }

  List<Widget> getAttributesList() {
    List<Widget> result = [];
    if (widget.orderDetalis.attributeMap != null &&
        widget.orderDetalis.attributeMap.length != 0) {
      for (AttributeMap attributeMap in widget.orderDetalis.attributeMap) {
        if (attributeMap.color == null) {
          result.add(Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Text(
                '${attributeMap.value}',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              ),
            ),
          ));
        } else {
          result.add(
            Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: parseColor(attributeMap.color),
              ),
            ),
          );
        }

        result.add(
          SizedBox(
            width: 15,
          ),
        );
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  //todo open product details
                  /*Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 300),
                        pageBuilder: (context, animation, animation2) {
                          return DetailsScreen(
                            backgroundHeroTag: widget.backgroundHeroTag,
                            imageHeroTag: widget.imageHeroTag,
                            shoes: widget.shoesCart.shoes,
                            animation: animation,
                          );
                        }),
                  );*/
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Transform.scale(
                      scale: deleteAnimation.value,
                      child: SizedBox(
                        width: 140,
                        height: 120,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Hero(
                                tag: widget.backgroundHeroTag,
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: parseColor(widget.orderDetalis
                                          .product.productImgcolor)),
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Container(
                                width: 140,
                                height: 120,
                                padding: EdgeInsets.only(right: 10, bottom: 10),
                                child: Hero(
                                  tag: widget.imageHeroTag,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.orderDetalis.image ?? '',
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                              ),
                                            )),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Icon(
                                        FontAwesomeIcons.image,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Transform(
                        transform: Matrix4.translationValues(
                            -300 * (1.0 - deleteAnimation.value), 0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                widget.orderDetalis.product.name,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${widget.orderDetalis.product.price}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 8,
                              ), //TODO
                              SingleChildScrollView(
                                child: Container(
                                  height: 20,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: getAttributesList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Provider.of<CartData>(context,
                                              listen: false)
                                          .subCartNumAt(widget.index);
                                      if (widget.orderDetalis.orderCount == 0) {
                                        deleteAnimationController
                                            .forward()
                                            .then((value) {
                                          Provider.of<CartData>(context,
                                                  listen: false)
                                              .deleteListItem(widget.index);
                                          deleteAnimationController.reset();
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: kNearlyBlue
                                                    .withOpacity(0.2),
                                                offset: const Offset(4.0, 4.0),
                                                blurRadius: 8.0),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.remove,
                                          color: kNearlyBlue,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    '${widget.orderDetalis.orderCount}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Provider.of<CartData>(context,
                                              listen: false)
                                          .addCartNumAt(widget.index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: kNearlyBlue
                                                    .withOpacity(0.2),
                                                offset: const Offset(4.0, 4.0),
                                                blurRadius: 8.0),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.add,
                                          color: kNearlyBlue,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

Color parseColor(String color) {
  Color col;
  try {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  } catch (e) {
    col = Colors.white;
  }
  return col;
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            'موارد',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                //Todo open search screen
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Colors.grey.shade100),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.search,
                      color: Colors.grey.shade600,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'بحث',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              //Todo open notification screen
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  color: Colors.grey.shade100),
              child: Icon(
                FontAwesomeIcons.bell,
                color: Colors.grey.shade600,
                size: 18,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
