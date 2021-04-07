import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/home/flash_sales_screen.dart';
import 'package:mawared_app/screens/home/home_data.dart';
import 'package:mawared_app/screens/home/product_detalis_screen.dart';
import 'package:mawared_app/screens/home/sub_category_details.dart';
import 'package:mawared_app/screens/home/week_promotion_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:provider/provider.dart';

import 'category_details_screen.dart';

enum WidgetType { ProductList, ImagesList, ProductGrid, ProductPatternList }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider(
          create: (context) => HomeData(),
          builder: (bildContext, child) {
            return Provider.of<HomeData>(bildContext).showFirstListLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : HomeScreenBody();
          },
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              TopImageSlider(
                imagesUrl:
                    Provider.of<HomeData>(context).topHomeData.mainBrochures,
              ),
              Categories(),
              WeekPromotion(),
              FlashSaleWidget(),
              ItemList(
                  title: 'العناصر المقترحة',
                  items: Provider.of<HomeData>(context)
                      .topHomeData
                      .recommandedproducts),
              ItemList(
                  title: 'الرائجة',
                  items: Provider.of<HomeData>(context)
                      .topHomeData
                      .featureproducts),
              ItemList(
                  title: 'الجديدة',
                  items:
                      Provider.of<HomeData>(context).topHomeData.newproducts),
              SizedBox(
                height: 15,
              ),
              Provider.of<HomeData>(context).showBottomListLoading
                  ? Center(child: CircularProgressIndicator())
                  : HomeBottomList(
                      bottomHomeData:
                          Provider.of<HomeData>(context).bottomHomeDatas,
                    ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
        CustomAppbar(),
      ],
    );
  }
}

class TopImageSlider extends StatelessWidget {
  final List<MainBrochures> imagesUrl;

  const TopImageSlider({Key key, this.imagesUrl}) : super(key: key);

  List<dynamic> getImages(context) {
    List<dynamic> result = [];
    for (MainBrochures headerImage in imagesUrl) {
      result.add(InkWell(
        onTap: () async {

        },
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
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: imagesUrl != null && imagesUrl.length > 0,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        height: 182.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          dotColor: kNearlyBlue,
          dotSize: 5.5,
          dotSpacing: 16.0,
          dotBgColor: Colors.transparent,
          showIndicator: true,
          overlayShadow: true,
          overlayShadowColors: Colors.white.withOpacity(0.9),
          overlayShadowSize: 0.9,
          autoplayDuration: Duration(seconds: 5),
          images: getImages(context),
        ),
      ),
    );
  }
}

class HomeBottomList extends StatelessWidget {
  final List<BottomHomeData> bottomHomeData;

  const HomeBottomList({Key key, this.bottomHomeData}) : super(key: key);

