import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/home/product_details.dart';
import 'package:mawared_app/screens/home/product_details_bottom_sheet.dart';
import 'package:mawared_app/screens/home/review_layout.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'category_details_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String guide;

  const ProductDetailsScreen({Key key, this.guide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ChangeNotifierProvider(
          create: (context) => ProductDetailsData(guide),
          builder: (context, child) {
            return Scaffold(
              body: Provider.of<ProductDetailsData>(context).showProductLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : DetailsBody(),
            );
          },
        ));
  }
}

class DetailsBody extends StatefulWidget {
  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  int mainImageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void setImage(int image) {
    setState(() {
      mainImageIndex = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetails productDetails =
        Provider.of<ProductDetailsData>(context).productDetails;
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 310,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 310,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(225, 125),
                      bottomLeft: Radius.elliptical(370, 300),
                    ),
                    color: (productDetails.productimgs != null) &&
                            (productDetails.productimgs.length != 0)
                        ? parseColor(productDetails
                            .productimgs[mainImageIndex].backgroundcolor)
                        : Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 15.0, right: 15.0, left: 15.0, top: 75.0),
                child: CachedNetworkImage(
                  imageUrl: (productDetails.productimgs != null) &&
                          (productDetails.productimgs.length != 0)
                      ? productDetails.productimgs[mainImageIndex].imageUrl ??
                          ''
                      : '',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          )),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      FontAwesomeIcons.image,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          '${(productDetails.productManfuters != null) && (productDetails.productManfuters.length != 0) ? productDetails.productManfuters[0].name : ''}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        backgroundColor: Colors.white,
                        mini: true,
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ImagesWidget(
          onImageTap: setImage,
          images: productDetails.productimgs,
        ),
        SizedBox(
          height: 10,
        ),
        NameAndPriceText(
          name: productDetails.product.name,
          price: productDetails.product.price,
        ),
        DescreptionText(
          desc: productDetails.product.fullDescription,
        ),
        (productDetails.productsattrbutes != null) &&
                (productDetails.productsattrbutes.length != 0)
            ? AttributesListBuilder(
                attributes: productDetails.productsattrbutes,
              )
            : SizedBox(),
        (productDetails.productspecification != null) &&
                (productDetails.productspecification.length != 0)
            ? SpecificationListBuilder(
                specifications: productDetails.productspecification,
              )
            : SizedBox(),
        ItemList(
          title: 'العناصر الرائجة',
          items: productDetails.crossproducts,
        ),
        ItemList(
          title: 'العناصر المرتبطة ',
          items: productDetails.relatedproducts,
        ),
        Reviews(),
        DetailsButton(
          productDetails: productDetails,
        )
      ],
    );
  }
}

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    Key key,
    @required this.productDetails,
  }) : super(key: key);

  final ProductDetails productDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: RoundedButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: DetailsBottomSheet(
                    productDetails: productDetails,
                  ),
                ),
              ),
            );
          },
          colour: parseColor(productDetails.product.productImgcolor),
          title: 'اضافة الى السلة',
        ));
  }
}

class AttributesListBuilder extends StatelessWidget {
  final List<Productsattrbutes> attributes;

  const AttributesListBuilder({Key key, this.attributes}) : super(key: key);

  List<Widget> getItems() {
    List<Widget> result = [];

    for (Productsattrbutes attribute in attributes) {
      result.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          attribute.attributename,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ));

      if (attribute.attributeValueTypeId != 1) {
        result.add(DetailsAttributesList(
          attributes: attribute.avalibeoptions,
        ));
      } else {
        result.add(DetailsAttributesListColor(
          attributes: attribute.avalibeoptions,
        ));
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: getItems(),
    );
  }
}

class DetailsAttributesList extends StatelessWidget {
  const DetailsAttributesList({Key key, this.attributes}) : super(key: key);

  final List<Avalibeoptions> attributes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        scrollDirection: Axis.horizontal,
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          return Container(
            height: 70,
            alignment: Alignment.center,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(1.1, 2.0),
                    blurRadius: 9.0),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '${attributes[index].name}',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsAttributesListColor extends StatelessWidget {
  const DetailsAttributesListColor({Key key, this.attributes})
      : super(key: key);

  final List<Avalibeoptions> attributes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        scrollDirection: Axis.horizontal,
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          return Container(
            height: 70,
            width: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(1.1, 2.0),
                    blurRadius: 9.0),
              ],
              color: parseColor(attributes[index].attribueColor),
              borderRadius: BorderRadius.circular(70.0),
            ),
          );
        },
      ),
    );
  }
}

class DescreptionText extends StatelessWidget {
  const DescreptionText({Key key, this.desc}) : super(key: key);

  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Html(
        data: desc ?? '',
        defaultTextStyle: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      ),
    );
  }
}

