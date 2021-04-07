import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/Brands/brand_data.dart';
import 'package:mawared_app/screens/home/product_detalis_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:provider/provider.dart';

class BrandDetailsScreen extends StatelessWidget {
  final String id;

  const BrandDetailsScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ChangeNotifierProvider(
          create: (context) => BrandDetailsData(id),
          child: Scaffold(
            backgroundColor: kBackground,
            body: BrandDetailsBody(id: id),
          ),
        ));
  }
}

class BrandDetailsBody extends StatelessWidget {
  final String id;

  const BrandDetailsBody({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Provider.of<BrandDetailsData>(context).showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              /// Appbar Custom using a SliverAppBar
              SliverAppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                expandedHeight: 380.0,
                elevation: 0.1,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      Provider.of<BrandDetailsData>(context).brand.name,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700),
                    ),
                    background: Material(
                      child: Hero(
                        tag: 'hero-tag-$id',
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: Provider.of<BrandDetailsData>(context)
                              .brand
                              .imageUrl,
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
                    )),
              ),

              /// Container for description to Sort and Refine
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 20.0, right: 20.0),
                                  child: Html(
                                    data: Provider.of<BrandDetailsData>(context)
                                            .brand
                                            .description ??
                                        '',
                                    defaultTextStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0,
                                        color: Colors.black54),
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
              ),

              /// Create Grid Item
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        /*Provider.of<BrandDetailsData>(context)
                      .brand
                      .items[index]
                      .id;*/
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => ProductDetailsScreen(
                                  guide: Provider.of<BrandDetailsData>(context)
                                      .brand
                                      .products[index]
                                      .porductGuid,
                                )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                Container(
                                  height: mediaQueryData.size.height / 3.5,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl:
                                        Provider.of<BrandDetailsData>(context)
                                                .brand
                                                .products[index]
                                                .productImg ??
                                            '',
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
                                ),
                                Padding(padding: EdgeInsets.only(top: 7.0)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: Text(
                                    Provider.of<BrandDetailsData>(context)
                                        .brand
                                        .products[index]
                                        .name,
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 1.0)),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    '\$ ${Provider.of<BrandDetailsData>(context).brand.products[index].price}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 5.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            '\$ 5',
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: Provider.of<BrandDetailsData>(context)
                      .brand
                      .products
                      .length,
                ),

                /// Setting Size for Grid Item
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250.0,
                  mainAxisSpacing: 7.0,
                  crossAxisSpacing: 7.0,
                  childAspectRatio: 0.605,
                ),
              ),
            ],
          );
  }
}
