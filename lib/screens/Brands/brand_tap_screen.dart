import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/Brands/brand_detalis_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:provider/provider.dart';

import 'brand_data.dart';

class BrandTapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ChangeNotifierProvider(
          create: (context) => BrandTapData(),
          child: Scaffold(
            backgroundColor: kBackground,
            body: BrandTapBody(),
          ),
        ));
  }
}

class BrandTapBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<BrandTapData>(context).showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60, bottom: 60),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(top: 0.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: 145.0,
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ItemCard(Provider.of<BrandTapData>(context)
                                .brandData[index]);
                          },
                          childCount: Provider.of<BrandTapData>(context)
                              .brandData
                              .length,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomAppbar(),
            ],
          );
  }
}

/// Constructor for itemCard for List Menu
class ItemCard extends StatelessWidget {
  /// Declaration and Get data from BrandDataList.dart
  final Brand brand;
  ItemCard(this.brand);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    new BrandDetailsScreen(id: brand.manufacturerGuid),
                transitionDuration: Duration(milliseconds: 600),
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }),
          );
        },
        child: Container(
          height: 130.0,
          width: 400.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Stack(
            children: [
              Hero(
                tag: 'hero-tag-${brand.manufacturerGuid}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 130.0,
                    width: 400.0,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: brand.imageUrl,
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
              Container(
                height: 130.0,
                width: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.black12.withOpacity(0.1),
                ),
              ),
              Center(
                child: Text(
                  brand.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
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