class NameAndPriceText extends StatelessWidget {
  const NameAndPriceText({Key key, this.name, this.price}) : super(key: key);

  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text(
          '$name',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        Expanded(
          child: SizedBox(),
        ),
        Text(
          '$price',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}

class ImagesWidget extends StatelessWidget {
  final Function(int index) onImageTap;
  final List<Productimgs> images;

  const ImagesWidget({Key key, this.onImageTap, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            height: 90,
            width: 115,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(1.1, 2.0),
                    blurRadius: 9.0),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  onImageTap(index);
                },
                child: CachedNetworkImage(
                  imageUrl: images[index].imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          )),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      FontAwesomeIcons.image,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Color parseColor(String color) {
  Color col;
  print(color);
  try {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "3f37c9";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  } catch (e) {
    col = kBlue;
  }
  return col;
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

class SpecificationListBuilder extends StatelessWidget {
  final List<Productspecification> specifications;

  const SpecificationListBuilder({Key key, this.specifications})
      : super(key: key);

  List<Widget> getItem() {
    List<Widget> result = [];

    result.add(Text(
      'الخواص',
      style: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
    ));

    int i = 0;
    for (Productspecification specification in specifications) {
      result.add(Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: i % 2 == 0 ? Colors.white : Colors.blue.shade50,
        child: Row(
          children: [
            Text(
              specification.attributename,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              specification.attributevaluename,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
      ));

      i++;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(1.1, 2.0),
              blurRadius: 9.0),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: getItem(),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final String title;
  final List<Crossproducts> items;

  const ItemList({Key key, this.title, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: items != null && items.length > 0,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${title}",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        /*Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SubCategoryDetailsScreen(
                              subCategory: SubCategory(sub.id, sub.name),
                            ),
                          ),
                        );*/
                      },
                      child: Text("عرض المزيد",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.grey.shade600)),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                height: 300.0,

                ///
                ///
                /// check the condition if image data from server firebase loaded or no
                /// if image true (image still downloading from server)
                /// Card to set card loading animation
                ///
                ///
                child:
                    Provider.of<ProductDetailsData>(context).showProductLoading
                        ? _loadingImageAnimationDiscount(context)
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) =>
                                discountItem(items[index]),
                            itemCount: items.length,
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Class Component a Item Discount Card
class discountItem extends StatelessWidget {
  Crossproducts item;
  discountItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => ProductDetailsScreen(
                    guide: item.porductGuid,
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Container(
                width: 160.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 185.0,
                          width: 160.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: item.productImg ?? '',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                      ),
                                    )),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                FontAwesomeIcons.image,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            height: 25.5,
                            width: 55.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFD7124A),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(5.0))),
                            child: Center(
                                child: Text(
                              "{item.disscount}%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 7.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 1.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        '${item.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.0),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text('${item.oldPrice}',
                            style: TextStyle(
                              fontSize: 10.5,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '5',
                                style: TextStyle(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14.0,
                              )
                            ],
                          ),
                          Text(
                            '5',
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _loadingImageAnimationDiscount(BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) =>
        loadingMenuItemDiscountCard(),
    itemCount: 5,
  );
}

class Reviews extends StatelessWidget {
  /// Custom Text for Header title
  static var _subHeaderCustomStyle = TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 415.0,
        width: 600.0,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Color(0xFF656565).withOpacity(0.15),
            blurRadius: 1.0,
            spreadRadius: 0.2,
          )
        ]),
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'المراجعات',
                    style: _subHeaderCustomStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, top: 15.0, bottom: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Padding(
                              padding: EdgeInsets.only(top: 2.0, left: 3.0),
                              child: Text(
                                'عرض الكل',
                                style: _subHeaderCustomStyle.copyWith(
                                    color: Colors.indigoAccent, fontSize: 14.0),
                              )),
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => ReviewsAll()));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 18.0,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        StarRating(
                          size: 25.0,
                          starCount: 5,
                          rating: 4.0,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 5.0),
                        Text('8 مراجعات')
                      ]),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 7.0),
                child: _line(),
              ),
              _buildRating('18 Nov 2018',
                  'Item delivered in good condition. I will recommend to other buyer.',
                  (rating) {
                /* setState(() {
                      this.rating = rating;
                    });*/
              }, "assets/avatars/avatar-1.jpg"),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 7.0),
                child: _line(),
              ),
              _buildRating('18 Nov 2018',
                  'Item delivered in good condition. I will recommend to other buyer.',
                  (rating) {
                /* setState(() {
                      this.rating = rating;
                    });*/
              }, "assets/avatars/avatar-4.jpg"),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 7.0),
                child: _line(),
              ),
              _buildRating('18 Nov 2018',
                  'Item delivered in good condition. I will recommend to other buyer.',
                  (rating) {
                /* setState(() {
                      this.rating = rating;
                    });*/
              }, "assets/avatars/avatar-2.jpg"),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}

Widget _buildRating(
    String date, String details, Function changeRating, String image) {
  return ListTile(
    leading: Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    ),
    title: Row(
      children: <Widget>[
        StarRating(
            size: 20.0,
            rating: 3.5,
            starCount: 5,
            color: Colors.yellow,
            onRatingChanged: changeRating),
        SizedBox(width: 8.0),
        Text(
          date,
          style: TextStyle(fontSize: 12.0),
        )
      ],
    ),
    subtitle: Text(
      details,
      style: TextStyle(
          fontFamily: "Gotik",
          color: Colors.black54,
          letterSpacing: 0.3,
          wordSpacing: 0.5),
    ),
  );
}