  List<Widget> getItems(context) {
    List<Widget> result = [];

    for (BottomHomeData homeData in bottomHomeData) {
      if (homeData.widgetControlId == 10) {
        //list normall
        result.add(ItemList(
          items: homeData.products,
          title: homeData.categoryName,
        ));
      } else if (homeData.widgetControlId == 20) {
//patterm
        result.add(PatternProductList(
          products: homeData.products,
          title: homeData.categoryName,
        ));
      } else if (homeData.widgetControlId == 30) {
//grid
        result.add(SubCategoryList(
          categories: homeData.subcategories,
          title: homeData.categoryName,
        ));
      } else if (homeData.widgetControlId == 40) {
//image slider
        result.add(TopImageSlider(
          imagesUrl: homeData.categoryBrochures,
        ));
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getItems(context),
    );
  }
}

class ItemList extends StatelessWidget {
  final String title;
  final List<Product> items;

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
                child: Provider.of<HomeData>(context).showFirstListLoading
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

class discountItem extends StatelessWidget {
  Product item;
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

class WeekPromotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 15.0, bottom: 3.0),
              child: Text(
                "حسومات الاسبوع",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
              )),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10.0, right: 20),
              scrollDirection: Axis.horizontal,
              itemCount:
                  Provider.of<HomeData>(context).topHomeData.discounts.length,
              itemBuilder: (buildContext, index) {
                return InkWell(
                  onTap: () {
                    //Todo open week promotion stuf :)😒
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => WeekPromotionScreen(
                              discountGuide: Provider.of<HomeData>(context)
                                  .topHomeData
                                  .discounts[index]
                                  .discountGuid,
                            )));
                  },
                  child: SizedBox(
                    height: 200,
                    width: 170,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: Provider.of<HomeData>(context)
                            .topHomeData
                            .discounts[index]
                            .discountImgurl,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FlashSaleWidget extends StatefulWidget {
  @override
  _FlashSaleWidgetState createState() => _FlashSaleWidgetState();
}

class _FlashSaleWidgetState extends State<FlashSaleWidget> {
  //todo get duration
  CountdownController countdownController =
      CountdownController(duration: Duration(days: 3));

  List<Widget> getItems(context) {
    List<Widget> result = [];

    result.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 40),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.shoppingBag,
              color: Colors.white,
              size: 25,
            ),
            Text(
              "حسومات",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            Text(
              "ينتهي الحسم في :",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.0),
            ),

            /// Get a countDown variable
            Text(
              '${countdownController.currentRemainingTime.hours}:${countdownController.currentRemainingTime.min}:${countdownController.currentRemainingTime.sec}',
              style: TextStyle(
                fontSize: 19.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    ));
    result.add(Padding(padding: EdgeInsets.only(right: 40.0)));

    List<Product> flashSales =
        Provider.of<HomeData>(context).topHomeData.flashSalesProduct;

    for (Product flashSale in flashSales) {
      result.add(FlashSaleItem(
        image: flashSale.productImg,
        title: flashSale.name,
        guide: flashSale.porductGuid, //fixme
        normalprice: '\$ ${flashSale.oldPrice}',
        discountprice: '\$ ${flashSale.price}',
        ratingvalue: '5',
        place: 'syria',
      ));
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    countdownController.start();
    countdownController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      decoration: BoxDecoration(
        /// To set Gradient in flashSale background
        gradient: LinearGradient(colors: [
          Color(0xFF7F7FD5).withOpacity(0.8),
          Color(0xFF86A8E7),
          Color(0xFF91EAE4)
        ]),
      ),

      /// To set FlashSale Scrolling horizontal
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: getItems(context),
      ),
    );
  }
}

class FlashSaleItem extends StatelessWidget {
  final String image;
  final String title;
  final String normalprice;
  final String discountprice;
  final String ratingvalue;
  final String place;
  final String guide;

  const FlashSaleItem(
      {Key key,
      this.image,
      this.title,
      this.normalprice,
      this.discountprice,
      this.ratingvalue,
      this.place,
      this.guide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                //Todo open flash sales things :0)
                /*  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new flashSale(),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 850)));*/

                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => FlashSaleScreen(
                          discountGuide: guide,
                        )));
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(bottom: 10),
                width: 145.0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 140.0,
                      width: 145.0,
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: image,
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
                    Padding(
                      padding:
                          EdgeInsets.only(right: 8.0, left: 3.0, top: 15.0),
                      child: Text(title,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0, top: 5.0),
                      child: Text(normalprice,
                          style: TextStyle(
                            fontSize: 10.5,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0, top: 5.0),
                      child: Text(discountprice,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF7F7FD5),
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          /*   Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star_half,
                            size: 11.0,
                            color: Colors.yellow,
                          ),*/
                          Text(
                            ratingvalue,
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Sans",
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 11.0,
                            color: Colors.black38,
                          ),
                          Text(
                            place,
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class Categories extends StatelessWidget {
  List<Widget> getItems(context) {
    List<Category> categoriesList =
        Provider.of<HomeData>(context).topHomeData.mainCategories;
    List<Widget> result = [];

    for (Category category in categoriesList) {
      result.add(InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => CategoryDetailsScreen(
                    name: category.name,
                    guide: category.categoryGuid,
                  )));
        },
        child: Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: category.catImgUrl,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
              Center(
                child: Text(
                  category.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 20.0),
            child: Text(
              "الاصناف",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.67,
              primary: false,
              children: getItems(context),
            ),
          )
        ],
      ),
    );
  }
}

