import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/home/sub_category_details.dart';
import 'package:mawared_app/screens/home/product_detalis_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import 'category_data.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String guide;
  final String name;

  const CategoryDetailsScreen({Key key, this.guide, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ChangeNotifierProvider(
          create: (context) => CategoryDetailsData(guide),
          child: Scaffold(
            body: categoryDetail(name),
            backgroundColor: Colors.white,
          ),
        ));
  }
}

class categoryDetail extends StatefulWidget {
  final String name;

  categoryDetail(this.name);

  @override
  _categoryDetailState createState() => _categoryDetailState();
}

/// if user click icon in category layout navigate to categoryDetail Layout
class _categoryDetailState extends State<categoryDetail> {
  ///
  /// check the condition is right or wrong for image loaded or no
  ///

  /// custom text variable is make it easy a custom textStyle black font
  static var _customTextStyleBlack = TextStyle(
      color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15.0);

  /// Custom text blue in variable
  static var _customTextStyleBlue = TextStyle(
      color: Color(0xFF6991C7), fontWeight: FontWeight.w700, fontSize: 15.0);

  ///
  /// SetState after imageNetwork loaded to change list card
  ///
  @override
  void initState() {
    super.initState();
  }

  List<dynamic> getImages(context) {
    List<CategoryBrochures> imagesURL =
        Provider.of<CategoryDetailsData>(context)
            .categoryDetails
            .categoryBrochures;
    List<dynamic> result = [];
    for (CategoryBrochures headerImage in imagesURL) {
      result.add(InkWell(
        onTap: () async {
          //Todo open product details

        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: headerImage.imageUrl ?? '',
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
      ));
    }

    return result;
  }

  List<Widget> getSubCategoriesItems(context) {
    List<Widget> result = [];
    List<Subcategories> subCategories =
        Provider.of<CategoryDetailsData>(context).categoryDetails.subcategories;

    List<Products> products = Provider.of<CategoryDetailsData>(context)
        .categoryDetails
        .category
        .products;

    result.add(Visibility(
      visible: Provider.of<CategoryDetailsData>(context)
                  .categoryDetails
                  .categoryBrochures !=
              null &&
          Provider.of<CategoryDetailsData>(context)
                  .categoryDetails
                  .categoryBrochures
                  .length >
              0,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, left: 10.0, right: 10.0, bottom: 35.0),
        child: Container(
          height: 180.0,
          child: new Carousel(
            boxFit: BoxFit.cover,
            dotColor: Colors.transparent,
            dotSize: 5.5,
            dotSpacing: 16.0,
            dotBgColor: Colors.transparent,
            showIndicator: false,
            overlayShadow: false,
            overlayShadowColors: Colors.white.withOpacity(0.9),
            overlayShadowSize: 0.9,
            images: getImages(context),
          ),
        ),
      ),
    ));
    result.add(Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "الاصناف الفرعية",
                  style: _customTextStyleBlack,
                ),
                Visibility(
                  visible: false,
                  child: InkWell(
                    onTap: () {
                      /* Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new promoDetail()));*/
                    },
                    child: Text("عرض المزيد",
                        style: _customTextStyleBlue.copyWith(
                            color: Colors.black26)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(right: 10.0, top: 5.0),
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Provider.of<CategoryDetailsData>(context)
                    .categoryDetails
                    .subcategories
                    .length,
                itemBuilder: (buildContext, index) {
                  return InkWell(
                    onTap: () {
                      //Todo
                      /*Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SubCategoryDetailsScreen(
                            subCategory:
                                Provider.of<CategoryDetailsData>(context).categoryDetails
                                    .subcategories[index],
                          ),
                        ),
                      );*/
                    },
                    child: itemPopular(
                      subCat: Provider.of<CategoryDetailsData>(context)
                          .categoryDetails
                          .subcategories[index],
                      title: Provider.of<CategoryDetailsData>(context)
                          .categoryDetails
                          .subcategories[index]
                          .name,
                      image: Provider.of<CategoryDetailsData>(context)
                          .categoryDetails
                          .subcategories[index]
                          .catImgUrl,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));

    result.add(Visibility(
      visible: products != null && products.length > 0,
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
                    "منتجات الصنف",
                    style: _customTextStyleBlack,
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      /* onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => SubCategoryDetailsScreen(
                                subCategory: SubCategory(sub.id, sub.name),
                              ),
                            ),
                          );
                        },*/
                      child: Text("عرض المزيد", style: _customTextStyleBlue),
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
                child: Provider.of<CategoryDetailsData>(context).showLoading
                    ? _loadingImageAnimationDiscount(context)
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            discountItem(products[index]),
                        itemCount: products.length,
                      ),
              ),
            )
          ],
        ),
      ),
    ));

    for (Subcategories sub in subCategories) {
      result.add(Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${sub.name}",
                    style: _customTextStyleBlack,
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      /* onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SubCategoryDetailsScreen(
                              subCategory: SubCategory(sub.id, sub.name),
                            ),
                          ),
                        );
                      },*/
                      child: Text("عرض المزيد", style: _customTextStyleBlue),
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
                child: Provider.of<CategoryDetailsData>(context).showLoading
                    ? _loadingImageAnimationDiscount(context)
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            discountItem(sub.products[index]),
                        itemCount: sub.products.length,
                      ),
              ),
            )
          ],
        ),
      ));
    }

    return result;
  }

  /// All Widget Component layout
  @override
  Widget build(BuildContext context) {
    return Provider.of<CategoryDetailsData>(context).showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    /* Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new searchAppbar()));*/
                  },
                  icon: Icon(Icons.search, color: Color(0xFF6991C7)),
                ),
              ],
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "${widget.name}",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: Colors.black54),
              ),
              iconTheme: IconThemeData(
                color: Color(0xFF6991C7),
              ),
              elevation: 0.0,
            ),

            /// For call a variable include to body
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: getSubCategoriesItems(context),
                ),
              ),
            ),
          );
  }
}

