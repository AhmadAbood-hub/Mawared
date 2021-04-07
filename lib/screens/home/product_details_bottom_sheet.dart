import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/screens/home/product_details.dart';
import 'package:mawared_app/screens/home/product_detalis_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:provider/provider.dart';

class DetailsBottomSheet extends StatefulWidget {
  final ProductDetails productDetails;

  const DetailsBottomSheet({Key key, this.productDetails}) : super(key: key);

  @override
  _DetailsBottomSheetState createState() => _DetailsBottomSheetState();
}

class _DetailsBottomSheetState extends State<DetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ChangeNotifierProvider(
        create: (context) => OrderBottomSheetData(
            widget.productDetails.productsattrbutes,
            widget.productDetails.productimgs[0].imageUrl),
        child: Container(
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.productDetails.productimgs[0].imageUrl ?? '',
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
                    Expanded(
                      child: SizedBox(),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.productDetails.product.name}',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.productDetails.product.price}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'اختر المواصفات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                (widget.productDetails.productsattrbutes != null) &&
                        (widget.productDetails.productsattrbutes.length != 0)
                    ? AttributesListBuilder(
                        attributes: widget.productDetails.productsattrbutes,
                      )
                    : SizedBox(),
                SizedBox(
                  height: 15,
                ),
                OrderCountWidget(),
                SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RoundedButton(
                    title: 'اضافة الى السلة',
                    product: widget.productDetails,
                    colour: parseColor(
                        widget.productDetails.product.productImgcolor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderCountWidget extends StatelessWidget {
  const OrderCountWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            Provider.of<OrderBottomSheetData>(context, listen: false)
                .subOrderCount();
          },
          child: Container(
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.remove,
                color: kNearlyBlue,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          '${Provider.of<OrderBottomSheetData>(context).orderCount}',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Provider.of<OrderBottomSheetData>(context, listen: false)
                .addOrderCount();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: kNearlyBlue.withOpacity(0.2),
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 8.0),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.add,
                color: kNearlyBlue,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AttributesListBuilder extends StatelessWidget {
  final List<Productsattrbutes> attributes;

  const AttributesListBuilder({Key key, this.attributes}) : super(key: key);

  List<Widget> getItems() {
    List<Widget> result = [];

    for (int i = 0; i < attributes.length; i++) {
      Productsattrbutes attribute = attributes[i];
      result.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          attribute.attributename,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ));

      //Fixme
      if (attribute.attributeValueTypeId != 1) {
        result.add(DetailsAttributesList(
            attributes: attribute.avalibeoptions,
            position: i,
            guide: attribute.attributeGuid));
      } else {
        result.add(DetailsAttributesListColor(
            attributes: attribute.avalibeoptions,
            position: i,
            guide: attribute.attributeGuid));
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
  const DetailsAttributesList(
      {Key key, this.attributes, this.position, this.guide})
      : super(key: key);

  final List<Avalibeoptions> attributes;
  final int position;
  final String guide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        scrollDirection: Axis.horizontal,
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Provider.of<OrderBottomSheetData>(context, listen: false)
                  .setAttributeAtPosition(
                      position,
                      guide,
                      attributes[index].productttributeOptionGuid,
                      attributes[index].name,
                      null);
            },
            child: Container(
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
                border: Border.all(
                    width: 3,
                    color: Provider.of<OrderBottomSheetData>(context)
                                .attributeMap[position]
                                .childGuide ==
                            attributes[index].productttributeOptionGuid
                        ? kNearlyBlue
                        : Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '${attributes[index].name}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsAttributesListColor extends StatelessWidget {
  const DetailsAttributesListColor(
      {Key key, this.attributes, this.position, this.guide})
      : super(key: key);

  final List<Avalibeoptions> attributes;
  final int position;
  final String guide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        scrollDirection: Axis.horizontal,
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Provider.of<OrderBottomSheetData>(context, listen: false)
                  .setAttributeAtPosition(
                      position,
                      guide,
                      attributes[index].productttributeOptionGuid,
                      attributes[index].name,
                      attributes[index].attribueColor);
            },
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 3,
                    color: Provider.of<OrderBottomSheetData>(context)
                                .attributeMap[position]
                                .childGuide ==
                            attributes[index].productttributeOptionGuid
                        ? kNearlyBlue
                        : Colors.white),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(1.1, 2.0),
                      blurRadius: 9.0),
                ],
                color: parseColor(attributes[index].attribueColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.title,
      this.colour,
      @required this.onPressed,
      this.textColor,
      this.product});

  final Color colour;
  final ProductDetails product;
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
          onPressed: () {
            Provider.of<OrderBottomSheetData>(context, listen: false)
                .addToCart(product.product);
            Navigator.pop(context);
          },
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