class SubCategoryList extends StatelessWidget {
  final List<Category> categories;
  final String title;

  const SubCategoryList({Key key, this.categories, this.title})
      : super(key: key);

  List<Widget> getItems(context) {
    print('grid ${categories.length}');
    List<Widget> result = [];
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    for (Category category in categories) {
      result.add(itemPopular(
        image: category.catImgUrl,
        title: category.name,
        name: category.name,
        guide: category.categoryGuid,
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20.0),
              child: Text(
                "$title",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                ),
              ),
            ),

            /// To set GridView item
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 17.0,
              childAspectRatio: 1,
              crossAxisCount: 2,
              primary: false,
              children: getItems(context),
            )
          ],
        ),
      ),
    );
  }
}

class itemPopular extends StatelessWidget {
  String image, title;
  final String guide;
  final String name;

  itemPopular({this.image, this.title, this.guide, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new SubCategoryDetailsScreen(
                  guide: guide,
                  name: name,
                )));
      },
      child: Container(
        height: 250.0,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Stack(
          children: [
            Container(
                width: 150,
                height: 200,
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
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.black.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 125.0, right: 50.0),
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

class SuggestedItems extends StatelessWidget {
  final List<Category> categories;

  SuggestedItems({this.categories});

  List<Widget> getItems(context) {
    print('grid ${categories.length}');
    List<Widget> result = [];
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    for (Category category in categories) {
      result.add(InkWell(
        onTap: () {
          //Todo open item details screen
          /* Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new detailProduk(gridItem),
              transitionDuration: Duration(milliseconds: 900),

              /// Set animation Opacity in route to detailProduk layout
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));*/
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /// Set Animation image to detailProduk layout
                  Hero(
                    tag: "hero-grid-${category.categoryGuid}",
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return new Material(
                                  color: Colors.black54,
                                  child: Container(
                                    padding: EdgeInsets.all(30.0),
                                    child: InkWell(
                                      child: Hero(
                                        tag:
                                            "hero-grid-${category.categoryGuid}",
                                        child: CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          imageUrl: category.catImgUrl,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: downloadProgress
                                                          .progress,
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
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                              transitionDuration:
                                  Duration(milliseconds: 1000)));
                        },
                        child: Container(
                          height: mediaQueryData.size.height / 3.3,
                          width: 200.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: category.catImgUrl,
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
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 7.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      category.name,
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
                      '${category.name} \$',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20.0),
              child: Text(
                "العناصر المقترحة",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                ),
              ),
            ),

            /// To set GridView item
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 17.0,
              childAspectRatio: 0.545,
              crossAxisCount: 2,
              primary: false,
              children: getItems(context),
            )
          ],
        ),
      ),
    );
  }
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

class PatternProductList extends StatelessWidget {
  final List<Product> products;
  final String title;

  const PatternProductList({Key key, this.products, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(viewportFraction: 0.6);
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 20.0),
            child: Text(
              "$title",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 325.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return CardPriority(
                  product: products[position],
                );
              },
              itemCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}

class CardPriority extends StatelessWidget {
  CardPriority({this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /* Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (context, animation, animation2) {
                return DetailsScreen(
                  backgroundHeroTag: backgroundHeroTag,
                  imageHeroTag: imageHeroTag,
                  shoes: Provider.of<ShoesData>(context).feathersShoes[index],
                  animation: animation,
                );
              }),
        );*/
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProductDetailsScreen(
                  guide: product.porductGuid,
                )));
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 25, right: 8, bottom: 15),
            child: Container(
              width: 190,
              height: 350,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(1.1, 4.0),
                        blurRadius: 8.0),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  color: parseColor(product.productImgcolor)),
              padding: EdgeInsets.all(15.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 175, left: 25, right: 8, bottom: 15),
            child: Container(
              width: 190,
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${product.manufacutername}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${product.name}',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${product.price}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: -2,
              top: 0,
              child: Container(
                width: 185,
                height: 185,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: product.productImg ?? '',
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
              ))
        ],
      ),
    );
  }
}

Color parseColor(String color) {
  Color col;
  try {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "3f37c9";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  } catch (e) {
    col = kNearlyBlue;
  }
  return col;
}