/// Class Component a Item Discount Card
class discountItem extends StatelessWidget {
  Products item;

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
//           offset: Offset(4.0, 10.0)
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
                              "%",
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
                            '200',
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

/*/// Class Component Card in Category Detail
class Item extends StatelessWidget {
  categoryItem item;

  Item(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
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
                    Container(
                      height: 185.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0)),
                          image: DecorationImage(
                              image: AssetImage(item.image),
                              fit: BoxFit.cover)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 7.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 1.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        item.Salary,
                        style: TextStyle(
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0),
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
                                item.Rating,
                                style: TextStyle(
                                    fontFamily: "Sans",
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
                            item.sale,
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
}*/

///
///
///
/// Loading Item Card Animation Constructor
///
///
///
class loadingMenuItemDiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
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
                            color: Colors.black12,
                          ),
                          Container(
                            height: 25.5,
                            width: 65.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFD7124A),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(5.0))),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 12.0),
                          child: Container(
                            height: 9.5,
                            width: 130.0,
                            color: Colors.black12,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 10.0),
                          child: Container(
                            height: 9.5,
                            width: 80.0,
                            color: Colors.black12,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: "Sans",
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
                            Container(
                              height: 8.0,
                              width: 30.0,
                              color: Colors.black12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
///
///
/// Loading Item Card Animation Constructor
///
///
///
class loadingMenuItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
                  width: 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 185.0,
                        width: 160.0,
                        color: Colors.black12,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 12.0),
                          child: Container(
                            height: 9.5,
                            width: 130.0,
                            color: Colors.black12,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 10.0),
                          child: Container(
                            height: 9.5,
                            width: 80.0,
                            color: Colors.black12,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: "Sans",
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
                            Container(
                              height: 8.0,
                              width: 30.0,
                              color: Colors.black12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingImageAnimation(BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) => loadingMenuItemCard(),
    itemCount: itemDiscount.length,
  );
}*/

///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingImageAnimationDiscount(BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) =>
        loadingMenuItemDiscountCard(),
    itemCount: 5,
  );
}

/// Popular Keyword Item class
class KeywordItem extends StatelessWidget {
  @override
  String title;

  KeywordItem({this.title});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 3.0),
          child: Container(
            height: 29.5,
            width: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.5,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Center(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontFamily: "Sans"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class itemPopular extends StatelessWidget {
  String image, title;
  final Subcategories subCat;

  itemPopular({this.image, this.title, this.subCat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new SubCategoryDetailsScreen(
                  guide: subCat.categoryGuid,
                  name: subCat.name,
                )));
      },
      child: Container(
        width: 130.0,
        height: 130.0,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Stack(
          children: [
            Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: image ?? '',
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
                )),
            Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0, right: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Gotik",
                      fontSize: 15.5,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
